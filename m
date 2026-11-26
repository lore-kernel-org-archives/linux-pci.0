Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795653202;
	b=py+F+7cwkn/mo7uxPYOKKFpPIy0buWj6d1xwho2JZx3DCRX72IPj2MNwAA+/UjnpZxKd
	 p2LjpWJHbBMp7iL15a5TJS3E/CoaekLsg1v5YTu7cRCG3LXpMX4uB7YmDcprJqPWbEQdB
	 0QLczs2JlWDp6o4Suz7TSsdVu4oxTss7zRYEtTtM0ZQYGhzJf6S9MgXb77mBh4gWzP5Nl
	 dXfsGViht5xR3tXrwk3LGcqhNu7CDPjbFAub60yzGXi9LkoIhx7Js/eOFiZNJyvItx/mN
	 eFKafDlAfWlwaAGESo/LKhJIlOFTlSQQA5iOEfrFN8iTJ8M8ObqelLVnIp3UpPoQIag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795653202;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:
	 Content-Transfer-Encoding;
	bh=bkVnt5x6snV/jr94cYM++Xh7cb4q6PuWBIFYI70gTyg=;
	b=Z59XJ8eKaxxy8mGUAcPQcSGRJpTtU7Eu4wJwECtxpMGxWsecjGgzgMaIMA3i1B9We7hg
	 AW+7G5GO3ljP3CQOZqmXVgiCTDhDLE/nZKIDfoW9jH5+CD8t4Zz0R+f48JbN+zBYiKQZg
	 WSZd4/vZ6k7qCyMtSRtNUHcq8NusJcTUlVETSgegjlcDpe44arfMBN0iU2Ee5oWODxKDt
	 r9LPJyk9fSWFeT8BCF6Y6M6SjEjmILwjDlktDvNCfdC//1axu7DzCuD/USq4Xzs7+0h50
	 ITpQZS/DbptR6exUuXEvrFaONj4dvFTbyjN1AJ0dBjgR2Ylb13DkOHQPDLBhQWXcVkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=fail reason="signature verification failed" header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b="DbxIXyP/";
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269E8606A323;
	Thu, 26 Nov 2026 00:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 269E8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=DbxIXyP/
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A234340E0232;
	Thu, 26 Nov 2026 00:33:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UOQM5oECOoh7; Thu, 26 Nov 2026 00:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795653193; bh=LET1Bou+dV9QSsRxgNAzEMVbQ5p9yJ4crrWpmY8stqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbxIXyP/IpF5rt5A6Z7ECR8zlMsDfebBgBm5OL3+l4T+oLgJxmRxrsogYS+sUGMux
	 EDJ5GKOoWw3T2TX4+2y/I7X27+Uc5RAsp66MTNYD0y5IrsN5vlV1KmDwCm3nanwyf8
	 C+5TYovtuX1dyE+AJx3/lLpPRcarQx/6QG3OS64cbd7eY0jdqQV1ZoiYP/xcx+7wda
	 ZEV1nDrNBOL3BgedsobXdcoYiTksxYvHD5lTcUIuE6wQKYvd4yELj0s3GJVYtpAM3D
	 EJDCNucgWsA0AhuCyxYEF4QFstEMifxRTAICYvTMgGwYg0HHXPg65keieYm6uja4Zv
	 c4w2UgqpbwBI/T3FK1wPyhLHHoUXUg3U6DrYcZydObF4znkaBekrkZB63Uur1JpNLS
	 u33L8Q4mK+jIfbJqkro+0eUn/1jMr9NOn4aZcU2CCI/Rzxp+O/rVmyNLS2Mj4ChyCN
	 i1wEJkYKnt7XvBKe1Eiu1qzoIs3cPseX/ZYq5YZXBtsn7N7M/O1Jf3ifKxUhvaxOV5
	 oC96XejJBj36Wlo2ZxURRNjrxWHdLBVtxWyXPBHmG4V/bqP4ATeOPSC6sD9/hjkiNt
	 yOZjfwUo6LH2OHG1X3rx/af+Mv34yG+vfyEU6rEeyaQL56Th7h/ofhVI4MgMAvpZx7
	 701CESX7kPADclxF1k2e9+Ok=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0444F40E0140;
	Thu, 26 Nov 2026 00:33:01 +0000 (UTC)
Date: Wed, 25 Nov 2026 16:32:58 -0800
From: Borislav Petkov <bp@alien8.de>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	David Matlack <dmatlack@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/17] EDAC/i82875p: Convert to
 pci_assign_unassigned_bus_resources()
Message-ID: <20261126003258.GBawd-OkxwAzwVVNI_@fat_crate.local>
References: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
 <20261125230925.2441-11-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261125230925.2441-11-ilpo.jarvinen@linux.intel.com>
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 01:09:09AM +0200, Ilpo J=C3=A4rvinen wrote:
> The i82875p_edac driver scans a single device and then attempts to
> assign its resources using pci_bus_assign_resources(). That function
> makes bridge window sizing disjoint from the assignment phase and is
> going to be removed.
>=20
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources() which is likely a no-op in this
> case as it looks like bridges are not involved here.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/edac/i82875p_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/edac/i82875p_edac.c b/drivers/edac/i82875p_edac.c
> index 869de8e372b3..59a92a209dea 100644
> --- a/drivers/edac/i82875p_edac.c
> +++ b/drivers/edac/i82875p_edac.c
> @@ -290,7 +290,7 @@ static int i82875p_setup_overfl_dev(struct pci_dev =
*pdev,
>  		if (dev =3D=3D NULL)
>  			return 1;
> =20
> -		pci_bus_assign_resources(dev->bus);
> +		pci_assign_unassigned_bus_resources(dev->bus);
>  		pci_bus_add_device(dev);
>  	}
> =20
> --=20

You can drop this from your set:

e5c2a84fd615 ("EDAC/i82875p: Convert to pci_assign_unassigned_bus_resourc=
es()")

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
