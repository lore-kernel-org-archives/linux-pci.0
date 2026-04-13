Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5B7237713;
	Mon, 13 Apr 2026 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079181; cv=none; b=rFfUiaZts1aNCEQdmh5WoVNfJXoO0Nx/xRIHfipoHILNk4GbMF3hFsOvwyvuutJH1pxcRoS8E9+nfE+vrVkLLiOFMNKLta1AxJ9MkZCBIzZnIs5COQmeKz9huGW4dLu/XZrzKdKH2AZZCQL1bpIureyoo6xVHRHnRQ+uQCKfj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079181; c=relaxed/simple;
	bh=CVbVKb2nM0zwk8+T+WrSIwjJaIItZ5z+YYob7tPm2q0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m8QTml6RZ8c5JOamG2M8IVwf8gX8XvpHI2o4j/hgAv0OUBIUTWMnzypgvRNJ5gN/ORLlmxjq+QGSry9eQCWf8t5HAgg/Bhn51LZ8sbEibauw9jGMTYYWj9khrC9M0a4eYivs8KRUFKOo1QwcE40mSUIzXd+t2Ym78JrqwaPmsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jdl2iTNY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jdl2iTNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776079179; x=1807615179;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CVbVKb2nM0zwk8+T+WrSIwjJaIItZ5z+YYob7tPm2q0=;
  b=Jdl2iTNYQEKqXAtoL7KS2RtWWqufOSG+YQLD1sCEAFSDuB4iU7CNZrAw
   1zLu4Gb7n1/ZcU6hfvzCdBGvvm/lJ5o6YCr8SM/UEaWzl6F5Q3yIXwuQY
   skOrVBvNyvnRYSFAQOJTK3GauAzQVTaExotPl5JdTZrttqg/93lLS9kzr
   7dkjPw1Mb7RfpU7KZUzKimGkjrPPct6a+8tfeTm7aXLNrojZrCc4mwM8l
   PNaee+UvGPolc3QmZguG2W7HvzKBgHePj4i6Jo7hkNs6WSN/ip8RSWvWb
   F8viwwctZI2aUtH1Cop7xUVM8TOtSM+HnRuAJiM/GHV53odDdZlibXGRx
   Q==;
X-CSE-ConnectionGUID: Yguq/QBxRZWO94tPUdVjXA==
X-CSE-MsgGUID: LsE/VexkTbeXzNFKw1dVaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="80597612"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="80597612"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:19:37 -0700
X-CSE-ConnectionGUID: +OGPYEbfShKT7eOQV1rdjg==
X-CSE-MsgGUID: gjMpAYX/ROeP86KL5DHTBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="234741721"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:19:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Apr 2026 14:19:27 +0300 (EEST)
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
Subject: Re: [PATCH v4 02/24] PCI: Add pci_resource_is_io() and pci_resource_is_mem()
 helpers
In-Reply-To: <20260411080148.471335-3-kwilczynski@kernel.org>
Message-ID: <22b1e95c-4741-66c3-3ef5-5a87daba6056@linux.intel.com>
References: <20260411080148.471335-1-kwilczynski@kernel.org> <20260411080148.471335-3-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2046482584-1776079167=:962"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2046482584-1776079167=:962
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 11 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Add helpers to check whether a PCI resource is of I/O port or
> memory type.  These replace the open-coded pci_resource_flags()
> with IORESOURCE_IO and IORESOURCE_MEM pattern used across the
> tree.
>=20
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  include/linux/pci.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1c270f1d5123..05aceb7f1f37 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2295,6 +2295,31 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, s=
truct vm_area_struct *vma);
>  =09CONCATENATE(__pci_dev_for_each_res, COUNT_ARGS(__VA_ARGS__)) =09\
>  =09=09    (dev, res, __VA_ARGS__)
> =20
> +/**
> + * pci_resource_is_io - check if a PCI resource is of I/O port type.
> + * @dev: PCI device to check.
> + * @resno: The resource number (BAR index) to check.
> + *
> + * Returns true if the resource type is I/O port.
> + */
> +static inline bool pci_resource_is_io(const struct pci_dev *dev, int res=
no)
> +{
> +=09return resource_type(pci_resource_n(dev, resno)) =3D=3D IORESOURCE_IO=
;
> +}
> +
> +/**
> + * pci_resource_is_mem - check if a PCI resource is of memory type.
> + * @dev: PCI device to check.
> + * @resno: The resource number (BAR index) to check.
> + *
> + * Returns true if the resource type is memory, including
> + * prefetchable memory.
> + */
> +static inline bool pci_resource_is_mem(const struct pci_dev *dev, int re=
sno)
> +{
> +=09return resource_type(pci_resource_n(dev, resno)) =3D=3D IORESOURCE_ME=
M;
> +}
> +
>  /*
>   * Similar to the helpers above, these manipulate per-pci_dev
>   * driver-specific data.  They are really just a wrapper around
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-2046482584-1776079167=:962--
