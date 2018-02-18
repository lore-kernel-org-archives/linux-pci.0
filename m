Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-he1eur01on0122.outbound.protection.outlook.com ([104.47.0.122]:26400
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751689AbeBRXNP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 18 Feb 2018 18:13:15 -0500
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
To: linux-pci@vger.kernel.org, mj@ucw.cz
Cc: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Subject: [PATCH v3 3/3] lspci: Add JSON PCI Express capabilities
Date: Mon, 19 Feb 2018 02:12:51 +0300
Message-Id: <20180218231251.23988-4-viktor.prutyanov@virtuozzo.com>
In-Reply-To: <20180218231251.23988-1-viktor.prutyanov@virtuozzo.com>
References: <20180218231251.23988-1-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds JSON format of PCI Express capabilities

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
---
 ls-caps.c | 417 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lspci.c   |   5 +
 lspci.h   |  33 ++---
 3 files changed, 439 insertions(+), 16 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index d4aebc8..9fe4b82 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -716,6 +716,73 @@ static void cap_express_dev(struct device *d, int where, int type)
 	FLAG(w, PCI_EXP_DEVSTA_TRPND));
 }
 
+static void fill_info_express_dev(struct info_obj *exp_obj, struct device *d, int where, int type)
+{
+  u32 t;
+  u16 w;
+  struct info_obj *dev_cap_obj, *dev_ctl_obj, *dev_sta_obj, *dev_ctl_re_obj;
+  char buf[64];
+
+  t = get_conf_long(d, where + PCI_EXP_DEVCAP);
+  dev_cap_obj = info_obj_create_in_obj(exp_obj, "DevCap");
+  info_obj_add_fmt_buf_str(dev_cap_obj, "MaxPayload", buf, sizeof(buf), "%d",
+	128 << (t & PCI_EXP_DEVCAP_PAYLOAD));
+  info_obj_add_fmt_buf_str(dev_cap_obj, "PhantFunc", buf, sizeof(buf), "%d",
+	(1 << ((t & PCI_EXP_DEVCAP_PHANTOM) >> 3)) - 1);
+  if ((type == PCI_EXP_TYPE_ENDPOINT) || (type == PCI_EXP_TYPE_LEG_END))
+    {
+      info_obj_add_str(dev_cap_obj, "L0s", latency_l0s((t & PCI_EXP_DEVCAP_L0S) >> 6));
+      info_obj_add_str(dev_cap_obj, "L1", latency_l1((t & PCI_EXP_DEVCAP_L1) >> 9));
+    }
+  info_obj_add_flag(dev_cap_obj, "ExtTag", FLAG(t, PCI_EXP_DEVCAP_EXT_TAG));
+  if ((type == PCI_EXP_TYPE_ENDPOINT) || (type == PCI_EXP_TYPE_LEG_END) ||
+      (type == PCI_EXP_TYPE_UPSTREAM) || (type == PCI_EXP_TYPE_PCI_BRIDGE))
+    {
+      info_obj_add_flag(dev_cap_obj, "AttnBtn", FLAG(t, PCI_EXP_DEVCAP_ATN_BUT));
+      info_obj_add_flag(dev_cap_obj, "AttnInd", FLAG(t, PCI_EXP_DEVCAP_ATN_IND));
+      info_obj_add_flag(dev_cap_obj, "PwrInd", FLAG(t, PCI_EXP_DEVCAP_PWR_IND));
+    }
+  info_obj_add_flag(dev_cap_obj, "RBE", FLAG(t, PCI_EXP_DEVCAP_RBE));
+  if ((type == PCI_EXP_TYPE_ENDPOINT) || (type == PCI_EXP_TYPE_LEG_END))
+    info_obj_add_flag(dev_cap_obj, "FLReset", FLAG(t, PCI_EXP_DEVCAP_FLRESET));
+  if ((type == PCI_EXP_TYPE_ENDPOINT) || (type == PCI_EXP_TYPE_UPSTREAM) ||
+      (type == PCI_EXP_TYPE_PCI_BRIDGE))
+    info_obj_add_fmt_buf_str(dev_cap_obj, "SlotPowerLimit", buf, sizeof(buf), "%.3f",
+	power_limit((t & PCI_EXP_DEVCAP_PWR_VAL) >> 18,
+		    (t & PCI_EXP_DEVCAP_PWR_SCL) >> 26));
+
+  w = get_conf_word(d, where + PCI_EXP_DEVCTL);
+  dev_ctl_obj = info_obj_create_in_obj(exp_obj, "DevCtl");
+  dev_ctl_re_obj = info_obj_create_in_obj(dev_ctl_obj, "Report-errors");
+  info_obj_add_flag(dev_ctl_re_obj, "Correctable", FLAG(w, PCI_EXP_DEVCTL_CERE));
+  info_obj_add_flag(dev_ctl_re_obj, "Non-Fatal", FLAG(w, PCI_EXP_DEVCTL_NFERE));
+  info_obj_add_flag(dev_ctl_re_obj, "Fatal", FLAG(w, PCI_EXP_DEVCTL_FERE));
+  info_obj_add_flag(dev_ctl_re_obj, "Unsupported", FLAG(w, PCI_EXP_DEVCTL_URRE));
+  info_obj_add_flag(dev_ctl_obj, "RlxdOrd", FLAG(w, PCI_EXP_DEVCTL_RELAXED));
+  info_obj_add_flag(dev_ctl_obj, "ExtTag", FLAG(w, PCI_EXP_DEVCTL_EXT_TAG));
+  info_obj_add_flag(dev_ctl_obj, "PhantFunc", FLAG(w, PCI_EXP_DEVCTL_PHANTOM));
+  info_obj_add_flag(dev_ctl_obj, "AuxPwr", FLAG(w, PCI_EXP_DEVCTL_AUX_PME));
+  info_obj_add_flag(dev_ctl_obj, "NoSnoop", FLAG(w, PCI_EXP_DEVCTL_NOSNOOP));
+  if (type == PCI_EXP_TYPE_PCI_BRIDGE)
+    info_obj_add_flag(dev_ctl_obj, "BrConfRtry", FLAG(w, PCI_EXP_DEVCTL_BCRE));
+  if (((type == PCI_EXP_TYPE_ENDPOINT) || (type == PCI_EXP_TYPE_LEG_END)) &&
+      (t & PCI_EXP_DEVCAP_FLRESET))
+    info_obj_add_flag(dev_ctl_obj, "FLReset", FLAG(w, PCI_EXP_DEVCTL_FLRESET));
+  info_obj_add_fmt_buf_str(dev_ctl_obj, "MaxPayload", buf, sizeof(buf), "%d",
+	128 << ((w & PCI_EXP_DEVCTL_PAYLOAD) >> 5));
+  info_obj_add_fmt_buf_str(dev_ctl_obj, "MaxReadReq", buf, sizeof(buf), "%d",
+	128 << ((w & PCI_EXP_DEVCTL_READRQ) >> 12));
+
+  w = get_conf_word(d, where + PCI_EXP_DEVSTA);
+  dev_sta_obj = info_obj_create_in_obj(exp_obj, "DevSta");
+  info_obj_add_flag(dev_sta_obj, "CorrErr", FLAG(w, PCI_EXP_DEVSTA_CED));
+  info_obj_add_flag(dev_sta_obj, "UncorrErr", FLAG(w, PCI_EXP_DEVSTA_NFED));
+  info_obj_add_flag(dev_sta_obj, "FatalErr", FLAG(w, PCI_EXP_DEVSTA_FED));
+  info_obj_add_flag(dev_sta_obj, "UnsuppReq", FLAG(w, PCI_EXP_DEVSTA_URD));
+  info_obj_add_flag(dev_sta_obj, "AuxPwr", FLAG(w, PCI_EXP_DEVSTA_AUXPD));
+  info_obj_add_flag(dev_sta_obj, "TransPend", FLAG(w, PCI_EXP_DEVSTA_TRPND));
+}
+
 static char *link_speed(int speed)
 {
   switch (speed)
@@ -810,6 +877,59 @@ static void cap_express_link(struct device *d, int where, int type)
 	FLAG(w, PCI_EXP_LNKSTA_AUTBW));
 }
 
