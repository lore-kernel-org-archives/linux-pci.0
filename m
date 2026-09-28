Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C344BB810
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601583; cv=none; b=gTXDOY3xRPzwXfWyw5BobN3DVEJZXtM/6AbAVJAszUbCzHoFXBi0XEViUsA4cTVTOjdbolg8U679OIV086hBVIaAXwj+XMUq1B3bb8VZgPwK3KNiKekCjIxBREV6s9gMwdg6cTxNdn6qTRg43XKxEN6pBQuePVrwSgc2MQ7OgLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601583; c=relaxed/simple;
	bh=SoizpoAG/pMluxZjy93Na4BbzbSV8XKJZUQd7kr2tLk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeB2AIfE2uFQCfcMnztqsbk4IKkc4d1PdmuqaFgzJViktnZGi3G+0ySdJnAYuP6VH6VT9ioDu9gCHL46cQ4vtxS6bUQbXR826Jsi1q7zDx9+X1W+wUjvd+a/Mkir9WtWzR/4SQwBZJQushNqhL0925mvlvR3cttHzusRvgRUU1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA93a7vg; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA93a7vg"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so15606325e9.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790601580; x=1791206380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O7nnZDeFGYuHWDhrqOrge38zVHlwWRKN/G0qkoJU/0s=;
        b=iA93a7vg6QjKmq7e8C+wZkNi9y9IYpQM4ArWkf+cEgrCw/o0hAuOHl+Kc1ynNjEhzl
         DRjlOqOwx0ftEH16skQa+AeU/ZYnSmLk0ziwLEt659kULau35fQqBhSMDMyJjcKE+SFU
         SkZeV4mOilZFg7xy9N+dlotWQbGdJpz96xHkgTX8+2qDSbbk+pJllsKJkj+ei1SgX7+q
         t9vNboJTaoIa3n8+Xby7/ZC0U/kpGd6ZEbRcP8u6n5OIYormnxCBSDD4KvjPsGgDQztd
         h0mFYqwDohCVUtfcrPTqbELskGw3HUXdt7u6PNSgV6VZuHBai6gk7+p8FKIaHwUajlSn
         sqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790601580; x=1791206380;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O7nnZDeFGYuHWDhrqOrge38zVHlwWRKN/G0qkoJU/0s=;
        b=uG4qTYcCnb4uuTEzUWGHQ0dVJo3h/PdEb37C9UOhP5bJstaa52LOmlwNm5EDYvBP88
         bSGtleiezUqH+BvvkAa6ChB9Y3imKziaO61bQqkTIqewJ+99SQq84beSM1fWHPLarfdg
         S5rhlimhwIT+Swz7HnYvO7bHyTdsdSqVHpm4tzdbhTHEvwItMTYfjEFUztIs3QgvfljE
         D8rEjoU4Yy8/3rQFjw5taQhiml7YBz6y+bD8xedhB/3TYYg01L3Y1UPhamHN6lxEqDTY
         SpIpRVJgkbuv8Cacm+0+6bRMwm46FvcwyQ1ohSa1fG53sCFUWq+6/CkVWXpHk8f7mAmh
         iSfQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOtNkNccZT2GEJABrWSo7rOUyiWFNZNrifeWnFrp+APcar43Q1o5VuzZw9enPTheefy/GjWp/MCNM=@vger.kernel.org
X-Gm-Message-State: AFuF++l3fQnHaRR+Ds8pqGSC59lCHJy/7/THMFswowqt1fogZsv/Q9fE
	IedtMz0VUJshZW6M3e1b4imLz+V77VPmf5U6/ppunwvjRkZNj48RkaQ8
X-Gm-Gg: AYBFou2QL6PoN2RsStya6ndHxh/ewenVvM/FxOztsLfbkwFQ7TQSfGCVlh+/e5XSqBS
	mjcCT/dosOPq8UrHq5dxYgxtzpCC/LV7NACcUPagqoymuMihFlbohpQ2z4rE2Gt8q+IPgHnZukJ
	63EKITwuTzUKQZIXl7S/NEPDj10xoDHPS7KoHTUGC8gAQjoXohqzVieYg18Wn1tzKSGO/gpbv+v
	d6/zVNUch77zoVY53yLyiBUdOi8yNLiMyew18NSVhmGueTOZP0mNiFA3dGmsKKsvhy/sP4ntyoe
	CyRxL7/sJaJlZ/Xpdp0j46y+K/LAQqVjJhd/bCxXHsdN1lL8zHspwSrQIVGgKrO9or08TER38Va
	jtkiQQge/ZOi0hb/ECCvIyepSj+Nxh8w1q7bfIkbG5L/GWkb3TOO7N7k015LmrzWYIdCOyxJmF1
	/Wt1WdF5mrGTF7xL8I8cN6qOrNlk8hq9oURBfeBu6zKxqe/IzsxVlHodD3B0Lg0lmKS0X9a2CD4
	ZLLXCxQWXrHF8kDaDuE6LPKsyZjlzE+wII=
