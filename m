Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760022AbdKQXty (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Nov 2017 18:49:54 -0500
Date: Fri, 17 Nov 2017 17:49:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: treding@nvidia.com, bhelgaas@google.com, rajatja@google.com,
        yinghai@kernel.org, david.daney@cavium.com, Julia.Lawall@lip6.fr,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com
Subject: Re: [PATCH V2 3/4] PCI: tegra: Apply sw fixups to support ASPM-L1
 Sub-States
Message-ID: <20171117234951.GB16907@bhelgaas-glaptop.roam.corp.google.com>
References: <1509423769-10522-1-git-send-email-vidyas@nvidia.com>
 <1509423769-10522-4-git-send-email-vidyas@nvidia.com>
 <20171107225007.GA22847@bhelgaas-glaptop.roam.corp.google.com>
 <ef7d193c-c114-d0c6-e450-c00ae3ab2d51@nvidia.com>
 <20171108174829.GE28427@bhelgaas-glaptop.roam.corp.google.com>
 <c387c65f-6e87-639e-0bf5-2324a745ba5a@nvidia.com>
 <20171110212900.GB19895@bhelgaas-glaptop.roam.corp.google.com>
 <7b61f849-2a0a-528e-aa6f-b259fda2294b@nvidia.com>
 <20171114231307.GA13646@bhelgaas-glaptop.roam.corp.google.com>
 <f8024b01-74de-7610-53ab-f5be30077de5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f8024b01-74de-7610-53ab-f5be30077de5@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 17, 2017 at 07:35:21PM +0530, Vidya Sagar wrote:
> On Wednesday 15 November 2017 04:43 AM, Bjorn Helgaas wrote:
> >On Sun, Nov 12, 2017 at 05:21:47PM +0530, Vidya Sagar wrote:
> >>On Saturday 11 November 2017 02:59 AM, Bjorn Helgaas wrote:
> >>>On Fri, Nov 10, 2017 at 03:37:10PM +0530, Vidya Sagar wrote:
> >>>>LTR_L1.2_THRESHOLD time is for the device to enter into and exit
> >>>>from L1.2 state.
> >>>That doesn't feel right to me.  Device characteristics are normally
> >>>communicated via "capabilities" registers, not programmed by the OS in
> >>>"control" registers.  The OS needs to be able to configure arbitrary
> >>>plug-in devices without having device-specific details built into it.
> >>But there is no capability register/field for LTR_L1.2_THRESHOLD either for
> >>root ports or end points
> >Sorry, I didn't state that clearly.  I agree that LTR_L1.2_THRESHOLD
> >should be the time required to enter and exit the L1.2 state.
> >
> >What doesn't make sense to me is that the OS would have to have
> >device-specific quirks built into it instead of being able to discover
> >what it needs via "capabilities" registers.  If it did, we would have
> >no way to configure a plug-in switch unless we added a quirk for every
> >device.  That would be a serious design error in the L1 Substates
> >feature.
> >
> >Assume we have an Endpoint connected to a Root Port.  We should set
> >LTR_L1.2_THRESHOLD to the time it takes to transition the Link from L0
> >to L1.2 and back to L0.  Then we will enter L1.2 only if the Endpoint
> >has reported that it can tolerate at least that much latency.
> >
> > From sec 5.5.3.3.1, Figures 5-16 and 5-17, it looks like the latency
> >to go from L1.0 to L1.2 and back to L0 should be at least the sum of:
> >
> >   T(POWER_OFF)       max 2us (from Table 5-11)
> >   T(L1.2)            min 4us (from Table 5-11)
> >   T(POWER_ON)        from L1 PM Substates Control 2 register
> >   T(COMMONMODE)      from L1 PM Substates Control 1 register
> >
> >This doesn't include (a) the time from L0 to L1.0 and (b) the gap
> >between T(POWER_ON) and T(COMMONMODE).  I don't know how to learn
> >those.  But I think we know how to compute T(POWER_ON) and
> >T(COMMONMODE) by taking the max of Port T_POWER_ON and Port
> >Common_Mode_Restore_Time for the two ends of the Link.
> >
> >Your lspci output (below) shows:
> >
> >   Root Port: Port T_POWER_ON = 70us
> >   Root Port: Port Common_Mode_Restore_Time = 30us
> >   Endpoint:  Port T_POWER_ON = 10us
> >   Endpoint:  Port Common_Mode_Restore_Time = 10us
> >
> >That would make T(POWER_ON) = max(70us, 10us) = 70us
> >and T(COMMONMODE) = max(30us, 10us) = 30us.
> >
> >So I would think the LTR_L1.2_THRESHOLD should be at least
> >
> >   2us + 4us + 70us + 30us = 106us
> >
> >Your hardware folks came up with 55us, but I don't know how.  I
> >guess they're using information not visible to the OS?
> >
> >Can you explain where I'm going wrong in my calculations?  I think
> >we should be able to relate the values from the L1 PM Substates
> >Capabilities register to the timing diagrams in sec 5.5.3.3.1
> >somehow.
> 
> Your calculations are correct. This is in fact the value we used
> initially, but, later on Tegra hardware is tweaked by which
> T_POWER_ON is brought down to 35us and T_cmrt to 14us (to achieve
> better power savings for a specific endpoint) thereby arriving at
> 55us of LTR_L1.2_THRESHOLD value.  Its my mistake that I didn't
> update these new values for T_PowerOn and T_cmrt.

> Also, I got the confirmation from our hardware folks that, it is
> better to go with 70us and 30us for T_PowerOn and T_cmrt
> respectively and stick to 106us of LTR_L1.2_THRESHOLD to be able to
> work with variety of end points.

If you need to make your driver update the values reported via
PCI_L1SS_CAP, that makes sense.  I would guess it might depend on the
hardware implementation, though, so maybe it should be encoded in DT?

> Now that, having a strong API implementation to supply
> LTR_L1.2_THRESHOLD from host controller driver (and weak API
> implementation in aspm sub-system) doesn't seem correct, do you
> suggest to derive LTR_L1.2_THRESHOLD value (like you mentioned
> above) and then update it in both RP and EP L1SS control registers?
> Though it doesn't include gaps (a) and (b) above, I think it is
> still the best way to come up a suitable LTR_L1.2_THRESHOLD value
> without having to be supplied by host controller drivers.

Yes.  I think we should do something like the patch below.

I am still curious about this because I *think* none of this will make
any difference unless firmware is enabling LTR.  Does firmware enable
LTR in your system?  I do think we should also make Linux enable LTR
when appropriate; I'm just wondering why people are tripping over the
LTR_L1.2_THRESHOLD thing.

Bjorn


commit 8390e9bb6a809bb2201ffd29f2a37af6170b1606
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Nov 17 14:26:42 2017 -0600

    PCI/ASPM: Calculate LTR_L1.2_THRESHOLD from device characteristics
    
    Per PCIe r3.1, sec 5.5.1, LTR_L1.2_THRESHOLD determines whether we enter
    the L1.2 Link state when CLKREQ# is de-asserted: if L1.2 is enabled and
    downstream devices have reported via LTR that they can tolerate latency of
    at least LTR_L1.2_THRESHOLD, we must enter L1.2.  The implication is that
    LTR_L1.2_THRESHOLD is the time required to transition the Link from L0 to
    L1.2 and back to L0.
    
    Previously we set LTR_L1.2_THRESHOLD to a fixed value of 163840ns
    (163.84us), but that doesn't account for the because the L1.2 entry and
    exit times depend on the devices on both ends of the Link.
    
    We already set Common_Mode_Restore_Time and T_POWER_ON on both ends of the
    Link to the higher of the values reported in the L1 PM Substates
    Capabilities of the Link ends.  Use those to compute LTR_L1.2_THRESHOLD:
    
        2us T(POWER_OFF)
      + 4us T(L1.2)
      + T(POWER_ON)
      + T(COMMONMODE)
      = LTR_L1.2_THRESHOLD
    
    Note that while firmware may enable LTR, Linux itself currently does not
    enable LTR.  When L1.2 is enabled but LTR is not, LTR_L1.2_THRESHOLD is
    ignored and we always enter L1.2 when it is enabled and CLKREQ# is
    de-asserted.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 9783e10da3a9..8d5ba9bdf24b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -43,18 +43,6 @@
 #define ASPM_STATE_ALL		(ASPM_STATE_L0S | ASPM_STATE_L1 |	\
 				 ASPM_STATE_L1SS)
 
