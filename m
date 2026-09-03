Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860E037F739;
	Thu,  3 Sep 2026 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422421; cv=none; b=Q6xqYBULl/WZmpvQlMp4aK/jlsFe0v78HsOvr3ITDIe123xucXV5p+55U0HAKNqTL9lmS2+EYz/0GxT6qFiFewKXuOLZaTARirPBMvvCyyZfROOondAFeuWh3/rHBN7Hcts0ZTmpixvSLB+qgr9LX44V2bbeuaRVRaoproIhL+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422421; c=relaxed/simple;
	bh=jWyIv1lR5Y3PERX5VbHonZePYUojv+kBjh90V0RxVRU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xpf58Hh4njufI3uqa/MYoAhzVgBDlFxLwVAXnNI+yvyUrKdvflSViROFSvsLF+wQaIpyBL2vc00GXvAOmoF+sV3ZLefo/4EMLUnPIC4r/LciswIzaPMEnzinEA/RdAwwGH8u529dmruI1BPeJ+RhEq9qHF++DINYgjFFYy1+3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S84Qr7RL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S84Qr7RL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C0D1F000E9;
	Thu,  3 Sep 2026 08:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788422420;
	bh=jWyIv1lR5Y3PERX5VbHonZePYUojv+kBjh90V0RxVRU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S84Qr7RLtaIzNmT3vaO1+P8oPaQdHS2cj9+DZFAEFG6oxT2/MMPN+8pujiBDvFLLA
	 UOJaU+oG9Na9ANhhWZOK5HnVqnU4dExRshnld3ZbDvloYWDgISsxwwcFGrJoCwO+g3
	 nASsr0a4PvNa0TcmFNUrJ+Hf4VucGWNJ9IFpf+rJjAYERmVvEZ4UuURw4qv6mUz4ph
	 GpRBCIBCLoZ8B8hHS4kizGQVpy/WDO2gPvE4TmmBXXWdrQpVD+Ysw07tsemgFyMxB8
	 sY+cvgyYHngqyPnU72wi56DxHFzxLwlzCZ6G1bYEg7rknvvHtA57bhtiK/dSlZL/Vw
	 PSNQZAO6Az1Zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] perf hisi-ptt: Extract the raw data printing
 part
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260903075241.1445338-4-liusizhe5@huawei.com>
References: <20260903075241.1445338-1-liusizhe5@huawei.com>
 <20260903075241.1445338-4-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:00:19 +0000
Message-Id: <20260903080019.E0C0D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Extract the raw data printing part of the TLP header into
> hisi_ptt_print_raw_record() for reuse by subsequent patches that
> add field-level parsing of individual DW headers.
>=20
> Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903075241.1445=
338-1-liusizhe5@huawei.com?part=3D3

