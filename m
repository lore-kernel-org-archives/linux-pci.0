Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E6D2550D5
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 23:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082503; cv=none; b=WE4IQT6t0Xg3rUcr604pQf4k9uUbmzcr3v6gglR3JhuXoSpm8r0etaYNa6RNZAh6CZh0i/e9gL1SeSWa5fvGzHYLuZZe2XKLee9JeGA0lK2TKaneeRTSrZgWA6bbjar3yTaysDv3k9o2XeQSn9X5FSpuzCAGPnQjGSBUKTZjmvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082503; c=relaxed/simple;
	bh=rBUXBP6V96HYI0nlYY61klIS8YGoLWUmvYWvBYalGmE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tifURXNCe8El6Ye/sWqol2pdzfw7uXGmH1sMwKUfy2s2hkjcPAA6pVV5WB9fMx6fSsiY4SH14KI0KDoLwM4bC3MFvk3PpQFL/oWyhMYZU9XlDJltnMgGeVctcP67hzcIHv67YnObcB/PfkLu7SfhHQiujjdkoG1ELPRvTZWx7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RN6zj4y5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RN6zj4y5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFF41F000FF;
	Thu, 10 Sep 2026 23:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789082501;
	bh=rBUXBP6V96HYI0nlYY61klIS8YGoLWUmvYWvBYalGmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RN6zj4y5vRkv0xY6NjP5qEo9vUO5yT5bGUSQ3f3ZT2MItNU4WnZjnRkwNzMPu22CC
	 fAhDepFK31SqaDHICegnkiYtReBTmWj6hLRrLPVxLIsVfnxyxSJrd85DQqs8dsxb70
	 lYcJssAjesV9vu9bpg2ECLvmA7IPQ/arad8+s2/yWbelUPIE6S6YJcORcqBrPbuaNS
	 jymWCLpRLssvYieLcQAaYBTXQVeLn4bFzqRvSqQx2fj7VSIlEHqsymMXnbiBu+OxEm
	 sBV/trGNbAX3M99QOI1Fck2XoHUod8kXOMnPm9imJijkfnZkGRQSXNoBf/kdGz7Ws0
	 kpPO1IG5WjMFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/15] iommu/arm-smmu-v3: Add Q_POS() macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <b8dd2049f2a6856f014a18ebfe61a9074da5a48c.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <b8dd2049f2a6856f014a18ebfe61a9074da5a48c.1789081084.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 23:21:41 +0000
Message-Id: <20260910232141.9AFF41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A queue position, the wrap bit combined with the index, is Q_WRP | Q_IDX.
> It is a (max_n_shift + 1)-bit value that wraps at twice the queue capacit=
y.
> queue_inc_cons(), queue_sync_cons_ovf(), and queue_inc_prod_n() currently
> compute such positions by open-coding the two macros at each call site.
>=20
> Add a Q_POS() macro and switch the open-coded sites to it.
>=20
> A subsequent change will build a Q_DIFF() on it, to count the entries that
> a queue pointer moved past.
>=20
> No functional change intended.
>=20
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789081084.gi=
t.nicolinc@nvidia.com?part=3D3

