Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A343B27D3
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581167; cv=none; b=LBi6xS1NNslPkhMwsS+3BRGgjyELm8U6lcrWtbjbw/VdtZHvW8HsG96QV5x2QRoA+1oIMWie7J+AezfivTsEP+IJFnRlhevMh2UQMyGXJHYguJKtSqvjE2Mir0NF8ycj0KFgzYQC+mODtNQvDgsrnwPBGQOiZc10y1zsZcmVaz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581167; c=relaxed/simple;
	bh=/xVBZZMgtQuAQB2GRlb8ZUwluZqtAAINKzLYWO2Rw6I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tOhj9BfCM+AlTkfhu3xoh2UKaFjpHNj7DH3mweXgbDIsW2Ys5I8qrIy7akP5yaLJ6Yli/zP42gXkwoSoK9pQiv82Xpmk9VAs1J3YGtoB02ZtTHu/Bvf0tjj4FsyjhkDZr81ub3twzucY9DDUo3GUtpiEOj3W3qc5BreYFRj2nmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxZmEdRO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxZmEdRO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1961F000E9;
	Mon, 20 Jul 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784581165;
	bh=+NJVDG2oc/lO0DmFx0e5JWDkbs34C311ajD9JAU0gMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NxZmEdROJzla6eJaS+YgqMIdaCcqL+dbAJz4OHMw9J4D0WhfWTGUdWuG8Ztkm7X90
	 /qcrVioLc26AbpR/7P4HYIf1rNib4R8tuQD0VPgnBPupRRg2dPRjEjaxNpidelWlzj
	 KhPeDUGmeuu+4n7VLdtUhRAmvysbvdULSZam+mBHP5jCMhyIcSsOugIC06nx6s3eN4
	 JMDMFfaluRnaPqNmrH4qL19IZOeUJoITX5Y58SI7JaIgMWa3Wo6OiiJXMlG8J2Q5AL
	 izi6SWzgzClOmgElV6r/pPWwGT4ibENOYeuk7iJjigOhe5lhbkH8iPVwzor9TVKAi8
	 BkJgM7uiC+3YA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/sysfs: Avoid spurious runtime PM wakeup on config
 space accesses
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260720204356.1501749-1-kwilczynski@kernel.org>
References: <20260720204356.1501749-1-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 20:59:25 +0000
Message-Id: <20260720205925.BB1961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, the boundary checks in pci_read_config() and
> pci_write_config() reject only offsets beyond the effective
> configuration space size.
>=20
> Thus, an access at an offset exactly equal to that size passes
> the check, has its length clamped to zero, and then invokes
> pci_config_pm_runtime_get() and pci_config_pm_runtime_put()
> around transfer blocks that do nothing.
>=20
> This is a problem because pci_config_pm_runtime_get() synchronously
> resumes the upstream bridge through pm_runtime_get_sync(), and resumes
> the device itself through pm_runtime_resume() when it is in D3cold,
> only for the handler to return zero immediately afterwards.  Such a
> spurious wakeup wastes power and adds needless resume latency.
>=20
> The sysfs core already clamps accesses against the attribute size set
> through the bin_size() callback, which reports either 256 or 4096
> bytes.  As such, the affected accesses are reads at offset 64 (or 128
> for CardBus devices) through files opened without CAP_SYS_ADMIN, and
> reads and writes at the exact configuration space size on devices
> where a quirk sets a non-standard size.
>=20
> Therefore, reject accesses at the boundary offset as well, so that
> they return early before any runtime PM involvement, matching the
> procfs implementations in proc_bus_pci_read() and proc_bus_pci_write().
>=20
> The value returned to userspace at these offsets remains zero,
> so the change is not visible to userspace.
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720204356.1501=
749-1-kwilczynski@kernel.org?part=3D1

