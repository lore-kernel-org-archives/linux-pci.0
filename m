Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569ED57C700
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790193837; cv=none; b=UZLDeKqX23tZD/cOI6/zSM014HJk99hyYeNOhVBve19OictGZs4Kwfbl0PT3Z29hGVYTpwWkMTFXsO+6PSvg1Zt1vHxYHDmvDWoGLSUP2cStZYl6Hj0dsY5T19R4iG9c2L4URZxMyZsWXXsW9ZcMlv6MUdTMNjKOU/L5LSmAQoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790193837; c=relaxed/simple;
	bh=83px00VSvVFTcbEGavWd6GQSRymNtnzVErKNl+asPFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WeQ4xETjPGc1/O1Hn7t1LJjxWdDJYMnHyOIB8Uq7oRx5l8hNzIB1OSkOSqTzvchHFRzbr9ZQbtntILVVXGujfD0nllCTWkYAOYdH6+ECGHRyDqSar5F3eTyKKG3XuxPelFUy3nVNzDYo0lEMqLvEOkr2ELAOqudJxyU34yW+mQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLC1FE3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLC1FE3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBFB1F000FF;
	Wed, 23 Sep 2026 20:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790193827;
	bh=BR6x3GAK34APiWcl4q0ZfRSebMn0IhiZptZ6giLJk4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WLC1FE3oXSb78pHbjJ1DD4xwOEktVKrEC+zzcOU2PVoYMkSLmuyAh1GET7O8kR6A/
	 EBOiDjJxFJrpR2xvrwvrMql9El3wFbwVDNO/l9mj0LzCSDStdq8jLNf2E8cAtpcS5R
	 3SC0M/+C1pdWkin0Vj5nL9PnN1168qMHmXQ2XPAgtJU3zPBOCS5S7QcorOTJU6B+QR
	 PbPGYqsklVmW6DdO8liiD8goPhko79UZlqhrzTBTl9EjVhZ5gj2zJlOZb1dAx959ig
	 +vQfZ/7uyqkH1hjyiw5lq/MCwJUA5C8nAzQ9/32/nGNaiN05Cb3ZgLimPl/xf4lncI
	 jS8Avh6QfxTXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: tegra264: Fix Link Capabilities register offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260923195719.1933175-2-bhelgaas@google.com>
References: <20260923195719.1933175-2-bhelgaas@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:03:47 +0000
Message-Id: <20260923200347.7BBFB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCI Express Capability begins at 0x48.  Link Capabilities is a 32-bit
> register at offset 0xc, and Link Status is a 16-bit register at offset
> 0x12:
>=20
>   Link Capabilities is at 0x48 + 0xc  =3D 0x54
>   Link Status       is at 0x48 + 0x12 =3D 0x5a
>=20
> Previously the driver read Link Capabilities with a 16-bit read from
> XTL_RC_PCIE_CFG_LINK_CAPS (0x56), which incorrectly read just the upper
> half of the register.  When a hotplug-capable port has no link during
> probe, tegra264_pcie_icc_set() consequently derives the maximum speed and
> width from unrelated bits and requests the wrong interconnect bandwidth.
>=20
> Correct the Link Capabilities usage by adding a XTL_RC_PCIE_CAP definition
> for the base of the PCIe Capability, using the existing PCI_EXP_LNKCAP
> (0xc) and PCI_EXP_LNKSTA (0x12) offsets so they're easily searchable, and
> reading the entire 32 bits of Link Capabilities.
>=20
> Fixes: 01c3c27a0ef6 ("PCI: tegra264: Add Tegra264 support")
> Based-on-patch-by: Linmao Li <lilinmao@kylinos.cn>
> Link: https://lore.kernel.org/20260827093919.2825467-1-lilinmao@kylinos.cn
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923195719.1933=
175-2-bhelgaas@google.com?part=3D1

