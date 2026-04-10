Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA4839B955;
	Fri, 10 Apr 2026 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775819981; cv=none; b=EinaXqFXKmUwHStdVDvGKsIlmvWf6I5aPQHkN1OyGrRgOogrsohKN9h+JYxYmrZApZtnVwjp25oOGKnmuqS6AY7Y8cvJFW3UbxDvhXLgmSj1DMPNIDMthFEXdJ35yQkTlU0vtvi//yeqZ42ctj9T4Ug0lXSsZ89+qtm2aKd2g3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775819981; c=relaxed/simple;
	bh=y2Ft9tQbJmBllEvwEPLEzQ//AalTGbNGlcFniNwTlWc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sbO/LZNPi5Kvsoa1XRmMi6R8AgxK96hSkPYBZ/MM8a8D4VF17Wir/jVwWmQ9rQq52Yk/bAxjpJg7sodbK9EhEG4rEbFFhBXyvBhpk5jl7t0jUMbwF1WmzKbzFozVXRMMHsZIhM/0rR3QQgavJhopfYNUCNLqSp6P/FzsAuRAzdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dyoRAYyO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dyoRAYyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775819981; x=1807355981;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=y2Ft9tQbJmBllEvwEPLEzQ//AalTGbNGlcFniNwTlWc=;
  b=dyoRAYyOrLQ4nbxQ72lRD5JyyGgkFSF83fhaUIQfFqGIWWkFFKIR3A6o
   ++W5lJspxcwbiaL5qjI8jz/OqkCaL5rsq7B8t8eHsys5CGwN2V0CxkDlI
   pUiO+pQVK0ghTqYx4Wxw8cfBZsT9/QJgITjOih4RV9Lv0rjug7kvaLt7w
   h3GYjG6kzGCjQy9KZWT/EWlOhvzr/l2hEUtBjTAy4HqwciJ+dswRqtNUo
   FsIoJhNmFREA1/WNDLT27Tem+SDS+hEth4eTLCSgo0U12LQJdWj8f76p6
   JXpf75p3v7tkkZPWQkTwSp9B0EEQsyLrna7eyyD/9krtouaUQAQCpO+oQ
   g==;
X-CSE-ConnectionGUID: HTZZ1ojKRpGOnfINCBiV/A==
X-CSE-MsgGUID: 6tJvYRfQSXGVCQPfuD3bYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76745207"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="76745207"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:19:40 -0700
X-CSE-ConnectionGUID: xvtL+CXXRjqr7ImdpYZiRw==
X-CSE-MsgGUID: HohmFH4wSUuwW10pd0WNPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="222569712"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:19:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Apr 2026 14:19:27 +0300 (EEST)
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
Subject: Re: [PATCH 14/20] alpha/PCI: Add static PCI resource attribute
 macros
In-Reply-To: <20260410055040.39233-15-kwilczynski@kernel.org>
Message-ID: <2c5b50c7-b357-025d-e0de-1fce1fcddf20@linux.intel.com>
References: <20260410055040.39233-1-kwilczynski@kernel.org> <20260410055040.39233-15-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-866756695-1775819880=:1195"
Content-ID: <2a2e8981-2c02-5e58-5eae-1f1106216ee6@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-866756695-1775819880=:1195
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <ff8eb51f-5b94-3fee-1a97-87bd0c1b2236@linux.intel.com>

On Fri, 10 Apr 2026, Krzysztof Wilczy=F1ski wrote:

> Add macros for declaring static binary attributes for Alpha's PCI
> resource files:
>=20
>   - pci_dev_resource_attr(),        for dense/BWX systems (mmap dense)
>   - pci_dev_resource_sparse_attr(), for sparse systems (mmap sparse)
>   - pci_dev_resource_dense_attr(),  for dense companion files (mmap dense=
)
>=20
> Each macro creates a const bin_attribute with the BAR index stored in
> the .private property and the appropriate .mmap callback.
>=20
> Signed-off-by: Krzysztof Wilczy=F1ski <kwilczynski@kernel.org>
> ---
>  arch/alpha/kernel/pci-sysfs.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index 867199b988de..0e016b597b06 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -104,6 +104,26 @@ static int pci_mmap_resource_dense(struct file *filp=
, struct kobject *kobj,
>  =09return pci_mmap_resource(kobj, attr, vma, 0);
>  }
> =20
> +#define __pci_dev_resource_attr(_bar, _name, _suffix, _mmap)=09=09\
> +static const struct bin_attribute=09=09=09=09=09\
> +pci_dev_resource##_bar##_suffix##_attr =3D {=09=09=09=09\
> +=09.attr =3D { .name =3D __stringify(_name), .mode =3D 0600 },=09=09\
> +=09.private =3D (void *)(unsigned long)(_bar),=09=09=09\
> +=09.mmap =3D (_mmap),=09=09=09=09=09=09\
> +}
> +
> +#define pci_dev_resource_attr(_bar)=09=09=09=09=09\
> +=09__pci_dev_resource_attr(_bar, resource##_bar,,=09=09=09\
> +=09=09=09    pci_mmap_resource_dense)
> +
> +#define pci_dev_resource_sparse_attr(_bar)=09=09=09=09\
> +=09__pci_dev_resource_attr(_bar, resource##_bar##_sparse, _sparse,=09\
> +=09=09=09    pci_mmap_resource_sparse)
> +
> +#define pci_dev_resource_dense_attr(_bar)=09=09=09=09\
> +=09__pci_dev_resource_attr(_bar, resource##_bar##_dense, _dense,=09\
> +=09=09=09    pci_mmap_resource_dense)
> +
>  /**
>   * pci_remove_resource_files - cleanup resource files
>   * @pdev: pci_dev to cleanup
>=20

Wouldn't this belong together with the next patch, or is there some good=20
reason why you added them separately?

--=20
 i.
--8323328-866756695-1775819880=:1195--
