Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6072EC57C;
	Tue,  8 Sep 2026 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877707; cv=none; b=QagvH4QqeBFInYZFkCTeurpOlh2uW/c/2IMA1D0ee5C5UXVOu3Xgu4yrqxgWgTenXw0kyiVEjc/++iO4V9qPX8daEvVVVQwcZDbqQ/DtoUyju9kuuvwqah2vQGcfhDIkAoRwydJ0Ox50v7VC83qD123aY3D3jRI5T2edQSDn5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877707; c=relaxed/simple;
	bh=6CDTTqg62HfK65ROJSCRoSPnmxqDg/MfftcqO8XUrtc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kXUIeTDNi2PlR6HX67k/NwZDIzEK/XSVOpsjY8cERECTIyva5YcQ8dwcFBEbdnTIIMP5xHCsxRUNYyluglGBu4hIBMtONN7Z5koM2zAQD1mejM36cUglFqdAg9gohnnQzIfd9nhSDXswjvD+BX0KgsBtzsIoFviqBz3T58SDr94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQSgNSef; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQSgNSef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370DE1F00A3A;
	Tue,  8 Sep 2026 14:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788877696;
	bh=6CDTTqg62HfK65ROJSCRoSPnmxqDg/MfftcqO8XUrtc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GQSgNSefWyPtz5PWI9U5OKnVcWrNWGFX7BISZXFkyV2M6dupjkF440u/SVHo4lGcu
	 a9S+9MY2GzRwJ8J6WfAMJ7GKUB95zk0K8gWJ9z4NfrWYWveyOcW7bPmkChyMVcCvuw
	 fEPQdiCofSxkE7Q8vfltYcL14LpF6NWFu8gzxb1Ht+8QiB4cmaDZWrVuJcL4h9n5Af
	 5C16SEaR3pWDlPtIZYy56FPI16b6HJAX8AA8CcANsaq8yksB37bREYT0Z9iCpfprsZ
	 KhE9jjXjrZx/KqB9AbZ3dnO2PIwG2EIUZEBtlDAb6DhBOgCh9IkZbP1sjTXgvo9fuW
	 0tF1gn8ZjrKbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/8] perf hisi-ptt: Pass pattern version to decoder
 for compatibility
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260908140509.2485649-9-liusizhe5@huawei.com>
References: <20260908140509.2485649-1-liusizhe5@huawei.com>
 <20260908140509.2485649-9-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:28:15 +0000
Message-Id: <20260908142816.370DE1F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908140509.2485=
649-1-liusizhe5@huawei.com?part=3D8

