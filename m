Return-Path: <SRS0=C84e=CM=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=C84e=CM=arm.com=lorenzo.pieralisi@kernel.org>
Date: Tue, 14 Nov 2017 17:21:45 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
	rfi@lists.rocketboards.org,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
	Ley Foon Tan <lftan@altera.com>,
	linux-arm-kernel@lists.infradead.org,
	Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH v1 0/3] PCI: Rename host functions for consistency
Message-ID: <20171114172144.GA15495@red-moon>
References: <20171113224001.29024.87126.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171113224001.29024.87126.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 13, 2017 at 04:40:36PM -0600, Bjorn Helgaas wrote:
> All native host bridge driver probe functions are called *_pci_probe() or
> *_pcie_probe() *except* X-Gene's.  All "is the link up?" functions are
> called *_pcie_link_up() *except* Altera's and Xilinx's.  Rename them to be
> consistent.
> 
> I plan to include these for v4.15 unless there are objections.
> 
> ---
> 
> Bjorn Helgaas (3):
>       PCI: xgene: Rename xgene_pcie_probe_bridge() to xgene_pcie_probe()
>       PCI: altera: Rename altera_pcie_link_is_up() to altera_pcie_link_up()
>       PCI: xilinx: Rename xilinx_pcie_link_is_up() to xilinx_pcie_link_up()
> 
> 
>  drivers/pci/host/pci-xgene.c   |    4 ++--
>  drivers/pci/host/pcie-altera.c |    8 ++++----
>  drivers/pci/host/pcie-xilinx.c |    6 +++---
>  3 files changed, 9 insertions(+), 9 deletions(-)

On the series:

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
