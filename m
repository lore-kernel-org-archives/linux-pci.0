Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EFE436347;
	Tue, 16 Jun 2026 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607324; cv=none; b=Hc0naX/M36oV1MggKmD76DB2n3lorv7cI4KylFqnzoXom+huxTAP3w1sGJj+5BL7wcQnFL4AIZh6cP6F5BAXNR5Cdja/QfFURqUFZZtdqjVKAwaL49vqtW949sYQWayrFCkCETKNwEA+ddv/BHZIFLFqnXbeFhbzNZxV5ZIEKaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607324; c=relaxed/simple;
	bh=RyLaQxSYskyUUNZrpNTD+GHFu+udpIUVGaJmYpRRbY4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DL4K9oj4wfBh0mREtGRVdEo2KP1W+Aml5Uf0c1RRKjwyZOZA0RaXgXAF1q6Y3EEBK5DdpzbC+1NB/vz6kPARyMTnqCVxLblcOgbjGM2Htcs4h5pjiXdGmfFrhkBnZCQCVzGsXz4IaLWu92loFdsqhCUZdYvYUtsJ7OHxnKmy37I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTGkybrf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTGkybrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1397D1F000E9;
	Tue, 16 Jun 2026 10:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781607323;
	bh=RyLaQxSYskyUUNZrpNTD+GHFu+udpIUVGaJmYpRRbY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RTGkybrfO3Hrbm2zUkwsR4bU/zbRxxFIZUM/RLfWLmFI1S2eWBIUyHM5p4Tejeuwt
	 S4UhuYS7W30lZZT4Jz3CU9q5sXEIMcS38ZNRD8wlhxaBJ81EjS7RDDGLz6fC7BpxY4
	 GJ8ODr8pNBwffAUOr2MP8KuG333nznYuY+HJ0RPF1mCbwyQK5DVm3Ab9DHd+bCJKB1
	 sH4ijHlCxd0LBhN6sVr+KIrQyJ01Hply7sETXoearMffTxf1st6td189+ln2P3mEmR
	 egvNjzl2DjeoUCLyeN6vxF4hvebKXyR2/RHiaJ+6eKUaioh4TqsxZkkSPQ1an07gXs
	 o0CHwrDBBLH3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 03/12] PCI/TPH: Cache TPH requester capability at
 probe time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260616104621.41915-4-fengchengwen@huawei.com>
References: <20260616104621.41915-4-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 10:55:22 +0000
Message-Id: <20260616105523.1397D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Calculate the negotiated TPH requester type from device and root port
> capabilities once in pci_tph_init().
>=20
> Add tph_ext_support flag to cache whether the device is allowed to
> issue Extended TPH requests after topology negotiation. If the final
> requester type is disabled, clear TPH capability to prevent usage.
>=20
> Simplify pcie_enable_tph() by using the cached requester capability
> instead of recalculating every time.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616104621.4191=
5-1-fengchengwen@huawei.com?part=3D3

