Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0050.outbound.protection.outlook.com ([104.47.37.50]:43191
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933550AbeFLOeI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jun 2018 10:34:08 -0400
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhu, Rex" <Rex.Zhu@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Daenzer, Michel" <Michel.Daenzer@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "Zhu, Rex" <Rex.Zhu@amd.com>
Subject: RE: [PATCH 1/2] PCI: Avoid access memory outside the resource window
Date: Tue, 12 Jun 2018 14:34:05 +0000
Message-ID: <BN6PR12MB18094ED53FC13A7C7A83BD38F77F0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1528163206-4136-1-git-send-email-Rex.Zhu@amd.com>
In-Reply-To: <1528163206-4136-1-git-send-email-Rex.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Rex Zhu [mailto:Rex.Zhu@amd.com]
> Sent: Monday, June 4, 2018 9:47 PM
> To: bhelgaas@google.com; Daenzer, Michel <Michel.Daenzer@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; linux-
> pci@vger.kernel.org
> Cc: Zhu, Rex <Rex.Zhu@amd.com>
> Subject: [PATCH 1/2] PCI: Avoid access memory outside the resource
> window
>=20
> change ">" to ">=3D" to avoid access beyond the actual length of io memor=
y.
>=20
> Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/pci/rom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c index 374a334..a5c6016
> 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -108,7 +108,7 @@ size_t pci_get_rom_size(struct pci_dev *pdev, void
> __iomem *rom, size_t size)
>  		length =3D readw(pds + 16);
>  		image +=3D length * 512;
>  		/* Avoid iterating through memory outside the resource
> window */
> -		if (image > rom + size)
> +		if (image >=3D rom + size)
>  			break;
>  	} while (length && !last_image);
>=20
> --
> 1.9.1
