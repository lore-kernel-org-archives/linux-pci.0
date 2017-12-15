Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 15 Dec 2017 13:25:06 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: linux-pci@vger.kernel.org, kishon@ti.com,
        Niklas Cassel <niklass@axis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Fix find_first_zero_bit() usage
Message-ID: <20171215132506.GB30737@red-moon>
References: <20171214130147.1790-1-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171214130147.1790-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 14, 2017 at 02:01:43PM +0100, Niklas Cassel wrote:
> find_first_zero_bit()'s parameter 'size' is defined in bits,
> not in bytes.
> 
> Calling find_first_zero_bit() with the wrong size unit
> will lead to insidious bugs.
> 
> Fix all uses of find_first_zero_bit() called with
> sizeof() as size argument in drivers/pci.
> 
> Niklas Cassel (3):
>   PCI: designware-ep: Fix find_first_zero_bit() usage
>   PCI: endpoint: Populate func_no before calling pci_epc_add_epf()
>   PCI: endpoint: Fix find_first_zero_bit() usage
> 
>  drivers/pci/dwc/pcie-designware-ep.c | 34 ++++++++++++++++++++++++++--------
>  drivers/pci/dwc/pcie-designware.h    |  8 ++++++--
>  drivers/pci/endpoint/pci-ep-cfs.c    | 19 ++++++++++---------
>  3 files changed, 42 insertions(+), 19 deletions(-)

Applied to pci/endpoint for v4.16 (updated some commit logs)
with Kishon's ACKs.

Thanks,
Lorenzo
