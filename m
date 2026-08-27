Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1BB23392B;
	Thu, 27 Aug 2026 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839993; cv=none; b=DZdc6YeWiYyM6XOAEWrR5NH/uzVPWpPnTgrrr078pWk7NwwCBv4YyG2ihoxlQwrpmIuzz86Pc9s1WXFPLJvyNK5/ydYcdWoQOFWSN7bDsVmQV7OtJ+PapqFY6DCTtdLRxLwRS4ew5NEVFlIyrrchwehYkNzMq5RIUDkPCy6Ejyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839993; c=relaxed/simple;
	bh=6ucXk7xecDAqe0eIPrpz/6lq3O0xCwDII/ID0j7U7VE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hW+RA648/Qdw1d98HalGiHRWfUCrmlY25LSV4xf0Q/EBS/DHOTqaYqLLw9wJx4Vf6oy55zgX8UN/abiLe5yQPJT0HmzjeIDbWTtIbFibsyhZGiBZ/R220KWqYyP9dqvEllpknYTM9tWTmg7i5WbO25GEBp7K6llKtgMMPs2THrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6WoLXp8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6WoLXp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A381F000E9;
	Thu, 27 Aug 2026 14:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787839991;
	bh=6ucXk7xecDAqe0eIPrpz/6lq3O0xCwDII/ID0j7U7VE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K6WoLXp8wXtZBGdSA36lgIvmp/oyLAka7d5zuAL5pau+FvQm1HtCn//MhYDRrJw8I
	 Qd0xsiP3UxmXB6RERMT08ogO3Blg71sMApuXTzNu/hmsXBmtwGFDIF6VsRo7GT+D2H
	 +C3zqWbBkfbOH3z1K5GpvAssLShK4zOHq0Ir3BRAlfih6u1G/P+FvhDV4vWXCB5Th7
	 M1wd1kvlyS9+UEibszAixKC9HjniPsYxN2vYoNjvTvdNsxfENWsw4piV4LDA+qu8IR
	 j90/JtmLPu7EFcvRueNmt5Gppcj6y4l4G/5Tr9L0tGpAqy8s0yjbM2NQYoEwgGZK31
	 ebVieuWer57tA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] perf hisi-ptt: Pass pattern version to decoder
 for compatibility
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260827140442.2031128-9-liusizhe5@huawei.com>
References: <20260827140442.2031128-1-liusizhe5@huawei.com>
 <20260827140442.2031128-9-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:13:11 +0000
Message-Id: <20260827141311.B8A381F000E9@smtp.kernel.org>
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
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827140442.2031=
128-1-liusizhe5@huawei.com?part=3D8

