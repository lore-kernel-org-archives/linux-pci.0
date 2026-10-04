Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546236E498;
	Sun,  4 Oct 2026 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791128703; cv=none; b=S5UOx+kU0w0EJQam+N13XkPagZQdpGfrqOTDADDZ86Sqd+LuI8LON0FFvyJuCy5ghMmcCMig7DQlyXb4o/qtTd/mg1eEcu1HH25EzoX8fzHglTGy3eFmkDb0j1Cr9MRkEJHWLQbxPx1pkxRsifhWBPoC6366qMvjcLFZeDMNmRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791128703; c=relaxed/simple;
	bh=6VExMatIpNaJGFvg0DCb2B+ps2eCBCtSzNT7we71dIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmEhFULe7lx2yHNWyPfLARTqNAHLM2Pdk7ughVSV1uCmH03gTZh1NI2CNp/L48uT/iqTgpUd8pizjFQOnCmBav0WSWSWIiEIV7pDV9IdbUbWoxPOntwBBxOelxZP9eLvx2slWJB1qPUBWPG9HlkEx025zTe7e4TiZz2DCQpgh7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IlQhKE7N reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IlQhKE7N"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B97BA40E01B4;
	Sun,  4 Oct 2026 15:44:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4yVDCcEjaToe; Sun,  4 Oct 2026 15:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1791128687; bh=BAFSbCkTz3nxD5ued70ACeS8eONsJiVPIwxaE2QsvxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IlQhKE7NqzscRABDcEzeyhmIzVq8MC8yvIQMrUrW53Q274J9L6B6knzmuW3pZ38pu
	 8859asSzPvZgqVTUqvEKQ7URvKv6XPxLhj/mz38ttmoBecy4/zSGju+2Nz5qUJXe8f
	 i4XdMMZvyKRoegpj8PCnC4sCAZ/hSM4K4l+vK19kitcroBeqBaNZcRS7rE+5qQ/qca
	 VZr05vjYM1ZBcKva9g4FrxhOohNWmBh4aoCdOaz0cU32v2YtzZr+E4UuBTpe1f1CRq
	 8YuWoD4ygMImRagaZRB+yUeuvUVITW40dz1rbODO24jHjDr8bx9oqzOJuXo5wzgq4v
	 ZVwudH79v3GwjLBpJ564Z+M5/pLCB8KPlEQiU+wImeLEgFodG8hP4KvpXApv+Tk7Bb
	 zVapcRNpftOAVRs9Zfqk3I2MasL7vTJt6tpoFJ6pi+0cyY+HI/m2ew264MX2BqPwKk
	 EimAPxc6scGfSgMCqX6VQhuYhQlum+NpDsRsWDFcnfNVUCv+v1g5kNpKABb+CI3fLQ
	 4BmHkaNv/H8DJJOR5hVwTP2SMlM9Soq0OwYsywaa4QNyu8DZ6Kqppu8Pj0rqH92SCe
	 z+6rbxF3bZfQ4sUS1wZDRwXwHBnPjQtA5svqoEs+kZxWLb1luKZEMQqdAwm8J14wgv
	 Urk+o8xX3u7QaRfdocHT72CM=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D2FE340E015B;
	Sun,  4 Oct 2026 15:44:32 +0000 (UTC)
Date: Sun, 4 Oct 2026 08:44:28 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Nikolas Joshua Britton <nbritton@exabit.io>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 7/7] PCI/quirks: Avoid certain address on Genoa systems
Message-ID: <20261004154428.GAasJ0XCWdso81YdwH@fat_crate.local>
References: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
 <20261002113319.6652-8-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002113319.6652-8-ilpo.jarvinen@linux.intel.com>
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2026 at 02:33:15PM +0300, Ilpo J=C3=A4rvinen wrote:
> While testing the resource placement changes, tests hit a case where
> igb fails to probe when BAR 0 is placed at 0x9c000000:
>=20
>    90000000-9cffffff : PCI Bus 0000:a0
>   -  90000000-902fffff : PCI Bus 0000:a1
>   -    90000000-900fffff : 0000:a1:00.0
>   -      90000000-900fffff : igb
>   -    90100000-901fffff : 0000:a1:00.0
>   -    90200000-90203fff : 0000:a1:00.0
>   -      90200000-90203fff : igb
>   +  9be00000-9c0fffff : PCI Bus 0000:a1
>   +    9be00000-9befffff : 0000:a1:00.0
>   +    9bf00000-9bf03fff : 0000:a1:00.0
>   +    9c000000-9c0fffff : 0000:a1:00.0
>      9c100000-9c17ffff : amd_iommu
>      9c180000-9c1803ff : IOAPIC 8
>=20
>   -       Region 0: Memory at 90000000 (32-bit, non-prefetchable) [size=
=3D1M]
>   -       Region 3: Memory at 90200000 (32-bit, non-prefetchable) [size=
=3D16K]
>   -       Expansion ROM at 90100000 [disabled] [size=3D1M]
>   +       Region 0: Memory at 9c000000 (32-bit, non-prefetchable) [size=
=3D1M]
>   +       Region 3: Memory at 9bf00000 (32-bit, non-prefetchable) [size=
=3D16K]
>   +       Expansion ROM at 9be00000 [disabled] [size=3D1M]
>=20
> igb 0000:a1:00.0 0000:a1:00.0 (uninitialized): PCIe link lost
> ------------[ cut here ]------------
> igb: Failed to read reg 0x18!
> WARNING: drivers/net/ethernet/intel/igb/igb_main.c:724 at igb_rd32.cold=
+0x3c/0x4f [igb], CPU#32: kworker/32:1/706
> ...
>  igb_get_invariants_82575+0xff/0xf00 [igb]
>  igb_probe+0x3c8/0x1190 [igb]
>  local_pci_probe+0x3b/0x80
>=20
> It turns out there is a 64kB iomem black hole at 9c000000 that returns

Can we please debug that "It turns out" thing and try to find out what re=
ally
is going on here.

Can you pls explain what your machine looks like so that we can try to
reproduce it and see what's going on?

Does it have latest BIOS, microcode, etc etc? If it doesn't, can you upgr=
ade
and try again?

I guess dmesg, hwinfo, kernel .config would be good starters, privately i=
s
fine too.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
