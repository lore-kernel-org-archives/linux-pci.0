Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:64094 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932226AbbDIBgM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Apr 2015 21:36:12 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NMI00J0LN4ATH70@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 09 Apr 2015 10:36:10 +0900 (KST)
Message-id: <5525D789.2060200@samsung.com>
Date: Thu, 09 Apr 2015 10:36:09 +0900
From: Jaehoon Chung <jh80.chung@samsung.com>
MIME-version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Jisheng Zhang <jszhang@marvell.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, CPGS <cpgs@samsung.com>
Subject: Re: [Query] Direction of adding arm64 support to PCIe designware driver
References: <20150403174621.02681f0d@xhacker> <20150408103222.GB22376@red-moon>
In-reply-to: <20150408103222.GB22376@red-moon>
Content-type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi.

On 04/08/2015 07:32 PM, Lorenzo Pieralisi wrote:
> Hi Jisheng,
> 
> On Fri, Apr 03, 2015 at 10:46:21AM +0100, Jisheng Zhang wrote:
>> Hi all,
>>
>> Currently, the pci designware driver still lacks of arm64 support and I noticed
>> that many works are done to achieve this goal.
>>
>> Some patches are merged and some are under discussion. And Per my understanding, 
>> even w/ these patches merged, the driver still doesn't support arm64. Could you
>> please kindly point out the direction to add arm64 support to the PCIe
>> designware driver?
> 
> We should remove pci_sys_data dependency since ARM depends on that.
> I removed it from a couple of places already (eg pci_mmap_page_range).
> 
> Now, pcibios_align_resource and pcibios_msi_controller need patching.
> 
> I have a patch for pcibios_align_resource() (I am waiting for Yijing
> Wang series to get merged so that we can move the align_resource
> function pointer in the host bridge):
> 
> https://lkml.org/lkml/2015/4/3/171
> 
> For MSI, code converted to use CONFIG_PCI_MSI_IRQ_DOMAIN should
> not need pcibios_msi_controller ARM function, but if we still compile
> that function in we do need pci_sys_data on ARM, so we have to have
> it even if it can be dead code in some platforms, I have to vet all
> ARM PCI host controllers to check, but removing it would break MSI
> support.
> 
> Does it help ? MSIs are the most important change required,
> align_resource() pointer can be sorted out easily once Yijing's
> code gets in.

I'm not sure whether my working is right..I used the pcie_port instead of pci_sys_data.

static inline struct *sys_to_pcie(struct pci_sys_data *sys)
-> static inline struct *sys_to_pcie(struct pcie_port *pp)

And add "struct list_head resources" as member of pcie_port.

diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 91484a9..1cde583 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -53,6 +53,7 @@ struct pcie_port {
        struct irq_domain       *irq_domain;
        unsigned long           msi_data;
        DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
+       struct list_head        resources;
 };

and just used pci_scan_root_bus(). (before call this, it's added the offset of resources..)
So i got the below message.

[    2.396822] exynos-pcie 156b0000.pcie: Link up!
[    2.397011] exynos-pcie 156b0000.pcie: PCI host bridge to bus 0000:00
[    2.397021] pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
[    2.397026] pci_bus 0000:00: root bus resource [mem 0x0c011000-0x0ffffffe]
[    2.397033] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.409000] pci 0000:00:00.0: BAR 8: assigned [mem 0x0c200000-0x0c7fffff]
[    2.409009] pci 0000:01:00.0: BAR 2: assigned [mem 0x0c400000-0x0c7fffff 64bit]
[    2.409509] pci 0000:01:00.0: BAR 0: assigned [mem 0x0c200000-0x0c207fff 64bit]
[    2.410008] pci 0000:00:00.0: PCI bridge to [bus 01]
[    2.410027] pci 0000:00:00.0:   bridge window [mem 0x0c200000-0x0c7fffff]

Well, i needs to work more and get the knowledge for pcie. (It's not working completely.)
If somebody is working this, it's great..otherwise I will send the RFC patch to get comment for my code.

If i'm missing something, let me know, plz.

Best Regards,
Jaehoon Chung

> 
> Lorenzo
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

