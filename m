Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0B5C282C5
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 20:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D141C218D0
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 20:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360318;
	bh=KBil2V4mn9rIrGvctvF+AA+Sf2jqYkG8jZ6Dtp6wUQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TAUX8QyVbMj98HWm7Uz5GJivdFiYBRhpW9AhpahiQB92NdgB/Cx0yZpJyD4N8sxUz
	 pXICRY9x7c6fdnJE2Y87UMrfAYwSR++DMcW4/zNYpG9PVolo1eLgk3E7GoGKg8Ocpc
	 BWITmQxW9EOxDSk6eq6eHsoUN8Av9mikENlrw3zM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfAXUFM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:05:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:60082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728565AbfAXUFL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 15:05:11 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4396821855;
        Thu, 24 Jan 2019 20:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548360310;
        bh=KBil2V4mn9rIrGvctvF+AA+Sf2jqYkG8jZ6Dtp6wUQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L2m9VQTFmfl58CLgs3uEPTzPbdl/KXMSPhBahzDNX94BNnmhvO3e3xxqAl0HmBVtD
         pN1Nf7tFO1YtegT72Sp9la3jjEw/5ORCX00SbGk+sNsHzxhvoKNDngAktT/q429o1/
         WN+YfJJteDisAbkdoFOAjLydSJUGIjSu+ruTVRBI=
Date:   Thu, 24 Jan 2019 14:05:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI / ACPI: Don't clear pme_poll on device that has
 unreliable ACPI wake
Message-ID: <20190124200508.GH14636@google.com>
References: <20190122064544.27426-1-kai.heng.feng@canonical.com>
 <20190122235134.GE14636@google.com>
 <91E74111-5BB6-4604-A1D7-B537AB42C317@canonical.com>
 <20190124151524.GF14636@google.com>
 <FFC6EC3F-3608-41FC-8B14-815D1747C4B6@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FFC6EC3F-3608-41FC-8B14-815D1747C4B6@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 24, 2019 at 11:29:37PM +0800, Kai Heng Feng wrote:
> > On Jan 24, 2019, at 11:15 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Jan 23, 2019 at 03:17:37PM +0800, Kai Heng Feng wrote:
> >>> On Jan 23, 2019, at 7:51 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>> On Tue, Jan 22, 2019 at 02:45:44PM +0800, Kai-Heng Feng wrote:
> >>>> There are some e1000e devices can only be woken up from D3 one time, by
> >>>> plugging ethernet cable. Subsequent cable plugging does set PME bit
> >>>> correctly, but it still doesn't get woken up.
> >>>> 
> >>>> Since e1000e connects to the root complex directly, we rely on ACPI to
> >>>> wake it up. In this case, the GPE from _PRW only works once and stops
> >>>> working after that.
> >>>> 
> >>>> So introduce a new PCI quirk, to avoid clearing pme_poll flag for buggy
> >>>> platform firmwares that have unreliable GPE wake.
> >>> 
> >>> This quirk applies to all 0x15bb (E1000_DEV_ID_PCH_CNP_I219_LM7) and
> >>> 0x15bd (E1000_DEV_ID_PCH_CNP_I219_LM6) devices.  The e1000e driver
> >>> claims about a zillion different device IDs.
> >>> 
> >>> I would be surprised if these two devices are defective but all the
> >>> others work correctly.  Could it be that there is a problem with the
> >>> wiring on this particular motherboard or with the ACPI _PRW methods
> >>> (or the way Linux interprets them) in this firmware?
> >> 
> >> If this is a motherboard issue or platform specific, do you prefer to use
> >> DMI matches here?
> > 
> > I'm not sure what the problem is yet, so let's hold off on the exact
> > structure of the fix.
> 
> I think DMI table can put in e1000e driver instead of PCI quirk.

I don't think we should add a quirk or DMI table yet because we
haven't gotten to the root cause of this problem.  If the root cause
is a problem in the Linux code, adding a quirk will mask the problem
for this specific system, but will leave other systems with similar
problems.

