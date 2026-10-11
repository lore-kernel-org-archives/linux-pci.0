Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA3C2BDC13;
	Sun, 11 Oct 2026 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791685336; cv=none; b=WS7sEWgOQNBkZU+GUImPGiMi3l81g7sRo3AZfSwjjakFjEhsd7C8PLtZl80QhQATRJ71RIsLVkAfwY1Zl+9Fm7QAOPVUMVUz41mdQEDzEjshovVIIvyyWOPhMK5+wcyfVrKm/CCJSf708yupgMPB9TYsbM1MgolCP6v0RCr96CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791685336; c=relaxed/simple;
	bh=CBt5flnRC2LrWCsUreMrOANIVYbAgplLLgN5Fhh9XJk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gCGDpXbKUm41aRI4EPmJeGQk11MUZPCDgXA5EHYTk9Z3QdSyK/z74nqd0kzkk8aXYRtltpbHtrYIHeYkCzerueX2EOVtzOFeADhWXr3HQnv7OuC56L+DaGHQkHMvM27FwPKbkIYDguoVeskmMJnzoYKgVYc0Jhkt+n0SrrkvuYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSGYc2M8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSGYc2M8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A651F000FF;
	Sun, 11 Oct 2026 02:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791685335;
	bh=CBt5flnRC2LrWCsUreMrOANIVYbAgplLLgN5Fhh9XJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iSGYc2M82U9EuODESSukTK94ZFWKJRRcp0fHW4gI8rDTrhs9sUr97UbG95BIqZLAC
	 KKC7RZljNu8YQL8OS0FVnzEgFHykWQXePDvwyoMTlkhao2i0xDCAa1sAuMAUvOwVrz
	 u93Sikort3Z4VnR3G4KOYVRzbQgyuYQud44KrCT3Fqj/4bMxN45XTZD0SwzFTQpuim
	 v4FfA8kFfn40PpwTaKUCzD8if0hBNWNqftWgmcGyPUwTIs57Nfi3fjMlhH2bJKoS/d
	 hB2Y+CatNhpLVvmX6tvdTccs9N7qUEhAAtJLnNOwBra7XqsEAJS/BsdETZB5tQ6s0C
	 LL05wD1a08xMg==
Message-ID: <sashiko-outbox-166971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 16/16] tools/testing/cxl: Add HDM decoder range
 checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261011021422.3428136-17-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-17-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:22:14 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Test cxl_hdm_unpack_decoder() when cxl_test loads, failing module loading
> if a check fails. Cover range boundaries and overflow, an all-ones base,
> zero-size and uncommitted decoders, and a locked host-only decoder with
> 12-way interleave. Verify the decoded fields for valid inputs.
>=20
> Run the checks separately from the watermark hooks, using a helper
> exported only by mock cxl_core. No PCI device or MMIO is needed.
>=20
> Cache refresh, retained-state comparison, and reset restoration need
> follow-up tests with additional mock support. These checks do not cover
> reset sequencing or hardware cache invalidation.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011021422.3428=
136-1-smadhavan@nvidia.com?part=3D16