+static void fill_info_express_link(struct info_obj *exp_obj, struct device *d, int where, int type)
+{
+  u32 t, aspm;
+  u16 w;
+  struct info_obj *lnk_cap_obj, *lnk_ctl_obj, *lnk_sta_obj;
+  char buf[64];
+
+  t = get_conf_long(d, where + PCI_EXP_LNKCAP);
+  aspm = (t & PCI_EXP_LNKCAP_ASPM) >> 10;
+  lnk_cap_obj = info_obj_create_in_obj(exp_obj, "LnkCap");
+  info_obj_add_fmt_buf_str(lnk_cap_obj, "Port", buf, sizeof(buf), "%d", t >> 24);
+  info_obj_add_str(lnk_cap_obj, "Speed", link_speed(t & PCI_EXP_LNKCAP_SPEED));
+  info_obj_add_fmt_buf_str(lnk_cap_obj, "Width", buf, sizeof(buf), "x%d", (t & PCI_EXP_LNKCAP_WIDTH) >> 4);
+  info_obj_add_str(lnk_cap_obj, "ASPM", aspm_support(aspm));
+  if (aspm)
+    {
+      if (aspm & 1)
+	info_obj_add_str(lnk_cap_obj, "L0s", latency_l0s((t & PCI_EXP_LNKCAP_L0S) >> 12));
+      if (aspm & 2)
+	info_obj_add_str(lnk_cap_obj, "L1", latency_l1((t & PCI_EXP_LNKCAP_L1) >> 15));
+    }
+  info_obj_add_flag(lnk_cap_obj, "ClockPM", FLAG(t, PCI_EXP_LNKCAP_CLOCKPM));
+  info_obj_add_flag(lnk_cap_obj, "Surprise", FLAG(t, PCI_EXP_LNKCAP_SURPRISE));
+  info_obj_add_flag(lnk_cap_obj, "LLActRep", FLAG(t, PCI_EXP_LNKCAP_DLLA));
+  info_obj_add_flag(lnk_cap_obj, "BwNot", FLAG(t, PCI_EXP_LNKCAP_LBNC));
+  info_obj_add_flag(lnk_cap_obj, "ASPMOptComp", FLAG(t, PCI_EXP_LNKCAP_AOC));
+
+  w = get_conf_word(d, where + PCI_EXP_LNKCTL);
+  lnk_ctl_obj = info_obj_create_in_obj(exp_obj, "LnkCtl");
+  info_obj_add_str(lnk_ctl_obj, "ASPM", aspm_enabled(w & PCI_EXP_LNKCTL_ASPM));
+  if ((type == PCI_EXP_TYPE_ROOT_PORT) || (type == PCI_EXP_TYPE_ENDPOINT) ||
+      (type == PCI_EXP_TYPE_LEG_END) || (type == PCI_EXP_TYPE_PCI_BRIDGE))
+    info_obj_add_fmt_buf_str(lnk_ctl_obj, "RCB", buf, sizeof(buf), "%d", w & PCI_EXP_LNKCTL_RCB ? 128 : 64);
+  info_obj_add_flag(lnk_ctl_obj, "Disabled", FLAG(w, PCI_EXP_LNKCTL_DISABLE));
+  info_obj_add_flag(lnk_ctl_obj, "CommClk", FLAG(w, PCI_EXP_LNKCTL_CLOCK));
+  info_obj_add_flag(lnk_ctl_obj, "ExtSynch", FLAG(w, PCI_EXP_LNKCTL_XSYNCH));
+  info_obj_add_flag(lnk_ctl_obj, "ClockPM", FLAG(w, PCI_EXP_LNKCTL_CLOCKPM));
+  info_obj_add_flag(lnk_ctl_obj, "AutWidDis", FLAG(w, PCI_EXP_LNKCTL_HWAUTWD));
+  info_obj_add_flag(lnk_ctl_obj, "BWInt", FLAG(w, PCI_EXP_LNKCTL_BWMIE));
+  info_obj_add_flag(lnk_ctl_obj, "AutBWInt", FLAG(w, PCI_EXP_LNKCTL_AUTBWIE));
+
+  w = get_conf_word(d, where + PCI_EXP_LNKSTA);
+  lnk_sta_obj = info_obj_create_in_obj(exp_obj, "LnkSta");
+  info_obj_add_str(lnk_sta_obj, "Speed", link_speed(w & PCI_EXP_LNKSTA_SPEED));
+  info_obj_add_fmt_buf_str(lnk_sta_obj, "Width", buf, sizeof(buf), "x%d", (w & PCI_EXP_LNKSTA_WIDTH) >> 4);
+  info_obj_add_flag(lnk_sta_obj, "TrErr", FLAG(w, PCI_EXP_LNKSTA_TR_ERR));
+  info_obj_add_flag(lnk_sta_obj, "Train", FLAG(w, PCI_EXP_LNKSTA_TRAIN));
+  info_obj_add_flag(lnk_sta_obj, "SlotClk", FLAG(w, PCI_EXP_LNKSTA_SL_CLK));
+  info_obj_add_flag(lnk_sta_obj, "DLActive", FLAG(w, PCI_EXP_LNKSTA_DL_ACT));
+  info_obj_add_flag(lnk_sta_obj, "BWMgmt", FLAG(w, PCI_EXP_LNKSTA_BWMGMT));
+  info_obj_add_flag(lnk_sta_obj, "ABWMgmt", FLAG(w, PCI_EXP_LNKSTA_AUTBW));
+}
+
 static const char *indicator(int code)
 {
   static const char *names[] = { "Unknown", "On", "Blink", "Off" };
@@ -865,6 +985,61 @@ static void cap_express_slot(struct device *d, int where)
 	FLAG(w, PCI_EXP_SLTSTA_LLCHG));
 }
 
