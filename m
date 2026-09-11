Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264CE32C8B
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170115; cv=none; b=hrkQagDZ/c30LncwO6QwSyIVx9pjzCHF1+CuQh5CrQ8roUbbs0Q9lkcdIjNHru8HDOT0/NAfrvs/o5OHvXQ3aE6fc7Zedv8mwSvlZg616rmHGHqIk9UT2fuo/hzLBVrNq4yFSdvGnYfUmyOot0klfOxIiw9Tz8YqmfbSYRe2X2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170115; c=relaxed/simple;
	bh=kIBuFjrUg2AbPW/Vv9T3XyEu7ii6ZnMYRge62rlp1RA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m6CHOy0aLGztE2SvmrG7YSSFnl0b9gVX73O6RCnFzwh1lRD5V0QBwrMnKZewskYjMWnGsRbGVT1+ibkyQmqSnslKpwkX2gmSWkL1/3CSQST5HSOU3FA+gj8IjlilsWEsOCC8jYAH7tv6dsg/0H8Z4u5HAZekrEHxOtXuIuGaRbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHMbD+mt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHMbD+mt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8889C1F000FF;
	Fri, 11 Sep 2026 23:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789170113;
	bh=kIBuFjrUg2AbPW/Vv9T3XyEu7ii6ZnMYRge62rlp1RA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZHMbD+mtSoels5EtrshLCBejSBF67zcxwxGDEVZnd60cgGb9UoMKHXAMpE3/eDvji
	 cSHD3u+er2lTouBZNtxxNK6Xaxe/5u4gIfDX9GT3F/DlNJ67onxhMXErVX9f+P+xqg
	 TeLpFU6Ka/KZ06vlZUoveViqvUCjLMvnA8DHjcBS8mRvyBSs94P6Ez3T7EmrlZg29+
	 uUwJZYdMxnfwNNvZXaJUvapSsSw6Ng2//NKVZtF/NPNhnMqfH0Jl4Cqhm5udq2QB2L
	 mUpbWu9NMafNcHoV7jOZr4b0/sJDaXiJspgrgtPMXRdaXiToDigRSnDzV4HMQwDjiq
	 Fv9aPegzUhmmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13] PCI: brcmstb: Declare and assign flag IS_BMIPS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Quinlan" <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911233541.1650895-7-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-7-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:41:53 +0000
Message-Id: <20260911234153.8889C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Eliminate a function that evaluates SoC chip IDs and instead declare and
> use a flag that indicates the SoC employs a CPU with a variant of the
> MIPS-1 ISA.
>=20
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911233541.1650=
895-1-james.quinlan@broadcom.com?part=3D6

