Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928E3C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 12:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629E722360
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 12:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629E722360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbeKMW5Q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:57:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:50887 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732875AbeKMW5Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 17:57:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 04:59:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="99870839"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga003.jf.intel.com with SMTP; 13 Nov 2018 04:59:12 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 13 Nov 2018 14:59:10 +0200
Date:   Tue, 13 Nov 2018 14:59:10 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>, Lukas Wunner <lukas@wunner.de>
Subject: Re: Qemu Guest kernel 4.20-rc1 PCIe hotplug issue
Message-ID: <20181113125910.GB2500@lahna.fi.intel.com>
References: <5FC3163CFD30C246ABAA99954A238FA8387DD344@FRAEML521-MBX.china.huawei.com>
 <20181113122522.GA2500@lahna.fi.intel.com>
 <5FC3163CFD30C246ABAA99954A238FA8387DF43F@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8387DF43F@FRAEML521-MBX.china.huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 13, 2018 at 12:36:20PM +0000, Shameerali Kolothum Thodi wrote:
> > @@ -156,9 +156,9 @@ static void pcie_do_write_cmd(struct controller *ctrl,
> > u16 cmd,
> >  	slot_ctrl |= (cmd & mask);
> >  	ctrl->cmd_busy = 1;
> >  	smp_mb();
> > +	ctrl->slot_ctrl = slot_ctrl;
> 
> Actually I tried this one, but it doesn't help in this case as the initial 
> pcie_capability_read_word() returns the slot_ctrl without PCI_EXP_SLTCTL_HPIE
> bit set.  It looks to me  pcie_enable_notification() function enables this,
> 
> 	if (!pciehp_poll_mode)
> 		cmd |= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE;
> 
> I don't know this is as per the spec or not as the initial cap read doesn't seems to
> have the PCI_EXP_SLTCTL_HPIE bit set.

If I read the code right cmd value should end up in ctrl->slot_ctrl
properly from pcie_enable_notification().

However, I think we are missing check for PCI_EXP_SLTCTL_CCIE in
pciehp_isr().

Here's an updated patch, can you try and see if it makes any difference?

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 7dd443aea5a5..da2cbe892444 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -156,9 +156,9 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	slot_ctrl |= (cmd & mask);
 	ctrl->cmd_busy = 1;
 	smp_mb();
+	ctrl->slot_ctrl = slot_ctrl;
 	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
 	ctrl->cmd_started = jiffies;
-	ctrl->slot_ctrl = slot_ctrl;
 
 	/*
 	 * Controllers with the Intel CF118 and similar errata advertise
@@ -522,7 +522,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	 * in the Slot Control register (PCIe r4.0, sec 6.7.3.4).
 	 */
 	if (pdev->current_state == PCI_D3cold ||
-	    (!(ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE) && !pciehp_poll_mode))
+	    (!(ctrl->slot_ctrl & (PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE)) && !pciehp_poll_mode))
 		return IRQ_NONE;
 
 	/*
