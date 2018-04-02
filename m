Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:34821 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbeDBFgO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Apr 2018 01:36:14 -0400
Subject: Re: [PATCH 4/8] misc: pci_endpoint_test: Add designware EP entry
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
References: <cover.1522235224.git.gustavo.pimentel@synopsys.com>
 <1bc09dfd205d0721366267e023550c4a5a4a84db.1522235224.git.gustavo.pimentel@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <76c6e35c-5659-7313-a1b4-aa93e323ef79@ti.com>
Date: Mon, 2 Apr 2018 11:06:02 +0530
MIME-Version: 1.0
In-Reply-To: <1bc09dfd205d0721366267e023550c4a5a4a84db.1522235224.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Wednesday 28 March 2018 05:08 PM, Gustavo Pimentel wrote:
> Adds the designware EP device ID entry to pci_endpoint_test driver table
> to allow this device to be recognize and handle by the pci_endpoint_test
> driver.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 320276f..e80c533 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -632,6 +632,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
>  static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, 0xedda) },

Add device ids to include/linux/pci_ids.h and use the macro here.

Thanks
Kishon