-/*
- * When L1 substates are enabled, the LTR L1.2 threshold is a timing parameter
- * that decides whether L1.1 or L1.2 is entered (Refer PCIe spec for details).
- * Not sure is there is a way to "calculate" this on the fly, but maybe we
- * could turn it into a parameter in future.  This value has been taken from
- * the following files from Intel's coreboot (which is the only code I found
- * to have used this):
- * https://www.coreboot.org/pipermail/coreboot-gerrit/2015-March/021134.html
- * https://review.coreboot.org/#/c/8832/
- */
-#define LTR_L1_2_THRESHOLD_BITS	((1 << 21) | (1 << 23) | (1 << 30))
-
 struct aspm_latency {
 	u32 l0s;			/* L0s latency (nsec) */
 	u32 l1;				/* L1 latency (nsec) */
@@ -333,6 +321,31 @@ static u32 calc_l1ss_pwron(struct pci_dev *pdev, u32 scale, u32 val)
 	return 0;
 }
 
+static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
+{
+	u64 threshold_ns = threshold_us * 1000;
+
+	if (threshold_ns < 32) {
+		*scale = 0;
+		*value = threshold_ns;
+	} else if (threshold_ns < 1024) {
+		*scale = 1;
+		*value = threshold_ns >> 5;
+	} else if (threshold_ns < 32768) {
+		*scale = 2;
+		*value = threshold_ns >> 10;
+	} else if (threshold_ns < 1048576) {
+		*scale = 3;
+		*value = threshold_ns >> 15;
+	} else if (threshold_ns < 33554432) {
+		*scale = 4;
+		*value = threshold_ns >> 20;
+	} else {
+		*scale = 5;
+		*value = threshold_ns >> 25;
+	}
+}
+
 struct aspm_register_info {
 	u32 support:2;
 	u32 enabled:2;
@@ -443,6 +456,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 				struct aspm_register_info *dwreg)
 {
 	u32 val1, val2, scale1, scale2;
+	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
 
 	link->l1ss.up_cap_ptr = upreg->l1ss_cap_ptr;
 	link->l1ss.dw_cap_ptr = dwreg->l1ss_cap_ptr;
@@ -454,16 +468,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	/* Choose the greater of the two Port Common_Mode_Restore_Times */
 	val1 = (upreg->l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
 	val2 = (dwreg->l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
-	if (val1 > val2)
-		link->l1ss.ctl1 |= val1 << 8;
-	else
-		link->l1ss.ctl1 |= val2 << 8;
-
-	/*
-	 * We currently use LTR L1.2 threshold to be fixed constant picked from
-	 * Intel's coreboot.
-	 */
-	link->l1ss.ctl1 |= LTR_L1_2_THRESHOLD_BITS;
+	t_common_mode = max(val1, val2);
 
 	/* Choose the greater of the two Port T_POWER_ON times */
 	val1   = (upreg->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_VALUE) >> 19;
@@ -472,10 +477,27 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	scale2 = (dwreg->l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_SCALE) >> 16;
 
 	if (calc_l1ss_pwron(link->pdev, scale1, val1) >
-	    calc_l1ss_pwron(link->downstream, scale2, val2))
+	    calc_l1ss_pwron(link->downstream, scale2, val2)) {
 		link->l1ss.ctl2 |= scale1 | (val1 << 3);
-	else
+		t_power_on = calc_l1ss_pwron(link->pdev, scale1, val1);
+	} else {
 		link->l1ss.ctl2 |= scale2 | (val2 << 3);
+		t_power_on = calc_l1ss_pwron(link->downstream, scale2, val2);
+	}
+
+	/*
+	 * Set LTR_L1.2_THRESHOLD to the time required to transition the
+	 * Link from L0 to L1.2 and back to L0 so we enter L1.2 only if
+	 * downstream devices report (via LTR) that they can tolerate at
+	 * least that much latency.
+	 *
+	 * Based on PCIe r3.1, sec 5.5.3.3.1, Figures 5-16 and 5-17, and
+	 * Table 5-11.  T(POWER_OFF) is at most 2us and T(L1.2) is at
+	 * least 4us.
+	 */
+	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
+	encode_l12_threshold(l1_2_threshold, &scale, &value);
+	link->l1ss.ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
 }
 
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
