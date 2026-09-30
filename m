Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D81B511E96
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786974; cv=pass; b=J/f53qZBlYHllw6uOyYgSLl4YKshIx3ciRjY7NIGqPy+v0dWJecnFu5Jq+CnXC19gW7plqPf299t8W4Jul1nk9+o4JGOTf25Umn8F8cdkPPJnPWx5ifw9yo/g5mCkpfxT1urodGTFXWwUthngRIrOx15nlYYXDOE8mP6OIKymYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786974; c=relaxed/simple;
	bh=m/oaydNeB7KKez2Jzp2jljrx95qkFNgazQFseegu3Nw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qs8UhBodkD0chXvR+B8+jgXLrJJeVWgTEGUi3nrM+wTG2O4OMk1kwx2x+l7NTiAqYg7Lr5uWbbMVHXt80o1c9CHj+s3yr+Eno5yaAI8gJd6Mb7cO+b2IukwuceGYqnDb0oqMTjDNGqh5FQy9vlnOlKeR1YY6UPDlbc4jUokzdMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCcTd+DL; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCcTd+DL"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-910704e63a9so9175786d6.0
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 09:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790786971; cv=none;
        d=google.com; s=arc-20260327;
        b=BPIU3F3wuo0UmVfsIy7zwRIb58GEDjpk8EFjUGova2ddsaBvQHk7eA4B4dj3izIt1k
         XtdqCLrfxT5fNQnfyj/elOiz4HuD1rFRuBOcia46SAzOow2iEg9BRRU3xDxwU51pNsm1
         hz2UxL8K8DFdR/z23x3OQQDExFHmQcYbEHN9ONcOYSwENayPQhVwzSBPPw2n7jqZqOVB
         T0NT3d1y6pCf3eGDo0HC3xUDRzrugkjRqDzNVGTIfgHTK9IcqJCUSHiazL6MnZeKtj1p
         Wq0PlgYWDeFbDuJEUcxzx9KsscA4JTech12XZF07F9Q6n9irLkHgLIcwZA5CzX+kpFG2
         sliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=m/oaydNeB7KKez2Jzp2jljrx95qkFNgazQFseegu3Nw=;
        fh=MsmUWjvrFldjNQkb6zUzDeWCji/1mS6Y0MsGp4uEl0Q=;
        b=e1PFhMnfWgqoMGqWWnLU5SngesmB+hRAykYeVNgpO2l0ddhOKyEu2gK6heVfgm3+4Y
         7bCfeHtwPCwp/oL+2NtU6TY3p2gLmHwHF6omTfip5NUgulq+5hdOCRgJVB+BDczruSLs
         qL6++sVZ5JqKAmhlPnykvINnwY2qEHX85wCyZViKyEWazyIjW45vitTFoOvDtgxG1mJZ
         Bbe7XYthlg4VhFZnkSL59TN2704n7VtHN7dRNgUUFHpkx6X5Yb3ZOnDnUCns6PzapFtc
         qOiZ0FH2eTGhG6azKY+dV0nlGS0PDExKw81lGn3CyfY/7QBqfaHzyxyc+6ehbxMHfrux
         eTig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790786971; x=1791391771; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m/oaydNeB7KKez2Jzp2jljrx95qkFNgazQFseegu3Nw=;
        b=tCcTd+DLGs9sBdlnQcXaucopfITBrPe8XKjYki/asPhXRYRLkfn235gBE0TPPTgYZd
         Kqh27H9NiszDnZVQFl3NvUeTlJfFSoaw7a1DA9Hmyrp5b/Qr0LTBYDNzOjMXjaRvIab3
         afU6ljijFKYgKAXyOyOvz9MNq08Aq9dxgFCbZVeM3yIw+ZALhtIavcPtMo4dFXI8MMaw
         zf4LkB3YbZ75tpeb1WpjFiqx8lvm9vTF3LdIM/o2FSQGa76srPKMG62qeBJR6dAohaUP
         XoA0tj3H4+lHp4+0FSjloYcCbdW4qr2Qaax6XEeHezQSFuXxoUHLY5/4udcVtKIZDUW2
         sEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790786971; x=1791391771;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m/oaydNeB7KKez2Jzp2jljrx95qkFNgazQFseegu3Nw=;
        b=SnwWZI2m0G6haDDHn8TEvdHvCzeSS2VRdai8NBORmrvh/uppn8Fvvdjfjrqek4J3gL
         5IfgQ5d8oI2eD7Yn8QXgL9oqKYOQ4vUPL6Agm91P8pQpBJiutDcTOHNU1vAPcLb2ZZP+
         ULgAv1kPNyL3eMxnftovgwke0lHET7yKONq2cJM34XPEQmTyI6Y8rKHyjqupp0LuUhRC
         KxeSR9Z4SWLBfv0ZQ2Qd1BP/g8e/jK3M3iYWIrAH72Q9WAoeG+xVwuPzvB7ssBdim5LT
         1OzjOhjkx1GOcV2Pb4iUy/GOolFRarVRhGFYmrVdgcgpzEJN8uj8Ww7jIUDHEvz11yyQ
         qZrA==
X-Forwarded-Encrypted: i=1; AKwUvBysMqF37ysg0N3HxRrWzEeCCqL1eMXC7SIlvnjr/kA8CITOTXHNBHtKEM4rCzZE6DpfOTPEKb4tILo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLO7PBdsd01dHfP+UdfTg3yBSVcoyx57zmZ2MmQkwYRQx+rbZ7v
	G2TB0Yicf8pwy2A4YDMtDAhXCmIj2C3X7k+JHJfEZv1LKyXpW32xkOUbj1D1tw85fpUIS1uBbkY
	fcP21dFK1qddo6e00cYrd9vfrfYgXRyk=