+static void fill_info_express_slot(struct info_obj *exp_obj, struct device *d, int where)
+{
+  u32 t;
+  u16 w;
+  struct info_obj *slt_cap_obj, *slt_ctl_obj, *slt_sta_obj;
+  struct info_obj *slt_ctl_enable_obj, *slt_ctl_control_obj;
+  struct info_obj *slt_sta_status_obj, *slt_sta_changed_obj;
+  char buf[128];
+
+  t = get_conf_long(d, where + PCI_EXP_SLTCAP);
+  slt_cap_obj = info_obj_create_in_obj(exp_obj, "SltCap");
+  info_obj_add_flag(slt_cap_obj, "AttnBtn", FLAG(t, PCI_EXP_SLTCAP_ATNB));
+  info_obj_add_flag(slt_cap_obj, "PwrCtrl", FLAG(t, PCI_EXP_SLTCAP_PWRC));
+  info_obj_add_flag(slt_cap_obj, "MRL", FLAG(t, PCI_EXP_SLTCAP_MRL));
+  info_obj_add_flag(slt_cap_obj, "AttnInd", FLAG(t, PCI_EXP_SLTCAP_ATNI));
+  info_obj_add_flag(slt_cap_obj, "PwrInd", FLAG(t, PCI_EXP_SLTCAP_PWRI));
+  info_obj_add_flag(slt_cap_obj, "HotPlug", FLAG(t, PCI_EXP_SLTCAP_HPC));
+  info_obj_add_flag(slt_cap_obj, "Surprise", FLAG(t, PCI_EXP_SLTCAP_HPS));
+  info_obj_add_fmt_buf_str(slt_cap_obj, "Slot", buf, sizeof(buf), "%d", (t & PCI_EXP_SLTCAP_PSN) >> 19);
+  info_obj_add_fmt_buf_str(slt_cap_obj, "PowerLimit", buf, sizeof(buf), "%.3f",
+		  power_limit((t & PCI_EXP_SLTCAP_PWR_VAL) >> 7, (t & PCI_EXP_SLTCAP_PWR_SCL) >> 15));
+  info_obj_add_flag(slt_cap_obj, "Interlock", FLAG(t, PCI_EXP_SLTCAP_INTERLOCK));
+  info_obj_add_flag(slt_cap_obj, "NoCompl", FLAG(t, PCI_EXP_SLTCAP_NOCMDCOMP));
+
+  w = get_conf_word(d, where + PCI_EXP_SLTCTL);
+  slt_ctl_obj = info_obj_create_in_obj(exp_obj, "SltCtl");
+  slt_ctl_enable_obj = info_obj_create_in_obj(slt_ctl_obj, "Enable");
+  info_obj_add_flag(slt_ctl_enable_obj, "AttnBtn", FLAG(w, PCI_EXP_SLTCTL_ATNB));
+  info_obj_add_flag(slt_ctl_enable_obj, "PwrFlt", FLAG(w, PCI_EXP_SLTCTL_PWRF));
+  info_obj_add_flag(slt_ctl_enable_obj, "MRL", FLAG(w, PCI_EXP_SLTCTL_MRLS));
+  info_obj_add_flag(slt_ctl_enable_obj, "PresDet", FLAG(w, PCI_EXP_SLTCTL_PRSD));
+  info_obj_add_flag(slt_ctl_enable_obj, "CmdCplt", FLAG(w, PCI_EXP_SLTCTL_CMDC));
+  info_obj_add_flag(slt_ctl_enable_obj, "HPIrq", FLAG(w, PCI_EXP_SLTCTL_HPIE));
+  info_obj_add_flag(slt_ctl_enable_obj, "LinkChg", FLAG(w, PCI_EXP_SLTCTL_LLCHG));
+  slt_ctl_control_obj = info_obj_create_in_obj(slt_ctl_obj, "Control");
+  info_obj_add_str(slt_ctl_control_obj, "AttnInd", indicator((w & PCI_EXP_SLTCTL_ATNI) >> 6));
+  info_obj_add_str(slt_ctl_control_obj, "PwrInd", indicator((w & PCI_EXP_SLTCTL_PWRI) >> 8));
+  info_obj_add_flag(slt_ctl_control_obj, "Power", FLAG(w, PCI_EXP_SLTCTL_PWRC));
+  info_obj_add_flag(slt_ctl_control_obj, "Inrelock", FLAG(w, PCI_EXP_SLTCTL_INTERLOCK));
+
+  w = get_conf_word(d, where + PCI_EXP_SLTSTA);
+  slt_sta_obj = info_obj_create_in_obj(exp_obj, "SltSta");
+  slt_sta_status_obj = info_obj_create_in_obj(slt_sta_obj, "Status");
+  info_obj_add_flag(slt_sta_status_obj, "AttnBtn", FLAG(w, PCI_EXP_SLTSTA_ATNB));
+  info_obj_add_flag(slt_sta_status_obj, "PowerFlt", FLAG(w, PCI_EXP_SLTSTA_PWRF));
+  info_obj_add_flag(slt_sta_status_obj, "MRL", FLAG(w, PCI_EXP_SLTSTA_MRL_ST));
+  info_obj_add_flag(slt_sta_status_obj, "CmdCplt", FLAG(w, PCI_EXP_SLTSTA_CMDC));
+  info_obj_add_flag(slt_sta_status_obj, "PresDet", FLAG(w, PCI_EXP_SLTSTA_PRES));
+  info_obj_add_flag(slt_sta_status_obj, "Interlock", FLAG(w, PCI_EXP_SLTSTA_INTERLOCK));
+  slt_sta_changed_obj = info_obj_create_in_obj(slt_sta_obj, "Changed");
+  info_obj_add_flag(slt_sta_changed_obj, "MRL", FLAG(w, PCI_EXP_SLTSTA_MRLS));
+  info_obj_add_flag(slt_sta_changed_obj, "PresDet", FLAG(w, PCI_EXP_SLTSTA_PRSD));
+  info_obj_add_flag(slt_sta_changed_obj, "LinkState", FLAG(w, PCI_EXP_SLTSTA_LLCHG));
+}
+
 static void cap_express_root(struct device *d, int where)
 {
   u32 w = get_conf_word(d, where + PCI_EXP_RTCTL);
@@ -886,6 +1061,29 @@ static void cap_express_root(struct device *d, int where)
 	FLAG(w, PCI_EXP_RTSTA_PME_PENDING));
 }
 
