Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0040.outbound.protection.outlook.com ([104.47.36.40]:59875
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933435AbdDGQqm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Apr 2017 12:46:42 -0400
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: 'Joerg Roedel' <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        Samuel Sieb <samuel@sieb.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: RE: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
Date: Fri, 7 Apr 2017 16:46:36 +0000
Message-ID: <BN6PR12MB1652634583ADBB2C93E1414DF70C0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
In-Reply-To: <1491575538-22694-1-git-send-email-joro@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Friday, April 07, 2017 10:32 AM
> To: Bjorn Helgaas
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Daniel Drake=
;
> Deucher, Alexander; Samuel Sieb; David Woodhouse; Joerg Roedel
> Subject: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
>=20
> From: Joerg Roedel <jroedel@suse.de>
>=20
> ATS is broken on this hardware and causes IOMMU stalls and
> system failure. Disable ATS on these devices to make them
> usable again with IOMMU enabled.
>=20
> Note that the commit in the Fixes-tag is not buggy, it
> just uncovers the problem in the hardware by increasing
> the ATS-flush rate.
>=20
> Fixes: b1516a14657a ('iommu/amd: Implement flush queue')
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/pci/quirks.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6736836..7cbe316 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4634,3 +4634,22 @@ static void quirk_no_aersid(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2031,
> quirk_no_aersid);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2032,
> quirk_no_aersid);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033,
> quirk_no_aersid);
> +
> +#ifdef CONFIG_PCI_ATS
> +/*
> + * Some devices have a broken ATS implementation causing IOMMU stalls.
> + * Don't use ATS for those devices.
> + */
> +static void quirk_disable_ats(struct pci_dev *pdev)
> +{
> +	/*
> +	 * Set pdev->ats_cap =3D 0 to make pci_enable_ats() bail out
> +	 * early.
> +	 */
> +	dev_info(&pdev->dev, "QUIRK: Disabling ATS");
> +	pdev->ats_cap =3D 0;
> +}
> +
> +/* AMD Stoney platform GPU */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4,
> quirk_disable_ats);
> +#endif /* CONFIG_PCI_ATS */
> --
> 1.9.1
