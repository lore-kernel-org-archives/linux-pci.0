Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802BF23BCF7;
	Sun, 11 Oct 2026 02:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791685410; cv=none; b=p/nRWARiURWwVbFBCV57ypCiwkwOVW3kUrVmF2IKpVWBy5TetdmHMPbgVnF3mN3mdTSOvAVHeAry6bFtim8MJUcl9rUz7RrBrfhlvqDZLoJhKzFzAYtPnvSrEz0QNhJebotJSFsM+GSVYTYTkCnojpR3AOHFPw63dMSlPp5KIEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791685410; c=relaxed/simple;
	bh=M01w7JoWD/8wmrWimYFlM8AMHHqrCr/LOaHjL1/qFK8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=I2cSLHEUQk/QHVn0vcY0O0CirLBzwL4Giy6IAxIBj5F670nf7tFgX/YrA4bTbimJzZGXjFV4DZeF1h1wajtrep7+S4o7JT56FyBh4z+2pLIjPSK5xPrt1I+y74+1KguPzGjKeET0JWQsJeV1fqmBZciepStQ5LWh2OBgnslRIqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDXHgUAy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDXHgUAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81FB1F000FF;
	Sun, 11 Oct 2026 02:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791685409;
	bh=M01w7JoWD/8wmrWimYFlM8AMHHqrCr/LOaHjL1/qFK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NDXHgUAym6fUGVpfCjXPjJPji08U25ucLJlwmh64lfhY9wXOLcq7OqNpjm60PjnmD
	 dHamjFWQLA889mFds3N1NdUB8eso82NfGMmqv8Cbb+4vB6ZOz8DSigvBpvR7VBlQG3
	 eGhJr/TqqyB4zUjJvf3yqkpz6Y3X9KixZChr4JQXfB72RCvnvb8ttEfa6BocvnCcoq
	 EGN7JCAqfJ3cBkOWmcp/W6QX2YLAvGg1HoJueecW6LyiJulM8MK55wKPpLnDOihSAH
	 wrm2qz5XUOe7CvxFGZffI2YBaQ1vyWkNtVrEBYVfWBday/Qewbt+yPDzoUF7GpYrph
	 kDfNfY2Bceatg==
Message-ID: <sashiko-outbox-166973@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 08/16] cxl: Refresh cached PCI HDM decoder settings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261011021422.3428136-9-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:23:28 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Early PCI discovery creates the HDM cache, while later CXL enumeration and
> decoder operations provide updated programming state.
>=20
> Refresh the PCI snapshot when decoders are enumerated, committed, or reset
> so reset recovery need not walk the CXL topology. Ignore updates when no
> cache exists and reject decoder-count mismatches.
>=20
> Use CXL_RESET for the PCI HDM cache. Shared HDM register helpers do not
> require it.
>=20
> Skip cache checks and updates for DVSEC-emulated decoders, which do not
> use HDM registers. Keep cached global control when MMIO reads return all
> ones.
>=20
> Skip non-PCI mock ports to avoid test wrappers and a circular dependency
> between cxl_core and cxl_mock.
>=20
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/co=
mmit/?id=3D50a88f5194e5df38590d413f925d8d5afa8a8488
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011021422.3428=
136-1-smadhavan@nvidia.com?part=3D8