X-Gm-Gg: AYBFou3XENcZ0RGwdqW0tDGnmP2NzzlPb3C0GdYxGM7FkAsUylJ1dg2pR6n+w8uNsF0
	Gz7/3WkSFr4jH1RUyjOmcV72xzSjcCrce8uo1xfPGtXjLH50vJXCsVTJdHpo2ux+pttVDSY6FQH
	66cLXODXUbiMswvMMtxrfPreugqOiYhew1LtsQPPUlSeOBisk7lmItxrJw3+4HJLliDsB1T/uxV
	2iW7m4bZby9KnCGcyW1bAPH/LJxb1HqR1DNP0ce1mMyQzddjboFXJXhqlLKitpSik+px3JFMt/J
	03bsNy6oJTz3RRrC00beTMXIHrn80OiHDahUa/O6E8swG4ak2NSbmCtqu6TZEsThHr7nrM/SK6c
	agJhkwCG4qIPqVmXdaDZOR0fwP+ao7seUvY002Je7B00n
X-Received: by 2002:a05:6214:54c5:b0:90c:a989:a68a with SMTP id
 6a1803df08f44-917aa2f093bmr3499616d6.11.1790786971288; Wed, 30 Sep 2026
 09:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Claudio Gratton <cla20gra@gmail.com>
Date: Wed, 30 Sep 2026 18:49:19 +0200
X-Gm-Features: AclHuK8KG73Rdozl3C21tUCJ3Qj_vy52lU6tUV5dAYIHAggwiXb0lvze3F5m_BU
Message-ID: <CAGohoTay793z6HftCY-1m+DP0yCJ1eeB+q4p5-z7+bOnrOWOCQ@mail.gmail.com>
Subject: mt7925e: endpoint keeps a stale zero-latency LTR after s2idle resume,
 blocks package C6/C10 (Panther Lake laptop)
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I may have found a resume issue with the MT7925 PCIe Wi-Fi card
(mt7925e) on a Panther Lake laptop. I am not sure whether the driver,
the firmware or the platform is at fault, so I'm asking here first.
Everything below is marked either "measured" or "guess".

Hardware / software
- HP OmniBook 7 14-hg0xxx, Core Ultra X7 358H (Panther Lake), Wi-Fi/BT
MT7925, mt7925e at 0000:2c:00.0, root port 0000:00:1c.0
- Reproduced on Arch linux 7.2.3.arch1-3 and on linux-omarchy 7.2.5-3
(Arch config plus patches). Not tested on a vanilla mainline kernel.

Symptom (measured)
- Fresh boot: the PMC LTR table (/sys/kernel/debug/pmc_core/ltr_show)
shows SOUTHPORT_B = 0x0 and the package reaches PC10 at idle.
- After the first s2idle resume in a boot, SOUTHPORT_B reads
0x80008000 (valid, zero latency) and stays there. The package then
stays in PC2 (PC6/PC10 residency 0%) although everything else is idle.
- Idle power on battery is roughly 0.5 W higher while it is stuck
(about 3.1-3.6 W vs 2.0-3.1 W, screen on). I also changed other things
in the same period (a Bluetooth autosuspend workaround), so treat the
0.5 W as approximate. With "echo 1 > ltr_ignore" the package reaches
PC10 again.

Why I think it is this Wi-Fi card (measured)
- Unloading mt7925e changes SOUTHPORT_B to a constant 0x88418841.
- Toggling the Wi-Fi radio (rfkill), NVMe I/O bursts and an empty USB4
port do not change it.

State across the resume (measured, one suspend cycle, "systemctl suspend")
- Before suspend: SOUTHPORT_B = 0x0.
- Immediately after resume, before any userspace hook: SOUTHPORT_B = 0x80008000.
- Endpoint 2c:00.0 stays in D0; DevCtl2 = 0x0409 (LTR Mechanism Enable
set) and the LTR capability max snoop/no-snoop latency 0x100f/0x100f
are identical before and after.
- Root port 00:1c.0: DevCtl2 = 0x0400 and LnkCtl = 0x0c43, unchanged.
- No kernel messages from mt7925e or PCI during the resume.

Workaround that fixes it (measured)
- About 6 s after resume, clear and re-set DevCtl2 bit 10 (LTR
Mechanism Enable) on the endpoint, 0.3 s apart:
setpci -s 2c:00.0 CAP_EXP+0x28.w=<old & ~0x0400>; sleep 0.3; setpci -s
2c:00.0 CAP_EXP+0x28.w=<old>
The endpoint then sends a fresh LTR message, SOUTHPORT_B returns to
0x0 and PC10 residency comes back (about 28% of samples in my run,
idle 1.99 W with the screen on).
- I run it from a systemd-sleep hook as a stop-gap. It has fixed the
state after every resume I have tried, including a repeat this
afternoon.

What I do not know (guess)
- My guess is that the chip or its firmware re-sends a "0 latency" LTR
message at resume and never sends the update. I cannot rule out that
the driver or the platform leaves something unprogrammed; the
unchanged config space only shows that it is not a PCI-level
difference I can see.
- I have not checked whether other MT7925/MT7922 platforms, or
Intel/AMD systems, show the same.

Questions
1. Has anyone seen the same behaviour, and is it known on the firmware side?
2. If it is a driver issue, would re-triggering the LTR message at
resume (as above) be acceptable in mt7925e, or is there a cleaner way?

I can provide full logs, run patches or test firmware versions.

Thanks,
Claudio Gratton