+static void fill_info_express_root(struct info_obj *exp_obj, struct device *d, int where)
+{
+  struct info_obj *root_cap_obj, *root_ctl_obj, *root_sta_obj;
+
+  u32 w = get_conf_word(d, where + PCI_EXP_RTCTL);
+  root_ctl_obj = info_obj_create_in_obj(exp_obj, "RootCtl");
+  info_obj_add_flag(root_ctl_obj, "ErrCorrectable", FLAG(w, PCI_EXP_RTCTL_SECEE));
+  info_obj_add_flag(root_ctl_obj, "ErrNon-Fatal", FLAG(w, PCI_EXP_RTCTL_SENFEE));
+  info_obj_add_flag(root_ctl_obj, "ErrFatal", FLAG(w, PCI_EXP_RTCTL_SEFEE));
+  info_obj_add_flag(root_ctl_obj, "PMEIntEna", FLAG(w, PCI_EXP_RTCTL_PMEIE));
+  info_obj_add_flag(root_ctl_obj, "CRSVisible", FLAG(w, PCI_EXP_RTCTL_CRSVIS));
+
+  w = get_conf_word(d, where + PCI_EXP_RTCAP);
+  root_cap_obj = info_obj_create_in_obj(exp_obj, "RootCap");
+  info_obj_add_flag(root_cap_obj, "CRSVisible", FLAG(w, PCI_EXP_RTCAP_CRSVIS));
+
+  w = get_conf_long(d, where + PCI_EXP_RTSTA);
+  root_sta_obj = info_obj_create_in_obj(exp_obj, "RootSta");
+  info_obj_add_fmt_str(root_sta_obj, "PME-ReqID", 5, "%04x", w & PCI_EXP_RTSTA_PME_REQID);
+  info_obj_add_flag(root_sta_obj, "PMEStatus", FLAG(w, PCI_EXP_RTSTA_PME_STATUS));
+  info_obj_add_flag(root_sta_obj, "PMEPending", FLAG(w, PCI_EXP_RTSTA_PME_PENDING));
+}
+
 static const char *cap_express_dev2_timeout_range(int type)
 {
   /* Decode Completion Timeout Ranges. */
@@ -1046,6 +1244,61 @@ static void cap_express_dev2(struct device *d, int where, int type)
     }
 }
 
