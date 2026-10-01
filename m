Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181F348F039
	for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2026 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873126; cv=none; b=PFKTM09uaAs+BZfgV3Z3k88HFtCrEqL0c15jh9jwy1lIXpNus6s5pbXoEF50UZWfYuZA3io/F7tA5VM24KdBRmzxZPsVfpveKxOwYkZ/T9/IsS6B7ss8yjAQ4TZccKwVCXw4KQ4Pl2Fe7r3MCopWsqOQ4H+tEV1/JftXnpBOruU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873126; c=relaxed/simple;
	bh=PY5qgS40a627xWmb4B40zcptBam7oiykXKkXPZoCEUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CD5wnKqb+6MasMz7f4vajwuXeqyGHUcrxDkWQP2eo7T6K3LZox6YGJA+RVdFK4TzF3eFZjsOOTnMSNBLD14ClSbL+uVlj9VeuQ8E6Z1wtySh4+1PyqZcsxgSSOWLpUj9JbIUk314xuPXC7KfqjSVqlXGFxUr9gxUOq5AeZ+aKTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeJfh7bU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeJfh7bU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38F61F0089E
	for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2026 16:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790873124;
	bh=PY5qgS40a627xWmb4B40zcptBam7oiykXKkXPZoCEUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CeJfh7bUAALKgBMdcUwnxr3hBMN3xrgRoUl66u7rO0rlZByk7ZpeCOLsnPdPEIeZg
	 EQ4YHHiQFDapR6tiEwWRYgTueaVjZkPYzNlA4oc+/uM7URJG2m0kiyfXLaf0YhARte
	 lBs0zgltfbGeoiOWeIYiQQejlT0vSaquL+6rdnNubhJIwyHspiRZxaWqe7iZbYH2Wt
	 l/93577ae8mAfE+IzcQZB9lWMnK+cw7MuL/up3Sy9BiwbYwRHHAvhxSgtO/QQYzd5K
	 rDnmy9QnMSdw0xJVDsrqfxBruRmdrJ9HdmtlS/B6BEemIANBQ11NGIEwlJrbNDoEdU
	 8eCRpPJEXZB9A==
Received: by mail-lr2-f33.google.com with SMTP id 38308e7fff4ca-3a7be75eb9bso7809421fa.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Oct 2026 09:45:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwYHVUhI0oIlMYJwDxZM7uz3PCgaIWCK1ELQwRe6v/6vNB2Fm6TcfVyRoftqU7JTik/xP9yFGTkA3Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYInh1/j0uCrDks0EOpweLcGEghBCglYr0V4qjzKQ3wEM86wVKeq
	yBzSfYk0ber0G5u4K7iqgftBKG9CV7zHDia5MO8F0TledOuZ2HVxp0ismQdI2hE7ax4FfRTJOr8
	YI8gLnq/YSwGzm3r8q9gZBtaGUCLnfns=
X-Received: by 2002:a05:6512:3c82:b0:5b6:183b:d20e with SMTP id
 2adb3069b0e04-5ba405ebc71mr2317546e87.53.1790873123100; Thu, 01 Oct 2026
 09:45:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911164705.841407-1-dave.jiang@intel.com> <20260912001329.6db3222b@jic23-hlaptop>
In-Reply-To: <20260912001329.6db3222b@jic23-hlaptop>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 1 Oct 2026 18:43:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gX4mf8ThCd4ifcwd4YSahQ4JC9oJ__mYdvDNKmagsSEw@mail.gmail.com>
X-Gm-Features: AclHuK98bfyzp21C-YwvFUnVedmTWLA6Qdhhhta023tzcpUV5MlsjL9DmU-GRXc
Message-ID: <CAJZ5v0gX4mf8ThCd4ifcwd4YSahQ4JC9oJ__mYdvDNKmagsSEw@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/AER: Map a raw AER Capability image field by field
To: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, bhelgaas@google.com, 
	ilpo.jarvinen@linux.intel.com, bp@alien8.de, guohanjun@huawei.com, 
	mchehab@kernel.org, xueshuai@linux.alibaba.com, terry.bowman@amd.com, 
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 1:13=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 11 Sep 2026 09:47:05 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>
> > struct aer_capability_regs is not the hardware layout: the embedded
> > struct pcie_tlp_log spans 60 bytes where the Header Log it stands in fo=
r
> > is 16, so a flat copy misplaces everything behind it.
> >
> > extlog_print_pcie(), ghes_handle_aer() and cxl_rch_get_aer_info() work
> > around that by stopping at the Header Log, dropping everything past
> > offset 44. Flit mode is never decoded either: the Flit bit and Logged
> > TLP Size sit at offset 0x18, unread, so the Flit DWORDs at 0x38 are los=
t
> > and the log prints as non-Flit.
> >
> > Add aer_cap_regs_unpack() to map the registers individually, taking the
> > TLP Log layout from the Flit bit as pcie_read_tlp_log() does. Clamp the
> > logged length: Logged TLP Size is 5 bits wide, so an untrusted value
> > reaches 31 where dw[] holds 14 and pcie_print_tlp_log() walks
> > header_len unbounded.
> >
> > Take the image little-endian, as both sources are: CPER by definition,
> > PCIe registers on the wire. Read it with get_unaligned_le32(), since a
> > CPER section sits wherever firmware put it, and take the two source IDs
> > out of the Error Source Identification register by bit position rather
> > than byte offset. cxl_rch_get_aer_info() uses readl(), so it hands back
> > __le32.
> >
> > Convert all three callers. cxl_rch_get_aer_info() now reads the whole
> > MMIO block, so size its ioremap by the hardware registers (96 bytes)
> > rather than by sizeof(struct aer_capability_regs) (100). Shrinking the
> > mapping is safe: the read it replaces stopped at 44 bytes.
> >
> > Reported-by: sashiko-bot@kernel.org
> > Closes: https://sashiko.dev/#/patchset/20260904172337.1409775-1-dave.ji=
ang@intel.com?part=3D5
> > Link: https://lore.kernel.org/linux-cxl/CAJZ5v0hDv11cPuztPZsaDd7uwD_49K=
znJy=3DtzuRO+dZc=3DCnAEQ@mail.gmail.com/
> > Assisted-by: LLM
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Nice.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Applied as 7.4 material, thanks!