X-Received: by 2002:a05:600c:698e:b0:49c:fc6e:a3dc with SMTP id 5b1f17b1804b1-49fe66f1491mr237541635e9.27.1790601578644;
        Mon, 28 Sep 2026 06:19:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a007fd1a01sm38437975e9.0.2026.09.28.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:19:38 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:19:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Maciej Grochowski <Maciej.Grochowski@sony.com>,
 Nikolas Joshua Britton <nbritton@exabit.io>, Geramy Loveless
 <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>, Alexey Fomenko
 <alexey.fomenko@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] PCI/quirks: Avoid certain BAR 0 address with igb
Message-ID: <20260928141936.2539ad5f@pumpkin>
In-Reply-To: <447e3daa-c8a5-2b0c-2c6d-3f3eb92e94cc@linux.intel.com>
References: <20260924202056.GA2001522@bhelgaas>
	<447e3daa-c8a5-2b0c-2c6d-3f3eb92e94cc@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Sep 2026 15:20:13 +0300 (EEST)
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 24 Sep 2026, Bjorn Helgaas wrote:
>=20
> > [+cc Rafael, ACPI resource question]
> >=20
> > On Wed, Sep 23, 2026 at 04:17:55PM +0300, Ilpo J=C3=A4rvinen wrote: =20
> > > While testing the resource placement changes, my tests hit a case whe=
re
> > > igb fails to probe when BAR 0 is placed at 0x9c000000:
> > >=20
> > >    90000000-9cffffff : PCI Bus 0000:a0
> > >   -  90000000-902fffff : PCI Bus 0000:a1
> > >   -    90000000-900fffff : 0000:a1:00.0
> > >   -      90000000-900fffff : igb
> > >   -    90100000-901fffff : 0000:a1:00.0
> > >   -    90200000-90203fff : 0000:a1:00.0
> > >   -      90200000-90203fff : igb
> > >   +  9be00000-9c0fffff : PCI Bus 0000:a1

Is that valid?
I'm no expect but I wouldn't expect an address range to cross a power of 2 =
boundary.

David

