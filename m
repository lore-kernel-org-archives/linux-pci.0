Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 06/10] misc: pci_endpoint_test: Add designware EP entry
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
References: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
 <11fa6ecaae3b0c004b18e57b6b16b2b89ad4dfd4.1523881182.git.gustavo.pimentel@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <549c7c45-4e01-33b6-a105-2a621128c748@ti.com>
Date: Tue, 17 Apr 2018 14:52:17 +0530
MIME-Version: 1.0
In-Reply-To: <11fa6ecaae3b0c004b18e57b6b16b2b89ad4dfd4.1523881182.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Monday 16 April 2018 08:07 PM, Gustavo Pimentel wrote:
> Adds the designware EP device ID entry to pci_endpoint_test driver table
> to allow this device to be recognize and handle by the pci_endpoint_test
> driver.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Change v1->v2:
> - Changed device id following Kishon's suggestion.
> Change v2->v3:
> - Nothing changed, just to follow the patch set version.
> Changes v3->v4:
> - Nothing changed, just to follow the patch set version.
> 
>  drivers/misc/pci_endpoint_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index fe8897e..37db0fc 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -634,6 +634,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
>  static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, PCI_DEVICE_ID_SYNOPSYS_SMPL_EP) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
> 
