Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF43B8BBB;
	Fri, 10 Apr 2026 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775819486; cv=none; b=H+EQ1mZd3QrZS6bIzC0M6D0uPCxJAju3/M3wOscO6mR9u1EuMffM7ErwEsPhFBuxHBDyPigi4Fjd/CV1yU7c2q9fb9t8RhXNJqNHD2z0GwoSy/zMLMZpboq4MDzLUyO2qPG79CnNuhMv1nOtU0r4cxsH50DxasZ06XhSke8ElhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775819486; c=relaxed/simple;
	bh=YmmZv/KghyXwXxLltau1kH9MzqjsToUkSr3yj3hE0LI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FBuPnqed/PcN8GGv5NxrnCutVJsEJQ+HSAkXeL6OFz2jn2lp5Egmpgvc+KP+zwtXD0vnqLSqRXZ2jIdvKQgzknjIYW3ykWA8zHlBQ8ysqB/20tGfj4n6p2isIUaTtzg5TtJYAUJVNwy4Aqv5KwZhNDYkbKXP451X7saTqSGKVFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWum9QaQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWum9QaQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775819483; x=1807355483;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YmmZv/KghyXwXxLltau1kH9MzqjsToUkSr3yj3hE0LI=;
  b=IWum9QaQC7UCkpSF9t67RLp5vRnFxX0OjKNy+KHeWKvZwONzXkrPU7zl
   cGghgi99RwOm+A08lfPf/cpFhM1M5xYbon/MMH+8TvayfBNIFNkfFXZ9+
   D8RlLfNPmJSeBM49tbsAn3+3CkhJUjewHH5W+9JgcxlPcIRy+aN4QDBbj
   /yULyEIRofEoRqqNMKTmRUIs8Nh/KM29xvKFktZ45p0PlHBrq2zl1d2Cn
   mYmheq7OZpZ4bA8GPEyL1QCpIjEQwGdMZT4QrxyGL7LZDKBlGoxRYozrc
   aNIwm5KgMooTZrq+Kd9tz7FgVo1Qd4M4pSz8PHfzvZ52iT0OYBgBFbEwc
   A==;
X-CSE-ConnectionGUID: 7g7AhKi6QUamrL1SL2zlXg==
X-CSE-MsgGUID: XRKeZeePQoyby1NYEvnDLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="77023377"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="77023377"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:11:22 -0700
X-CSE-ConnectionGUID: RGX5iTjcQ+GI+udWcK3Itg==
X-CSE-MsgGUID: pFRvyePbSROC6CAFst+SHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="224315446"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:11:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Apr 2026 14:11:11 +0300 (EEST)
To: =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>, 
    Manivannan Sadhasivam <mani@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Christophe Leroy <chleroy@kernel.org>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Dexuan Cui <decui@microsoft.com>, 
    =?ISO-8859-2?Q?Krzysztof_Ha=B3asa?= <khalasa@piap.pl>, 
    Lukas Wunner <lukas@wunner.de>, Oliver O'Halloran <oohall@gmail.com>, 
    Saurabh Singh Sengar <ssengar@microsoft.com>, 
    Shuan He <heshuan@bytedance.com>, 
    Srivatsa Bhat <srivatsabhat@microsoft.com>, linux-pci@vger.kernel.org, 
    linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 12/20] alpha/PCI: Use PCI resource accessor macros
In-Reply-To: <20260410055040.39233-13-kwilczynski@kernel.org>
Message-ID: <f36a3096-4a9c-93f7-48cb-e6f4c60fdb93@linux.intel.com>
References: <20260410055040.39233-1-kwilczynski@kernel.org> <20260410055040.39233-13-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1891398941-1775819471=:1195"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1891398941-1775819471=:1195
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 10 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Replace direct pdev->resource[] accesses with pci_resource_n(),
> and pdev->resource[].flags accesses with pci_resource_flags().
>=20
> No functional changes intended.
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  arch/alpha/kernel/pci-sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index c84867ce31f5..7aac5e76dcd6 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -141,7 +141,7 @@ static int sparse_mem_mmap_fits(struct pci_dev *pdev,=
 int num)
>  =09long dense_offset;
>  =09unsigned long sparse_size;
> =20
> -=09pcibios_resource_to_bus(pdev->bus, &bar, &pdev->resource[num]);
> +=09pcibios_resource_to_bus(pdev->bus, &bar, pci_resource_n(pdev, num));
> =20
>  =09/* All core logic chips have 4G sparse address space, except
>  =09   CIA which has 16G (see xxx_SPARSE_MEM and xxx_DENSE_MEM
> @@ -181,7 +181,7 @@ static int pci_create_attr(struct pci_dev *pdev, int =
num)
>  =09suffix =3D "";=09/* Assume bwx machine, normal resourceN files. */
>  =09nlen1 =3D 10;
> =20
> -=09if (pdev->resource[num].flags & IORESOURCE_MEM) {
> +=09if (pci_resource_flags(pdev, num) & IORESOURCE_MEM) {

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

I started wonder though if we'd want to add pci_resource_is_mem/io()=20
shortcuts for these, as it's largely what

    git grep pci_resource_flags

results contain.

--=20
 i.

--8323328-1891398941-1775819471=:1195--
