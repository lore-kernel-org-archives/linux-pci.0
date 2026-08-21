Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F5739DBC5
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315844; cv=none; b=KEe4UPiuXVx9rYOSHgj6uUduHZkET/5Bfu9gkMSMIawPsjdnuDUIR5T9uNcw95AR7SR99ZKQuBNT076fS8rI3Fp63QwB1Ay8bUUvQLG2yRnJmnpg58PPBNwg1fSOMELCHMABViqFhbywNk3fRkxkCV69plxOnge78jQ44GgvMM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315844; c=relaxed/simple;
	bh=cdcVkuFNkh3zNqVY+1U+IYYAi7St9pWVplNAIz2A+GI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=obht3s6qUuvwjWtXVAHoN9pQYiNGxPO17+s6ncqORt0/tC6biTil0FWcPnpgOmrZ97Vrps1ZLnhxc73zTRHdplDjeCHXSG7jIikj2dj7K1OB+tCI0OnICuwsK0Uq+Jz/CEWjWUiGfUrVi5nlwHsR2tIHWtcFgHJ1mkNUJxEp4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEQcGUqC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEQcGUqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FF81F01558;
	Fri, 21 Aug 2026 12:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787315839;
	bh=cdcVkuFNkh3zNqVY+1U+IYYAi7St9pWVplNAIz2A+GI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cEQcGUqCe86xo92ZJxj3tGjhkbBY+/lWZjAw5CvO+yiw5eM0L5EWB/oy09Xas7jzs
	 9X7Drt3O5ox0DvQAAo9uj/bL2Zw+ASdZ8BC6BVa+rz4FXGUro4gF5x8xKcbWykgsUo
	 BYFKGENUu2Yy2ecNOCkWrkA8/xRrVtoHreMyVTdaWwyVnUqpuOIo4AUo285WqcYUZC
	 FSXQDDXKIp+FaGbhpr72bgaRw/2bQywjCH571N3UgBrYZluXB6PJNheafGoKB3VEkI
	 FMGnOkg7u7gz6D6ntrA7gC5iRSmuZFvh2dUBoU3ZEPkz/VHr4jRoR+2ezkR9shTj5v
	 Pt2AnkAdAyNFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] PCI: dwc: Add .post_deinit counterpart to
 endpoint .pre_init callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260821122808.238248-1-marek.vasut+renesas@mailbox.org>
References: <20260821122808.238248-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 12:37:18 +0000
Message-Id: <20260821123719.01FF81F01558@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> If .pre_init() succeeds but subsequent initialization fails, it is
> mandatory to correctly undo the hardware configuration which the
> .pre_init() callback did. Intrododuce .post_deinit() callback to do
> exactly that, undo what the .pre_init() callback did. Usually, that
> means stop the clock, assert reset, and possibly program some registers
> to quiescense the hardware. Invoke the .post_deinit() callback in
> dw_pcie_ep_deinit() to retain functional symmetry.
>=20
> Reviewed-by: Koichiro Den <den@valinux.co.jp>
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821122808.2382=
48-1-marek.vasut+renesas@mailbox.org?part=3D1

