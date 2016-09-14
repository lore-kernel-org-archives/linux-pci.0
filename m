Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762001AbcINTRL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 15:17:11 -0400
Date: Wed, 14 Sep 2016 14:17:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        Soren Brinkmann <sorenb@xilinx.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>,
        "yinghai@kernel.org" <yinghai@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "fengguang.wu@intel.com" <fengguang.wu@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/6] PCI: xilinx: Keep both legacy and MSI interrupt
 references.
Message-ID: <20160914191704.GA9208@localhost>
References: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
 <20160913155641.GB4138@localhost>
 <8520D5D51A55D047800579B094147198258D6418@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8520D5D51A55D047800579B094147198258D6418@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 14, 2016 at 03:32:44PM +0000, Bharat Kumar Gogada wrote:
> On Thu, Sep 01, 2016 at 03:44:41PM +0530, Bharat Kumar Gogada wrote:
> > When built with MSI support the legacy domain reference is being 
> > overwritten with MSI.
> > Instead creating two separate domains for MSI and legacy interrupts.
> > 
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> 
> Applied all these (except [5/6]) with Michal's ack to pci/host-xilinx for v4.9, thanks!
> 
> I already applied Po Liu's patch ("PCI: xilinx: Relax device number checking to allow SR-IOV") to pci/virtualization.  This is identical to [5/6], so I dropped [5/6] to avoid a conflict.
> 
> Thanks Bjorn. 
> Some how I couldn't find Po Liu's patch, can you provide git link of patch that was applied. 

Sure, here it is: https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/virtualization&id=8e7ca8ca5fd8a3242289105723c429733be8b73b
