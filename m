Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F93D1AB7
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 21:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582724; cv=none; b=txQaqB4RJcJSY88dRp8j754nvUEcza0SH7orG5w1dmsFNZEKCOGuDbXkr/UOwie20jxBIJbGKki6dTvtIaQMqBgD96Du90qpPusMB/hTc2sJXdnRYbHlkIMdC8EY9aUmK+NrO1tlYIE5SeW6ad9LoYlI4j5LKYVs1hOaHstkVn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582724; c=relaxed/simple;
	bh=LsSD6ymqMn/Jn2l2kSZVjS8fkb7Km+qi71LrLK6Nx2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hm9jHG/xlvjxe9piucAN6crojey7S3A2icW8jfpjcU/Lt3jVT4ao6BqLHkFrUscuqF6S1joo/u5HhNN6QuC1+e8k0nob+VkUiISQ97F8rTCAzfv86Ei459Zz/nqE3d7e3x0D63oY4l2UF0cnZh/hQEP1MQl4xeSi+FngOafN+x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNOzObot; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNOzObot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425EC1F000E9;
	Mon, 20 Jul 2026 21:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784582723;
	bh=LsSD6ymqMn/Jn2l2kSZVjS8fkb7Km+qi71LrLK6Nx2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jNOzObotCRkMG9vZoq7mWlas8mEk/ULkdPtZAQBz4Djo5JCxdNFMnaaLQhWHUzv//
	 ZGNBnmOO4556NkXnt0foiIj0F2+eZbpsxFCTu42oX/wUoE7AH2ID4LNWXiJKPZ58sT
	 Nkhk6faby6b8CBCHqz47ndPmIP+fllRRlDQkvZNwmx8iUUkmhXjZrJa8HgHqdnBC72
	 O3G6Sqc2YgALr2Zyzch8fAzCtQiGx3DweKOFo2p9WwtWQHbsYdBFCMwb5HjQ251eNL
	 rM1cFwHVPL9QHBcy1JCLsxONTb4d+hpH+B7h1dnvy4w/KkvB02nW93n7yN4NmplCEC
	 ilB4WiYUvZTmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/sysfs: Add lockdown checks to legacy I/O and memory
 handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260720211541.1509744-1-kwilczynski@kernel.org>
References: <20260720211541.1509744-1-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 21:25:22 +0000
Message-Id: <20260720212523.425EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, the legacy I/O and memory sysfs handlers do not
> check security_locked_down(LOCKDOWN_PCI_ACCESS), leaving the
> legacy_io and legacy_mem files unprotected when the kernel is
> locked down.
>=20
> Commit eb627e17727e ("PCI: Lock down BAR access when the
> kernel is locked down") added the check to pci_write_config(),
> pci_mmap_resource(), and pci_write_resource_io() to prevent
> userspace from programming DMA-capable hardware that could be
> used to modify kernel code, but did not cover the legacy
> handlers.
>=20
> As a result, root can still write arbitrary I/O ports and map
> the legacy I/O and memory spaces while the kernel is locked
> down, which is the same capability the lockdown is meant to
> remove.
>=20
> Thus, add the same check to pci_write_legacy_io(),
> pci_mmap_legacy_mem(), and pci_mmap_legacy_io().
>=20
> These generic handlers cover both architectures that
> define HAVE_PCI_LEGACY (such as Alpha and PowerPC).
>=20
> Fixes: eb627e17727e ("PCI: Lock down BAR access when the kernel is locked=
 down")
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720211541.1509=
744-1-kwilczynski@kernel.org?part=3D1

