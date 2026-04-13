Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A2B31A053;
	Mon, 13 Apr 2026 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080751; cv=none; b=ldYTl+ktkyHVp8HND3wqMRM5hHPuguNCKJBSpYqBHVJp2ui9FTFt7Zus/LzLDB39XJ1sQ8ZF5wfAI7tB0zY9mLPwievHYYcTT4YwJI+uusaHsHSgfYZl43DGQUER5/IOTY01bg6psghkhI6/3htr6MXn/lp0w2zXt2brM+rS6Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080751; c=relaxed/simple;
	bh=MXb8znk6JA5uSw7e9wrvMoeQSHS1hheycQygUFtOceI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tKnW/Rzn+zF4r9Km+889Hh2wHWjh0sJ5bp2Bn6ENvEwu1qxyne9eo3MzYFRNtoEcIPEC2CC24KD8Xlv9UBrEtjXacmxGpgLv48/r6CqKCSY8rtiWYDvfJE0dtDsvXu3w9ErxfhhhJzGPNnBFbMOYhM+LbpOYthb5JIK4Nnvm6GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTwmbzLb; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTwmbzLb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776080750; x=1807616750;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MXb8znk6JA5uSw7e9wrvMoeQSHS1hheycQygUFtOceI=;
  b=gTwmbzLbTYSaY8Def1TRQIhmlT6A8R28ladhEwK6R0r59eoCjwYB25kU
   AimKAxBd5/wlZrQeqAScQZeuIr54CmBbS2NfXvT+Tw6tuEQ4ObqElqSBN
   xHE6xnUOhj1Y/OHTF9pdHV8bgC0BYm2fklmlMmSkPnbbkVsw8Rzkm03R5
   ZmF8vcT+EOGlBwjNAn0cxg1VXS0r+3F8U2QRomJhRSNSkNkIvzF6ao0EZ
   vykng0JB2uAWPUx4WSY4Gy4EYW5JQqd1oHjwmLYZxdkwlr/Wwq3wfUjS7
   EIxs42z+Axoh+tHpP2hR86EuM96nj0ZJEk5QaWhsX9vHra1e2uHwFkdpd
   Q==;
X-CSE-ConnectionGUID: NJ/AfIg/QSuB6UC08PsR/A==
X-CSE-MsgGUID: ua0mpdcmQwSI3gvV7QIdNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="88396338"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="88396338"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:45:49 -0700
X-CSE-ConnectionGUID: RZP0kXKVTxepfqH2u5Mj1w==
X-CSE-MsgGUID: hvRUpLyoSQGtB1aLUpdGmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="231496176"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.63])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:45:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Apr 2026 14:45:32 +0300 (EEST)
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
Subject: Re: [PATCH v4 16/24] alpha/PCI: Remove WARN from __pci_mmap_fits()
In-Reply-To: <20260411080148.471335-17-kwilczynski@kernel.org>
Message-ID: <683c3e65-4589-b3a1-ac51-6d7e2b679944@linux.intel.com>
References: <20260411080148.471335-1-kwilczynski@kernel.org> <20260411080148.471335-17-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1168042318-1776080732=:962"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1168042318-1776080732=:962
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 11 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Remove the WARN() that fires when userspace attempts to mmap beyond
> the BAR bounds.  The check still returns 0 to reject the mapping,
> but the warning is excessive for normal operation.
>=20
> A similar warning was removed from the PCI core in the commit
> 3b519e4ea618 ("PCI: fix size checks for mmap() on /proc/bus/pci files").
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  arch/alpha/kernel/pci-sysfs.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index 2748000a7486..c136603ddf2c 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -48,13 +48,7 @@ static int __pci_mmap_fits(struct pci_dev *pdev, int n=
um,
>  =09start =3D vma->vm_pgoff;
>  =09size =3D ((len - 1) >> (PAGE_SHIFT - shift)) + 1;
> =20
> -=09if (start < size && size - start >=3D nr)
> -=09=09return 1;
> -=09WARN(1, "process \"%s\" tried to map%s 0x%08lx-0x%08lx on %s BAR %d "
> -=09=09"(size 0x%08lx)\n",
> -=09=09current->comm, sparse ? " sparse" : "", start, start + nr,
> -=09=09pci_name(pdev), num, size);
> -=09return 0;
> +=09return start < size && size - start >=3D nr;
>  }
> =20
>  /**
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1168042318-1776080732=:962--
