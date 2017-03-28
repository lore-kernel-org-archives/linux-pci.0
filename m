Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0084.outbound.protection.outlook.com ([104.47.33.84]:49440
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752358AbdC1US3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Mar 2017 16:18:29 -0400
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: 'Joerg Roedel' <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Daniel Drake <drake@endlessm.com>,
        "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH] PCI: Blacklist AMD Stoney GPU devices for ATS
Date: Tue, 28 Mar 2017 20:18:26 +0000
Message-ID: <BN6PR12MB1652414344196BA60520B828F7320@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1490703404-4944-1-git-send-email-joro@8bytes.org>
In-Reply-To: <1490703404-4944-1-git-send-email-joro@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Tuesday, March 28, 2017 8:17 AM
> To: Bjorn Helgaas
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Joerg Roedel=
;
> Daniel Drake; Deucher, Alexander
> Subject: [PATCH] PCI: Blacklist AMD Stoney GPU devices for ATS
>=20
> From: Joerg Roedel <jroedel@suse.de>
>=20
> ATS is broken on these devices. Under invalidation load, the
> GPU does not reply to invalidations anymore, causing
> Completion-wait loop timeouts on the AMD IOMMU driver side.
> Fix it by not enabling ATS on these devices.
>=20
> Note that below mentioned commit is not broken, it just
> triggers the issue because it might cause invalidation
> storms on devices.
>=20
> Fixes: b1516a14657a ('iommu/amd: Implement flush queue')
> Reported-by: Daniel Drake <drake@endlessm.com>
> Cc: Daniel Drake <drake@endlessm.com>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Did you see Arindam's patch from yesterday[1]?  Not sure which is the prope=
r fix, maybe both?

Alex

[1] - https://lists.freedesktop.org/archives/amd-gfx/2017-March/006862.html

> ---
>  drivers/pci/ats.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index eeb9fb2..711bdb2 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -17,10 +17,18 @@
>=20
>  #include "pci.h"
>=20
> +static const struct pci_device_id broken_ats_tbl[] =3D {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x98e4) }, /* AMD Stoney GPU
> part */
> +	{ 0 }
> +};
> +
>  void pci_ats_init(struct pci_dev *dev)
>  {
>  	int pos;
>=20
> +	if (pci_match_id(broken_ats_tbl, dev))
> +		return;
> +
>  	pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
>  	if (!pos)
>  		return;
> --
> 1.9.1
