Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300F214A64;
	Tue, 17 Mar 2026 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761193; cv=none; b=SU8dp6vA37hULqiYnCv9rsCd+ogSxTpbMe0KXSbSbgJNMkzdDp1SjBLl3yzKM9WWqRZvSKJi2slJ9Z7BuVjWssKxY3ExalbnIi4b+EXeAt8/8v6qKq3uqSb3Rrvz4aKwhEKXDOScRFC5rkNMxNHodWuTwgVlQLzYy8u9T/1uBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761193; c=relaxed/simple;
	bh=hYXp9a2NLaQVekWjZ+4yth845DCIClXSayYXXsM3Uyc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TDdyKD3CpgJcq5+C9G6ob+C6MOHbQ0A+D+VGUe1EBrUIwVQzcxlplt3IT+sWBy1CyAUpc1jEH+et6UM2NM21S71ixSiHUBgteMJug+FOj8GS8xy/ErNCOTLDd1waHeKrf1fHilDG/RE9xaXEShE5SJxF3AiSPI22UKLH9VXch8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDGYmgmO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDGYmgmO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773761193; x=1805297193;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hYXp9a2NLaQVekWjZ+4yth845DCIClXSayYXXsM3Uyc=;
  b=SDGYmgmOhg/jH55ElbeQ/cDMqAiBtRH4GQABiLrJP2pEZV/MCmuaBVzT
   Ttuv6r1yDnG6KgEDonGsL9+8Ta2G9O7XDqk8oZ2bqkNL590J7R2PNMnlP
   1VI6uznO2i6IDBm81rdBpbr0schJhKaherrqsvSgxQrATQEYX/6CsCFfZ
   l2w1c+9wTpZEOdFLKA/7JeyraVmWXzSLIFAvVBx3XpRX8icFwUnUC/2/w
   jTmFXVCuDoz/PZte8odbVsTjKpXrzPiYOtzPuk+a7/P6EH809puqTgRYF
   hQPzjCk8OqJSDXLHz/XZsJiR3kw6eK1n0981qQOzHuXJJryirRyzmeIHq
   A==;
X-CSE-ConnectionGUID: 8ftMiKTrTx27qYT06K3tJA==
X-CSE-MsgGUID: h2+L++ymQlWXteRSVoX4rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74681337"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74681337"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:26:32 -0700
X-CSE-ConnectionGUID: ZST71INmRsKeCKApGPuKCQ==
X-CSE-MsgGUID: m12kp4T8QlWEYWIU2Ok2MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="245322289"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.161])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:26:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 17:26:22 +0200 (EET)
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
Subject: Re: [PATCH v2 4/4] PCI: rpaphp: Simplify with scoped for each OF
 child loop
In-Reply-To: <20260317133322.266102-8-krzysztof.kozlowski@oss.qualcomm.com>
Message-ID: <b983a05b-2d90-2a88-4b60-49c6c5ee777d@linux.intel.com>
References: <20260317133322.266102-5-krzysztof.kozlowski@oss.qualcomm.com> <20260317133322.266102-8-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1763753626-1773761182=:968"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1763753626-1773761182=:968
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
>  drivers/pci/hotplug/rpaphp_slot.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpap=
hp_slot.c
> index 33ca19200c1b..67362e5b9971 100644
> --- a/drivers/pci/hotplug/rpaphp_slot.c
> +++ b/drivers/pci/hotplug/rpaphp_slot.c
> @@ -82,7 +82,6 @@ EXPORT_SYMBOL_GPL(rpaphp_deregister_slot);
>  int rpaphp_register_slot(struct slot *slot)
>  {
>  =09struct hotplug_slot *php_slot =3D &slot->hotplug_slot;
> -=09struct device_node *child;
>  =09u32 my_index;
>  =09int retval;
>  =09int slotno =3D -1;
> @@ -97,11 +96,10 @@ int rpaphp_register_slot(struct slot *slot)
>  =09=09return -EAGAIN;
>  =09}
> =20
> -=09for_each_child_of_node(slot->dn, child) {
> +=09for_each_child_of_node_scoped(slot->dn, child) {
>  =09=09retval =3D of_property_read_u32(child, "ibm,my-drc-index", &my_ind=
ex);
>  =09=09if (my_index =3D=3D slot->index) {
>  =09=09=09slotno =3D PCI_SLOT(PCI_DN(child)->devfn);
> -=09=09=09of_node_put(child);
>  =09=09=09break;
>  =09=09}
>  =09}
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1763753626-1773761182=:968--
