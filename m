Return-Path: <SRS0=hZ+Q=RL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82CCC43381
	for <linux-pci@archiver.kernel.org>; Fri,  8 Mar 2019 18:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B23E20661
	for <linux-pci@archiver.kernel.org>; Fri,  8 Mar 2019 18:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfCHSYH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:24:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:40140 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfCHSYG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Mar 2019 13:24:06 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 10:24:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="150572049"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2019 10:24:05 -0800
Date:   Fri, 8 Mar 2019 11:24:38 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
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
Message-ID: <20190308182437.GB5232@localhost.localdomain>
References: <20190308180149.GD214730@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308180149.GD214730@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 08, 2019 at 12:01:49PM -0600, Bjorn Helgaas wrote:
> Changing that would be a big project that I don't want to tackle right
> now, but I think a small step would be to simplify the dmesg logging
> by doing it with the underlying pci_dev instead of the pcie_device.
> For example, we could do something like the patch below, which would
> change the dmesg output like this:
> 
>   - pciehp 0000:80:10.0:pcie004: Slot #36 AttnBtn- PwrCtrl- MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
>   + pcieport 0000:80:10.0: pciehp: Slot #36 AttnBtn- PwrCtrl- MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
 

Acked-by: Keith Busch <keith.busch@intel.com>
 
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
