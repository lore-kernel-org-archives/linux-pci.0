Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819E9387358;
	Mon, 13 Apr 2026 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080686; cv=none; b=SVKcznVGnmXAHZLs345/O1rauGDkU6468vR87lVG1P7geYEFRP487offr2SX9DPjgjv0VPWnzj+zruiouVChLpWw2d691yESlj/MhqW0BJ8tUlysqqWzcVhOtIWpC+RqOPaKjtxiE1KmkJkbh7dfFgKDyRtcvhBsd2Fsf9OzcZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080686; c=relaxed/simple;
	bh=AFSD+d73vMww+hbY63uE4fAGE+VrR8hSSF0t67UtcMY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=flgZb5kWkWdCd3jObHjn1IhUD9FDrCXnccgd6nKttJxApJFQ2MSVnH9OfmhmWMO70JMmAK22C9YKJxH5V9BrKT+DO5yQ4/g2eWyElc0yWRdaXF1r9b/X5i9WMMjIaruNaX/SGtWoVA7zP0ftkSLYDmi7IXLg9eZTRbElUlka6Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xrt87pcC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xrt87pcC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776080686; x=1807616686;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AFSD+d73vMww+hbY63uE4fAGE+VrR8hSSF0t67UtcMY=;
  b=Xrt87pcC+gAKIiS712BDAawSsIET0uUWAqOLSDEZY/KzRdD4YYm02MZi
   2+k+kH4RG7Vo0nmNuH7eKkp4GIyN1nwm7nO31KyZCIBCF2w8ILbu5Yzil
   K5TXLzPCkJEyL0Ct+I/pUeUF9mjSr7PReKFUNp2L0JSdbtTTBRnFjqHej
   1a9RQWeJx3O/XtpeBbzNQLemSt7c3aP1Bib43ex9wXpuik6wi121VLbw5
   HcbDVkM5GuRgkT9xGjr3RSiEQ/HxfPv95TYtkwaxuTVH6FDY00zheiaxe
   5JLIf+U5JAw+0RqmzezHu8mVstSRPX6cbQmwlWWyBlNIkOggwRCvssGZs
   w==;
X-CSE-ConnectionGUID: FUfauHGTTmKVG8QwOKK09w==
X-CSE-MsgGUID: guarExyXQL+z162ZiW8zew==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="80894512"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="80894512"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:44:45 -0700
X-CSE-ConnectionGUID: hIZS6DwhSW2wkfAszU3ESQ==
X-CSE-MsgGUID: 0jcsmTVPSeCQKJIJ8iTaGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="225482707"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.63])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:44:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Apr 2026 14:44:29 +0300 (EEST)
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
Subject: Re: [PATCH v4 15/24] alpha/PCI: Fix __pci_mmap_fits() overflow for
 zero-length BARs
In-Reply-To: <20260411080148.471335-16-kwilczynski@kernel.org>
Message-ID: <e6dfcdef-c5ba-7c23-73cc-cf2ffd084b4e@linux.intel.com>
References: <20260411080148.471335-1-kwilczynski@kernel.org> <20260411080148.471335-16-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1214616222-1776080669=:962"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1214616222-1776080669=:962
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 11 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Currently, __pci_mmap_fits() computes the BAR size using
> pci_resource_len() - 1, which wraps to a large value when the
> BAR length is zero, causing the bounds check to incorrectly
> succeed.
>=20
> Thus, add an early return for empty resources.
>=20
> Fixes: 10a0ef39fbd1 ("PCI/alpha: pci sysfs resources")
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  arch/alpha/kernel/pci-sysfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index 6c011dab326d..2748000a7486 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -37,12 +37,16 @@ static int hose_mmap_page_range(struct pci_controller=
 *hose,
>  static int __pci_mmap_fits(struct pci_dev *pdev, int num,
>  =09=09=09   struct vm_area_struct *vma, int sparse)
>  {
> +=09resource_size_t len =3D pci_resource_len(pdev, num);
>  =09unsigned long nr, start, size;
>  =09int shift =3D sparse ? 5 : 0;
> =20
> +=09if (!len)
> +=09=09return 0;
> +
>  =09nr =3D vma_pages(vma);
>  =09start =3D vma->vm_pgoff;
> -=09size =3D ((pci_resource_len(pdev, num) - 1) >> (PAGE_SHIFT - shift)) =
+ 1;
> +=09size =3D ((len - 1) >> (PAGE_SHIFT - shift)) + 1;
> =20
>  =09if (start < size && size - start >=3D nr)
>  =09=09return 1;
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1214616222-1776080669=:962--
