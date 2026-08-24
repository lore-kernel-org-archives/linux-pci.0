Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B6F45A2A0
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588703; cv=pass; b=lWfC9nB4Yq7JqRcWG5vHFds1rFSin7gHZlUmOh34HUoNG4k/S9FmpCxF+sU90nw2j0HYlKQfPr8mX3648X5tOeIsg8b+5Jx12PdkVXGVHC/sbIp4cjq6J9MFm5h9k1OeZS52bY+BBIUVdVjQUTyLac5jL67FhX46t/KSRmWxYLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588703; c=relaxed/simple;
	bh=RXUvjMGPJD51f8u5xTe88xmslE/n5kupkQmieVyO2dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3BgAEePg11VtZy7btyxWrGnY1wTZ2zYI4W9+Pw+IUnA++kifJzkjzosyahj+w/MFcY0bV5RQmb/uxzytA46OEaaE1SCCQhkqK/yUTcKrKyxXOXDLvT7fNzU7bXZe9SZrw2EoC2GxEl3pHuWhNfV439Z8KUCDYYyv4XG2Cf20KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tutLVXiN; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tutLVXiN"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso52257a12.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 09:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787588701; cv=none;
        d=google.com; s=arc-20260327;
        b=hPPiZapeKYT5ne+bYjIhnfHkfl85x7btzFKCb3XHnkhqkgxPUshXtQDNbDnn3oaDpD
         p7mCVEEciz7ohfvolKB5OCQ7ApYUiotdKHmehSJ+cyjDMxNFSrtutRuBwNALcPjU3/Z8
         WZbPDhLBdvBGjnUwcQpoRoQkua3XBDH7UaKIkEdJnkefroCX97REgjNDOUsCnCPMNjOn
         k5+CVmfs4Y1q8zbIKmUUjPWcWiwHzm4Y9JdDYJ2V4RFBFjAo/aAcH2h+lhEYlHLVWJpt
         FaYIp92/4P3niwqtoQjzrjbWzdwgN7aHsPutuoMajTESUWRTXMiYu/tb0PlhA1uDskm/
         9/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PuOg8Ngz+t1jK2W+Es70HYu9dN9CX11UQpscLdprOyg=;
        fh=3GFVTNmG3OX3dpD/C2JZnhfexEahsNMPe9nIW9gziDI=;
        b=NA67hsmeyetZUSHQkCpk1PDykDq1hgwQk4mhoGbQP6yjZ8+9cTtMCVEx1ag25nlW7P
         Sk8eB6yCdWrsdaGl0bzEXYGsKXMkGH0pQlqGfIMXY1xci0hJuo5I8BnIl7xeoOuwLWf0
         cMEBkVsifNycWSF5KMsbIPRvIThGm32qpO7bCGv+R++WoJN28fvKQYrd1qiyiILgaXdN
         Hiz+H8t/WM3kqY4RUUyA/XPagMtxoh8t7oqVo0x8tcE+K396guSHPWwqImrRbdsOunB6
         bl0+SO9SQ5qiNTXBb2oDqz4iktlOZm5bgCAVsbp26DUZxq5quJsjeeTmnM1LMK8lXIrR
         lEWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787588701; x=1788193501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PuOg8Ngz+t1jK2W+Es70HYu9dN9CX11UQpscLdprOyg=;
        b=tutLVXiNQxEzsUoO+aM21vT8hPMbyemUUSea9JZi4wl4fWNf3+6WiJK5DKIAunFgV+
         rdYusElS9fE67xt7yf/HpAQqD6hfQJlv9JGjpZfVax+5BfsasWs0shZd/O1mHII9yIw1
         /MUdrehyHyfJiMBXftB/rQiZIu1maHgrz8YvT4jS5TsAru/VRrOoD8sMWOqrvVmInSy4
         oH68kAbTIPBrnRNMJF3ynrlMFw+8UDXSZVQ6K59uJjNojG/TdgqHjlJENS2VzsdDPUcU
         JvrLf/Qh+fkNwe8lFDnu0+i4mDQGKCLVtya5UZf1nn8jCdo9Ibp0eLJy2VvakfuwfuNP
         8cTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787588701; x=1788193501;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PuOg8Ngz+t1jK2W+Es70HYu9dN9CX11UQpscLdprOyg=;
        b=l/wLHmFKHD2YPMx/xT2wwd7TYrUCHEmxafOTg+9l98K4/ZKwXsuMBHFk+6kqq36tYn
         xX2ESJzU/3kszuPFbI0kWDzA2vRRYqQCCWS+bRZ+0DnL1+6BKWq0CwkYjKm8X28d7yfb
         eVnygmfD0viWRd8DtqfKlF1MczvXhVNdkF+M4PNgGQFGShWvOiC+2DE+Y/pWFA8g9+kv
         xdwOtxPpDU3/JKeJSoJ8a2DnouQkLVu2VFo9Ac2jzUGxHS9fAbi6bCGgTH8rjpRJPUv2
         PsAykGHTgRJfAsAt/4EFptNzK7BWhAYFbnew7cB7ssSdR6oqivxWSYJe0Qa7R+pvAHcb
         eFzQ==
