Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53452525A94
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068294; cv=none; b=j7udIpysHiZcj4hvWF09rFXjWggLuLBBOZaFkTYm8nyj02xoDHaJTTt69rICBkACD60c0FBwvbcMqNPubw+XweHEBioOdORssvkst2x6lP+EG/M78nhr26HLpA99qQw7163eTNkzUSe9Vqoe0rNdWf27FVsGIMwZtNbPVonmZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068294; c=relaxed/simple;
	bh=ZJ2VUqAd2n3POWsXnHUzMvLsv8rn97gLT6jbngpOf4Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ram3eKHEH+sZ3vHo1z6CL/eiVgW8mhJRKHevfSsuLzD2/cecYnDesV/dT0CStccNiSzv9shSRnrlCVOEpN0LNKfOtLMT4M2XfLioPrXLqjERoIOOkAMfG8MYxLk5ffsWJrhUZIrqGA+7NzABXUJ75Q1LQ3fraBYXcNyejleXcWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5Ah1vnN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5Ah1vnN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1C81F000C4;
	Thu, 15 Oct 2026 12:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792068293;
	bh=ZJ2VUqAd2n3POWsXnHUzMvLsv8rn97gLT6jbngpOf4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G5Ah1vnNWLF4NBZCblhmkdvyZnXxVteip7LbKDiTWEpRfoHvLu2bG1Y9ZULQJaO1W
	 QQREBe5e1Qv9k6Y66g3c2pKtJo1Kg1cr1p1DyaWu0nvWhZ353swO1JynMHK29gWXP3
	 dSs0mU6igKqKIHWSbADtqDDn0ckHinXuBCKGw0XvBw52tQFpDCMw6B70H5l1uUfIY5
	 ufY6E0VjlzO5wlfSFkMU2Mx8URPiAlSlsWGhYCvnqGqp0aFHZloYP8KMt0k5laRa1t
	 WWij/7gEKhDpaS3Ci9cpss4A9P5/1TQ8lUD4PEuhrGoiceBrH1CGm58sQiSBI/Vq8w
	 N8Qhs5UbHdonw==
Message-ID: <sashiko-outbox-172856@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] rust: io: project primitive accessors directly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015-io-access-modes-v1-4-93611b84b5e3@collabora.com>
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
 <20261015-io-access-modes-v1-4-93611b84b5e3@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:44:51 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The primitive accessors, `read8` to `write64` and their `try_` variants,
> pass their offset as an `IoLoc` to the generic `read`, `write`,
> `try_read` and `try_write`, which project the view to that location and
> then call `read_val` or `write_val`. Commit 147b41ba23d6 ("rust: io: use
> generic read/write accessors for primitive accesses") made them do so to
> reduce the number of unsafe blocks.
>=20
> Since commit e0454ec1220c ("rust: io: use view types instead of
> addresses for `Io`"), projecting to an offset is safe. Thus, have the
> primitive accessors project with `io_view` and `io_view_assert` and call
> `read_val` or `write_val` themselves. The bounds checks are the same.
>=20
> This prepares for access modes on I/O locations, added in a following
> patch, which make the bounds of the generic methods depend on the mode
> of the location. The primitive accessors keep their current bounds.
>=20
> No functional change intended.
>=20
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-io-access-=
modes-v1-0-93611b84b5e3@collabora.com?part=3D4

