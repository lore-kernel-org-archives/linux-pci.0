Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEEFC43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E9C206BA
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfCKJwJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:52:09 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43060 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfCKJwJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Mar 2019 05:52:09 -0400
Received: from 79.184.254.189.ipv4.supernova.orange.pl (79.184.254.189) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 0a8ec5d0db2c5889; Mon, 11 Mar 2019 10:52:07 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
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
Subject: Re: [RFC] Log PCIe service info with pci_dev, not pcie_device
Date:   Mon, 11 Mar 2019 10:50:23 +0100
Message-ID: <1585578.yUfP4slHvQ@aspire.rjw.lan>
In-Reply-To: <20190308180149.GD214730@google.com>
References: <20190308180149.GD214730@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday, March 8, 2019 7:01:49 PM CET Bjorn Helgaas wrote:
> This is strictly a discussion starter, obviously not for application.
> 
> The portdrv driver binds to pci_dev for PCIe Root Ports and Switch
> Ports.  It creates additional pcie_devices for each "service" (Power
> Management events, AER, hotplug, Downstream Port Containment, etc).
> These pcie_devices have their own struct device, in addition to the
> one in the struct pci_dev.
> 
> Service drivers can then bind to those pcie_devices, and their
> dev_printk output is typically associated with those, e.g.,
> 
>   pciehp 0000:80:10.0:pcie004: Slot #36 ...
> 
> The "pcie004" is a bitmask that identifies the particular service, but
> I don't think it's very useful to users, especially since we already
> have "pciehp" as the driver name.
> 
> I think the fact that pcie_device has its own struct device is
> probably a design mistake and it would be better if those "services"
> were more tightly integrated into the PCI core.
> 
> Changing that would be a big project that I don't want to tackle right
> now, but I think a small step would be to simplify the dmesg logging
> by doing it with the underlying pci_dev instead of the pcie_device.
> For example, we could do something like the patch below, which would
> change the dmesg output like this:
> 
>   - pciehp 0000:80:10.0:pcie004: Slot #36 AttnBtn- PwrCtrl- MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
>   + pcieport 0000:80:10.0: pciehp: Slot #36 AttnBtn- PwrCtrl- MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
> 
> Please discuss :)

No strong opinion here, and please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this patch.

> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 7dd443aea5a5..2761778f2ecc 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -868,7 +868,7 @@ struct controller *pcie_init(struct pcie_device *dev)
>  		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_CC |
>  		PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC);
>  
> -	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c LLActRep%c%s\n",
> +	pci_info(pdev, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c LLActRep%c%s\n",
>  		(slot_cap & PCI_EXP_SLTCAP_PSN) >> 19,
>  		FLAG(slot_cap, PCI_EXP_SLTCAP_ABP),
>  		FLAG(slot_cap, PCI_EXP_SLTCAP_PCP),
> 


