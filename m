Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BFA3F8250
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000811; cv=none; b=gPVwk1zZoWj6yKp4MTNtdfZBL6tQK7RI+MZJGyCpV6wY7fu2Gw0D3sWeR3rNNpSC3TCCluKCwxOV7Yh6v1KvLWPWXqa6slCd7TsmF1S+0Xu9V0exI/SBPkwrna5MSOR5e4OYGSJu3HT3r6hikcSzGk1KrJZ3EWnlSO0wSlEfzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000811; c=relaxed/simple;
	bh=PUl2ZTQW4y8L2nSR5UA6lKbgK83ZqbKUGGxmeM1C7bo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ehTdv3ZZlI8KyCyIWNGXPFGytKLxfqNAhfBpTRhXC/DP/s16x6iyGMFJ+84OK3kOpQyFtyKzxIpmoSgTxOWhqM5k89LzvQjpVpEadTweLB2rmIHveCr42aIGyQ1XJ/ILRb5NLeObVwbBhOpQu+AgO9uBN5flfNgABkwHCfQcLe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QinIzqgT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QinIzqgT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8BA1F000FF;
	Mon, 21 Sep 2026 14:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000809;
	bh=PUl2ZTQW4y8L2nSR5UA6lKbgK83ZqbKUGGxmeM1C7bo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QinIzqgTlgsjHzInAHlp+hjN4/kktjjCF3lRqKnL+QvFk7L/es6ouX10Fu4otoCC+
	 P6bT8F/WBtrd4baP1ieh3TgPePsR487as/B+0yBmpuHPVyre5qFx2UgXkpUPK2WQ28
	 FDLt5fMxltfJlrZFVEVA/P+lgKuJrjB3WcDfo8jd7iveOy9EdPMyKVPHfM9V21yOfU
	 zL8NoBCzZXCJ9LmvgnljBQ7ujcSCgZ7WMRE1fi/xQBFstTBjEnao+KaDj8YCQMkr/g
	 0AyTzEZGMCJWF9y03OWF2LSukvhp6NtOY0CUcNW+y3385OTw5ninGAZaNZmJfNRIcF
	 7LBlX+10Ro4ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/8] PCI: vmd: Convert bus and busn_start to an array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260921164316.3860312-7-szymon.durawa@linux.intel.com>
References: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
 <20260921164316.3860312-7-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 14:26:49 +0000
Message-Id: <20260921142649.8A8BA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Convert bus and busn_start from scalar to an array to support
> multiple VMD buses in the future. No functional changes.
>=20
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921164316.3860=
312-1-szymon.durawa@linux.intel.com?part=3D6

