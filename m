Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A453BAD87;
	Fri, 10 Apr 2026 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775819709; cv=none; b=QEH+z0CnfJBFz2I508XB1gwUqQtyP1NSHVRbjZRm0ZtS6ylBvPTehbzaApVeUjDSOaJ6AmzVCGsw24LuxWiIZqOvu0TZX3h948P4rEs288cps/8ikARbNmoQ4IYvCMls6B2q0gPOHdJ7W+zBQi6EtUMsPahbO1BJXzro+xWxdro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775819709; c=relaxed/simple;
	bh=LQlh8I55FJSDZdIW0plgYRYVBRUjST2rjdHoYnP/X9g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AHClCPu1fWxe2msj7VdeZJZ8Tc53sai6/HuDFBhT2/eieouonhErDbtfd60W8dkZEMrDD5zcc57jP4LSOKJiYJru0rhI/cfVhVv8SvI1VcvsIUAjyk3auVDzSRb3Py8jaMSE2LELpUVHNpK7Sv+Z/MhowRlJnr5qYFFyKd3Nw7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3UsNCv4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3UsNCv4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775819708; x=1807355708;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LQlh8I55FJSDZdIW0plgYRYVBRUjST2rjdHoYnP/X9g=;
  b=U3UsNCv41jhJAKcIXkshJVvck///8mho4EY4szMD2yyWPTht9x9RzceF
   dMhuc7vJOAhoU8VsxnXK9J7795N4MVTss8x4qiY5bCPaoDJ3nPQ63Zq5b
   BMhriVgUfmehFmvwFyc6lwwOVT9WM44HDIiRF2rpQqhyJLN76Iec3DNDn
   Y3An7jomv+SbgSrahqXMIDbCfkMjeM7fXS1+hr++si2CV6cagO8FcjsxR
   mFVUrNfeZpqA8qEsi3zjFl+J57McG1pGRXyZgJBw7cZbYbsT+HNdt76MY
   9qgpyAMlVWogBa8hw2MX0M/XnKR+NYVAgsRtEfbyadHKWCYs/gMKFrA9W
   A==;
X-CSE-ConnectionGUID: ZBsjoM83TRaIVqR51r+ZHQ==
X-CSE-MsgGUID: TnwaurmVQNWToZfW4OH7pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="94415842"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="94415842"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:15:07 -0700
X-CSE-ConnectionGUID: XwV8+G46Tz+BFYBFlBtq8g==
X-CSE-MsgGUID: z5AtohwQS8qN4xrUHCo/DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="267023344"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:14:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Apr 2026 14:14:55 +0300 (EEST)
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
Subject: Re: [PATCH 13/20] alpha/PCI: Clean up __pci_mmap_fits()
In-Reply-To: <20260410055040.39233-14-kwilczynski@kernel.org>
Message-ID: <66eb23bf-1995-363f-78e6-f5a397a063a2@linux.intel.com>
References: <20260410055040.39233-1-kwilczynski@kernel.org> <20260410055040.39233-14-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-133140870-1775819695=:1195"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-133140870-1775819695=:1195
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 10 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Currently, __pci_mmap_fits() computes the BAR size using
> pci_resource_len() - 1, which wraps to a large value when the
> BAR length is zero, causing the bounds check to incorrectly
> succeed.
>=20
> Thus, add an early return for empty resources.
>=20
> Also, remove the WARN() that fires when userspace attempts to
> mmap beyond the BAR bounds.  The check still returns 0 to reject
> the mapping, but the warning is excessive for normal operation.
>=20
> A similar warning was removed from the PCI core in the commit
> 3b519e4ea618 ("PCI: fix size checks for mmap() on /proc/bus/pci files").

This looks like entirely separate two changes to me which just happen=20
within the same context.

> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  arch/alpha/kernel/pci-sysfs.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index 7aac5e76dcd6..867199b988de 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -37,20 +37,18 @@ static int hose_mmap_page_range(struct pci_controller=
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

--=20
 i.

--8323328-133140870-1775819695=:1195--