X-Forwarded-Encrypted: i=1; AHgh+RrZfx7i0ubY21/N7lCa0ZkhjMaMLit86glwJIxySW/gtdQLLBv8mjT+879cNOIbJ9lSID90f1vIew4=@vger.kernel.org
X-Gm-Message-State: AFuF++ktAZmHvuYXDSoXtiRU4t2a9QLxcQo+Sy/oMIu9iZNMw755Nwd0
	QH/AufqH+zTbNfkScFdRxt/ko0JAPZbxMcCQO4ZdgMLdX8WtIRW2RbgEWuDSDPYs410nE9NqM/H
	VG1tFxQMJxn1Hji1KX6RoFP/3BcSBibTlen84vZDI
X-Gm-Gg: AR+sD10aPltHna7BLiC3f2nLrrSbJE49KqM+QqlnmO5jIlZ20NHpVH5gVRlDy6Psb8a
	Fw84rgstpBqqkLoMpE/ObX7Qx9pips2520d561R2IorPJyxRrdasmqu/JH9hTk06gu4W8bHpnNy
	FXrti15WJKIAwekFZJ65FGXZJnorq2Z2LeKQX9ObeugSqG86/RdaPzdZ2d0hhm3kUqcm1UM3Oxb
	OthXPjtZDaXj8SGoQ0qLZmYSKXoabNKakKmBL0sMzEeaDV8GgmBfYigRAovoApmEmDZ/tBWnIT0
	k0eJJte/fcFLOwnTtkflp5pJUs8jb/LfnWizc9UX1RBkPF+iCR4=
X-Received: by 2002:a17:90b:1344:b0:396:44ef:ab64 with SMTP id
 98e67ed59e1d1-39645b70506mr418840a91.21.1787588700365; Mon, 24 Aug 2026
 09:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821221610.3570722-1-dmatlack@google.com> <20260821230620.fcpmn7radmwnfnh2@pali>
In-Reply-To: <20260821230620.fcpmn7radmwnfnh2@pali>
From: David Matlack <dmatlack@google.com>
Date: Mon, 24 Aug 2026 09:24:33 -0700
X-Gm-Features: AcwNN1XeHHaCMhereVaMF3FarogWmDkKRLNAh04LFSmzAm2WUcck41ZSA2SCJlM
Message-ID: <CALzav=dOumVYvjShjHHd1fydKMO1OX2w-ps4HEH5kBU7_3AVzg@mail.gmail.com>
Subject: Re: [pciutils PATCH v2] lspci: Determine bridge window address size
 from bridge_flags
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Martin Mares <mj@ucw.cz>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 4:06=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> Hello! Thank you for taking this issue. I briefly checked the change and
> I think that this is the right way how to address that issue.
>
> Anyway, it would be nice to provide some example of config space of PCI
> Bridge (lspci -x) which is affected by this issue and have it in
> pciutils/tests/ directory.

Ack, I will incorporate that into a v3.

