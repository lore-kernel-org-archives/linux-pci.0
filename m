Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 18 Apr 2018 08:40:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 05/10] PCI: Adds device ID for Synopsys Sample
 Endpoint.
Message-ID: <20180418134035.GM28657@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1523973931.git.gustavo.pimentel@synopsys.com>
 <5d20185e88e7b6738d6b6aca41b1a237033fc36f.1523973931.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5d20185e88e7b6738d6b6aca41b1a237033fc36f.1523973931.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 17, 2018 at 03:34:23PM +0100, Gustavo Pimentel wrote:
> The PCIe controller dual mode is capable of operating in host mode as well
> as endpoint mode by configuration.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Change v1->v2:
>  - Register new device id following Kishon's suggestion.
> Change v2->v3:
>  - Nothing changed, just to follow the patch set version.
> Changes v3->v4:
>  - Nothing changed, just to follow the patch set version.
> Changes v4->v5:
>  - Nothing changed, just to follow the patch set version.
> 
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index cc608fc5..22b1c1b 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2350,6 +2350,7 @@
>  #define PCI_DEVICE_ID_CENATEK_IDE	0x0001
>  
>  #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
> +#define PCI_DEVICE_ID_SYNOPSYS_SMPL_EP	0xedda

This definition is only used once, so it fails the test at the top of
pci_ids.h (we only add entries that will be shared between multiple
drivers).  Just use the 0xedda constant in the driver.

I'm not really sure there's much value in the device ID definitions at
all.  Maybe we should consider adding only new vendor IDs?

>  #define PCI_VENDOR_ID_VITESSE		0x1725
>  #define PCI_DEVICE_ID_VITESSE_VSC7174	0x7174
> -- 
> 2.7.4
> 
> 
