Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59E72D3A69;
	Mon, 13 Apr 2026 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776081573; cv=none; b=g9ES0EKhMKkIUvTvNmU+hgjjSAkLVXOV1AS/MzT5+5BqudyW/ZYd6kKQg9Vk7uoisblYtsDAu7PFltGMnTPH9jpaBOpQqO+GAR/ZU958L4iL5nnp0C5TTblnvYC6SPth0AexTch5Zmw7A2Uh/w3NbzkQ+z4TbVUhXvr2kr9z8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776081573; c=relaxed/simple;
	bh=XjCiDo9y+OHrVQDJKUrYSIpvMP1U6UUn5n4372Stk5c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tGLdyYwRyECKjsEvlLS5LRAWAJP8h3aKxyO+l0IT0dwxepEmXf3J/eSi4jCuYEpzlunGt8Tm8UP44ubEXG28jUAe7++ewfilfOVKxgVhs7wxKHSP0BOeyiTSsDZrfpYDx5Q9dR8207fuZE+bP+Oy9rtqkpiMyA4VDWXJTRSn6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+7FwymM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+7FwymM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776081573; x=1807617573;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=XjCiDo9y+OHrVQDJKUrYSIpvMP1U6UUn5n4372Stk5c=;
  b=F+7FwymMvCsIaEKXr/DA8heqhpka18pCpxDdg60fZFjw+u/hANFEy+aQ
   nm4DZkpa4bX+1XXXuefDQ2a6oepQlFNhhhS26iBdKbMik9uTbTVP3vO+K
   TryXJ0hergcGsI4qbuuM7D37Pe3nXuR2CugugG8DlaOHWYUtYI3EEJ74t
   IieL1mROPhUq199A5XfHGHAIkNEmVL9QssaWsg9g622+2V7CVxuBPhA/G
   xIuma8x414O/8Am2Pch0oplg73c4457A86RF9tbjXYZwEgoTetBqJ+N9C
   5j50TdfGm+KC0UhYOYP2ZZe4Y/LhGnITVrZxDvZJbd2WuqByPc2ylxnL7
   Q==;
X-CSE-ConnectionGUID: NEsLwy3zSc2MWdXv4HNfyQ==
X-CSE-MsgGUID: jz0r2Gi/Q6ar4Y2tzuvqOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="88088835"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="88088835"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:59:32 -0700
X-CSE-ConnectionGUID: AWmqfKN+SAKDaoql7UTAbw==
X-CSE-MsgGUID: 0dDCkOLFShWVnJktOyq7nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="226597919"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.63])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:59:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Apr 2026 14:59:19 +0300 (EEST)
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
Subject: Re: [PATCH v4 20/24] PCI: Add macros for legacy I/O and memory
 address space sizes
In-Reply-To: <20260411080148.471335-21-kwilczynski@kernel.org>
Message-ID: <a73af6f4-9f9a-cff8-e00e-042dcf934708@linux.intel.com>
References: <20260411080148.471335-1-kwilczynski@kernel.org> <20260411080148.471335-21-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-972594317-1776081516=:962"
Content-ID: <ad975c4c-2f7e-f46a-75e8-090fb701efc6@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-972594317-1776081516=:962
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <061d9599-649d-f8aa-2b31-8fe5344029e1@linux.intel.com>

On Sat, 11 Apr 2026, Krzysztof Wilczy=F1ski wrote:

> Add defines for the standard PCI legacy address space sizes,
> replacing the raw literals used by the legacy sysfs attributes.
>=20
> Suggested-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Krzysztof Wilczy=F1ski <kwilczynski@kernel.org>
> ---
>  include/linux/pci.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f6f55005f82d..6b630bac8c08 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -27,6 +27,7 @@
>  #include <linux/mod_devicetable.h>
> =20
>  #include <linux/types.h>
> +#include <linux/sizes.h>
>  #include <linux/init.h>
>  #include <linux/ioport.h>
>  #include <linux/list.h>
> @@ -1167,6 +1168,10 @@ enum {
>  /* These external functions are only available when PCI support is enabl=
ed */
>  #ifdef CONFIG_PCI
> =20
> +/* PCI legacy I/O port and memory address space sizes. */
> +#define PCI_LEGACY_IO_SIZE=09(SZ_64K - 1)
> +#define PCI_LEGACY_MEM_SIZE=09SZ_1M
> +
>  extern unsigned int pci_flags;
> =20
>  static inline void pci_set_flags(int flags) { pci_flags =3D flags; }
>=20

Shouldn't this also convert the use in pci-sysfs.c (which you now mixed=20
into the static attrs conversion patch)?

--=20
 i.
--8323328-972594317-1776081516=:962--
