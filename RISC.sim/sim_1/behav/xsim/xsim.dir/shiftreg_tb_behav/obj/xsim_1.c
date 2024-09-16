/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
IKI_DLLESPEC extern void execute_2(char*, char *);
IKI_DLLESPEC extern void execute_5(char*, char *);
IKI_DLLESPEC extern void execute_6(char*, char *);
IKI_DLLESPEC extern void execute_8(char*, char *);
IKI_DLLESPEC extern void execute_10(char*, char *);
IKI_DLLESPEC extern void execute_12(char*, char *);
IKI_DLLESPEC extern void svlog_sampling_process_execute(char*, char*, char*);
IKI_DLLESPEC extern void sequence_expr_m_533898a687dc4299_4674d38f_1(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_533898a687dc4299_4674d38f_2(char*, char *);
IKI_DLLESPEC extern void vlog_sv_sequence_execute_0 (char*, char*, char*);
IKI_DLLESPEC extern void assertion_action_m_533898a687dc4299_4674d38f_1(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_533898a687dc4299_4674d38f_3(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_533898a687dc4299_4674d38f_4(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_533898a687dc4299_4674d38f_2(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_533898a687dc4299_4674d38f_6(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_533898a687dc4299_4674d38f_7(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_533898a687dc4299_4674d38f_3(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_533898a687dc4299_4674d38f_5(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_533898a687dc4299_4674d38f_9(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_533898a687dc4299_4674d38f_10(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_533898a687dc4299_4674d38f_4(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_533898a687dc4299_4674d38f_8(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_533898a687dc4299_4674d38f_12(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_533898a687dc4299_4674d38f_13(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_533898a687dc4299_4674d38f_5(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_533898a687dc4299_4674d38f_11(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_533898a687dc4299_4674d38f_15(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_533898a687dc4299_4674d38f_16(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_533898a687dc4299_4674d38f_6(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_533898a687dc4299_4674d38f_14(char*, char *);
IKI_DLLESPEC extern void execute_59(char*, char *);
IKI_DLLESPEC extern void execute_60(char*, char *);
IKI_DLLESPEC extern void execute_61(char*, char *);
IKI_DLLESPEC extern void execute_62(char*, char *);
IKI_DLLESPEC extern void execute_63(char*, char *);
IKI_DLLESPEC extern void execute_64(char*, char *);
IKI_DLLESPEC extern void execute_4(char*, char *);
IKI_DLLESPEC extern void execute_19(char*, char *);
IKI_DLLESPEC extern void execute_15(char*, char *);
IKI_DLLESPEC extern void execute_16(char*, char *);
IKI_DLLESPEC extern void execute_17(char*, char *);
IKI_DLLESPEC extern void execute_18(char*, char *);
IKI_DLLESPEC extern void execute_65(char*, char *);
IKI_DLLESPEC extern void execute_66(char*, char *);
IKI_DLLESPEC extern void execute_67(char*, char *);
IKI_DLLESPEC extern void execute_68(char*, char *);
IKI_DLLESPEC extern void execute_69(char*, char *);
IKI_DLLESPEC extern void execute_70(char*, char *);
IKI_DLLESPEC extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[49] = {(funcp)execute_2, (funcp)execute_5, (funcp)execute_6, (funcp)execute_8, (funcp)execute_10, (funcp)execute_12, (funcp)svlog_sampling_process_execute, (funcp)sequence_expr_m_533898a687dc4299_4674d38f_1, (funcp)sequence_expr_m_533898a687dc4299_4674d38f_2, (funcp)vlog_sv_sequence_execute_0 , (funcp)assertion_action_m_533898a687dc4299_4674d38f_1, (funcp)sequence_expr_m_533898a687dc4299_4674d38f_3, (funcp)sequence_expr_m_533898a687dc4299_4674d38f_4, (funcp)assertion_action_m_533898a687dc4299_4674d38f_2, (funcp)sequence_expr_m_533898a687dc4299_4674d38f_6, (funcp)sequence_expr_m_533898a687dc4299_4674d38f_7, (funcp)assertion_action_m_533898a687dc4299_4674d38f_3, (funcp)sequence_expr_m_533898a687dc4299_4674d38f_5, (funcp)sequence_expr_m_533898a687dc4299_4674d38f_9, (funcp)sequence_expr_m_533898a687dc4299_4674d38f_10, (funcp)assertion_action_m_533898a687dc4299_4674d38f_4, (funcp)sequence_expr_m_533898a687dc4299_4674d38f_8, (funcp)sequence_expr_m_533898a687dc4299_4674d38f_12, (funcp)sequence_expr_m_533898a687dc4299_4674d38f_13, (funcp)assertion_action_m_533898a687dc4299_4674d38f_5, (funcp)sequence_expr_m_533898a687dc4299_4674d38f_11, (funcp)sequence_expr_m_533898a687dc4299_4674d38f_15, (funcp)sequence_expr_m_533898a687dc4299_4674d38f_16, (funcp)assertion_action_m_533898a687dc4299_4674d38f_6, (funcp)sequence_expr_m_533898a687dc4299_4674d38f_14, (funcp)execute_59, (funcp)execute_60, (funcp)execute_61, (funcp)execute_62, (funcp)execute_63, (funcp)execute_64, (funcp)execute_4, (funcp)execute_19, (funcp)execute_15, (funcp)execute_16, (funcp)execute_17, (funcp)execute_18, (funcp)execute_65, (funcp)execute_66, (funcp)execute_67, (funcp)execute_68, (funcp)execute_69, (funcp)execute_70, (funcp)vlog_transfunc_eventcallback};
const int NumRelocateId= 49;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/shiftreg_tb_behav/xsim.reloc",  (void **)funcTab, 49);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/shiftreg_tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/shiftreg_tb_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_xsimdir_location_if_remapped(argc, argv)  ;
    iki_set_sv_type_file_path_name("xsim.dir/shiftreg_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/shiftreg_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/shiftreg_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, (void*)0, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
