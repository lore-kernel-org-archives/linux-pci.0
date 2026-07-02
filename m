Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6F480DFD;
	Thu,  2 Jul 2026 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996907; cv=none; b=MO/2prW9E5W71nUgxz+D1KbdtGZlASmLmE0RIBaWjh0UREYKFrSSChgCsjK+vk8QKx3XPJjPFnhYV3FlN/Ixs+GWbT37bGCIh1ieHVYqMaGksJXtIlMUUcb8IV7m2FHb4TGcCvaJ4yoVrSEXrS2uMcHzcQFZLd9b5XzTC8T4zuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996907; c=relaxed/simple;
	bh=Va3oIEEyBArJm2sW7YpK09HYLOSPFBWXukIZYUVwt5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UZac9SvpE7aOPkSmxXLbABZj7UFjnRS2YhAsx35vYwezb6FqNQdaWnzxwtHeO8b5rWEb3FQShhUf6gaxm5+DcORc0neKLVXl9+kbpJEvvWKCNUPJmUFXZ9usz+8UicD/FebBESZD/p5/aS0NpnKTLtM04G/CR2hCiV/fBeCoz44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5iIesRf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5iIesRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBCC1F00A3A;
	Thu,  2 Jul 2026 12:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996906;
	bh=Va3oIEEyBArJm2sW7YpK09HYLOSPFBWXukIZYUVwt5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S5iIesRfOxBBvO+hCgw6QmlaJYeiwFt1L4kE7SeQaEZW9hC10hV6ckmkgLnJ6+l2W
	 XvxGBJ/Mlbh9Tq9Cd04X1FjahKGPAI7Xqq39HnPokpnjjVVjhD9n56/hm8Ir0aInRj
	 i+t5Q8O8eNXOpzovzkJi5e8F7cDHJijvLizlcFNbrp/MspqQmI+N0nJA4mEk7wE4aK
	 u/0cZFLRzKpwShS/YJyri931Vw0hzGsLTBMQVoD9TEMuDK7HhuyrphMBuhzs3ffUNP
	 eZgKe8BUF+uKluF0FT3N6mHuEUat9skEyJxMdG2su7xJDBxGnClNiQUBdEcZslKw1D
	 xivxN1qPU1d5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 08/18] PCI/TPH: Add pci_tph_dsm_supported() helper
 to detect device TPH ST _DSM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702124224.57168-9-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-9-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:55:06 +0000
Message-Id: <20260702125506.7DBCC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add new helper pci_tph_dsm_supported() to check whether the root port
> of a given PCI device exposes the TPH ST ACPI _DSM method.
>=20
> Wrap all ACPI logic under CONFIG_ACPI guard, return false directly
> when ACPI is disabled.
>=20
> This helper is prepared for follow-up VFIO TPH virtualization patches
> to uniformly judge platform CPU TPH resolving support.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D8

