Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765D6315D3E
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783052667; cv=none; b=YXndFPMw+GL/i/6glWoAJ6DX72hOHwFh6bP0dOcdE5IfF7xpKfu3ttAjawroonvi7jrCxVO0i3kRD6XSNiiJQfmwLPO5GoV6RIfszcfkAiIUI1tAOQ0rQMV1IrrvuNaZjiBqwEbfzqB2Yv/V6U3zE/NM63qqOwq8etVHjnzcut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783052667; c=relaxed/simple;
	bh=xRb/+ruolbQny2mmrD5wVW9ARqi4YafsCHCXpgn9AH0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MtiI67hP0jZVuNo5+1MrsiMFe/mZuG0GYzBpP460+sBfYAzfuiXKgLeWIFV0Eyj7NlcdPaQb1F02qI/IQczUeYWsCqsrIsaRr3mdHRVjluoPHjSqs9OA3sefekLYZKZQqyvvBNUqXcCQqQIOZw0axEtAbM5kUMq7Fj72gJr2B74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3hbQU/o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3hbQU/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2061F000E9;
	Fri,  3 Jul 2026 04:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783052657;
	bh=xRb/+ruolbQny2mmrD5wVW9ARqi4YafsCHCXpgn9AH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k3hbQU/oFWXvMesOS8KkMGAT1MEVbw0eJtq5rZCGDNPsnvYC5wQAHI19V7xHMyuwd
	 61KtdCWEiCPTAuKvXkUty87WXnF+Ezfh0HxGo0mbprG8e4bfi4whHtB+GDidjEGT71
	 Gkk73TuT0IslM9ntHm54aIZOJrrNgTOygVAxHKzleCIeFL1wJFzV3w1jDHy1ei6W7Q
	 plp1KLYrLJynLE6+jQhAwzTVvvIKbv8MORRqq83tDMKH2YxbYcmMRc1Ml9A+USI56N
	 77gLSzqOtH1Mj4cQRTMwsTr+FZAy206C1O7oXPC9AghrWLWlQdgxIKJEU3wrbRzOyI
	 ZwGQ2YYBdcqFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/18] iommu: Convert gdev->blocked from bool to enum
 gdev_blocked
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <05da17325cf02758fb0eb3bde34c8ef2a22decbe.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <05da17325cf02758fb0eb3bde34c8ef2a22decbe.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:24:17 +0000
Message-Id: <20260703042417.8E2061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The gdev->blocked flag tracks whether a device is individually being held
> in the group->blocking_domain while group->domain is retained. Up to now,
> a PCI reset in flight is the only producer, so a bool suffices.
>=20
> Subsequent changes will add more reasons to keep a device blocked, e.g. a
> failed-reset case that must not auto-unblock, or a driver-side quarantine
> for a hardware fault. These reasons are cleared by different events, which
> a single bool cannot encode.
>=20
> Convert "bool blocked" into "enum gdev_blocked blocked", provisioned with
> two initial values: BLOCKED_NO and BLOCKED_RESETTING, for the existing use
> cases. All readers keep the "if (gdev->blocked)" form, as BLOCKED_NO =3D=
=3D 0.
>=20
> This is a pure type change with no behavior change. Follow-on changes will
> add new enum values along with their producers.
>=20
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D4