> > >   +    9be00000-9befffff : 0000:a1:00.0
> > >   +    9bf00000-9bf03fff : 0000:a1:00.0
> > >   +    9c000000-9c0fffff : 0000:a1:00.0
> > >      9c100000-9c17ffff : amd_iommu
> > >      9c180000-9c1803ff : IOAPIC 8
> > >=20
> > >   -       Region 0: Memory at 90000000 (32-bit, non-prefetchable) [si=
ze=3D1M]
> > >   -       Region 3: Memory at 90200000 (32-bit, non-prefetchable) [si=
ze=3D16K]
> > >   -       Expansion ROM at 90100000 [disabled] [size=3D1M]
> > >   +       Region 0: Memory at 9c000000 (32-bit, non-prefetchable) [si=
ze=3D1M]
> > >   +       Region 3: Memory at 9bf00000 (32-bit, non-prefetchable) [si=
ze=3D16K]
> > >   +       Expansion ROM at 9be00000 [disabled] [size=3D1M]
> > >=20
> > > igb 0000:a1:00.0 0000:a1:00.0 (uninitialized): PCIe link lost
> > > ------------[ cut here ]------------
> > > igb: Failed to read reg 0x18!
> > > WARNING: drivers/net/ethernet/intel/igb/igb_main.c:724 at igb_rd32.co=
ld+0x3c/0x4f [igb], CPU#32: kworker/32:1/706
> > > ...
> > >  igb_get_invariants_82575+0xff/0xf00 [igb]
> > >  igb_probe+0x3c8/0x1190 [igb]
> > >  local_pci_probe+0x3b/0x80
> > >=20
> > > Apparently, the igb driver bails out, after its initial sanity check
> > > detects an unexpected ~0 read. Hacking around the sanity check just
> > > results in more failures down the road so the sanity check itself is =
not
> > > the cause for the failure.
> > >=20
> > > The resource placement looks valid so the actual placement patches se=
em
> > > to work normally.
> > >=20
> > > All other possible 1M address I could test (with a hack patch) did wo=
rk. =20
> >=20
> > Super weird.  Is it possible there's some other device there?  It's
> > conceivable ACPI might have a _CRS method describing it.  I think
> > there are ACPI devices for which we don't reserve space mentioned in
> > _CRS.  Maybe Rafael knows a debug option to log everything in _CRS? =20
>=20
> Now that you mentioned it, there certainly something going on with=20
> that address:
>=20
> [    0.000000] BIOS-e820: [mem 0x0000000070000000-0x000000008fffffff]  de=
vice reserved
> [    0.000000] BIOS-e820: [gap 0x0000000090000000-0x000000009bffffff]
> [    0.000000] BIOS-e820: [mem 0x000000009c000000-0x000000009cffffff]  de=
vice reserved
> [    0.000000] BIOS-e820: [gap 0x000000009d000000-0x00000000a8ffffff]
> [    0.000000] BIOS-e820: [mem 0x00000000a9000000-0x00000000a9ffffff]  de=
vice reserved
> ...
> [    0.000000] efi: Remove mem48: MMIO range=3D[0x80000000-0x8fffffff] (2=
56MB) from e820 map
> [    0.000000] e820: remove [mem 0x80000000-0x8fffffff] device reserved
> [    0.000000] efi: Remove mem49: MMIO range=3D[0x9c000000-0x9cffffff] (1=
6MB) from e820 map
> [    0.000000] e820: remove [mem 0x9c000000-0x9cffffff] device reserved
> [    0.000000] efi: Remove mem50: MMIO range=3D[0xa9000000-0xa9ffffff] (1=
6MB) from e820 map
> [    0.000000] e820: remove [mem 0xa9000000-0xa9ffffff] device reserved
>=20
> But given the comment above efi_remove_e820_mmio() it sounds like this is=
=20
> a red herring.
>=20
> In any case, the address is inside the provided root bus resource:
>=20
> [    4.854840] ACPI: PCI Root Bridge [PC05] (domain 0000 [bus a0-bf])
> ...
> [    4.854848] PCI host bridge to bus 0000:a0
> [    4.854848] pci_bus 0000:a0: root bus resource [io  0x6000-0x6fff wind=
ow]
> [    4.854848] pci_bus 0000:a0: root bus resource [mem 0x90000000-0x9cfff=
fff window]
> [    4.854848] pci_bus 0000:a0: root bus resource [mem 0x71d60000000-0x7f=
cffffffff window]
> [    4.854848] pci_bus 0000:a0: root bus resource [bus a0-bf]
>=20
> > Does igb seem sensitive about this exact address on a variety of
> > machines?  If so I would expect some kind of igb hardware erratum for
> > it. =20
>=20
> I've not heard anything to that effect.
>=20
> But existance of the sanity check itself in the igb driver looks almost=20
> like a smoking gun so I don't know what to think of it.
>=20
> I'm also inclined to think that the placement approaches out there so far=
=20
> might not have covered that many addresses but used the left edge of the=
=20
> window. So this series, when it often moves resources to right edge of th=
e=20
> window, goes to what might not be on well-charted territory.
>=20
> > Do other non-igb devices work at that address? =20
>=20
> Unfortunately there are not other devices underneath the RP so I might no=
t=20
> be able to test this.
>=20
> > > Add quirk to reshuffle igb resources, use BAR 3 to block the problema=
tic
> > > address.
> > >=20
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >=20
> > > I know this is ugly and I don't like it either but do not know better
> > > way to avoid the regression.
> > >=20
> > > I've tried with iommu=3Doff and that did not resolve the issue.
> > >=20
> > > I also managed to prove igb works with the same resource layout in
> > > another system. So identifying the case should probably be tightened
> > > by matching with more devices than the one used by igb. This is open
> > > to discussion. =20
> >=20
> > I guess this answers one of my questions above. =20
>=20
> Yeah.
>=20
> But then there's the sanity check in igb which hints otherwise.
>=20
> > > ---
> > >  drivers/pci/quirks.c | 56 ++++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 56 insertions(+)
> > >=20
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index de9bbccda21f..e6f3e2ab1fd4 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -6288,6 +6288,62 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0=
x1536, rom_bar_overlap_defect);
> > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap=
_defect);
> > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap=
_defect);
> > > =20
> > > +/*
> > > + * The igb driver probe (due to reads returning ~0 unexpected) when =
BAR 0
> > > + * appears at 0x9c000000. The cause is unknown. =20
> >=20
> > I suppose this is missing "fails"?  "igb driver probe fails"? =20
>=20
> Obviously, thanks.
>=20

