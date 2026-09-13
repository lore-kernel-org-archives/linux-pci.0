Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AFD17A586
	for <linux-pci@vger.kernel.org>; Sun, 13 Sep 2026 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789334539; cv=none; b=JJxa4oEwe7vftu0CJBA3O1nvSSC54egu0xGWukHk56pwxMaQ0duNkAMYBJNNCNFnbdeIY+Vc0y0poXeWmkFNa//GYiVgjfTxq2i2qF3doxRU6qacGggjUuj3jxbLWvTsNGvRo8yFcEjl9ImzbXzoa6BUjh/SLR5uaGGdrncTpFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789334539; c=relaxed/simple;
	bh=F35P7dRCrLrAbzDMV4E7fU/MIeEPKkDIhpaxfaX7v2w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eKxbTXqLAAEz1/a7NJ2KHyPIGxYHymmpcwhVMT82aeMomKM9gU1EiH3+hxRb/p0U4XIQi2wNiWiD5cDK/r7GPktu0Cz4mNJjYqSSK5pUdAmv5PkhqBxzGgMnru+7ol4x9iSWtgPSoyaboVR5vZ99NZc+QBocGkzlzZmCM6twaZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt3E/UB5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt3E/UB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A7F1F000FF;
	Sun, 13 Sep 2026 21:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789334538;
	bh=F35P7dRCrLrAbzDMV4E7fU/MIeEPKkDIhpaxfaX7v2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qt3E/UB5VMA/HGjqE+xbptX2/jWlWl9Z8H3S+130JhYgIxib6n+Vi/r9v8TtLkB0z
	 H27Wt+Qd/nDt/AhoGq9TnK2qP0jk8cUTbpflmPUkofyrUvlR5HD26RaUEVdAVeQR0R
	 c3DWqQX11Z3cEkFbwIcCbdAJd1qHC9dELBBksvV+ViWe3mDIUXJx7phTXJy8EazAM7
	 7nWK7o2Mqikdki24V8t6TcymfHTrEY3kzrxRVkGE/q4AizMhbaIogE+9/rhem+urFt
	 w/uEWh3baoI/yGcC8zCGLyfaz3kYTSt0IyHwB8UqM0De/xLfTMCc1mIrEv9Qx5QFc3
	 B6/uLJD7k1KSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH wireless v3 2/4] wifi: iwlwifi: pcie: don't infer CSME
 presence from a failed read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Navon John Lukose" <navonjohnlukose@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <dba458f8bff1159de447653b03a9f39fb60e9549.1789333511.git.navonjohnlukose@gmail.com>
References: <cover.1789333511.git.navonjohnlukose@gmail.com>
 <dba458f8bff1159de447653b03a9f39fb60e9549.1789333511.git.navonjohnlukose@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 21:22:17 +0000
Message-Id: <20260913212217.E9A7F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> iwl_read_prph() returns 0x5a5a5a5a when it cannot grab NIC access, which
> reads as "no CSME"; an all-ones CSR_HW_IF_CONFIG_REG reads as "CSME
> present". me_present is never recomputed and gates the reset ladder, so o=
ne
> bad read skews it for good. Reject both values. This does
> downgrade a product reset that a poisoned read used to permit.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 41fff83fe6cd ("wifi: iwlwifi: pcie: check for WiAMT/CSME presence")
> Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789333511.gi=
t.navonjohnlukose@gmail.com?part=3D2

