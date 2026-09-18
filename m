Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91B3B47E3
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743896; cv=none; b=CR62kZPXMGaAGi2ngBCwG/v/9xarmx9S7IU9wHawCOaAGwkPc4cZcVs8E5Pu+sifQ4F8dIpzBr7bq7Nyi8wx7GvZgns8G8C2lN5BJs9DYcIW+NYU2IK3EjEhM9vGS3hrsiRe1+Yztm56Zj64zA1JYWouuA6nO+ZTa8GW/EBTJn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743896; c=relaxed/simple;
	bh=q4rPdOPQHueYQYgmzPDyvIPuGk6DruvBusxBlQG7nfM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bVTuHsbv79zN3eyXUHDGE5+viwfpoPj3cO7JVxkEKy8xgByWcRftyqzi2BSk4OK90cUL+GYRanlpkTA+AhLLCp38Je2zGnyoFCUrz9b/NKkVPaGQSqrJErw2vsAFqgCHz3fFEEpRBi4DnteLah7ZVKGaCF02iv5iA1xnOtGerz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2zgrCQv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2zgrCQv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6391F000FF;
	Fri, 18 Sep 2026 15:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789743895;
	bh=q4rPdOPQHueYQYgmzPDyvIPuGk6DruvBusxBlQG7nfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C2zgrCQvb/76pkAb9M3NK7mTh83mZRePJaJ1ojtkjHdvZ0OEUJa54guDzMiPviAai
	 +8h7qukwhlWIrryfXrf1DF5rvkch2ON+E08r0JtP6V932ScFfFkpVudqgbYPlD65FB
	 CQ65cXFULDpKCyasyhlAdNzfbNqZhqDaw6hbfkT2p6LhwzhtC1wo5Y0q2Sd1fuEHQ6
	 cjYiXHLhTowveISAGSWv+sBTi9cQpiZbhHjwPU1xfV/fJy/R3QeyEHpnsv/BV7xBJG
	 oY7cKlARW4MgcOyv7OQgEaKl2zpymanI3j2JIgceOHBzmnk9fK7HRuTEgpHi9SHhgp
	 +3crd3/rrPLDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/10] PCI/AER: Report the ratelimit interval in
 milliseconds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazen Ghannam" <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260918145619.3016889-4-yazen.ghannam@amd.com>
References: <20260918145619.3016889-1-yazen.ghannam@amd.com>
 <20260918145619.3016889-4-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:04:54 +0000
Message-Id: <20260918150455.6D6391F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The "*_ratelimit_interval_ms" attributes convert on the way in but not on
> the way out. The store path runs msecs_to_jiffies() before assigning to
> ratelimit_state.interval, and the show path prints that field raw.
>=20
> The field therefore reads back in jiffies while the attribute name and
> the ABI documentation both say milliseconds. The two only agree when
> CONFIG_HZ is 1000. With CONFIG_HZ=3D250 the default reads as 1250 rather
> than the documented 5000.
>=20
> Convert back with jiffies_to_msecs() so the attribute reports the unit
> it is named for. msecs_to_jiffies() rounds up, so a written value that
> is not a whole number of jiffies reads back rounded up. Document what a
> read returns, which the burst attributes beside it already do.
>=20
> Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
> Assisted-by: LLM
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918145619.3016=
889-1-yazen.ghannam@amd.com?part=3D3