+static void fill_info_express_dev2(struct info_obj *exp_obj, struct device *d, int where, int type)
+{
+  u32 l;
+  u16 w;
+  int has_mem_bar = device_has_memory_space_bar(d);
+  struct info_obj *dev_cap2_obj, *dev_ctl2_obj;
+
+  l = get_conf_long(d, where + PCI_EXP_DEVCAP2);
+  dev_cap2_obj = info_obj_create_in_obj(exp_obj, "DevCap2");
+  info_obj_add_str(dev_cap2_obj, "Completion-Timeout", cap_express_dev2_timeout_range(PCI_EXP_DEV2_TIMEOUT_RANGE(l)));
+  info_obj_add_flag(dev_cap2_obj, "TimeoutDis", FLAG(l, PCI_EXP_DEV2_TIMEOUT_DIS));
+  info_obj_add_flag(dev_cap2_obj, "LTR", FLAG(l, PCI_EXP_DEVCAP2_LTR));
+  info_obj_add_str(dev_cap2_obj, "OBFF", cap_express_devcap2_obff(PCI_EXP_DEVCAP2_OBFF(l)));
+  if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_DOWNSTREAM)
+    info_obj_add_flag(dev_cap2_obj, "ARIFwd", FLAG(l, PCI_EXP_DEV2_ARI));
+  if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_UPSTREAM ||
+      type == PCI_EXP_TYPE_DOWNSTREAM || has_mem_bar)
+    {
+      struct info_obj *dev_cap2_aoc_obj = info_obj_create_in_obj(dev_cap2_obj, "AtomicOpsCap");
+
+      if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_UPSTREAM ||
+          type == PCI_EXP_TYPE_DOWNSTREAM)
+	info_obj_add_flag(dev_cap2_aoc_obj, "Routing", FLAG(l, PCI_EXP_DEVCAP2_ATOMICOP_ROUTING));
+      if (type == PCI_EXP_TYPE_ROOT_PORT || has_mem_bar)
+	{
+	  info_obj_add_flag(dev_cap2_aoc_obj, "32bit", FLAG(l, PCI_EXP_DEVCAP2_32BIT_ATOMICOP_COMP));
+	  info_obj_add_flag(dev_cap2_aoc_obj, "64bit", FLAG(l, PCI_EXP_DEVCAP2_64BIT_ATOMICOP_COMP));
+	  info_obj_add_flag(dev_cap2_aoc_obj, "128bitCAS", FLAG(l, PCI_EXP_DEVCAP2_128BIT_CAS_COMP));
+	}
+    }
+
+  w = get_conf_word(d, where + PCI_EXP_DEVCTL2);
+  dev_ctl2_obj = info_obj_create_in_obj(exp_obj, "DevCtl2");
+  info_obj_add_str(dev_ctl2_obj, "Completion-Timeout", cap_express_dev2_timeout_value(PCI_EXP_DEV2_TIMEOUT_VALUE(w)));
+  info_obj_add_flag(dev_ctl2_obj, "TimeoutDis", FLAG(w, PCI_EXP_DEV2_TIMEOUT_DIS));
+  info_obj_add_flag(dev_ctl2_obj, "LTR", FLAG(w, PCI_EXP_DEV2_LTR));
+  info_obj_add_str(dev_ctl2_obj, "OBFF", cap_express_devctl2_obff(PCI_EXP_DEV2_OBFF(w)));
+  if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_DOWNSTREAM)
+    info_obj_add_flag(dev_ctl2_obj, "ARIFwd", FLAG(w, PCI_EXP_DEV2_ARI));
+  if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_UPSTREAM ||
+      type == PCI_EXP_TYPE_DOWNSTREAM || type == PCI_EXP_TYPE_ENDPOINT ||
+      type == PCI_EXP_TYPE_ROOT_INT_EP || type == PCI_EXP_TYPE_LEG_END)
+    {
+      struct info_obj *dev_ctl2_aoc_obj = info_obj_create_in_obj(dev_ctl2_obj, "AtomicOpsCtl");
+
+      if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_ENDPOINT ||
+          type == PCI_EXP_TYPE_ROOT_INT_EP || type == PCI_EXP_TYPE_LEG_END)
+	info_obj_add_flag(dev_ctl2_aoc_obj, "ReqEn", FLAG(w, PCI_EXP_DEV2_ATOMICOP_REQUESTER_EN));
+      if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_UPSTREAM ||
+          type == PCI_EXP_TYPE_DOWNSTREAM)
+	info_obj_add_flag(dev_ctl2_aoc_obj, "EgressBlck", FLAG(w, PCI_EXP_DEV2_ATOMICOP_EGRESS_BLOCK));
+    }
+}
+
+
 static const char *cap_express_link2_speed(int type)
 {
   switch (type)
@@ -1129,6 +1382,38 @@ static void cap_express_link2(struct device *d, int where, int type)
 	FLAG(w, PCI_EXP_LINKSTA2_EQU_REQ));
 }
 
