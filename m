Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795721618;
	b=zbmbaTcWBDyPUwBDNaIQjp/mkxf7smFlvfyrqApKP2b0OtMBGCLsjjY1wzmirjwMgoti
	 gLNl7dAWgIHxVYOyr3HgFLa6E/p9jupLnGFlEoN0tOBNbNtl6OKXoQI8mrm6qn58/yWcY
	 JW/25gU6shjS2MWa0cEh1AQ3np1o7Pb9PQk95H6HbPHUowfpY0ldsoxHNbarfz7SsF8pX
	 h6voEZdffNWgfxwYuSVQOvo4v7FzdpWsyfJVUg+eb+bIw+v4r313vdX4TjdXwcW6JKvJN
	 4bymkqdsafCYNDpcRiWrDzH4GbP6S1Og/ygbT4zdYX5NcMqF48cj5hFSChWK6MIPCnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795721618;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FJ+fnNInRVKJOOIyg0A7b/ksDzxySwVeLxHmv+YMYRw=;
	b=k+Xk7Ck+vXL1v6RIe5Q8luLbxMaxIwpixwlWOCd9X1LSeQLMdqTx2mIny9DsxGmUqYDy
	 pvudYKqRSrO1IrMivZosRcQVcQFhCcwYcWCok3jx09/X5L8cuM11gzvhB9mFRWxvpmSMG
	 bRuBgVwSy4fJnNS7TziQOPR4AfvpzcrFSQYyVjijq6dfgswGoBPbb0ItbJ8WC5IhVuMwx
	 MQWvjsWta2wFFN3S49+hsjNDtCNnlRCK31KekYGk6eqBrpv9MiNtLMbkUttIL+uObly9J
	 kVXLzLAKZBr32Wugec6Nyx10NDSFmO8Yb9HqbKmhtz85cY5XtDkSaiaR3jO9HHmOiVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExvDlpnE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8AB606A32D
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExvDlpnE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B333D1F01829;
	Thu, 26 Nov 2026 19:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795721617;
	bh=FJ+fnNInRVKJOOIyg0A7b/ksDzxySwVeLxHmv+YMYRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ExvDlpnEBmDV1bErOqhWDeF878jTEPIgG3z9P7Db61EPzMBCLL+R6YsSxvcEzkUjG
	 nY6NZIoCp46iQPzh/kSXrHq6qCw7XYJbYtF2Ox8UekMyoSYIBX6govIoW7bZuouuvV
	 VoD5rdQga4pA2VmU26YP4fjvKIskua9YM7v7CyoMifXxhMpewsDj+mbTmPLj4bIupX
	 6nE3vBOlCCP1i+IgAPdwx6DS+2wWPDPAMC4wNajnwPfQ6Tlcl9e1HeNdWFi9M1I5QG
	 xMJLpIqy0sUHIiaxUmK46ewgvXAQCeiJjM+NNA2FqBDXsiM865Jwj7gi7r6uCKGL5h
	 8CloNrImPd/jQ==
Message-ID: <sashiko-outbox-236097@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: dwc: Skip the empty CFG1 window for a two-bus ECAM
 range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Felipe Infante de Castro" <felipe.infante.de.castro@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <CADy1qsYumu=QY34qDxL2dPjQc4teadMaMgFS4rR2iAr3rMiqag@mail.gmail.com>
References: <CADy1qsYumu=QY34qDxL2dPjQc4teadMaMgFS4rR2iAr3rMiqag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 19:33:37 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: dwc: commit message includes email greeting and duplicates
  changelog
--

commit 7a5d39707aeeca95411c9f51ba2051ccdefb49e1
Author: Felipe Infante de Castro <felipe.infante.de.castro@gmail.com>

> PCI: dwc: Skip the empty CFG1 window for a two-bus ECAM range
>
> Hi,
>
> The patch is attached as a file rather than inline, because my mail
> client cannot send it inline without wrapping lines and converting
> tabs. Apologies for that. The commit message is repeated below for
> review.
>
> With the iATU-based ECAM mechanism and a host bus resource of [bus
> 00-01] (bus-range =3D <0 1> in a device tree),
> dw_pcie_config_ecam_iatu() programs the CFG0 window for bus 1 and then
> requests a CFG1 window of zero bytes:
>
>   atu.size =3D (SZ_1M * bus_range_max) - SZ_2M;
>
> dw_pcie_prog_outbound_atu() rejects a zero-size window with -EINVAL,
> the error propagates through dw_pcie_host_init() and the host bridge
> is never registered.
>
> resource_size() counts both ends of the range, so [bus 00-01] holds
> two buses. Bus 0 uses the DBI registers and bus 1 uses the CFG0
> window. A CFG1 window is needed only from bus 2 on, that is for three
> buses or more. The early return tests "bus_range_max < 2", which lets
> the two-bus case through. The patch returns early for two buses as
> well.
>
> Tested by replaying dw_pcie_config_ecam_iatu() and
> dw_pcie_prog_outbound_atu() in user space against memory-backed
> registers, for every bus count from 2 to 256 at two ECAM bases.
> Without the change the two-bus case fails with -EINVAL; with it all
> 510 cases pass and the CFG1 window for three or more buses is
> unchanged. Not tested on hardware with a two-bus range. The patch also
> builds cleanly on a 7.3.6 tree with W=3D1.
>
> The code was introduced by f6fd357f7afb ("PCI: dwc: Prepare the driver
> for enabling ECAM mechanism using iATU 'CFG Shift Feature'") and is
> unchanged in v7.4-rc4.
>
> Thanks,
> Felipe
>
> With the iATU-based ECAM mechanism and a host bus resource of [bus 00-01]
> (bus-range =3D <0 1> in a device tree), dw_pcie_config_ecam_iatu() progra=
ms
> the CFG0 window for bus 1 and then requests a CFG1 window of zero bytes:
>
>   atu.size =3D (SZ_1M * bus_range_max) - SZ_2M;
>
> dw_pcie_prog_outbound_atu() rejects a zero-size window with -EINVAL, the
> error propagates through dw_pcie_host_init() and the host bridge is never
> registered.
>
> resource_size() counts both ends of the range, so [bus 00-01] holds two
> buses. Bus 0 uses the DBI registers and bus 1 uses the CFG0 window. A
> CFG1 window is needed only from bus 2 on, that is for three buses or
> more. The early return tests "bus_range_max < 2", which lets the two-bus
> case through.
>
> Return early for two buses as well.
>
> Tested by replaying dw_pcie_config_ecam_iatu() and
> dw_pcie_prog_outbound_atu() in user space against memory-backed
> registers, for every bus count from 2 to 256 at two ECAM bases. Without
> the change the two-bus case fails with -EINVAL; with it all 510 cases
> pass and the CFG1 window for three or more buses is unchanged. Not
> tested on hardware with a two-bus range.
>
> Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mech=
anism using iATU 'CFG Shift Feature'")
> Assisted-by: OpenAI Codex
> Assisted-by: Claude Fable 5.2
> Signed-off-by: Felipe Infante de Castro <felipe.infante.de.castro@gmail.c=
om>

[Severity: Low]
This isn't a bug in the code, but the commit message includes the email
greeting ("Hi," ... "Thanks, Felipe") and repeats the entire changelog
body twice.  Any mail-client commentary belongs below the "---" separator
so it is not recorded in git history, and the duplicate copy of the
changelog should be dropped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CADy1qsYumu=3DQY34q=
DxL2dPjQc4teadMaMgFS4rR2iAr3rMiqag@mail.gmail.com?part=3D1
