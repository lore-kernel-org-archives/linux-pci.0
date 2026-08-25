Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD37254AFF;
	Tue, 25 Aug 2026 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787637490; cv=none; b=qfP26uEXHGjUzO9iHI36R2sqlaW2vn/oAT4qDLBSCMAT3NxorwTrWbyTLKXCqLFlaL/iBzSA07pBvkUi/u8FoQg2k7NiBZvBnm0w9Z8NMVMQkLhM/rzjifI/MOmUF2PhWc9FPMpp8qlvnzLP8FVi2ibjjqzztp89StptDJ8xoRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787637490; c=relaxed/simple;
	bh=rmF7O9m7gtaklRLHluh9+K7i5jEd9VwgddyanQbydNY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jBXmh4qDC2UATGcDu/bZmE1eW24TBJvJsSQ/lsPiqFH3QPIhcw5TYn7o6tM4SCkhGxlAagd4kNcOshqxNES+pSDWgOHVCil4PrhK3HHpOwkcmoD3/2advLTauS8NF6WRwLx6uTWBmoc6/G5zjms0HpPGJQn+Z4UW1XdHdXQQACo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXa+bo9Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXa+bo9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302681F000E9;
	Tue, 25 Aug 2026 05:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787637489;
	bh=FkPkgLm7MyhPLhskopghZwRJYH+/CYQvaDqt+64HpJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hXa+bo9Zw1Zc0ymFr6XbTURzvfKlKy8SjO7c9fIPBYO3H4ar6Y/NWo2ObjCOf1TLg
	 nudtCKqii9OqCV2UExxpbs8FZ0csThicOoXpopQ4idrvN4JCzs07dXmVx3sCzkh1Ww
	 TgpF/pCndjK8mXIe572GGLzyF5Suma0ZzTEua85PZ2tEEdgW6Z0rKzlDcjxhMrnDxI
	 uLbBllaF2uCmSigiueSPV4np0Zh/5UZGOCyoopowunKiuZbGI8UxlA2EIbXmiXppsA
	 NTvK1IoPw0Vht8o+7x1KsF+IToP9pWZoz1PVqus6H4+MQ1dmVFuNUsu07+6IKFk19Y
	 WT9gJJ/LGIIOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/xe/ras: Enable SGUnit PCIe error reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Raag Jadav" <raag.jadav@intel.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260825054312.1319951-3-raag.jadav@intel.com>
References: <20260825054312.1319951-1-raag.jadav@intel.com>
 <20260825054312.1319951-3-raag.jadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 05:58:08 +0000
Message-Id: <20260825055809.302681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unprotected call to pci_save_state() on a shared upstream device c=
an cause a data race.
--

--- Patch [2]: [PATCH v2 2/2] drm/xe/ras: Enable SGUnit PCIe error reportin=
g ---
commit 4e1cc07b97a799fd7dc8e01bed43ae859ed4cc97
Author: Raag Jadav <raag.jadav@intel.com>

drm/xe/ras: Enable SGUnit PCIe error reporting

This commit hacks the SGUnit config space to program error reporting bits
in the DevCtl register since it is not AER capable. It also adds a native
AER sanity check for the upstream port.

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index d25d25f775310..3118c713c1186 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
[ ... ]
> @@ -279,6 +292,7 @@ static void ras_usp_aer_init(struct xe_device *xe)
>  	/* Unmask Uncorrectable Internal Error */
>  	pci_clear_and_set_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, PCI_E=
RR_UNC_INTN, 0);
> =20
>  	pci_save_state(usp);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to call
pci_save_state(usp) on a shared upstream device without locking?

Looking at ras_usp_aer_init() in drivers/gpu/drm/xe/xe_ras.c, if multiple
SGUnits (endpoints) under the same upstream switch port are probed or
initialized concurrently (for example, via async probe of multiple GPU tiles
or functions), they will concurrently execute pci_save_state(usp) on the sa=
me
shared upstream port without acquiring the device lock.

Could this lead to a data race, writing directly to usp->saved_config_space
and other PM state arrays simultaneously, and corrupt the PCI PM state for =
the
upstream switch port?

>  	dev_dbg(&usp->dev, "Uncorrectable Internal Errors downgraded and unmask=
ed\n");
>  }
> +MODULE_IMPORT_NS("AER");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825054312.1319=
951-1-raag.jadav@intel.com?part=3D2