+static void fill_info_express_link2(struct info_obj *exp_obj, struct device *d, int where, int type)
+{
+  u16 w;
+  struct info_obj *lnk_sta2_obj;
+
+  if (!((type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_LEG_END) &&
+	(d->dev->dev != 0 || d->dev->func != 0))) {
+    struct info_obj *lnk_ctl2_obj;
+
+    w = get_conf_word(d, where + PCI_EXP_LNKCTL2);
+    lnk_ctl2_obj = info_obj_create_in_obj(exp_obj, "LnkCtl2");
+    info_obj_add_str(lnk_ctl2_obj, "Target-Link-Speed", cap_express_link2_speed(PCI_EXP_LNKCTL2_SPEED(w)));
+    info_obj_add_flag(lnk_ctl2_obj, "EnterCompliance", FLAG(w, PCI_EXP_LNKCTL2_CMPLNC));
+    info_obj_add_flag(lnk_ctl2_obj, "SpeedDis", FLAG(w, PCI_EXP_LNKCTL2_SPEED_DIS));
+    if (type == PCI_EXP_TYPE_DOWNSTREAM)
+      info_obj_add_str(lnk_ctl2_obj, "Selectable-De-emphasis", cap_express_link2_deemphasis(PCI_EXP_LNKCTL2_DEEMPHASIS(w)));
+    info_obj_add_str(lnk_ctl2_obj, "Transmit-Margin", cap_express_link2_transmargin(PCI_EXP_LNKCTL2_MARGIN(w)));
+    info_obj_add_flag(lnk_ctl2_obj, "EnterModifiedCompliance", FLAG(w, PCI_EXP_LNKCTL2_MOD_CMPLNC));
+    info_obj_add_flag(lnk_ctl2_obj, "ComplianceSOS", FLAG(w, PCI_EXP_LNKCTL2_CMPLNC_SOS));
+    info_obj_add_str(lnk_ctl2_obj, "Compliance-De-emphasis", cap_express_link2_deemphasis(PCI_EXP_LNKCTL2_COM_DEEMPHASIS(w)));
+  }
+
+  w = get_conf_word(d, where + PCI_EXP_LNKSTA2);
+  lnk_sta2_obj = info_obj_create_in_obj(exp_obj, "LnkSta2");
+  info_obj_add_str(lnk_sta2_obj, "Current-De-emphasis-Level", cap_express_link2_deemphasis(PCI_EXP_LINKSTA2_DEEMPHASIS(w)));
+  info_obj_add_flag(lnk_sta2_obj, "EqualizationComplete", FLAG(w, PCI_EXP_LINKSTA2_EQU_COMP));
+  info_obj_add_flag(lnk_sta2_obj, "EqualizationPhase1", FLAG(w, PCI_EXP_LINKSTA2_EQU_PHASE1));
+  info_obj_add_flag(lnk_sta2_obj, "EqualizationPhase2", FLAG(w, PCI_EXP_LINKSTA2_EQU_PHASE2));
+  info_obj_add_flag(lnk_sta2_obj, "EqualizationPhase3", FLAG(w, PCI_EXP_LINKSTA2_EQU_PHASE3));
+  info_obj_add_flag(lnk_sta2_obj, "LinkEqualizationRequest", FLAG(w, PCI_EXP_LINKSTA2_EQU_REQ));
+}
+
 static void cap_express_slot2(struct device *d UNUSED, int where UNUSED)
 {
   /* No capabilities that require this field in PCIe rev2.0 spec. */
@@ -1220,6 +1505,94 @@ cap_express(struct device *d, int where, int cap)
   return type;
 }
 
