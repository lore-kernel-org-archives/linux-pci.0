Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A6342E432;
	Thu,  3 Sep 2026 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423347; cv=none; b=JLgt2jl/dMD8rBgdgT08aZ8SyDOOQsopnUI7q8baST3xIOBUmVxNjv7wrowB/HwLWXPer+wD/ri9myGc4zhCk0p3LdUM5EHvPRaDTcV4AFvoWxAV6M0z+d6u4RgSm8p+dilW5SxgGiWrG72bkE8jSgoXPDwJSoLrGOlxAM52+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423347; c=relaxed/simple;
	bh=EDODARZVUlPkbXKCx4XTbWR1XeR1zBMSp2sAcbay/7M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DNpZePmbDp/Et7+p3cOqoEwY8S9K1Fr5JdaupCKu3YVZ2LCgLxKXgNRAADAZ/P/NIT7jsioKQCXY6eME8x+sXQiy6i3ml0RaCEqKGNt3kZsyJxJiKnm4oLouqWXvGm9/u3IZZ5qNlQa7YCMRkq/jr8bdlGMoWW8d3Djor+G0SvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqSoacMF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqSoacMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F891F000E9;
	Thu,  3 Sep 2026 08:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788423345;
	bh=EDODARZVUlPkbXKCx4XTbWR1XeR1zBMSp2sAcbay/7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HqSoacMF0NNaag/jKnU6NQ7tQ4DDY0sB2KsKQcQuk7WV+ZvF5JcpNmcBbBK152hCA
	 pmYDCI+uTHOFcw3cOh4EPVCbz4rlfLlIj9Oe84DHDlqRbt+c95xgSWTs5VKzjPY23z
	 OxGi9HZgFsTXtSy25uMuIe0GBuAR/wvRjNK64UlLGNjwz0+IwIKXZ5EgvwY79F4WrY
	 V6lpUiO3QoF6ojgzijTks7BdXXLUx8PXGg0fxa73MUSPFnR3ejZUnWlRnQR6uWht71
	 B9cQXL1mTPeq7Gh1x8oqSBhbAy3ZBtDVAgmzGPp9ydDvvMOh4XRvAYmScnl80ptIzz
	 RoYld+g56y8EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] perf hisi-ptt: Pass pattern version to decoder
 for compatibility
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260903075241.1445338-9-liusizhe5@huawei.com>
References: <20260903075241.1445338-1-liusizhe5@huawei.com>
 <20260903075241.1445338-9-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:15:45 +0000
Message-Id: <20260903081545.81F891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On the recording side, walk the evlist in hisi_ptt_info_fill() to find
> the hisi_ptt event, read out the pattern bits from its config, and
> forward the pattern version to the decoder through
> auxtrace_info->priv[1] as HISI_PTT_PATTERN_LEGACY or HISI_PTT_PATTERN_V1.
>=20
> On the decoding side, store the pattern version in struct hisi_ptt and
> propagate it to struct hisi_ptt_pkt_buf. The printers of Header DW2
> and DW3 check the version: HISI_PTT_PATTERN_V1 keeps the field-level
> parsing introduced by the previous patches, while HISI_PTT_PATTERN_LEGACY
> falls back to printing only the raw "Header DW2/DW3" label so legacy
> traces remain decodable with the new tool.
>=20
> The auxtrace priv size grows from one u64 to two. Use
> HISI_PTT_AUXTRACE_PRIV_SIZE_LEGACY for the minimum header size check
> and detect the actual priv_size at runtime to pick the pattern version.
> For trace data recorded by an older tracer that does not support the
> `pattern` parameter (no priv[1] in the header), the decoder defaults
> to legacy mode (HISI_PTT_PATTERN_LEGACY) so the new tool keeps parsing
> old traces correctly.
>=20
> The hisi_ptt_pkt_size array is moved out of the shared header into
> static definitions in the two .c files that consume it to avoid
> multiple definitions.
>=20
> Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903075241.1445=
338-1-liusizhe5@huawei.com?part=3D8

