/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x8ddf5b5d */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/student1/r2sagu/COE758/Project1CacheController/ProjectFiles/CacheController/SDRAMController.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_1242562249;

int ieee_p_1242562249_sub_17802405650254020620_1035706684(char *, char *, char *);
unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_2696732300_3212880686_p_0(char *t0)
{
    char t34[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    int t5;
    unsigned char t6;
    char *t7;
    int t8;
    int t9;
    char *t10;
    char *t11;
    int t12;
    int t13;
    char *t14;
    char *t15;
    unsigned char t16;
    char *t17;
    int t18;
    int t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    int t23;
    int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;

LAB0:    xsi_set_current_line(50, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 4104);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(51, ng0);
    t3 = (t0 + 2632U);
    t4 = *((char **)t3);
    t5 = *((int *)t4);
    t6 = (t5 == 0);
    if (t6 != 0)
        goto LAB5;

LAB7:
LAB6:    xsi_set_current_line(61, ng0);
    t1 = (t0 + 1512U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t6 = (t2 == (unsigned char)3);
    if (t6 != 0)
        goto LAB20;

LAB22:
LAB21:    goto LAB3;

LAB5:    xsi_set_current_line(52, ng0);
    t3 = (t0 + 9828);
    *((int *)t3) = 0;
    t7 = (t0 + 9832);
    *((int *)t7) = 7;
    t8 = 0;
    t9 = 7;

LAB8:    if (t8 <= t9)
        goto LAB9;

LAB11:    xsi_set_current_line(57, ng0);
    t1 = (t0 + 4248);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t7 = (t4 + 56U);
    t10 = *((char **)t7);
    *((int *)t10) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB6;

LAB9:    xsi_set_current_line(53, ng0);
    t10 = (t0 + 9836);
    *((int *)t10) = 0;
    t11 = (t0 + 9840);
    *((int *)t11) = 31;
    t12 = 0;
    t13 = 31;

LAB12:    if (t12 <= t13)
        goto LAB13;

LAB15:
LAB10:    t1 = (t0 + 9828);
    t8 = *((int *)t1);
    t3 = (t0 + 9832);
    t9 = *((int *)t3);
    if (t8 == t9)
        goto LAB11;

LAB19:    t5 = (t8 + 1);
    t8 = t5;
    t4 = (t0 + 9828);
    *((int *)t4) = t8;
    goto LAB8;

LAB13:    xsi_set_current_line(54, ng0);
    t14 = (t0 + 9844);
    t16 = (8U != 8U);
    if (t16 == 1)
        goto LAB16;

LAB17:    t17 = (t0 + 9828);
    t18 = *((int *)t17);
    t19 = (t18 - 7);
    t20 = (t19 * -1);
    t21 = (t20 * 32U);
    t22 = (t0 + 9836);
    t23 = *((int *)t22);
    t24 = (t23 - 31);
    t25 = (t24 * -1);
    t26 = (t21 + t25);
    t27 = (8U * t26);
    t28 = (0U + t27);
    t29 = (t0 + 4184);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    t32 = (t31 + 56U);
    t33 = *((char **)t32);
    memcpy(t33, t14, 8U);
    xsi_driver_first_trans_delta(t29, t28, 8U, 0LL);

LAB14:    t1 = (t0 + 9836);
    t12 = *((int *)t1);
    t3 = (t0 + 9840);
    t13 = *((int *)t3);
    if (t12 == t13)
        goto LAB15;

LAB18:    t5 = (t12 + 1);
    t12 = t5;
    t4 = (t0 + 9836);
    *((int *)t4) = t12;
    goto LAB12;

LAB16:    xsi_size_not_matching(8U, 8U, 0);
    goto LAB17;

LAB20:    xsi_set_current_line(64, ng0);
    t1 = (t0 + 1192U);
    t4 = *((char **)t1);
    t20 = (15 - 15);
    t21 = (t20 * 1U);
    t25 = (0 + t21);
    t1 = (t4 + t25);
    t7 = (t34 + 0U);
    t10 = (t7 + 0U);
    *((int *)t10) = 15;
    t10 = (t7 + 4U);
    *((int *)t10) = 8;
    t10 = (t7 + 8U);
    *((int *)t10) = -1;
    t5 = (8 - 15);
    t26 = (t5 * -1);
    t26 = (t26 + 1);
    t10 = (t7 + 12U);
    *((unsigned int *)t10) = t26;
    t8 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t1, t34);
    t10 = (t0 + 4312);
    t11 = (t10 + 56U);
    t14 = *((char **)t11);
    t15 = (t14 + 56U);
    t17 = *((char **)t15);
    *((int *)t17) = t8;
    xsi_driver_first_trans_fast(t10);
    xsi_set_current_line(65, ng0);
    t1 = (t0 + 1192U);
    t3 = *((char **)t1);
    t20 = (15 - 7);
    t21 = (t20 * 1U);
    t25 = (0 + t21);
    t1 = (t3 + t25);
    t4 = (t34 + 0U);
    t7 = (t4 + 0U);
    *((int *)t7) = 7;
    t7 = (t4 + 4U);
    *((int *)t7) = 5;
    t7 = (t4 + 8U);
    *((int *)t7) = -1;
    t5 = (5 - 7);
    t26 = (t5 * -1);
    t26 = (t26 + 1);
    t7 = (t4 + 12U);
    *((unsigned int *)t7) = t26;
    t8 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t1, t34);
    t7 = (t0 + 4376);
    t10 = (t7 + 56U);
    t11 = *((char **)t10);
    t14 = (t11 + 56U);
    t15 = *((char **)t14);
    *((int *)t15) = t8;
    xsi_driver_first_trans_fast(t7);
    xsi_set_current_line(66, ng0);
    t1 = (t0 + 1192U);
    t3 = *((char **)t1);
    t20 = (15 - 4);
    t21 = (t20 * 1U);
    t25 = (0 + t21);
    t1 = (t3 + t25);
    t4 = (t34 + 0U);
    t7 = (t4 + 0U);
    *((int *)t7) = 4;
    t7 = (t4 + 4U);
    *((int *)t7) = 0;
    t7 = (t4 + 8U);
    *((int *)t7) = -1;
    t5 = (0 - 4);
    t26 = (t5 * -1);
    t26 = (t26 + 1);
    t7 = (t4 + 12U);
    *((unsigned int *)t7) = t26;
    t8 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t1, t34);
    t7 = (t0 + 4440);
    t10 = (t7 + 56U);
    t11 = *((char **)t10);
    t14 = (t11 + 56U);
    t15 = *((char **)t14);
    *((int *)t15) = t8;
    xsi_driver_first_trans_fast(t7);
    xsi_set_current_line(68, ng0);
    t1 = (t0 + 1352U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t6 = (t2 == (unsigned char)3);
    if (t6 != 0)
        goto LAB23;

LAB25:    xsi_set_current_line(73, ng0);
    t1 = (t0 + 1992U);
    t3 = *((char **)t1);
    t1 = (t0 + 2312U);
    t4 = *((char **)t1);
    t5 = *((int *)t4);
    t8 = (t5 - 7);
    t20 = (t8 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, t5);
    t21 = (t20 * 32U);
    t1 = (t0 + 2472U);
    t7 = *((char **)t1);
    t9 = *((int *)t7);
    t12 = (t9 - 31);
    t25 = (t12 * -1);
    xsi_vhdl_check_range_of_index(31, 0, -1, t9);
    t26 = (t21 + t25);
    t27 = (8U * t26);
    t28 = (0 + t27);
    t1 = (t3 + t28);
    t10 = (t0 + 4504);
    t11 = (t10 + 56U);
    t14 = *((char **)t11);
    t15 = (t14 + 56U);
    t17 = *((char **)t15);
    memcpy(t17, t1, 8U);
    xsi_driver_first_trans_fast_port(t10);

LAB24:    goto LAB21;

LAB23:    xsi_set_current_line(70, ng0);
    t1 = (t0 + 1672U);
    t4 = *((char **)t1);
    t1 = (t0 + 2312U);
    t7 = *((char **)t1);
    t5 = *((int *)t7);
    t8 = (t5 - 7);
    t20 = (t8 * -1);
    t21 = (t20 * 32U);
    t1 = (t0 + 2472U);
    t10 = *((char **)t1);
    t9 = *((int *)t10);
    t12 = (t9 - 31);
    t25 = (t12 * -1);
    t26 = (t21 + t25);
    t27 = (8U * t26);
    t28 = (0U + t27);
    t1 = (t0 + 4184);
    t11 = (t1 + 56U);
    t14 = *((char **)t11);
    t15 = (t14 + 56U);
    t17 = *((char **)t15);
    memcpy(t17, t4, 8U);
    xsi_driver_first_trans_delta(t1, t28, 8U, 0LL);
    goto LAB24;

}


extern void work_a_2696732300_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2696732300_3212880686_p_0};
	xsi_register_didat("work_a_2696732300_3212880686", "isim/CacheControllerTestBench_isim_beh.exe.sim/work/a_2696732300_3212880686.didat");
	xsi_register_executes(pe);
}