+static int
+fill_info_cap_express(struct info_obj *caps_obj, struct device *d, int where, int cap)
+{
+  int type = (cap & PCI_EXP_FLAGS_TYPE) >> 4;
+  int size;
+  int slot = 0;
+  int link = 1;
+  struct info_obj *express_obj = info_obj_create_in_obj(caps_obj, "express");
+  char buf[128];
+
+  if (verbose >= 2)
+    info_obj_add_fmt_buf_str(express_obj, "ver", buf, sizeof(buf), "%d", cap & PCI_EXP_FLAGS_VERS);
+  switch (type)
+    {
+    case PCI_EXP_TYPE_ENDPOINT:
+      snprintf(buf, sizeof(buf), "Endpoint");
+      break;
+    case PCI_EXP_TYPE_LEG_END:
+      snprintf(buf, sizeof(buf), "Legacy Endpoint");
+      break;
+    case PCI_EXP_TYPE_ROOT_PORT:
+      slot = cap & PCI_EXP_FLAGS_SLOT;
+      snprintf(buf, sizeof(buf), "Root Port (Slot%c)", FLAG(cap, PCI_EXP_FLAGS_SLOT));
+      break;
+    case PCI_EXP_TYPE_UPSTREAM:
+      snprintf(buf, sizeof(buf), "Upstream Port");
+      break;
+    case PCI_EXP_TYPE_DOWNSTREAM:
+      slot = cap & PCI_EXP_FLAGS_SLOT;
+      snprintf(buf, sizeof(buf), "Downstream Port (Slot%c)", FLAG(cap, PCI_EXP_FLAGS_SLOT));
+      break;
+    case PCI_EXP_TYPE_PCI_BRIDGE:
+      snprintf(buf, sizeof(buf), "PCI-Express to PCI/PCI-X Bridge");
+      break;
+    case PCI_EXP_TYPE_PCIE_BRIDGE:
+      slot = cap & PCI_EXP_FLAGS_SLOT;
+      snprintf(buf, sizeof(buf), "PCI/PCI-X to PCI-Express Bridge (Slot%c)",
+	     FLAG(cap, PCI_EXP_FLAGS_SLOT));
+      break;
+    case PCI_EXP_TYPE_ROOT_INT_EP:
+      link = 0;
+      snprintf(buf, sizeof(buf), "Root Complex Integrated Endpoint");
+      break;
+    case PCI_EXP_TYPE_ROOT_EC:
+      link = 0;
+      snprintf(buf, sizeof(buf), "Root Complex Event Collector");
+      break;
+    default:
+      snprintf(buf, sizeof(buf), "Unknown type %d", type);
+  }
+  info_obj_add_str(express_obj, "type", buf);
+  info_obj_add_fmt_buf_str(express_obj, "MSI", buf, sizeof(buf), "%02x", (cap & PCI_EXP_FLAGS_IRQ) >> 9);
+
+  if (verbose < 2)
+    return type;
+
+  size = 16;
+  if (slot)
+    size = 24;
+  if (type == PCI_EXP_TYPE_ROOT_PORT)
+    size = 32;
+  if (!config_fetch(d, where + PCI_EXP_DEVCAP, size))
+    return type;
+
+  fill_info_express_dev(express_obj, d, where, type);
+  if (link)
+    fill_info_express_link(express_obj, d, where, type);
+  if (slot)
+    fill_info_express_slot(express_obj, d, where);
+  if (type == PCI_EXP_TYPE_ROOT_PORT)
+    fill_info_express_root(express_obj, d, where);
+
+  if ((cap & PCI_EXP_FLAGS_VERS) < 2)
+    return type;
+
+  size = 16;
+  if (slot)
+    size = 24;
+  if (!config_fetch(d, where + PCI_EXP_DEVCAP2, size))
+    return type;
+
+  fill_info_express_dev2(express_obj, d, where, type);
+  if (link)
+    fill_info_express_link2(express_obj, d, where, type);
+
+  return type;
+}
+
 static void
 cap_msix(struct device *d, int where, int cap)
 {
@@ -1577,3 +1950,47 @@ show_caps(struct device *d, int where)
   if (can_have_ext_caps)
     show_ext_caps(d, type);
 }
