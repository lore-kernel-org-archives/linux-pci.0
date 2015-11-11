Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:54059 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbbKKKK1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2015 05:10:27 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: RE: [PATCH] ARM/PCI: move align_resource function pointer into
 pci_host_bridge structure
Date: Wed, 11 Nov 2015 10:09:45 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E162A7A2E@lhreml503-mbs>
References: <1447204345-143793-1-git-send-email-gabriele.paoloni@huawei.com>
 <5509277.PRqCf43vDc@wuerfel>
In-Reply-To: <5509277.PRqCf43vDc@wuerfel>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Wednesday, November 11, 2015 4:48 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: Gabriele Paoloni; linux-pci@vger.kernel.org;
> lorenzo.pieralisi@arm.com; linux@arm.linux.org.uk; xuwei (O); Wangzhou
> (B); bhelgaas@google.com; Liguozhu (Kenneth)
> Subject: Re: [PATCH] ARM/PCI: move align_resource function pointer into
> pci_host_bridge structure
> 
> On Wednesday 11 November 2015 09:12:25 Gabriele Paoloni wrote:
> > From: gabpao01 <gabriele.paoloni@huawei.com>
> 
> Regardless of this patch, you might want to update your global git
> config
> to use the proper name for your commits.

Sorry, I am travelling and moved to another PC...I didn't notice
the wrong name, my bad.

> 
> > commit b3a72384fe29 ("ARM/PCI: Replace
> > pci_sys_data->align_resource with global function pointer") has
> > introduced a global function pointer that makes the ARM specific
> > code not portable and broken in case any platform have a two
> > different HW IPs for the PCIe host bridge controller.
> > This patch moves align_resource function pointer into
> > pci_host_bridge structure so that the code is now suitable to be
> > reworked as we want to get rid of hw_pci structure (the host bridge
> > drivers can just set the align function pointer in the
> > pci_host_bridge structure) and there is no more broken code for a
> > SoC with two HW IPs.
> >
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> 
> Thanks for doing this, that addresses my main concerns, and is probably
> small enough to still get it into 4.4 if Bjorn agrees with the general
> idea of putting more function pointers into struct pci_host_bridge.
> 
> As a follow-on to this, we can now try to get rid of
> pcibios_align_resource
> by moving the existing per-architecture implementations in there as
> well,
> with a reasonable default for the common case.
> 
> 	Arnd
