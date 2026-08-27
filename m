Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FBE37CD32;
	Thu, 27 Aug 2026 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839977; cv=none; b=GYSbXRHrbXeD91GtaNspLIl1PRYq3xivsoRFjnHWtRVsYphcjFQeHv7rJvVCsIvEP/XdhAvBjo1TeiE6MIOzylEbkUilKbl4SiMmuLa+3nxRny+NNWedMqUzvy+XYVrOxLvfQa8shlROaG9eCqRPncP/pynozVTnpM4DRyZH9Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839977; c=relaxed/simple;
	bh=yrPz2YpDmIG37C+l9IJ4h9OkpmspasF0BOdd97zpUSY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AlWTORVDRhMtc8eZSsDd02nJQiLKY447PTa9zy2isqK6TauUZ/AC1/hz7zCzr6LKHDHImYtKqSdCI2l9nCUkpZnZRPvjl9JiB+1QAV1EwCd+OyHOx6lZg7JEXZNIRejdEUvUqz2dWrVkFUDtCxCyRX4lVE6AELDv6LkOwZdL9iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXwLz7hm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXwLz7hm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5B01F000E9;
	Thu, 27 Aug 2026 14:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787839976;
	bh=eVbIhLFKCMbjT0POuRE5OoAgOp+YKfWd5OvSzZ/RnSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bXwLz7hmOCBUhoF9CoV5P5fm20kEzLXtZ9NMtZOG2SX/JqLqqzZLC7RQCGOCanwzf
	 XH0Rh0Juzfu10gyFH1/nIwFx+YJ4VLoe/URVwunbQkb2RTrs3y6WGKeq8qCGjKbgIH
	 NwTDidJ35zmke7439InjFDg9eBMglpGwF303mGE+iHCrQQeBy9u+TXK3fY1rHEpGfd
	 ObX/C6ee+R0pV58te7cuZK0a6mGw/hVbvx2pYVnHSjiXYO3Vcb3o40bNNN2iHALqic
	 slwPGwp5RBdiogVCVVfaqruf42YAh4aAdwtcqNwXHF3ngae4aHiJ1qZAZcjOtewmZl
	 Su9eFMxS5jgzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] perf hisi-ptt: Add parsing of supported message
 types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260827140442.2031128-6-liusizhe5@huawei.com>
References: <20260827140442.2031128-1-liusizhe5@huawei.com>
 <20260827140442.2031128-6-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:12:55 +0000
Message-Id: <20260827141255.EE5B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit inclusion of <stdbool.h> for musl compatibility.
--

commit db9f8e2182c24e7486861ffcf7818bd57505c649
Author: Sizhe Liu <liusizhe5@huawei.com>

perf hisi-ptt: Add parsing of supported message types

This commit parses PCIe TLP messages into types like MWr, Msg, Atom, IO, CF=
G,
and CPL based on the Header DW0 Format and Type fields. The parsed message
type is stored in the packet buffer to select correct field layouts for lat=
er
processing.

> diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/to=
ols/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
> index 00bd9309df68a..e63fe1534693c 100644
> --- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
> +++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
> @@ -79,6 +79,66 @@ static const char * const hisi_ptt_4dw_pkt_field_name[=
] =3D {
>  	[HISI_PTT_4DW_HEAD3]	=3D "Header DW3",
>  };
> =20
> +/* TLP message parsers below according to PCIe r6.4 sec 2.2.1.1 & 2.2.1.=
2 */
> +static bool hisi_ptt_is_mwr_tlp(uint32_t format, uint32_t type)

[Severity: Low]
Does this missing explicit inclusion of <stdbool.h> break compilation under
musl libc?=20

The Perf subsystem guidelines require explicit inclusion of POSIX standard
headers for types like bool, because unlike glibc, musl strictly separates
declarations and does not implicitly pull them in.

> +{
> +	return (format =3D=3D 0x2 || format =3D=3D 0x3) && (type =3D=3D 0);
> +}
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827140442.2031=
128-1-liusizhe5@huawei.com?part=3D5
