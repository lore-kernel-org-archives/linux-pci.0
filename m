Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230209;
	b=0ZqqB8bai2QCTvLaiuDf9btAOB3DC3lSzeEFdY2NXiZ1CujCcnxML1dvoD4m0c9Ub1zh
	 hLWm58Z8ik9MtwqWix8z2U9BBrwnKSZ3HxvRENkJppkFnfYqalWfJCGNRkCNyVu++3zvz
	 hwIgpbUUqjm14c/+qnsuJNmAqLbsjZFlliUVL2gHV7wepeBok70jWb09+n5pF9xvfW7rN
	 3kGTrHH7XTUzMCsc2R/LIHoy1EY8DKm6AECEI/GqWJtcrh8vRQkG8ObUoY1L6sk/cEIon
	 /OAPUARZB3tyN9zqADWde68AqI3a8K3yAYLXNdpN4XyCZ4jwqjjjOGdTWpT2xs5NWPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230209;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=LccMJis6sYnn44X90MSK47Ehqu5qOodsJEfJUs7rEMo=;
	b=xYLghpljUg5GQqbkFsnPh/eMGkKFyWytRGzejYF+748Bq9eeG17ZsdhPFx8v+0mHLs3w
	 vIV+dbehWDY7xrgRcoW/CQRWy0ZAfO8qKOGn/wCklKb9zYG3b6rt+HuI0My3/EHNM6jgX
	 pYFXNnuGprjGh1jfF2TgR7q5frPfCjcFqjM/9eZVN408UQLzwBsd2MKxPl90BbC3kFdZE
	 PDu5c1a/oAKnbv/8QoPBNIhKC1BcFfKknfVVCA0sokW9qu+hAlSteD6uFN7pqnrmW7VZP
	 3cz2K1hKO+zGJsoCuGxH2XNTdj+ftyq5NGh5csiWWwgwdbxe7VDKDfVsXH6EJwgytQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kLb3eUCL;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318B4606A33A;
	Mon,  9 Nov 2026 13:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 318B4606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kLb3eUCL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794230209; x=1825766209;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oJECIkof0wKIc6PeDXCw3rXlNlQaD2qboHkqbMUp6Mo=;
  b=kLb3eUCLnNdgOzNMbcPbV/ClsVb8MppaUNyUcjfwJNb8YzxvRcshnUpC
   lPOqz/2fX7KXcVBDaRDb1DM61b4A/qpW108Gk2Utyypw1eXLc6Syw8RNX
   yuAu8HAKZx+1MvRzGNZ6KWgUc4sBGPmkQYDHRAZo5FGHZGS+4hQ8pgeOk
   AJZBYMRUTNpDxkQNJi8qkzGtiiXj0DOmyprj3O57SKVzTCs/q/5lTVX7F
   6L7Zq5pVmq3QxcVITHohO0mf6HUmfjdDzsRVuuyQaGArVzx5Gavv3Zvtq
   j7bFxod57CCpeOFz1fZaw7zHr2GDL4dBRvzOwvnF1f/1dsqV6WkilGA0L
   g==;
X-CSE-ConnectionGUID: +VeD7g3XTy2YHcVLJs2qZQ==
X-CSE-MsgGUID: QirATWYQTXyXWd0I2X4SxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2828591"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2828591"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:16:48 -0800
X-CSE-ConnectionGUID: vIFble+JSaOAKm1Cdg5yZw==
X-CSE-MsgGUID: 8U0mSmWlTfmLKtGjOI5Cxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7717855"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:16:46 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Nov 2026 15:16:42 +0200 (EET)
To: shao.mingyin@zte.com.cn
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Reject negative resource alignment order
In-Reply-To: <20261109185515838mOfBTIYMU1_4vygdxd-Gg@zte.com.cn>
Message-ID: <4f46d7de-5a52-4c01-3048-c8eee380c53d@linux.intel.com>
References: <20261109185515838mOfBTIYMU1_4vygdxd-Gg@zte.com.cn>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1838671496-1794230202=:1181"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1838671496-1794230202=:1181
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 9 Nov 2026, shao.mingyin@zte.com.cn wrote:

> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>=20
> pci_specified_resource_alignment() parses the pci=3Dresource_alignment=3D
> boot parameter and rejects only orders above 63.  A negative order, such
> as "pci=3Dresource_alignment=3D-5@...", passes that check and later reach=
es
> "align =3D 1ULL << align_order" with a negative shift count, which is
> undefined behavior; on x86 the 64-bit shift count is masked to six bits,
> silently producing a 2^59-byte alignment that mis-aligns (or fails to
> align) the affected IOV resources.
>=20
> align_order is a bit order, so parse it with %u.  vsscanf() does not
> accept a sign for %u, so a negative order no longer converts: the
> parameter is reported as invalid and no alignment is applied.  Orders
> above 63 are still rejected and fall back to the page-size alignment.
>=20
> Fixes: 6534aac198b5 ("PCI: Bounds-check command-line resource alignment r=
equests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> This supersedes 1/5 of the v1 series; 2/5-5/5 are unchanged.
>=20
> v2:
>   - parse the order with %u instead of %d, as Ilpo J=C3=A4rvinen suggeste=
d; a
>     bit order is unsigned, and this also removes the explicit < 0 test
>     added by v1
>   - pr_err() prints the order with %u as well
>   - note the resulting behaviour: vsscanf() does not accept a sign for
>     %u, so a negative order fails to parse instead of being clamped
> v1: https://lore.kernel.org/all/20261107002311316z2o2PFtFGoXh-VbqXtTGg@zt=
e.com.cn/
>=20
> Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the
> pci=3Dresource_alignment=3D boot parameter and a QEMU e1000 NIC; no extra
> hardware is needed.
>=20
> Booting with pci=3Dresource_alignment=3D-5@pci:8086:100e, the unpatched
> kernel parses -5 and "align =3D 1ULL << align_order" shifts by -5 (masked
> to 2^59 on x86-64); the e1000 BAR is resized to 2^59 bytes, which cannot
> be assigned, and the e1000 fails to probe.  With this patch "-5" does not
> convert and the parameter is rejected:
>=20
>   unpatched                            patched
>   requesting alignment to              PCI: Can't parse resource_alignmen=
t
>   0x800000000000000                    parameter: -5@pci:8086:100e
>   e1000 probe failed, no eth0          e1000 eth0 probes
>=20
>  drivers/pci/pci.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index bca3a5d84cd9..e3f701ff9881 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6585,7 +6585,8 @@ static DEFINE_SPINLOCK(resource_alignment_lock);
>  static resource_size_t pci_specified_resource_alignment(struct pci_dev *=
dev,
>  =09=09=09=09=09=09=09bool *resize)
>  {
> -=09int align_order, count;
> +=09unsigned int align_order;
> +=09int count;
>  =09resource_size_t align =3D pcibios_default_alignment();
>  =09const char *p;
>  =09int ret;

I'd have preferred having count and ret on the same line.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> @@ -6602,11 +6603,11 @@ static resource_size_t pci_specified_resource_ali=
gnment(struct pci_dev *dev,
> =20
>  =09while (*p) {
>  =09=09count =3D 0;
> -=09=09if (sscanf(p, "%d%n", &align_order, &count) =3D=3D 1 &&
> +=09=09if (sscanf(p, "%u%n", &align_order, &count) =3D=3D 1 &&
>  =09=09    p[count] =3D=3D '@') {
>  =09=09=09p +=3D count + 1;
>  =09=09=09if (align_order > 63) {
> -=09=09=09=09pr_err("PCI: Invalid requested alignment (order %d)\n",
> +=09=09=09=09pr_err("PCI: Invalid requested alignment (order %u)\n",
>  =09=09=09=09       align_order);
>  =09=09=09=09align_order =3D PAGE_SHIFT;
>  =09=09=09}
>=20
--8323328-1838671496-1794230202=:1181--
