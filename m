Return-Path: <SRS0=hZ+Q=RL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF2BC43381
	for <linux-pci@archiver.kernel.org>; Fri,  8 Mar 2019 18:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D9220857
	for <linux-pci@archiver.kernel.org>; Fri,  8 Mar 2019 18:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552068113;
	bh=a50geIOnOjK6X0A0X4iFC5JeQKpHie3qNWwacCLaewM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=oeuPI3EgmQjsl+n3tAO0UIjx/XpcckRacmyBth8xuOgtpbODogoNl6fDsbnem99Y2
	 Q630js7PnOqLIkTZIKvxfiJB0oDijm8eZzMn6KpQOIw02tyHQ1lgBUzoNV3uZjzIQj
	 02RA14NheRatDOKV7vu64wjVeywZqIKy4v9IapDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfCHSBw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:01:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfCHSBw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Mar 2019 13:01:52 -0500
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8999C20851;
        Fri,  8 Mar 2019 18:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552068111;
        bh=a50geIOnOjK6X0A0X4iFC5JeQKpHie3qNWwacCLaewM=;
        h=Date:From:To:Cc:Subject:From;
        b=PIEw29+vLmmxnM4FCsF4pgWc2PidN2E3l8RP08Hea/er4e9gQSTWYW7dBaNdmXzzJ
         rHySB1SbVO1OJF8S7G3UIovRiweK0QRSgzcR7RDqw47YanhshEHT7Bmz/1uGx6IDef
         PXEDQh0jKbsnsemWDpY/HR9IRCzVTupHSeb+CU6U=
Date:   Fri, 8 Mar 2019 12:01:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC] Log PCIe service info with pci_dev, not pcie_device
Message-ID: <20190308180149.GD214730@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is strictly a discussion starter, obviously not for application.

The portdrv driver binds to pci_dev for PCIe Root Ports and Switch
Ports.  It creates additional pcie_devices for each "service" (Power
Management events, AER, hotplug, Downstream Port Containment, etc).
These pcie_devices have their own struct device, in addition to the
one in the struct pci_dev.

Service drivers can then bind to those pcie_devices, and their
dev_printk output is typically associated with those, e.g.,

  pciehp 0000:80:10.0:pcie004: Slot #36 ...

The "pcie004" is a bitmask that identifies the particular service, but
I don't think it's very useful to users, especially since we already
have "pciehp" as the driver name.

I think the fact that pcie_device has its own struct device is
probably a design mistake and it would be better if those "services"
were more tightly integrated into the PCI core.

Changing that would be a big project that I don't want to tackle right
now, but I think a small step would be to simplify the dmesg logging
by doing it with the underlying pci_dev instead of the pcie_device.
For example, we could do something like the patch below, which would
change the dmesg output like this:

  - pciehp 0000:80:10.0:pcie004: Slot #36 AttnBtn- PwrCtrl- MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
  + pcieport 0000:80:10.0: pciehp: Slot #36 AttnBtn- PwrCtrl- MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+

Please discuss :)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 7dd443aea5a5..2761778f2ecc 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -868,7 +868,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_CC |
 		PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC);
 
-	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c LLActRep%c%s\n",
+	pci_info(pdev, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c LLActRep%c%s\n",
 		(slot_cap & PCI_EXP_SLTCAP_PSN) >> 19,
 		FLAG(slot_cap, PCI_EXP_SLTCAP_ABP),
 		FLAG(slot_cap, PCI_EXP_SLTCAP_PCP),
