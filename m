Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E939F38D3E3;
	Thu,  4 Jun 2026 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559938; cv=none; b=F3f4mEW25oCjEOwtksncF2CTCjdfoW1/d/iDM/+wwLxdtH2S7TOc2oGo2wpES6tpxprLjH5c+jMlPIzKcdkK1z6zdcfIn7vG5QGjjgpRSUow1m4IhsIYkzHvxoRTEODnkKVZ0WBwFR8Y8lR+hmHAih9EF9knAqVL6iQ36bpTidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559938; c=relaxed/simple;
	bh=H2LH1TDUNNwo9nnfgQHQwCRJoQXIQtgY4Zz/9WC/7EQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bZixgqmns2SEsMKK87WwKUITYtAtQy79Hyu1+QuewlFdna0fJW9CR1jq5mJ5T2Kc8F3PVpHn5+HAX6dOEIqWu26sccnLYeGrbN0FxA0vXOhiUaiFgzA2rvLuknZyOpBkFZYuciHV8yfKvYUVdlaYO05zmpPF0RMBDjawWkRwTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gM7mgHOg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gM7mgHOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734541F00893;
	Thu,  4 Jun 2026 07:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780559937;
	bh=kfwNWW0kvjY6QEZZuvHREvTY84+y47jmEedWPTkNgE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gM7mgHOg8KMSVeMp1kVo43bNI9dXlJ390dhYPadXmSvu1QbemqFcK21sbpLFHn/Hn
	 g31mf3XDdm7OwapSpaRAu3brgzVViCLu4pKQNMcFBGtWsIzSb67XVCKlbRZAJcvlB1
	 ZVokydaPrkZbFp04GSLMIJxhbsj2a5ShZ2T/ITpLv1TII6mA21BBKawMwxHE3T6FKf
	 /8XL5uQEKz5oK2eRMpAXPHewezowrhRmoXsLC1qxCRiYiWi7c/SIlWe9OQEgLb+zLb
	 OKP4REKcjmLuM1pjYateLWtJ+q+i2QC3YfzSqy5w6z2r8Q4A9oZQCGkZ+hCXtOTc9q
	 6a0LPB08fTb2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] perf hisi-ptt: Add field-level parsing for header
 DW2/DW3
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260604075005.2219785-10-liusizhe5@huawei.com>
References: <20260604075005.2219785-10-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 07:58:56 +0000
Message-Id: <20260604075857.734541F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Host-endian-dependent C bitfields break cross-platform trace ana=
lysis on big-endian hosts.
--

commit b5a1a94b81406195d7c90b32fd8a96a3d26602c2
Author: Sizhe Liu <liusizhe5@huawei.com>

perf hisi-ptt: Add field-level parsing for header DW2/DW3

This commit adds detailed field parsing for TLP header DW2 and DW3 based on
the message type parsed from DW0. It aims to provide more structured
information for users analyzing PTT trace data.

> diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/to=
ols/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
> index 59ab8ec3a03da..46f11d5719aca 100644
> --- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
> +++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
> @@ -127,6 +142,45 @@ union hisi_ptt_field_data {
>  		uint32_t type : 5;
>  		uint32_t format : 3;
>  	} dw0_8dw;
> +	/*
> +	 * Header DW2 for MWr/Msg/MsgD/FetchAdd/Swap/CAS/IORd/IOWr TLPs.
> +	 * Affects both 4DW and 8DW format.
> +	 */
> +	struct {
> +		uint32_t header_dw2 : 16;
> +		uint32_t tag : 4;
> +		uint32_t t : 1;
> +		uint32_t tv : 1;
> +		uint32_t rsv : 1;
> +		uint32_t request_segment : 8;
> +		uint32_t reserved : 1;
> +	} dw2_mixed;

[Severity: Medium]
Does using C bitfields here create an issue for big-endian hosts?

While le32_to_cpu() correctly handles the byte order of the raw integer,
the layout of C bitfields is implementation-defined. On big-endian systems,
won't the compiler pack these fields starting from the most significant
bit instead of the least significant bit?

> +	/*
> +	 * Header DW3 for CfgRd0/CfgWr0/CfgRd1/CfgWr1 TLPs.
> +	 * Affects both 4DW and 8DW format.
> +	 */
[ ... ]
> @@ -211,6 +265,85 @@ static void hisi_ptt_print_head0(struct hisi_ptt_pkt=
_buf *pkt_buf)
[ ... ]
> +static void hisi_ptt_print_head2(struct hisi_ptt_pkt_buf *pkt_buf)
> +{
> +	const char *color =3D PERF_COLOR_BLUE;
> +	union hisi_ptt_field_data dw;
> +
> +	dw.value =3D le32_to_cpu(*(__le32 *)(pkt_buf->buf + pkt_buf->pos));
> +	hisi_ptt_print_raw_record(pkt_buf->pos, dw.value);
> +
> +	if (pkt_buf->pkt_msg_type =3D=3D HISI_PTT_PKT_TYPE_MWR ||
> +	    pkt_buf->pkt_msg_type =3D=3D HISI_PTT_PKT_TYPE_MSG ||
> +	    pkt_buf->pkt_msg_type =3D=3D HISI_PTT_PKT_TYPE_ATOM ||
> +	    pkt_buf->pkt_msg_type =3D=3D HISI_PTT_PKT_TYPE_IO)
> +		color_fprintf(stdout, color,
> +			      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
> +			      "Reserved", dw.dw2_mixed.reserved,
> +			      "Request Segment", dw.dw2_mixed.request_segment,

[Severity: Medium]
Will this result in extracting entirely incorrect bits when a big-endian
host processes an ARM perf.data trace file?

Since perf tools are expected to support cross-platform trace analysis,
could we use bitwise operations instead of C bitfields to ensure the fields
are reliably extracted regardless of the host architecture's endianness?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604075005.2219=
785-1-liusizhe5@huawei.com?part=3D9
