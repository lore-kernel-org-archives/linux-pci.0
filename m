Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Pankaj Dubey' <pankaj.dubey@samsung.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: RE: [PATCH] PCI: dwc: designware: don't sleep in atomic context
Date: Thu, 12 Oct 2017 10:39:39 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00924BC@AcuExch.aculab.com>
References: <CGME20171012075438epcas2p32599c2db4ed1512c81d1039bb1ed5607@epcas2p3.samsung.com>
 <1507794889-11148-1-git-send-email-pankaj.dubey@samsung.com>
In-Reply-To: <1507794889-11148-1-git-send-email-pankaj.dubey@samsung.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Pankaj Dubey
> Sent: 12 October 2017 08:55
> In pcie-designware.c many places we are calling "usleep_range" which
> are in atomic context. This patch fixes these potential BUGs and
> replaces "usleep_range" with mdelay calls.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  drivers/pci/dwc/pcie-designware.c | 8 ++++----
>  drivers/pci/dwc/pcie-designware.h | 3 +--
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
> index 88abddd..35d19b9 100644
> --- a/drivers/pci/dwc/pcie-designware.c
> +++ b/drivers/pci/dwc/pcie-designware.c
> @@ -138,7 +138,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
>  		if (val & PCIE_ATU_ENABLE)
>  			return;
> 
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU_MIN);
>  	}

Spinning for 9ms (possibly 10 times) isn't really a good idea.

	David
