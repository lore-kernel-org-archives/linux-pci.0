Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F937A829;
	Thu, 30 Jul 2026 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393824; cv=none; b=VMnpWqxIhXzMOgSoQVwRVIsvODY69of74AAHpzRVdvInkWwZu29Xnbg7amuIth4t1unOmFPBy2QedLRjC4PXn+9jnD/ZhoCMK8GZvnpqmfTmxcasQ9s5cHqHs9CM9oCi1DFsaltoSzmx5eLjtVlpVMCR7gLVBIQPM4ecUM205uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393824; c=relaxed/simple;
	bh=EuSemK3BkMuFVc+R1l10uTDSqNGs2SCOzyEa+qEEVm4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W6jDC/22nYBRw+KI5P7fxioiOeZMuXgFZeZEJemcFqpySine5EYX17Hir5f+hkHPqZNFxF4CIIhZqy2mB1a/CSG0cX8pkRgRWjm1aYH+dAz7NVBakLhK11c/0N+EsT1YnL7VmfKooiicFw6xJ3BZIrkPLHZb1CsgAq370RS2HIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oALEx8Aa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oALEx8Aa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711431F000E9;
	Thu, 30 Jul 2026 06:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785393822;
	bh=mUihL8cpHZKmkxDeuCmSLvsE/kP9sYQfoIPueVuyWYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oALEx8AaNM2h7QTyMCc71Cu0MfoUQSnd6cubiwlHGeCfElw/7jRm8bQmFTWUC8PqC
	 eqCmlWLq0ImcHi0Tz6r8uYZjIpBL9F6/rTAn8X0KpotNFx7nlasHMsoaslG7sI+j4W
	 vYJkq/AOWJuOuTtESjiBwfQAHhzYh06gXtMAi352+qy9TNsOgjQgmQfCHSUqFZ0EKm
	 E03ZE+uMoEe7vj3ZBbY+Gr58DV0dA3OXYzS0l/BC/a6+cTCiypPjK0vgXIQKsUaUsY
	 Vzo0oM5Q1EmSyym+KwsTqLJ3KGjc4anoFFVYMJDevD+NHXyhmRXI/rk5IFEXhP5mjL
	 13HODVaHL7meg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] perf hisi-ptt: Fix PTT trace TLP header parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260730062709.534139-2-liusizhe5@huawei.com>
References: <20260730062709.534139-1-liusizhe5@huawei.com>
 <20260730062709.534139-2-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 06:43:42 +0000
Message-Id: <20260730064342.711431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The patch fixes endianness and strict-aliasing for packet decodi=
ng by replacing unaligned casts with `get_unaligned_le32()`, but misses `hi=
si_ptt_check_packet_type()` which dictates the packet format for the entire=
 trace.
- [Medium] Missing length validation before packet type detection can lead =
to an out-of-bounds read and potential crash when processing an auxtrace ev=
ent with a size less than 4 bytes.
--

--- Patch [1]: [PATCH v2 1/3] perf hisi-ptt: Fix PTT trace TLP header parsi=
ng ---
commit 94e8b50cd3127d5e0f6a440877771f9ffe7c6e0e
Author: Sizhe Liu <liusizhe5@huawei.com>

perf hisi-ptt: Fix PTT trace TLP header parsing

This commit fixes incorrect field decoding of HiSilicon PTT trace TLP heade=
rs
in 4DW format. It replaces the C bitfield struct with explicit bitmasks and
uses get_unaligned_le32() to extract the fields, resolving endianness and
strict-aliasing issues.

> diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/to=
ols/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
> index a17c423a526dd..5db44556fc4f5 100644
> --- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
> +++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
[ ... ]
> @@ -73,29 +75,20 @@ static const char * const hisi_ptt_4dw_pkt_field_name=
[] =3D {
[ ... ]
>  static void hisi_ptt_print_pkt(const unsigned char *buf, int pos, const =
char *desc)
>  {
>  	const char *color =3D PERF_COLOR_BLUE;
> +	uint8_t byte;
> +	uint32_t dw;
>  	int i;
> =20
> +	dw =3D get_unaligned_le32(buf + pos);

[Severity: Medium]
This is a pre-existing issue, but while this patch fixes endianness and
strict-aliasing during packet decoding, there appears to be another unalign=
ed
pointer cast in hisi_ptt_check_packet_type() in tools/perf/util/hisi-ptt.c:

tools/perf/util/hisi-ptt.c:hisi_ptt_check_packet_type() {
    ...
    uint32_t head =3D *(uint32_t *)buf;
    ...
}

Will this cause decoding failures on big-endian hosts because the native
unaligned 32-bit cast interprets the little-endian packet header with
incorrect byte order, causing the packet type bitmask check to misidentify
packets?

[Severity: Medium]
This is also a pre-existing issue, but can missing length validation before
packet type detection lead to an out-of-bounds read?

When processing an auxtrace event with a size less than 4 bytes,
hisi_ptt_dump() in tools/perf/util/hisi-ptt.c unconditionally calls
hisi_ptt_check_packet_type() without verifying len:

tools/perf/util/hisi-ptt.c:hisi_ptt_dump() {
    ...
    type =3D hisi_ptt_check_packet_type(buf);
    ...
}

This immediately dereferences 4 bytes in hisi_ptt_check_packet_type():

tools/perf/util/hisi-ptt.c:hisi_ptt_check_packet_type() {
    ...
    uint32_t head =3D *(uint32_t *)buf;
    ...
}

Could this result in a heap out-of-bounds read and potential crash?

>  	printf(".");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730062709.5341=
39-1-liusizhe5@huawei.com?part=3D1
