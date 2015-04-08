Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50182 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411AbbDHKc2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 8 Apr 2015 06:32:28 -0400
Date: Wed, 8 Apr 2015 11:32:22 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [Query] Direction of adding arm64 support to PCIe designware
 driver
Message-ID: <20150408103222.GB22376@red-moon>
References: <20150403174621.02681f0d@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150403174621.02681f0d@xhacker>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jisheng,

On Fri, Apr 03, 2015 at 10:46:21AM +0100, Jisheng Zhang wrote:
> Hi all,
> 
> Currently, the pci designware driver still lacks of arm64 support and I noticed
> that many works are done to achieve this goal.
> 
> Some patches are merged and some are under discussion. And Per my understanding, 
> even w/ these patches merged, the driver still doesn't support arm64. Could you
> please kindly point out the direction to add arm64 support to the PCIe
> designware driver?

We should remove pci_sys_data dependency since ARM depends on that.
I removed it from a couple of places already (eg pci_mmap_page_range).

Now, pcibios_align_resource and pcibios_msi_controller need patching.

I have a patch for pcibios_align_resource() (I am waiting for Yijing
Wang series to get merged so that we can move the align_resource
function pointer in the host bridge):

https://lkml.org/lkml/2015/4/3/171

For MSI, code converted to use CONFIG_PCI_MSI_IRQ_DOMAIN should
not need pcibios_msi_controller ARM function, but if we still compile
that function in we do need pci_sys_data on ARM, so we have to have
it even if it can be dead code in some platforms, I have to vet all
ARM PCI host controllers to check, but removing it would break MSI
support.

Does it help ? MSIs are the most important change required,
align_resource() pointer can be sorted out easily once Yijing's
code gets in.

Lorenzo
