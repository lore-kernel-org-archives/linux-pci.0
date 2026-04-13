Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D7D3AEF57;
	Mon, 13 Apr 2026 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079473; cv=none; b=mNIh4u+2bpRmjmi9v9mR8tgKt/C+XaXGlrOf1cKD+Bs+usMov7mL0Ua1VwmSLG+IhoNG66bVtpxewRJ7piKr3nx/9wx3/qiOjn1M62Zp8yho7aIBnDsjJqGJPOL3W8gpAinDxNcfNDR2gbLyiBRk8GlV7aLFHIJZCUDsooQOWJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079473; c=relaxed/simple;
	bh=ANPSmnJ2+vAlYbN/js49nW9FDlFUvNpC6ZARORPHgV0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Y7TifE/6iulOgiUUFPpBag1gDRVS3E0+wT9qDdj4a0DMfH14i5ZZUnRox27JNgZJ4uQ3j6MlkFHWpogjqyYAo4NIbwtZI7IWLPAdvbO5uwBmxdCVGUGB+UxETcrDKIiR6UYJqqCAKed1ft+Qa7mUeQ0rQShanjEGT3cS76LWuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKP5JmRz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKP5JmRz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776079471; x=1807615471;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ANPSmnJ2+vAlYbN/js49nW9FDlFUvNpC6ZARORPHgV0=;
  b=cKP5JmRz3rwToDlnaJjeFgmd5fvdAQzsltbEseXFzyeOb5Yn5ypOfjbz
   llbZObkxT0yT1yJ/JYtoQJpsobP7mmk6aOqxOPeQEpgsQLNm8OS2KZYM9
   nIR7XVlSU14WLdwr4879WD1bAxpWc9xXW/F2Fa/M1GSXb2IiYn/AlKwM5
   rvoJv0rZVlP6TBFRM/pEBdRyWUItoa1max7NB7VckbUo0T+YIkf0nkg2d
   SwAQYQYRNStnZCx8Vlj7+PqfyluYTAbiI8XPl6L9pclo146LFME9RUEeI
   L+oU4u6hkF1ZwcyZFqgT18MlIi2YpaQ+FVlq4te0h/WSuV9CXpQenfBqa
   w==;
X-CSE-ConnectionGUID: vU1CVygOQuO1H7uxoUJb0w==
X-CSE-MsgGUID: EeCjVgDUQdOvh/MdWYdFmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="76177567"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="76177567"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:24:31 -0700
X-CSE-ConnectionGUID: 33yh9LIcQJ+TH04CgmlBIg==
X-CSE-MsgGUID: TtU1KKBaSB6pirkxzyn3rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="252952094"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.63])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:24:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Apr 2026 14:24:23 +0300 (EEST)
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
Subject: Re: [PATCH v4 03/24] PCI/sysfs: Only allow supported resource types
 in I/O and MMIO helpers
In-Reply-To: <20260411080148.471335-4-kwilczynski@kernel.org>
Message-ID: <8424773e-84cd-25dc-6591-dd68292150fd@linux.intel.com>
References: <20260411080148.471335-1-kwilczynski@kernel.org> <20260411080148.471335-4-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-22180800-1776079463=:962"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-22180800-1776079463=:962
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 11 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Currently, when the sysfs attributes for PCI resources are added
> dynamically, the resource access callbacks are only set when the
> underlying BAR type matches, using .read and .write for IORESOURCE_IO,
> and .mmap for IORESOURCE_MEM or IORESOURCE_IO with arch_can_pci_mmap_io()
> support.  As such, when the callback is not set, the operation inherently
> fails.
>=20
> After the conversion to static attributes, visibility callbacks will
> control which resource files appear for each BAR, but the callbacks
> themselves will always be set.
>=20
> Thus, add a type check to pci_resource_io() and pci_mmap_resource()
> to return -EIO for an unsupported resource type.
>=20
> Use the new pci_resource_is_io() and pci_resource_is_mem() helpers
> for the type checks, replacing the open-coded bitwise flag tests and
> also drop the local struct resource pointer in pci_mmap_resource().
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  drivers/pci/pci-sysfs.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index ad3c17f86c7f..6783c6168445 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1108,20 +1108,24 @@ static int pci_mmap_resource(struct kobject *kobj=
, const struct bin_attribute *a
>  =09struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
>  =09int bar =3D (unsigned long)attr->private;
>  =09enum pci_mmap_state mmap_type;
> -=09struct resource *res =3D pci_resource_n(pdev, bar);
>  =09int ret;
> =20
>  =09ret =3D security_locked_down(LOCKDOWN_PCI_ACCESS);
>  =09if (ret)
>  =09=09return ret;
> =20
> -=09if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
> +=09if (!pci_resource_is_mem(pdev, bar) &&
> +=09    !(pci_resource_is_io(pdev, bar) && arch_can_pci_mmap_io()))
> +=09=09return -EIO;
> +
> +=09if (pci_resource_is_mem(pdev, bar) &&
> +=09    iomem_is_exclusive(pci_resource_start(pdev, bar)))
>  =09=09return -EINVAL;
> =20
>  =09if (!pci_mmap_fits(pdev, bar, vma, PCI_MMAP_SYSFS))
>  =09=09return -EINVAL;
> =20
> -=09mmap_type =3D res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_i=
o;
> +=09mmap_type =3D pci_resource_is_mem(pdev, bar) ? pci_mmap_mem : pci_mma=
p_io;
> =20
>  =09return pci_mmap_resource_range(pdev, bar, vma, mmap_type, write_combi=
ne);
>  }
> @@ -1149,6 +1153,9 @@ static ssize_t pci_resource_io(struct file *filp, s=
truct kobject *kobj,
>  =09int bar =3D (unsigned long)attr->private;
>  =09unsigned long port =3D off;
> =20
> +=09if (!pci_resource_is_io(pdev, bar))
> +=09=09return -EIO;
> +
>  =09port +=3D pci_resource_start(pdev, bar);
> =20
>  =09if (port > pci_resource_end(pdev, bar))
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-22180800-1776079463=:962--
