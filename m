Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EF122F388
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077366; cv=none; b=tF8vyLiCfRYvSvaqzqIrsOa8aRXp4n1pjMkMvk/X9hVcZOFhsQoDzqiQ1RrQmfLiMp+5kcF27WIohNs0WByiXQ5xtKT0Lh7yap8KnhZr0ezmpAIJM+jR9/62m9lYGxX3M80hYmpKCq7eL0g6elnXzQ4/EuisvZcNVwhufyHe12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077366; c=relaxed/simple;
	bh=v46SqU54Dgjifn4xpkFEcLb7euLxjO6P3KYR+OQ7hj0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=STwDKfOgfw+/yWwkGV4cvNVxk/P97lDXX/PgbJpU2DpUeEbrZbmS4LYq/X5acIoz0r1hUAVDS4H/qDc5Tuii7B94XH3cfhvw8TvGD2B8jCuHKKcdVwRFbg5nmyALIEXaLtxBy/Ra6wE5sancouatII4NsHSdCBVokFYC6NjXx1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIE5KeAM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIE5KeAM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769077365; x=1800613365;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=v46SqU54Dgjifn4xpkFEcLb7euLxjO6P3KYR+OQ7hj0=;
  b=EIE5KeAMZEbAL5hUWJvJHyYTQtfyI+ts2XENxcEUj2ASXJfzha0bJMCC
   mkKvwTvVsiX4vHNYS8ly54/3oQg3PIKGID0t9cwxoybzago0asRKHWxGt
   u/CROyP5T99dmgSnIV7bQtILyaLTXZnXSRGzBzWMW+Q+MbYWL4u7ui0n8
   yc0gQOBW08exkfc0cAzYYARjucmRIU86gQuGbToJg9cARRxxk5ag+sj8l
   pyLdX+jYe4Ql7jn8bcym+yd9v7f6iNJA9lNJoEgRjIYqIfCSO70hJJPeG
   sAdXx647eWrDXwWTSfYKHSTMgaEhHDsQru9tB6LpzCojlOksX0St+SrcI
   w==;
X-CSE-ConnectionGUID: 2xv7fDI5RKqq4aVrDRngWA==
X-CSE-MsgGUID: nlXIMCfqTaGZUfEHE0qUiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70038321"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70038321"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 02:22:44 -0800
X-CSE-ConnectionGUID: 1vLyTaxeTQGBzEwRRGgNVw==
X-CSE-MsgGUID: GcAe+rDGRi+zuqohbeRyEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="244303717"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 02:22:43 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 22 Jan 2026 12:22:39 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PME: Replace RMW of Root Status register with direct
 write
In-Reply-To: <39f87c99f6c44be3c0371c79e454e6fde7be0d4d.1761497583.git.lukas@wunner.de>
Message-ID: <4264eef0-c7c8-18c3-2461-d1fdcf2ba532@linux.intel.com>
References: <39f87c99f6c44be3c0371c79e454e6fde7be0d4d.1761497583.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-631596342-1769077359=:1059"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-631596342-1769077359=:1059
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 26 Oct 2025, Lukas Wunner wrote:

> As of PCIe r7.0, the Root Status register contains a single writeable bit
> (PME Status, type RW1C) and otherwise just read-only bits and RsvdZ bits
> (which software must write as zero, PCIe r7.0 sec 7.4).
>=20
> Thus, when clearing the PME Status bit, there's no need to perform a
> read-modify-write of the register.  Instead, the bit can be written
> directly.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..411a0b88841e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2285,7 +2285,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>   */
>  void pcie_clear_root_pme_status(struct pci_dev *dev)
>  {
> -=09pcie_capability_set_dword(dev, PCI_EXP_RTSTA, PCI_EXP_RTSTA_PME);
> +=09pcie_capability_write_dword(dev, PCI_EXP_RTSTA, PCI_EXP_RTSTA_PME);
>  }
> =20
>  /**
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-631596342-1769077359=:1059--
