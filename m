Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2020D3976B3;
	Fri, 10 Apr 2026 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775819070; cv=none; b=OuY5MSHuKpcoqTWYC30GxGoL22Fukjo8FFfOQc/syFzDiZaVJi0/BJUL/XS/pTBwDKDe2fxbxy6ElxfMVRnnNC8YaOO+XROxHKlnpJB0YMrqQcWAAMxJYFsh+mjsrImEMff8um4UEQVnnYutX0bKbKp8nqSC7c4/o9Wjb7GMFuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775819070; c=relaxed/simple;
	bh=ie5mL37AI9/SoDKmjWEXYIZ3Y62rbPGSCw23WIYez+M=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=py2g6yCD9VdrJuICaHZLXjmMzTjKFAwVS8csR7iXU8tB5E0GmkR6Xsaghb8+YeaXrVlaarZ3WvJiIDwxntH7y414f8ifGY14FdQaNhhXf3tjHN4kylC+927oQJN4FaaPluw3XPsCkhygJrCLuIIii7rEkEvVjWTx8iH3GKjjLsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9vQW5MP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9vQW5MP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775819070; x=1807355070;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ie5mL37AI9/SoDKmjWEXYIZ3Y62rbPGSCw23WIYez+M=;
  b=J9vQW5MPfe3wamTipMYJTrn3UGHhczvAzK/ds4u99BlXUOt+b8bQwrLn
   LWXsN/Z/lATSUymmipK3SC5G99yGWSxPuTw4nyZQZw8a/3CgVzuTj0Or7
   PUlXyj/fCZR2rpGHSvf1eur7EZnj/psobogfP/zXgznbvw61Zp0el6omm
   0ziKewXgWU/NLi09bJn1KYtbpUliAJeLuIjqw1K37SDBqNeGoIC2L+HXD
   FqVSPv4vCLr7lp7ju+4NRb3kQ5oS8vWw8uUUa/O9TQkO1KTZ5SEEazFwU
   7tHnBoKN+jA1TPclg5AA+29gWc8cOhb3axnZByux0RmYYPcIhwO+uRreF
   w==;
X-CSE-ConnectionGUID: 12pBNlVVSnOedsvhTomOJw==
X-CSE-MsgGUID: 2ET6pN/eSCuont9CXzzJqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="87913341"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="87913341"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:04:29 -0700
X-CSE-ConnectionGUID: AFN9uzRlTtyiLYJXbIC8Hg==
X-CSE-MsgGUID: 1Qnc4FGjTdGVlIiX03QVWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="228059061"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:04:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Apr 2026 14:04:16 +0300 (EEST)
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
Subject: Re: [PATCH 10/20] alpha/PCI: Add security_locked_down() check to
 pci_mmap_resource()
In-Reply-To: <20260410055040.39233-11-kwilczynski@kernel.org>
Message-ID: <93f81aa9-ce74-92bb-5227-d2ccb0a3e06c@linux.intel.com>
References: <20260410055040.39233-1-kwilczynski@kernel.org> <20260410055040.39233-11-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1107943852-1775819056=:1195"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1107943852-1775819056=:1195
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 10 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Currently, Alpha's pci_mmap_resource() does not check
> security_locked_down(LOCKDOWN_PCI_ACCESS) before allowing
> userspace to mmap PCI BARs.
>=20
> The generic version has had this check since commit eb627e17727e
> ("PCI: Lock down BAR access when the kernel is locked down") to
> prevent DMA attacks when the kernel is locked down.
>=20
> Add the same check to Alpha's pci_mmap_resource().
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Maybe add Fixes: eb627e17727e ...

> ---
>  arch/alpha/kernel/pci-sysfs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index 3048758304b5..2324720c3e83 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -11,6 +11,7 @@
>   */
> =20
>  #include <linux/sched.h>
> +#include <linux/security.h>
>  #include <linux/stat.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
> @@ -71,7 +72,11 @@ static int pci_mmap_resource(struct kobject *kobj,
>  =09struct resource *res =3D attr->private;
>  =09enum pci_mmap_state mmap_type;
>  =09struct pci_bus_region bar;
> -=09int i;
> +=09int i, ret;
> +
> +=09ret =3D security_locked_down(LOCKDOWN_PCI_ACCESS);
> +=09if (ret)
> +=09=09return ret;
> =20
>  =09for (i =3D 0; i < PCI_STD_NUM_BARS; i++)
>  =09=09if (res =3D=3D &pdev->resource[i])
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1107943852-1775819056=:1195--
