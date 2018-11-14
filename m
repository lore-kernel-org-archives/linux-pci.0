Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8E5C43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 09:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89F622360
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 09:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89F622360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeKNTzA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:55:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:23477 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbeKNTzA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Nov 2018 14:55:00 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 01:52:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,232,1539673200"; 
   d="scan'208";a="91012542"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga006.jf.intel.com with SMTP; 14 Nov 2018 01:52:26 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 14 Nov 2018 11:52:25 +0200
Date:   Wed, 14 Nov 2018 11:52:25 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>, Lukas Wunner <lukas@wunner.de>
Subject: Re: Qemu Guest kernel 4.20-rc1 PCIe hotplug issue
Message-ID: <20181114095225.GN2500@lahna.fi.intel.com>
References: <5FC3163CFD30C246ABAA99954A238FA8387DD344@FRAEML521-MBX.china.huawei.com>
 <20181113122522.GA2500@lahna.fi.intel.com>
 <5FC3163CFD30C246ABAA99954A238FA8387DF43F@FRAEML521-MBX.china.huawei.com>
 <20181113125910.GB2500@lahna.fi.intel.com>
 <5FC3163CFD30C246ABAA99954A238FA8387DF51F@FRAEML521-MBX.china.huawei.com>
 <20181113150749.GC2500@lahna.fi.intel.com>
 <5FC3163CFD30C246ABAA99954A238FA8387DF7B5@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8387DF7B5@FRAEML521-MBX.china.huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 13, 2018 at 03:57:47PM +0000, Shameerali Kolothum Thodi wrote:
> > The smb_mb() thing is not that clear (at least to me) because it is used
> > in two places in the driver and both seem to be making write to
> > ctrl->cmd_busy visible to other CPUs but I don't see where we deal with
> > the read part.
> > 
> > I may be missing something, though.
> 
> I think the read part is in wait_event_timeout() which evaluates the condition.
> The wake_up is called from the pciehp_isr().  Since the flag is being updated
> in both process level and interrupt handler context, smp_mb() is used. I think
> the same now applies to  ctrl->slot_ctrl now as this being used in process
> context and interrupt context as well.

Right, but that would require to use another read/general barrier in the
pciehp_isr() before we read the variable in case interrupt happens
immediately on another CPU (at least that's my understanding). Since I'm
not too comfortable with all these barriers to be honest I would prefer
reading the slot control register directly in pciehp_isr() :-)

I wonder if the below works in your case? I think it is still easier to
understand than adding another barrier there.

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 7dd443aea5a5..575da1005836 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -518,11 +518,9 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	u16 status, events;
 
 	/*
-	 * Interrupts only occur in D3hot or shallower and only if enabled
-	 * in the Slot Control register (PCIe r4.0, sec 6.7.3.4).
+	 * Interrupts only occur in D3hot or shallower (PCIe r4.0, sec 6.7.3.4).
 	 */
-	if (pdev->current_state == PCI_D3cold ||
-	    (!(ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE) && !pciehp_poll_mode))
+	if (pdev->current_state == PCI_D3cold)
 		return IRQ_NONE;
 
 	/*
@@ -548,6 +546,22 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
+	if (!pciehp_poll_mode) {
+		u16 ctrl;
+
+		/*
+		 * Check that the hotplug interrupt was enabled. It may
+		 * be that the interrupt was meant for PME instead as
+		 * they share the MSI vector.
+		 */
+		pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &ctrl);
+		if (ctrl == (u16) ~0 || !(ctrl & PCI_EXP_SLTCTL_HPIE)) {
+			if (parent)
+				pm_runtime_put(parent);
+			return IRQ_NONE;
+		}
+	}
+
 	/*
 	 * Slot Status contains plain status bits as well as event
 	 * notification bits; right now we only want the event bits.
