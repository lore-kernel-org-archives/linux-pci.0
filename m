Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812766;
	b=bVx6J3ryub9oELsdet7Ry5HUhUHR8gcKUSJXydnolPDJyZGAppSgwvFm2e0c/2UTvBN8
	 4xIq7gIRLLwhmAEAeJuP8xtzoSGTMF+x1K86r10ifq7mdPNWckh+lPDZhxXCmjrfWg3s8
	 SYw5c+zM6ngEY7zGbfxJQxrupWMgCxIw1L8cwsNU2RmFzErU5J9dpCyYeYx/yjzSPq0MB
	 Z3cThut4m6lJTk/cabbc0i2D/umxaZ5Ud75Gr1/LF98S+9n49gdGq/hYCdL0oACeZPww8
	 TysZRC4Qi3mjCNKihxipwLobld0y09QoU7q+toS6N9Uptufg/30snTTIPD3ryviHZrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812766;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tiG48DnyZGmU5gzeXcmtodiYWk9U98E+sQX2YBJR8BY=;
	b=En5NpLUeCMU9xAFbC+8apelIjhy+ceTnBJ5bgPPXidt2NFXeaIq46Zuu5fnpUqJ5qQbS
	 F0EyrLtCnxXI21Jz72Cpb2pL1iQHN4R96FAOEHM4CgbjSY3YHHjaCH6TY+4PWCmi1aLm1
	 kV9mkzCapwAtz4kGuutPa2VTTHZAL+YvfYwycNM6R0at1Zpw2vOe5OMQsyhJ6ZQFy7toX
	 su8H9B30/8myOVlqpD/dZfGfej/cQbiy1jq1I7xFwoX3ZZ1V1/BVqLFbBHlFLyEEVKRVd
	 FbwruAGUdB84AYBhU0yClga2Y3oj6hYROnTdAuyUJFrQ7pZMRaNLX4Iub8/xebSaWpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F94MEYqj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD44606A31C
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F94MEYqj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A19C1F000C4;
	Mon, 16 Nov 2026 07:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794812766;
	bh=tiG48DnyZGmU5gzeXcmtodiYWk9U98E+sQX2YBJR8BY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F94MEYqjbLkZvUoWbgrlhuTiQ6YN7PUCGM+tvsoJ6MQvC3vPzdQUjNWDlw91vVekR
	 XvUgB5PGn2YHdyYLA9ItA6xoBJMPAz0Qudq/Pfb+kwDd3Av3Id6kIQipnMXazyR9lL
	 EF1/N6//QxD1vCrH1MX+m34to2YqLWrUHgmzKSe6gOInxyNVqytd6i+kMk0UMmMmOf
	 hGWdi4sYq+QIhhPDHFfiKugvNW31/LQgvCPSQRB1kDyV6Fb1dSZRjsTtQYYVzMd6Dy
	 +DyxCsodEmJ6rJ6L6/qHC97fcX/1u8JIXhogHRU/2QtUhp1G4o2BRFrzurrmQYF8EI
	 181XHUdQtU/mw==
Message-ID: <sashiko-outbox-216379@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: Disable spurious s2idle wake from the NVMe root
 port on ThinkPad P1 Gen 9
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kean Ren" <rh_king@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261116065612.230481-1-rh_king@163.com>
References: <20261116014214.102524-1-rh_king@163.com>
 <20261116065612.230481-1-rh_king@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:06:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> On Lenovo ThinkPad P1 Gen 9 (21UF, Panther Lake), firmware enables the
> ACPI wake capability (_PRW) of PCIe root port 00:1c.4, which is the root
> port of the primary NVMe SSD.  When the NVMe controller is put into D3
> during system suspend, a spurious PME is raised on that root port, which
> sets ACPI GPE 0x6F (SCI).  The SCI fires during the noirq suspend phase
> and aborts s2idle before it reaches the low-power state: every suspend
> is followed by a wake within ~2.5 seconds with practically zero s2idle
> residency.
>=20
> The downstream NVMe device is not a wake source (its own ACPI wake is
> disabled), so the spurious event comes from the root port's wake/PME
> path.  Disable the root port's wake capability as well.
>=20
> No firmware with a fix is available: the issue reproduces with BIOS
> N4SET31W (1.10) and N4SET32W (1.11), the latest version at the time of
> writing.  Match the 21UF model prefix; all 21UF SKUs share the same
> platform and firmware, and the remaining MTM characters encode the
> factory configuration and region.  If a fixed BIOS is released later,
> this quirk can be removed or restricted to the affected BIOS versions.
>=20
> Verified on 21UFZE0PCN:
>  - gpe6F increments by one per suspend/resume on both BIOS versions;
>  - masking gpe6F, or disabling RP05 wake via /proc/acpi/wakeup, makes
>    s2idle stay asleep;
>  - with this quirk, /proc/acpi/wakeup reports RP05 as disabled and
>    gpe6F no longer increments across repeated suspends.
>=20
> Signed-off-by: Kean Ren <rh_king@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116065612.2304=
81-1-rh_king@163.com?part=3D1

