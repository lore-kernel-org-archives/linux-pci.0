Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59348 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbaBKKnF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Feb 2014 05:43:05 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Date: Tue, 11 Feb 2014 11:42:52 +0100
Message-ID: <2006726.HhIT01YuXY@wuerfel>
In-Reply-To: <20140210173450.GA5554@obsidianresearch.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com> <201402092130.25615.arnd@arndb.de> <20140210173450.GA5554@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 10 February 2014 10:34:50 Jason Gunthorpe wrote:

> I noticed this on mvebu as well..
> 
> 3.13 w/ mvebu driver:
> 
> e0001000-e0001fff : /mbus/pex@e0000000/pcie@1,0/fpga@0/fpga_sysmon@1000
> e0006000-e0006fff : /mbus/pex@e0000000/pcie@1,0/fpga@0/qdr2p@6000
> 
> 3.10 w/ old kirkwood driver:
> 
> e0000000-e7ffffff : PCIe 0 MEM
>   e0000000-e001ffff : 0000:00:01.0
>     e0001000-e0001fff : /mbus/pex@e0000000/pcie@1,0/fpga@0/fpga_sysmon@1000
>     e0006000-e0006fff : /mbus/pex@e0000000/pcie@1,0/fpga@0/qdr2p@6000
> 
> The latter is obviously correct and matches x86. I'm not sure where
> the new style host drivers are going wrong, even the resource that
> should be added by the PCI core itself for the BAR is missing..

I looked briefly at the code and found that mach-kirkwood/pcie.c does
both request_resource() and pci_add_resource_offset(), while
drivers/pci/host/pci-mvebu.c only does the latter. Does the patch
below restore the previous behavior?

Since the mvebu_pcie_setup() function seems very generic at this,
we should probably try to factor out that code into a common
helper, at least for arm64, but ideally shared with arm32
as well.

	Arnd

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 13478ec..b55e9a6 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -680,9 +680,17 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
 	struct mvebu_pcie *pcie = sys_to_pcie(sys);
 	int i;
 
-	if (resource_size(&pcie->realio) != 0)
+	if (request_resource(&iomem_resource, &pcie->mem))
+		return 0;
+
+	if (resource_size(&pcie->realio) != 0) {
+		if (request_resource(&ioport_resource, &pcie->realio)) {
+			release_resource(&pcie->mem);
+			return 0;
+		}
 		pci_add_resource_offset(&sys->resources, &pcie->realio,
 					sys->io_offset);
+	}
 	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
 	pci_add_resource(&sys->resources, &pcie->busn);
 

