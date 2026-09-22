Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB563DFC88;
	Tue, 22 Sep 2026 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067072; cv=none; b=QycRQRZClVZT78VyOKIqK+T2tdJS/ECW599BJrWCEV5rwh47hUMoCmi7tSnWth1jNTmo5AlI3+dz7PoB94YHj1gj9oY+uUzJhEQEzb1vwl9TDDs+boL6csghAmaTXbYwOz/6BRp5edimq6TLFyY+Era2rGNIbw0ibGUA6yALSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067072; c=relaxed/simple;
	bh=DA8x92fd9qRJhQC8U3eQrySISM9FsCBManVybzVurzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KpTTcgkXT42VM0ycOvcrLGrpZSgWISaBUiH/L67p8rBG8a208NvgvMGptRjbz+Q1LQRJkirlh8pUkMDgfZl2CypKp9LLzIhoCgmX4vvFBGXWAXydiNnG4fS8LlFg5zZISEsQ6ysFtabQ0zjOHBVVBUX3CprLx6GdsHepCYwvxj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOkhy86k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOkhy86k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1AF1F000FF;
	Tue, 22 Sep 2026 08:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067070;
	bh=DA8x92fd9qRJhQC8U3eQrySISM9FsCBManVybzVurzo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fOkhy86kCVRGIfDP42uQ4Vz9wAh+ZoTlg8FrSk5QVM2okcaOUBj8/B19+J8bdF2ic
	 YvW2/0aQVBVqXA7jbvUZSywlqpLvrouCVM6fXjiuV3ErmgYyQ9GGEBHzoRoAUp12z/
	 8CkrgwGh/bAvwac0Iee+PTItH53N5N0l/b+G/Al1Kb7JNBg5Oapriwr+l7m2JIntn5
	 ciNwc62B8t/RD3617zQSqCrAtTZUR5Iit/qq+anQXWxKdf9II2OePjmCsQjXv7oanY
	 Zldr0XI/oNJ1sKSovgXOS/VuUh3rnHXmJOtOLqGKoVYgZNh8kp7r8nKC4avaZfUuPS
	 8Qy2N7NQaM4tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 11/15] cxl: Validate and synchronize HDM ranges
 around reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260922083924.2451158-12-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-12-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:51:09 +0000
Message-Id: <20260922085110.1D1AF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Refuse reset unless enabled system-physical HDM ranges can be reserved
> exclusively and CPU-cache invalidation is available. Invalidate before
> reset and again after restoration, holding range reservations and IOMMU
> exclusion until the second invalidation completes.
>=20
> Reject normalized-addressing decoders because their cached ranges are not
> system physical addresses. Ignore zero-size decoders because they map no
> address range.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083924.2451=
158-1-smadhavan@nvidia.com?part=3D11

