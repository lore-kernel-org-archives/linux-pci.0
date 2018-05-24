Return-Path: <SRS0=6mTy=IL=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=6mTy=IL=arm.com=lorenzo.pieralisi@kernel.org>
Date: Thu, 24 May 2018 12:44:52 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <keith.busch@intel.com>,
	linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	Myron Stowe <myron.stowe@redhat.com>,
	Dave Fugate <david.fugate@intel.com>,
	Scott Bauer <scott.bauer@intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/5] Enable an additional VMD device id
Message-ID: <20180524114452.GA20732@e107981-ln.cambridge.arm.com>
References: <20180518192802.20371-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180518192802.20371-1-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 18, 2018 at 01:27:57PM -0600, Jon Derrick wrote:
> This patchset enables an additional VMD device ID to the VMD driver
> supporting assignment of the membar addresses from shadow registers and
> allows more flexibility in assigning bus numbers to a VMD PCIe domain.
> Additional VMD root port device ids have been added to the VMD AER
> quirk.
> 
> Changes from rfc include comments, code structure, and using
> pci_add_resource_offset to correctly assign addresses while virtualized.
> 
> Applies to Bjorn's next branch

Hi Jon,

You should base it on v4.17-rc1 and if there is a dependency on
later -rc* or a branch in Bjorn/my queue please let us know.

> Jon Derrick (5):
>   PCI: Add Intel VMD devices to pci ids
>   PCI/VMD: Assign membar addresses from shadow registers
>   PCI/VMD: Add offset to bus numbers if necessary
>   x86/PCI: Add additional VMD device root ports to VMD AER quirk
>   PCI/VMD: Add an additional VMD device id to driver device id table
> 
>  arch/x86/pci/fixup.c    |  4 +++
>  drivers/pci/host/vmd.c  | 91 +++++++++++++++++++++++++++++++++++++++++++------
>  include/linux/pci_ids.h |  2 ++
>  3 files changed, 87 insertions(+), 10 deletions(-)

I need Bjorn's ACK on patch (4), or if Bjorn is keen on pulling the
series, here's mine on the series:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