+
+void
+fill_info_caps(struct info_obj *dev_obj, struct device *d, int where)
+{
+  struct info_obj *caps_obj = info_obj_create_in_obj(dev_obj, "capabilities");
+
+  if (get_conf_word(d, PCI_STATUS) & PCI_STATUS_CAP_LIST)
+    {
+      byte been_there[256];
+      where = get_conf_byte(d, where) & ~3;
+      memset(been_there, 0, 256);
+      while (where)
+	{
+	  int id, next, cap;
+	  if (!config_fetch(d, where, 4))
+	    {
+	      fputs("<access denied>", stderr);
+	      break;
+	    }
+	  id = get_conf_byte(d, where + PCI_CAP_LIST_ID);
+	  next = get_conf_byte(d, where + PCI_CAP_LIST_NEXT) & ~3;
+	  cap = get_conf_word(d, where + PCI_CAP_FLAGS);
+	  if (been_there[where]++)
+	    {
+	      fprintf(stderr, "<chain looped>\n");
+	      break;
+	    }
+	  if (id == 0xff)
+	    {
+	      fprintf(stderr, "<chain broken>\n");
+	      break;
+	    }
+	  switch (id)
+	    {
+	    case PCI_CAP_ID_EXP:
+	      fill_info_cap_express(caps_obj, d, where, cap);
+	      break;
+	    default:
+	      break;
+	    }
+	  where = next;
+	}
+    }
+}
diff --git a/lspci.c b/lspci.c
index ae50a85..d5a02e8 100644
--- a/lspci.c
+++ b/lspci.c
@@ -1250,6 +1250,7 @@ fill_info_htype0(struct info_obj *dev_obj, struct device *d)
 
   fill_info_bases(htype0_obj, d, 6);
   fill_info_rom(htype0_obj, d, PCI_ROM_ADDRESS);
+  fill_info_caps(dev_obj, d, PCI_CAPABILITY_LIST);
 }
 
 static void
@@ -1359,6 +1360,8 @@ fill_info_htype1(struct info_obj *dev_obj, struct device *d)
       info_obj_add_flag(bridgectl_obj, "DiscTmrStat", FLAG(brc, PCI_BRIDGE_CTL_DISCARD_TIMER_STATUS));
       info_obj_add_flag(bridgectl_obj, "DiscTmrSERREn", FLAG(brc, PCI_BRIDGE_CTL_DISCARD_TIMER_SERR_EN));
     }
+
+  fill_info_caps(dev_obj, d, PCI_CAPABILITY_LIST);
 }
 
 static void
@@ -1446,6 +1449,8 @@ fill_info_htype2(struct info_obj *dev_obj, struct device *d)
   exca = get_conf_word(d, PCI_CB_LEGACY_MODE_BASE);
   if (exca)
     info_obj_add_fmt_buf_str(htype2_obj, "exca", buf, sizeof(buf), "%04x", exca);
+
+  fill_info_caps(dev_obj, d, PCI_CB_CAPABILITY_LIST);
 }
 
 static void
diff --git a/lspci.h b/lspci.h
index fc23d32..1646f99 100644
--- a/lspci.h
+++ b/lspci.h
@@ -58,22 +58,6 @@ void get_subid(struct device *d, word *subvp, word *subdp);
 #define BITS(x,at,width) (((x) >> (at)) & ((1 << (width)) - 1))
 #define TABLE(tab,x,buf) ((x) < sizeof(tab)/sizeof((tab)[0]) ? (tab)[x] : (sprintf((buf), "??%d", (x)), (buf)))
 
-/* ls-vpd.c */
-
-void cap_vpd(struct device *d);
-
-/* ls-caps.c */
-
-void show_caps(struct device *d, int where);
-
-/* ls-ecaps.c */
-
-void show_ext_caps(struct device *d, int type);
-
-/* ls-caps-vendor.c */
-
-void show_vendor_caps(struct device *d, int where, int cap);
-
 /* ls-info.c */
 
 enum info_val_type {
@@ -128,6 +112,23 @@ struct info_list *info_list_create_in_obj(struct info_obj *parent_obj, char *key
 void info_list_add_str(struct info_list *list, const char *str);
 void info_list_add_obj(struct info_list *list, struct info_obj *obj);
 
+/* ls-vpd.c */
+
+void cap_vpd(struct device *d);
+
+/* ls-caps.c */
+
+void show_caps(struct device *d, int where);
+void fill_info_caps(struct info_obj *dev_obj, struct device *d, int where);
+
+/* ls-ecaps.c */
+
+void show_ext_caps(struct device *d, int type);
+
+/* ls-caps-vendor.c */
+
+void show_vendor_caps(struct device *d, int where, int cap);
+
 /* ls-kernel.c */
 
 void show_kernel_machine(struct device *d UNUSED);
-- 
2.14.3
