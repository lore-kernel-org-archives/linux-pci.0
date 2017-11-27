Return-Path: <SRS0=OANM=CZ=gmail.com=ckoenig.leichtzumerken@kernel.org>
Return-Path: <SRS0=OANM=CZ=gmail.com=ckoenig.leichtzumerken@kernel.org>
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] PCI: use dev_info rather than dev_err for rom validation
To: Alex Deucher <alexdeucher@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20171127172110.16699-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6b705b32-b955-00d2-5ac9-10a21c2aab3f@gmail.com>
Date: Mon, 27 Nov 2017 18:26:19 +0100
MIME-Version: 1.0
In-Reply-To: <20171127172110.16699-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Am 27.11.2017 um 18:21 schrieb Alex Deucher:
> On AMD GPUs, we use several mechanisms to fetch the vbios
> rom depending on the platform.  We try to read the rom
> back via the rom BAR and fall back to other methods in
> some cases.  This leads to spurious error messages
> from the pci rom code which are harmless in our case.
> This leads to bugs being files, etc.  Change these to
> dev_info rather than dev_err to avoid that.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/pci/rom.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index b6edb187d160..7ab7c6bb17c6 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -92,14 +92,14 @@ size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom, size_t size)
>   		void __iomem *pds;
>   		/* Standard PCI ROMs start out with these bytes 55 AA */
>   		if (readw(image) != 0xAA55) {
> -			dev_err(&pdev->dev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
> +			dev_info(&pdev->dev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
>   				readw(image));
>   			break;
>   		}
>   		/* get the PCI data structure and check its "PCIR" signature */
>   		pds = image + readw(image + 24);
>   		if (readl(pds) != 0x52494350) {
> -			dev_err(&pdev->dev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
> +			dev_info(&pdev->dev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
>   				readl(pds));
>   			break;
>   		}
