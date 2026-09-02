Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6BF2D6E64;
	Wed,  2 Sep 2026 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335521; cv=none; b=Sw0vnsP3317sxX85EP3AmQX1Mp2EqMMlEkPn7Y+GWSVQe+CxZUn/MLpDrVPERxe9whdAJa5kQVLUwI+SbeaA6/0wdyUIVODBZ5n6h09GuO9459SMY6zueTIggwbCbF036aBJVYfcpoIZBa+yt0oc9jyb9OdKfFcWJkzElEk/TkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335521; c=relaxed/simple;
	bh=e4mintmfinkTxaVSGTkkNWZHqd2zrtc0ZA0DZNkoHx0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r93flGnRc9tQe41cPcG+etRf59ds1pPUyeY0RQ1HIJaN6DplKR+y/hjQUo0+m0RC1GYhg1erzBiKIVHsynHXUmH1FRxjAz7S0j33gQQbzKLuodwRyXB3aPAVeU9A0xheiS1dXVfOS8tcntr5mTOXmbQzDeG27d0csoMeHpC08rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/Zz4xI2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/Zz4xI2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCB51F000E9;
	Wed,  2 Sep 2026 07:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788335519;
	bh=PY0Wu/PhqeEjrsdwCafUAlZBmWRKMon2gkhMW4txzTw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l/Zz4xI2VpXP11GtyZYCPRDE0k9QxmO/O5yrLfNJiIlWibRMef4qfmtQata+q5c8e
	 JbO1Ynn0f6YKaD3sY8Cyki/Ir///+7R0SPY4eHkBcP+L2pkCaUHg22lfL4z1dZp5NW
	 SbjLpjmv/ienthwoNE5LuW/IysyeW15UuIsxWLMbk36IJUXld695n3yJx/SYB/EvVx
	 TsJpQhkBHT0ahUeVbcDl6uc8N8BOVBbeOrGQnU+N15n/mKnBawvyhVl5lF+NTgUt0i
	 /LJhhAe9QGZTDTdguzgvXxMlYrzIaJOdOJh0q1VQp/35/5dbb+lRahRLqDX58Sz8d5
	 rWEPf958tstjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 10/12] PCI/CXL: Expose CXL Reset as a PCI reset
 method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260902072804.665639-11-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-11-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:51:59 +0000
Message-Id: <20260902075159.8DCB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Bypass of hardware-enforced CXL decoder lock via reset
--

commit ac98b5cb3878ca89e0ba4a99f7bf56eb9d00c253
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Expose CXL Reset as a PCI reset method

Add the CXL Reset helper to the PCI reset-method table so userspace can
select it through the existing reset_method ABI.

Advertise the method for Type 2 CXL devices that report CXL Reset
support in the CXL Device DVSEC and pass the function-scope check. Reset
execution requires cached HDM decoder state for the target so affected
ranges can be validated and HDM programming can be restored. If that
state is unavailable at reset time, return -ENOTTY so PCI can try the
next reset method.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f80..157f06c576e93 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -5145,6 +5146,7 @@ const struct pci_reset_fn_method pci_reset_fn_metho=
ds[] =3D {
>  	{ },
>  	{ pci_dev_specific_reset, .name =3D "device_specific" },
>  	{ pci_dev_acpi_reset, .name =3D "acpi" },
> +	{ cxl_reset_function, .name =3D "cxl_reset" },

[Severity: High]
Does exposing this reset method allow bypassing the hardware-enforced CXL
decoder lock?

When a privileged user triggers a PCI reset on the CXL device via sysfs, the
hardware reset clears the decoder lock bit.

During recovery, the lock bit is explicitly stripped from the saved state
before restoration:

drivers/cxl/core/resource.c:cxl_restore_hdm_decoder_state() {
...
	ctrl &=3D ~(CXL_HDM_DECODER0_CTRL_COMMIT |
		  CXL_HDM_DECODER0_CTRL_COMMITTED |
		  CXL_HDM_DECODER0_CTRL_COMMIT_ERROR |
		  CXL_HDM_DECODER0_CTRL_LOCK);
...
}

Then in setup_hw_decoder(), which is called by cxl_commit_start(), the
decoder is committed but fails to check settings->flags & CXL_DECODER_F_LOCK
to re-apply the lock. The modified control register is written to hardware,
leaving it permanently unlocked:

drivers/cxl/core/resource.c:setup_hw_decoder() {
...
	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
...
}

Since firmware/BIOS sets the CXL decoder lock bit to prevent system memory
map modifications, does exposing this reset method expose the system to
malicious reprogramming of CXL decoders by bypassing the hardware lock?

>  	{ pcie_reset_flr, .name =3D "flr" },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902072804.6656=
39-1-smadhavan@nvidia.com?part=3D10
