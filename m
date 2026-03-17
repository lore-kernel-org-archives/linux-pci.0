Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F927FB0E;
	Tue, 17 Mar 2026 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761169; cv=none; b=Mn+GWwGriqOWf6IH71vc9n0Ab7tZcPh7h9IHI6aZUu5xRIm2uiTpcNhrQyS7NYahWD8RUrGI4QgOQhrBfS7IXXFK7eHLsY7cQ1yHu9ICHV5ycQ2bMfxg3j8KxDDE9UfMVvFTN5g2X9NmEcXHhnZSjzgrScIM9fBkgMH8bBK+1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761169; c=relaxed/simple;
	bh=U6HAOSeXpFA2xVKYhwIX8W3T28VbdLC3tfuXap/m1NI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZTFGWSY3znRWA+z7jg+YJ2AWs/yssT3+vVxkvKl5f/YL2cqUq+6mLucAok57qC/ywZnMk371PB97n60W0QwVjSEhtlbw6qcOeXtUVQyij6ASecyPeuVccOAQF8bv17NlFAqvL9MUtJGDzOapFRSxytduEK8x+NT/iIwykEOuGAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UF1h+bd/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UF1h+bd/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773761168; x=1805297168;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=U6HAOSeXpFA2xVKYhwIX8W3T28VbdLC3tfuXap/m1NI=;
  b=UF1h+bd/EbHoGukjg+5hBT9Wm57COakL3Hs3V6pwAUQh7DJsctbq335L
   n+Vuwbl7ts4PQD5GefQGRf9/ANJu90E8ORJ7BCIFw27Js/bPLjDZnpNZO
   bRkxary/qhTyEQiBsCjQvs9iLI3D/FCK4oXbIYqGwaX3879eu69PSfRtP
   ppogAxbRqxnsc3eOgJJGdtjiW4jGPRMuOmVEAmhPqIyJ2l4F4G/bqe3/t
   S061xbvqgMYu1pZ89Fp5Bl2Hsa1rjIZ0Pb+o8GTI8XbI3G/1noiVhOoZD
   p1ebJoPV7Bt2f1gLD+IqDMezat1qsOq+VH0jIo7Xew6DcMbNtCmC/s032
   w==;
X-CSE-ConnectionGUID: Qr35Mc7lSMy32ZoxmQomTw==
X-CSE-MsgGUID: GMS97VovSfaZufI0WRC6bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="73814371"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="73814371"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:26:07 -0700
X-CSE-ConnectionGUID: RgYiXBrtSTSlzqFAWWH6Ig==
X-CSE-MsgGUID: MrSQlNn4RuOayo1ru5RS2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="221356702"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.161])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:26:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 17:25:57 +0200 (EET)
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
    =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
    Tyrel Datwyler <tyreld@linux.ibm.com>, linux-pci@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, 
    linuxppc-dev@lists.ozlabs.org, 
    Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v2 3/4] PCI: pnv_php: Simplify with scoped for each OF
 child loop
In-Reply-To: <20260317133322.266102-7-krzysztof.kozlowski@oss.qualcomm.com>
Message-ID: <f4a8c26d-99ee-2f12-ddcf-cda2aaf0cf5b@linux.intel.com>
References: <20260317133322.266102-5-krzysztof.kozlowski@oss.qualcomm.com> <20260317133322.266102-7-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-823548865-1773761157=:968"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-823548865-1773761157=:968
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 17 Mar 2026, Krzysztof Kozlowski wrote:

> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
>=20
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>=20
> ---
>=20
> Changes in v2:
> Tags
> ---
>  drivers/pci/hotplug/pnv_php.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.=
c
> index 5c020831e318..ff92a5c301b8 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -215,24 +215,19 @@ static void pnv_php_reverse_nodes(struct device_nod=
e *parent)
>  static int pnv_php_populate_changeset(struct of_changeset *ocs,
>  =09=09=09=09      struct device_node *dn)
>  {
> -=09struct device_node *child;
> -=09int ret =3D 0;
> +=09int ret;
> =20
> -=09for_each_child_of_node(dn, child) {
> +=09for_each_child_of_node_scoped(dn, child) {
>  =09=09ret =3D of_changeset_attach_node(ocs, child);
> -=09=09if (ret) {
> -=09=09=09of_node_put(child);
> -=09=09=09break;
> -=09=09}
> +=09=09if (ret)
> +=09=09=09return ret;
> =20
>  =09=09ret =3D pnv_php_populate_changeset(ocs, child);
> -=09=09if (ret) {
> -=09=09=09of_node_put(child);
> -=09=09=09break;
> -=09=09}
> +=09=09if (ret)
> +=09=09=09return ret;
>  =09}
> =20
> -=09return ret;
> +=09return 0;
>  }
> =20
>  static void *pnv_php_add_one_pdn(struct device_node *dn, void *data)
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-823548865-1773761157=:968--