> > If I understand correctly, e1000e wakeup works once, but doesn't work
> > after that.  Your lspci (from after that first wakeup, from
> > https://bugzilla.kernel.org/attachment.cgi?id=280691) shows this:
> > 
> >  00:14.0 XHC  XHCI USB
> >    Flags: PMEClk- DSI- D1- D2- ... PME(D0-,D1-,D2-,D3hot+,D3cold+)
> >    Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
> >  00:1f.3 HDAS audio
> >    Flags: PMEClk- DSI- D1- D2- ... PME(D0-,D1-,D2-,D3hot+,D3cold+)
> >    Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
> >  00:1f.6 GLAN e1000e
> >    Flags: PMEClk- DSI+ D1- D2- ... PME(D0+,D1-,D2-,D3hot+,D3cold+)
> >    Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=1 PME+
> > 
> > So the e1000e PME_Status bit is still set, which means it probably
> > won't generate another PME interrupt, which would explain why wakeup
> > doesn't work.  To test this theory, can you try this:
> > 
> >  - sleep
> >  - wakeup via e1000e
> >  # DEV=00:1f.6
> >  # lspci -vvs $DEV
> >  # setpci -s $DEV CAP_PM+4.W
> >  # setpci -s $DEV CAP_PM+4.W=0x8100
> >  - sleep
> >  - attempt another wakeup via e1000e
> > 
> > If this second wakeup works, it would suggest that PME_Status isn't
> > being cleared correctly.  I see code, e.g., in
> > acpi_setup_gpe_for_wake(), that *looks* like it would arrange to clear
> > it, but I'm not very familiar with it.  Maybe there's some issue with
> > multiple devices sharing an "implicit notification" situation like
> > this.
> 
> The PME status is being cleared correctly.

I was hoping to understand this better via the experiment above, but
I'm still confused.  Here's the scenario as I understand it:

  0) fresh boot
  1) e1000e PME_Status should be 0
  2) sleep
  3) wakeup via e1000e succeeds
  4) e1000e PME_Status should be 0
  5) sleep
  6) wakeup via e1000e fails
  7) wakeup via USB succeeds
  8) e1000e PME_Status should be 0, but is actually 1

If I understand correctly, the bugzilla lspci
(https://bugzilla.kernel.org/attachment.cgi?id=280691) was collected
at point 8, and it shows PME_Status=1 when it should be 0.

If we write a 1 to PME_Status to clear it, and it remains set, that's
obviously a hardware defect, and Intel should document that in an
erratum, and a quirk would be the appropriate way to work around it.
But I doubt that's what's happening.

If e1000e changes PME_Status from 0 to 1 and we don't get an interrupt
(in this case, an SCI triggering GPE 0x6d), the problem is something
in the path outside e1000e.  Since the wakeup works the first time, we
know e1000e is *capable* of generating an interrupt, and the problem
is probably something in the way we acknowledge it.

I want to make sure we're executing the code that clears
PCI_PM_CTRL_PME_STATUS.  Would you mind applying the patch below,
turning on CONFIG_ACPI_DEBUG, booting with

  acpi.debug_layer=0x00000004 acpi.debug_level=0x00000004

and collecting the dmesg log?  I think you can also set these debug
flags via /sys/module/acpi/parameters/debug_* if that's easier.

> The lspci is captured after I plugged the ethernet cable second time,
> i.e. PME is set but not being woken up.
> 
> Kai-Heng

Bjorn

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c9d8e3c837de..91a70ffdd3a1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1927,7 +1927,7 @@ void pcie_clear_root_pme_status(struct pci_dev *dev)
 bool pci_check_pme_status(struct pci_dev *dev)
 {
 	int pmcsr_pos;
-	u16 pmcsr;
+	u16 pmcsr, pmcsr_orig;
 	bool ret = false;
 
 	if (!dev->pm_cap)
@@ -1939,6 +1939,7 @@ bool pci_check_pme_status(struct pci_dev *dev)
 		return false;
 
 	/* Clear PME status. */
+	pmcsr_orig = pmcsr;
 	pmcsr |= PCI_PM_CTRL_PME_STATUS;
 	if (pmcsr & PCI_PM_CTRL_PME_ENABLE) {
 		/* Disable PME to avoid interrupt flood. */
@@ -1948,6 +1949,9 @@ bool pci_check_pme_status(struct pci_dev *dev)
 
 	pci_write_config_word(dev, pmcsr_pos, pmcsr);
 
+	pci_read_config_word(dev, pmcsr_pos, &pmcsr);
+	pci_info(dev, "%s PM_CTRL %#06x -> %#06x\n", __func__, pmcsr_orig, pmcsr);
+
 	return ret;
 }
 
@@ -2027,18 +2031,22 @@ static void pci_pme_list_scan(struct work_struct *work)
 
 static void __pci_pme_active(struct pci_dev *dev, bool enable)
 {
-	u16 pmcsr;
+	u16 pmcsr, pmcsr_orig;
 
 	if (!dev->pme_support)
 		return;
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+	pmcsr_orig = pmcsr;
 	/* Clear PME_Status by writing 1 to it and enable PME# */
 	pmcsr |= PCI_PM_CTRL_PME_STATUS | PCI_PM_CTRL_PME_ENABLE;
 	if (!enable)
 		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
 
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
+
+	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+	pci_info(dev, "%s PM_CTRL %#06x -> %#06x\n", __func__, pmcsr_orig, pmcsr);
 }
 
 /**
