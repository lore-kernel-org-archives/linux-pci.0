Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3292264A9;
	Mon, 13 Apr 2026 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776081308; cv=none; b=Rpuu5rK7jWeCGBHz8FjpD/6CEKmfoti7sWJcPU2szF3vWfck1mBJQWQsZtJ6Dx9yaTYpoy+jrJZkOdO3NJc2dMoT6mhrH4/APpDTiSBhbNUc9iotSOO6HFuAQFvsqvQm2OtVcZrQVhhpCJtqiXhEHM3t8FlpUzp1RYZf1UfRK3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776081308; c=relaxed/simple;
	bh=m4D4xwrjWoPcKd39e9WIlNBkYbShl/QU18qRe1RJS34=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GemEaTMNo4wBhmRIU+B8gejs/OBCpvk7+2qILmiNLHEkE8QrM6BAe6WHk0CFM2o5qcauBhhMpqUZ5INvjaCubQCDAxElkbCZy6nDkjC171eaiQaYSMkxAPCgoliE1NNNzg5Us9ooyOnHEhNUCdI2alO7H4A0i5lEIboCvfrONbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQZlbsYZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQZlbsYZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776081306; x=1807617306;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=m4D4xwrjWoPcKd39e9WIlNBkYbShl/QU18qRe1RJS34=;
  b=OQZlbsYZETUYG5AQvqlM8B9tMXsswA9P0ggVVPB5Iw6LSN+idT2c79F5
   inl2Nx8LuDxgm7Vds8hd1kBwUUFLgPBfWXATYkr5sWbyQ0zSQhzEs5mNf
   LrcU4dfTiS1c7PS+tiKK0Xwb55tkiEs6Mt/IYdIh4mdSO+SazyPR6T+Wh
   QJahsIlstSYiaopzG3VIay3pVXyX3OAG60cvQUDMCME+gFAn7iIcYcTZb
   K+FfpT3xMrrF9TrgV9O9BXqDBtL/LHENUgViFogZnC8C8Y4djI+LqQV9x
   3U14k4Kh5cOxIsFrfZJwqKwM1wmtsmyD46vfINZAhwJcOtNdZQN+h1DZ8
   w==;
X-CSE-ConnectionGUID: Xl2NOor/RYCo/g/Uq/rD7A==
X-CSE-MsgGUID: x1aOug5KT02ZcT0IugS2Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="77030139"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="77030139"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:55:05 -0700
X-CSE-ConnectionGUID: lbiB9JauRxu0nvnsRhAtXQ==
X-CSE-MsgGUID: 7eAaEOTEQUC6kP4Yz6kYCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="252959648"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.63])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:54:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Apr 2026 14:54:55 +0300 (EEST)
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
Subject: Re: [PATCH v4 14/24] alpha/PCI: Clean up pci_mmap_resource()
In-Reply-To: <20260411080148.471335-15-kwilczynski@kernel.org>
Message-ID: <b4088182-cc79-3ee6-4b0c-9fa8f12d5cdf@linux.intel.com>
References: <20260411080148.471335-1-kwilczynski@kernel.org> <20260411080148.471335-15-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-878657269-1776081295=:962"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-878657269-1776081295=:962
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 11 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Replace open-coded res->flags type checks with new pci_resource_is_mem()
> and pci_resource_start() helpers.  Move the pci_resource_n() call into
> pcibios_resource_to_bus() and drop the local struct resource pointer.
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  arch/alpha/kernel/pci-sysfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index 7aac5e76dcd6..6c011dab326d 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -70,7 +70,6 @@ static int pci_mmap_resource(struct kobject *kobj,
>  {
>  =09struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
>  =09int barno =3D (unsigned long)attr->private;
> -=09struct resource *res =3D pci_resource_n(pdev, barno);
>  =09enum pci_mmap_state mmap_type;
>  =09struct pci_bus_region bar;
>  =09int ret;
> @@ -79,15 +78,16 @@ static int pci_mmap_resource(struct kobject *kobj,
>  =09if (ret)
>  =09=09return ret;
> =20
> -=09if ((res->flags & IORESOURCE_MEM) && iomem_is_exclusive(res->start))
> +=09if (pci_resource_is_mem(pdev, barno) &&
> +=09    iomem_is_exclusive(pci_resource_start(pdev, barno)))
>  =09=09return -EINVAL;
> =20
>  =09if (!__pci_mmap_fits(pdev, barno, vma, sparse))
>  =09=09return -EINVAL;
> =20
> -=09pcibios_resource_to_bus(pdev->bus, &bar, res);
> +=09pcibios_resource_to_bus(pdev->bus, &bar, pci_resource_n(pdev, barno))=
;
>  =09vma->vm_pgoff +=3D bar.start >> (PAGE_SHIFT - (sparse ? 5 : 0));
> -=09mmap_type =3D res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_i=
o;
> +=09mmap_type =3D pci_resource_is_mem(pdev, barno) ? pci_mmap_mem : pci_m=
map_io;
> =20
>  =09return hose_mmap_page_range(pdev->sysdata, vma, mmap_type, sparse);
>  }
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-878657269-1776081295=:962--
