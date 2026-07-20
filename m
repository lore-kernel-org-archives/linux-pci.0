Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC573B42F1
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784580716; cv=none; b=Ym4x/DuAZwn2OhFm+glH5mgppd+y0etbQIYrunIgl3wtVHr6Ld5p9YXvpYEWd1SNkkOGZ8LMaRiVZ99GaUPJZotSIdzAXZqEv9E1hNmcG8siBelpL1rv6UUjO5WIQzvF+kUqDQlQar5n/hkkU5FJtBClPFXUBQTvePIsCKYF9Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784580716; c=relaxed/simple;
	bh=4F1AlyZw+s3s+tq+bs4BjEf4PCIdD6JEFIVW+GGoWWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GRKH/xX0lfivHtQe93rL8w/ZqNCwBK4hGCfEZWjoXhacHSEPgppS2icKIe3I/Kvsq2Q8WtqT3x4xLseCHfkwaPuyf5Bksi5XKmN0iJxO86d9gx6tBw63meZ48tMMYyyEEtM7aK49GC6Df2e5K944ng4QEE2aLOAiGvUQoswpFfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orJO6hMj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orJO6hMj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F36F1F000E9;
	Mon, 20 Jul 2026 20:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784580715;
	bh=4Cf8h7i0be50IQvekzkkiOiO0u6G5v5kyLnx0TVNtXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=orJO6hMjYE0lH+1T7YFiqL/tQMtD8Kb/7ecZUzxL22kIfGsPx/cmTfNV0fwulgnW5
	 UXkHpSDB1R7O/aW1mYCZBt61JEZKyKvfJzy5Ql18H75geAVrzoVKoXyaWDevaf2i7W
	 XhMN4Aw81ZygeYTmM8xvBnOWl0AK05cDNtgP8Fl7WNXpV0BgfzCGwE1nKhVX+w4iTM
	 53QzXmGU1SLM01cJadix0w0gGUjzNuXhdGQQrEbbv96c7TNLTFFWvGUdR5d1EMEKyv
	 Ipnv6xMMIxtPv9ndanHzFiGauOQCIDYWr4YQP7Ul/q061Z2uACD8vCMuNzkgbWFR2J
	 VE9YPNHwLNjTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/sysfs: Return -EINVAL for unsupported I/O BAR mmap
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260720204624.1503794-1-kwilczynski@kernel.org>
References: <20260720204624.1503794-1-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 20:51:54 +0000
Message-Id: <20260720205155.3F36F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, mmap() of a resourceN file for an I/O BAR fails with
> -ENODEV on architectures where arch_can_pci_mmap_io() is 0, such as
> x86, because the attribute has no mmap callback there and the error
> comes from the generic kernfs dispatch.
>=20
> This is a side effect of commit e854d8b2a82e ("PCI: Add
> arch_can_pci_mmap_io() on architectures which can mmap() I/O space"),
> which removed the mmap callback from the I/O resource attribute on
> these architectures.  Previously the request reached the architecture
> mmap code and failed with -EINVAL, and the same commit deliberately
> kept -EINVAL for the identical operation on the procfs interface, so
> the two PCI userspace interfaces have disagreed ever since.
>=20
> Therefore, add a pci_mmap_resource_io_unsupported() callback that
> returns -EINVAL and use it as the mmap handler of the I/O resource
> attribute when arch_can_pci_mmap_io() is 0, so the failure is
> produced deliberately by PCI code, consistent with the procfs
> interface and with the behaviour before e854d8b2a82e.
>=20
> Architectures where arch_can_pci_mmap_io() is non-zero keep the real
> pci_mmap_resource_uc() handler and are unaffected.  The mmap() fails
> either way.  Only the reported error changes from -ENODEV to -EINVAL.
>=20
> Fixes: e854d8b2a82e ("PCI: Add arch_can_pci_mmap_io() on architectures wh=
ich can mmap() I/O space")
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720204624.1503=
794-1-kwilczynski@kernel.org?part=3D1