> On Friday 21 August 2026 22:15:59 David Matlack wrote:
> > Use bridge_flags to determine address size bits (16- vs 32-bit for I/O,
> > 32- vs 64-bit for prefetchable memory) when displaying bridge ranges
> > populated via PCI_FILL_BRIDGE_BASES.
> >
> > Commit ccf68033a452 ("lspci: Use PCI_FILL_BRIDGE_BASES to detect if
> > range behind bridge is disabled or unsupported") introduced code in
> > show_htype1() that reads PCI_IO_RANGE_TYPE_MASK and
> > PCI_MEMORY_RANGE_TYPE_MASK from bridge_base_addr[]. However,
> > bridge_base_addr[] holds base addresses without flags, as documented in
> > lib/pci.h and implemented across backends like sysfs.c and
> > win32-cfgmgr32.c.
> >
> > Because bridge_base_addr[] does not contain configuration register flag
> > bits, masking the lower bits evaluates to zero. As a result, 32-bit I/O
> > windows are mislabeled as "[16-bit]" and 64-bit prefetchable memory
> > windows are mislabeled as "[32-bit]" when using PCI_FILL_BRIDGE_BASES.
> >
> > Fixes: ccf68033a452 ("lspci: Use PCI_FILL_BRIDGE_BASES to detect if ran=
ge behind bridge is disabled or unsupported")
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> > v2:
> >  - Fix lspci.c to use bridge_flags[], per lib/pci.h, rather than
> >    changing the behavior of just the sysfs backend (Pali Roh=C3=A1r)
> >
> > v1: https://lore.kernel.org/linux-pci/20260626213047.189951-1-bhelgaas@=
google.com/
> >
> >  lspci.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/lspci.c b/lspci.c
> > index 2a14303e74f6..52fd9247aefb 100644
> > --- a/lspci.c
> > +++ b/lspci.c
> > @@ -571,10 +571,9 @@ show_htype1(struct device *d)
> >
> >    if ((p->known_fields & PCI_FILL_BRIDGE_BASES) && !io_disabled)
> >      {
> > -      io_base =3D p->bridge_base_addr[0] & PCI_IO_RANGE_MASK;
> > +      io_base =3D p->bridge_base_addr[0];
> >        io_limit =3D io_base + p->bridge_size[0] - 1;
> > -      io_type =3D p->bridge_base_addr[0] & PCI_IO_RANGE_TYPE_MASK;
> > -      io_bits =3D (io_type =3D=3D PCI_IO_RANGE_TYPE_32) ? 32 : 16;
> > +      io_bits =3D (p->bridge_flags[0] & PCI_IORESOURCE_IO_16BIT_ADDR) =
? 16 : 32;
> >        show_range("\tI/O behind bridge", io_base, io_limit, io_bits, io=
_disabled);
> >      }
> >    else if (io_type !=3D (io_limit & PCI_IO_RANGE_TYPE_MASK) ||
> > @@ -600,7 +599,7 @@ show_htype1(struct device *d)
> >
> >    if ((p->known_fields & PCI_FILL_BRIDGE_BASES) && !mem_disabled)
> >      {
> > -      mem_base =3D p->bridge_base_addr[1] & PCI_MEMORY_RANGE_MASK;
> > +      mem_base =3D p->bridge_base_addr[1];
> >        mem_limit =3D mem_base + p->bridge_size[1] - 1;
> >        show_range("\tMemory behind bridge", mem_base, mem_limit, 32, me=
m_disabled);
> >      }
> > @@ -616,10 +615,9 @@ show_htype1(struct device *d)
> >
> >    if ((p->known_fields & PCI_FILL_BRIDGE_BASES) && !pref_disabled)
> >      {
> > -      u64 pref_base_64 =3D p->bridge_base_addr[2] & PCI_MEMORY_RANGE_M=
ASK;
> > +      u64 pref_base_64 =3D p->bridge_base_addr[2];
> >        u64 pref_limit_64 =3D pref_base_64 + p->bridge_size[2] - 1;
> > -      pref_type =3D p->bridge_base_addr[2] & PCI_MEMORY_RANGE_TYPE_MAS=
K;
> > -      pref_bits =3D (pref_type =3D=3D PCI_PREF_RANGE_TYPE_64) ? 64 : 3=
2;
> > +      pref_bits =3D (p->bridge_flags[2] & PCI_IORESOURCE_MEM_64) ? 64 =
: 32;
> >        show_range("\tPrefetchable memory behind bridge", pref_base_64, =
pref_limit_64, pref_bits, pref_disabled);
> >      }
> >    else if (pref_type !=3D (pref_limit & PCI_PREF_RANGE_TYPE_MASK) ||
> >
> > base-commit: b41ce14da749fb44ca7940ba9797027bfa62c23e
> > --
> > 2.55.0.766.g2966f0265a-goog
> >
>
