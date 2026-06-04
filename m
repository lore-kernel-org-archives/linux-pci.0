Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B632F691D;
	Thu,  4 Jun 2026 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560076; cv=none; b=t80auB71bHz838rF8JInGEjKHUFKoNvfFZ48YcAPvtz9DlbkRmch9bD84kpr7P7OM//Tww3il8Z62uAYsQPVn9qlehw0OySLzWCNVKZtf0ic6JrbyXsDE8MUYTZnjhVoJsaGgTBFZwezAfF/Fe1W+rJjZBzP/2SSCQJ9FBljWLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560076; c=relaxed/simple;
	bh=V2xeaMuooKIL206Mu1rEZ2QfNIRpXu/7x5mV6kj8EDQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PXYpUCPB1bS8LJYgqmQVtoUqY89BUwNkiy8Sogf+zD1X+WZLhoX2gx7f3IXF3LOuntwI+VS8jlIuwOJKttp8AnCSb92WrAjjqhLA54Gca38dM790roF7wheJmX6TyxZ2ZNJj0GTVXqYydsSvq5jsSzJiWQJEtOEB/ihIakiLvmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=We5W1yRT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="We5W1yRT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F781F00893;
	Thu,  4 Jun 2026 08:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780560074;
	bh=7GBkcLtg0uqitR4e64V97wE61NpFm/OY8SkjUIKZ20U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=We5W1yRTORKjYvkbhHtCSa5RHEZusZIpYQYTmQTZUm6lrPtmj0vU5Yf03joA45ltl
	 HeUm63AH8qg0sUEZ74GGdSB1uabxDZ6kmNuFJvzMDrtr73e8GDdDzlpnwiTySTdWI4
	 sB5voiJdPO7VD8kUyt0hOr5JZFivugAtSozOnHCt8nzHCTxlol7TPzqgrFSjDcEwUB
	 wKQJsZba6CCd614yQLACVmFO0B3pMFZfm+mw29wmsUsCiRahd/kdF+HYCmdqwSx0uF
	 6c1AP5RMT1zN9YBJtBBbNN/6Mu77UwHMfEG+ai4waHoCYfd1mjzYkwx0LxuVZOZHdv
	 ePrbiCeDEf7wQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] perf hisi-ptt: Add parsing of supported message
 types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260604075005.2219785-9-liusizhe5@huawei.com>
References: <20260604075005.2219785-9-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 08:01:14 +0000
Message-Id: <20260604080114.97F781F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The decoder uses C bitfields (`dw0_4dw` and the newly added `dw0=
_8dw`) to parse hardware headers from a host-endian integer, which breaks c=
ross-platform perf trace analysis on big-endian architectures.
--

commit e6402a0d73ba805c4892540373d8a6a210da4d39
Author: Sizhe Liu <liusizhe5@huawei.com>

perf hisi-ptt: Add parsing of supported message types

This commit adds logic to parse TLP message types from Header DW0 Format and
Type fields for 4DW and 8DW packets. It stores the parsed message type in t=
he
packet buffer to select the correct field layout for subsequent decoding st=
eps.

> diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/to=
ols/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
> index 9ec84d398cc1b..59ab8ec3a03da 100644
> --- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
> +++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
[ ... ]
> @@ -90,9 +121,41 @@ union hisi_ptt_field_data {
>  		uint32_t type : 5;
>  		uint32_t format : 2;
>  	} dw0_4dw;
> +	/* Header DW0 for 8DW format */
> +	struct {
> +		uint32_t others : 24;
> +		uint32_t type : 5;
> +		uint32_t format : 3;
> +	} dw0_8dw;

[Severity: Medium]
Will this bitfield layout break cross-platform perf trace analysis on
big-endian architectures?

The hardware payload is loaded via le32_to_cpu(), which correctly guarantee=
s a
host-endian integer, but mapping C bitfields onto that integer relies on
implementation-defined behavior. On big-endian hosts, GCC packs bitfields
starting from the most significant bit, so accessing dw.dw0_8dw.format or
dw.dw0_8dw.type will extract the wrong bits.

Could these fields be extracted using standard bitwise shifts and masks
instead of relying on bitfield layout?

>  	uint32_t value;
>  };
> =20
> +static int hisi_ptt_parse_pkt_msg_type(union hisi_ptt_field_data dw,
> +				       enum hisi_ptt_pkt_type pkt_type)
> +{
> +	uint32_t format, type;
> +
> +	format =3D (pkt_type =3D=3D HISI_PTT_4DW_PKT) ? dw.dw0_4dw.format :
> +						  dw.dw0_8dw.format;
> +	type =3D (pkt_type =3D=3D HISI_PTT_4DW_PKT) ? dw.dw0_4dw.type :
> +						dw.dw0_8dw.type;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604075005.2219=
785-1-liusizhe5@huawei.com?part=3D8
