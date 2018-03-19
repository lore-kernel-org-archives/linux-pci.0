Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 19 Mar 2018 16:52:34 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: kishon@ti.com, linux-pci@vger.kernel.org,
        Niklas Cassel <niklass@axis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] PCI endpoint 64-bit BAR fixes
Message-ID: <20180319165234.GA12486@e107981-ln.cambridge.arm.com>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180308133331.19464-1-niklas.cassel@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 08, 2018 at 02:33:25PM +0100, Niklas Cassel wrote:
> PCI endpoint fixes to improve the way 64-bit BARs are handled.
> 
> 
> There are still future improvements that could be made:
> 
> pci-epf-test.c always allocates space for
> 6 BARs, even when using 64-bit BARs (which
> really only requires us to allocate 3 BARs).
> 
> pcitest.sh will print "NOT OKAY" for BAR1,
> BAR3, and BAR5 when using 64-bit BARs.
> This could probably be improved to say
> something like "N/A (64-bit BAR)".
> 
> Niklas Cassel (5):
>   PCI: endpoint: BAR width should not depend on sizeof dma_addr_t
>   PCI: designware-ep: Make dw_pcie_ep_set_bar() handle 64-bit BARs
>     properly
>   PCI: designware-ep: Make dw_pcie_ep_reset_bar() handle 64-bit BARs
>     properly
>   PCI: endpoint: Make pci_epc_set_bar() return the BAR width that was
>     set-up
>   misc: pci_endpoint_test: Handle 64-bit BARs properly
> 
>  drivers/misc/pci_endpoint_test.c              | 12 +++++++-----
>  drivers/pci/cadence/pcie-cadence-ep.c         |  2 +-
>  drivers/pci/dwc/pcie-designware-ep.c          | 22 ++++++++++++++++++----
>  drivers/pci/endpoint/functions/pci-epf-test.c | 22 +++++++++++++++-------
>  4 files changed, 41 insertions(+), 17 deletions(-)

Niklas,

I am fine with the series but I'd need Kishon ACKs (and Greg's for the
last patch), I am ready to queue them then.

Thanks,
Lorenzo
