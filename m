Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456C4086A;
	Wed, 29 Jul 2026 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306031; cv=none; b=B7H82r067TUdFDbkzFTa9jyIRn/7q9kblBwRbkzZFYtN+SU2s1x2CTcqwQsazbRBCBsLmNhSx8GVEUkkFKn93oZXn3KB1dwRU0cTMJmdM+3Ri38DJ9JKyWhdwooiOEynTP8Piop94R3jQco9KJ3r0j5x6xeHW5kK67D32WD7Igg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306031; c=relaxed/simple;
	bh=iHAVQ0kGoP1XkMAx0rRjRT3XV1pYc0rs7dUPdDwZS2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MYodPfHY34PuuLAyTi2Ti9oj+E54fzpwwAl1Su1M5Fw9pgl1xr9yNlitqxnptzUcDKOgv8iVWF07xGyRuwDNk2w2TCxa/TLX2/v0nj5jIUbjLPNOfgu3NnS/sIqO9tT5Oe1Iz6tlCXCzcyGVX1TOR+ycEJTTqBm+dLoLYpYvhPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSxo3kG4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSxo3kG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558A01F00A3A;
	Wed, 29 Jul 2026 06:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785306029;
	bh=1Z7nydMyXPQn588T5j4M7dLlnkVKKEHFlgC5Xr/OXk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oSxo3kG4Jz9nHx3v2FFI/YRjvk5QjzkQYW1og6dlKppAk3CQFFL13O9Lka8zXKdMB
	 o2ilKsm2pMqt9bmmekb6Rt/1DyuqkGB+/o6Qjra580hx+HpQHWGroZ8K0DP5yIDrF+
	 BTUujJyhf9x2Cz5OrmNZ1S6w0zndUQGSGPh1NGoS3ahp86CH65g+LLoFs7S2na2s6n
	 p+XwVvaLs7nRLelJM5waOkI2SU8+D/3Vvb3Jeay8RvgGUFk40OLKHnc9kZyMvO6xfc
	 JAZ/WTPBTcA15P6Za6HAgBV281QLhgcpmHm22YP53y2y25fjrT9XXORAZaoiz6nuRg
	 8GybddV2EAo4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf hisi-ptt: Fix PTT trace TLP header parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260729060220.624250-3-liusizhe5@huawei.com>
References: <20260729060220.624250-1-liusizhe5@huawei.com>
 <20260729060220.624250-3-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 06:20:28 +0000
Message-Id: <20260729062029.558A01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Incompatible pointer cast from `const unsigned char *` to `__le3=
2 *` violates strict aliasing rules.

Pre-existing issues:
- [High] Incomplete cross-platform decoding fix: `hisi_ptt_check_packet_typ=
e` reads the packet header using a host-endian memory cast, breaking 8DW pa=
cket identification on Big-Endian hosts.
- [High] Heap out-of-bounds read when processing auxtrace events with a siz=
e less than 4 bytes, due to missing bounds checking before packet type eval=
uation.
- [High] Integer truncation of the 64-bit `event->auxtrace.size` leads to a=
llocation failures and stream desynchronization.
--

--- Patch [2]: [PATCH 2/2] perf hisi-ptt: Fix PTT trace TLP header parsing =
---
commit 637114d43d04dfaf1c2cef1c93751d90838d2eb7
Author: Sizhe Liu <liusizhe5@huawei.com>

perf hisi-ptt: Fix PTT trace TLP header parsing

The DW0 bit field layout of the hisi_ptt_4dw union does not match the
actual bit ordering in little-endian memory. This commit fixes the
decoding by replacing the bitfield union with FIELD_GET() operations
against GENMASK/BIT masks and printing DW values in big-endian order.

> diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/to=
ols/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
> index c48b2ce7c4a3d..c1e169561087c 100644
> --- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
> +++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
[ ... ]
> @@ -73,29 +74,20 @@ static const char * const hisi_ptt_4dw_pkt_field_name=
[] =3D {
[ ... ]
>  static void hisi_ptt_print_pkt(const unsigned char *buf, int pos, const =
char *desc)
>  {
>  	const char *color =3D PERF_COLOR_BLUE;
> +	uint32_t value;
> +	uint8_t byte;
>  	int i;
> =20
> +	value =3D le32_to_cpu(*(__le32 *)(buf + pos));

[Severity: Medium]
Does this incompatible pointer cast from const unsigned char * to __le32 *
violate strict aliasing rules? Would it be safer to use
get_unaligned_le32(buf + pos) instead?

>  	printf(".");
>  	color_fprintf(stdout, color, "  %08x: ", pos);
> -	for (i =3D 0; i < HISI_PTT_FIELD_LENGTH; i++)
> -		color_fprintf(stdout, color, "%02x ", buf[pos + i]);
> +	for (i =3D 0; i < HISI_PTT_FIELD_LENGTH; i++) {
> +		byte =3D (value >> (24 - i * 8)) & 0xFF;
> +		color_fprintf(stdout, color, "%02x ", byte);
> +	}
[ ... ]
> @@ -122,22 +114,30 @@ static int hisi_ptt_8dw_pkt_desc(const unsigned cha=
r *buf, int pos)
>  static void hisi_ptt_4dw_print_dw0(const unsigned char *buf, int pos)
>  {
>  	const char *color =3D PERF_COLOR_BLUE;
> -	union hisi_ptt_4dw dw0;
> +	uint8_t byte;
> +	uint32_t dw;
>  	int i;
> =20
> -	dw0.value =3D *(uint32_t *)(buf + pos);
> +	dw =3D le32_to_cpu(*(__le32 *)(buf + pos));

[Severity: Medium]
Does this incompatible pointer cast from const unsigned char * to __le32 *
violate strict aliasing rules? Would it be safer to use
get_unaligned_le32(buf + pos) instead?

>  	printf(".");
>  	color_fprintf(stdout, color, "  %08x: ", pos);
> -	for (i =3D 0; i < HISI_PTT_FIELD_LENGTH; i++)
> -		color_fprintf(stdout, color, "%02x ", buf[pos + i]);
> +	for (i =3D 0; i < HISI_PTT_FIELD_LENGTH; i++) {
> +		byte =3D (dw >> (24 - i * 8)) & 0xFF;
> +		color_fprintf(stdout, color, "%02x ", byte);
> +	}
[ ... ]

[Severity: High]
This is a pre-existing issue, but does hisi_ptt_check_packet_type() break
8DW packet identification on big-endian hosts?

tools/perf/util/hisi-ptt.c:hisi_ptt_check_packet_type()
	uint32_t head =3D *(uint32_t *)buf;

	if ((HISI_PTT_8DW_CHECK_MASK & head) =3D=3D HISI_PTT_IS_8DW_PKT)
		return HISI_PTT_8DW_PKT;

The function reads the first 32-bit word using a host-endian memory cast
without correcting for host endianness. When analyzing a little-endian trace
on a big-endian host, this would cause valid 8DW packets to fail the
bitwise mask check and be misclassified as 4DW packets.


[Severity: High]
This is a pre-existing issue, but can this sequence lead to a heap
out-of-bounds read when processing malformed auxtrace events?

If the user provides an event with an auxtrace.size between 0 and 3 bytes:

tools/perf/util/hisi-ptt.c:hisi_ptt_process_auxtrace_event()
	int size =3D event->auxtrace.size;
	void *data =3D malloc(size);
	...
	err =3D readn(fd, data, size);
	...
	if (dump_trace)
		hisi_ptt_dump_event(ptt, data, size);

The buffer is passed to hisi_ptt_dump(), which unconditionally dereferences
the first 4 bytes of the buffer inside hisi_ptt_check_packet_type() before
validating if the buffer is large enough:

tools/perf/util/hisi-ptt.c:hisi_ptt_dump()
	type =3D hisi_ptt_check_packet_type(buf);

tools/perf/util/hisi-ptt.c:hisi_ptt_check_packet_type()
	uint32_t head =3D *(uint32_t *)buf;

Could this cause a heap out-of-bounds read if the buffer is smaller than
4 bytes?


[Severity: High]
This is a pre-existing issue, but does integer truncation on
event->auxtrace.size cause allocation failures or stream desynchronization?

tools/perf/util/hisi-ptt.c:hisi_ptt_process_auxtrace_event()
	int size =3D event->auxtrace.size;
	void *data =3D malloc(size);
	...
	err =3D readn(fd, data, size);

The 64-bit user-controlled size is implicitly truncated to a 32-bit signed
integer. For large valid traces (e.g., > 2GB), the truncated size becomes
negative, causing malloc to fail. Furthermore, if a huge size is specified,
it truncates to a small positive integer, causing an undersized read in
readn(). Could this leave unread payload in the pipe and permanently
desynchronize the stream?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729060220.6242=
50-1-liusizhe5@huawei.com?part=3D2
