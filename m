Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794740739;
	b=d3thsggoR3qQOAG2tAgkUSWl5vvNZNuVxockNPH7GZJSG4kIlzwt5Gi44x5FH1P3KD25
	 i0Th1slYCgSNLV+5TX6izdyCpbcJme30LuSHWU1pj9u4kOHdE3rKdRm3xP5M5BajAngbW
	 ShLwSKgOnNxPG3QWTFzRZrAIzD054DNaXR33TjKdBYX3hHg5RFFGo2F8szDGJro/8DaFD
	 aHwSjT9ml9StKM6GacA9ITGoo9CUQnNGITVShIVWQkBeQ2+5Qd4xtCBmwfaV9JslpjyZl
	 ArRHuVp8Nv78383jUZrVU+YXA4A52b3ZrXUIdWoUCfAmYOUWrBCg5sGZIPmaFI248SQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794740739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=xhc2X9EBtCDiImEay3p12HtOvn6I3vTCufPg8Dq4tWI=;
	b=XVlflXlyESjvJylcJpzfZJPBQFwOR5AyQBGaAapFm8zCdIVL1fIuaLkUXwu0FAJFaSng
	 xq+DmnLC7oeHxJVFLpu3vgrEnQZaNQtyyYrvPcc/+saZviamttlsugjV6qbVTgwONvpY8
	 AAkJGXAu7fTw+xDX7Hqoyy9V6La+9Vtl+NefuNfbOIfCD4L7WqMp9o6nr6LuHtYHVw3Ti
	 UhupqUnebw0Y9/H0CQpu+XDMGZ0kflRavhZP5NqSnLLQ2n8NaLf10pEl+PyOmNYKVaBA0
	 C9PhFMDNOhNBJoIPV2FL/WaubR1KQmvhCRRznJgofD0dvndbb+8zE5G1qqZvFfaXUIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hoULKyuS;
	arc=fail smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268D4606A31A
	for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2026 11:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 268D4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hoULKyuS
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1357912b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2026 03:05:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794740736; cv=none;
        d=google.com; s=arc-20260327;
        b=aScmrBb440kT8Le30/Ji5Cu4GqmAwjlRCWZemRLess1mqvhW+t4vJdOsso2ZA1fWJb
         EhWeRb76r7eLh3r3umUJxKfD6uVzAUBRwo/PpJO9d7BZu9pT373wnrxOAJkSYaHJQRzU
         TGNaF4QWfcsvROymMKU7fFmyASjEv8dYEwDG7TgnRj9YyuGm23/5EprlcgblCpsw94+T
         6wVpTUtwfBHm1PTAeMk9K+ZdTJbo7TgkqSusY2OZcm12BRRIoE7fmdeytC0hWHpS2oD2
         zq7DU2wX7zFR3XUrFji5k305QGTPWMh3qNivibL5QR+FKQf6mk0Vc0qYe3/Tkb/C9ZlS
         SzDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=xhc2X9EBtCDiImEay3p12HtOvn6I3vTCufPg8Dq4tWI=;
        fh=UzstcCk/yTeyhIFp+XpHe9VrmdZdzSXhR5nf2W2yxB8=;
        b=VvbG8NNkNVoJA7FpazZRheNtQTaOyaVFqZLhPX016eddLHDyalAYtBGdOBUSjsAXIr
         KYobWTEE1VQzd1ZoDKS4EW9Jn927/YC1VzlS5YHZgIG3Lonnvb2fKGxBvMTFZ0/e7oHm
         hi6/Gra6s2Tyh6/WWtaTHeeYuFi8zHoRQ6X7XjTf5sSD1GIyOAUI5LKgUvss3Xm68fdd
         qHvnoT3sGGRBsQtmd5OBIsEs217XNrZMpKHIRLpbeIi/y9fWEJDaz6K3Bg2BIK/jHORZ
         BwcTm1bv2BMlLS3APhK5ZIN0eFGfSf9DOhya+5Gin2933OFj2vUWEBwDcHdUsbdYBCPU
         L1Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794740736; x=1795345536; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xhc2X9EBtCDiImEay3p12HtOvn6I3vTCufPg8Dq4tWI=;
        b=hoULKyuSVYcAQrHKAr6HO+2WR3blNyvJyMVjYeG8e17rRgAKofQ2mg9VrYvMQtzdVq
         tNeepeYlldCaMIhp3dgvuEqFddSY4q+Bq7c5xhY9Iv6V9kWiHjuy3Yiu+TpDOz7RBJ4C
         CbQvAck9+Ugmk0rtyl5L73ggiHxO9PCKs0Xp5P696PeSvqtB+dkN9/Y+pab8TKttme4H
         CBDuz7me97lUeKcQPnWg88jsWgRVdifsv12C3HfgqbuWouMKEZZGYkeM+8M786i3eTa5
         g59bykasICeE2P+Ik5AMIr0vTnohO/Xl01Lr/b93YNiiAhxeFkaT02/HGhEvy1pMLFcB
         czvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794740736; x=1795345536;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xhc2X9EBtCDiImEay3p12HtOvn6I3vTCufPg8Dq4tWI=;
        b=PcYXowqa7bh/7JlqZo3SE0Z5Ao+cbX7jUe/ZKwLhGLaqdX/HeruKYTtJyHWunDuvA0
         kPlNjZQLtrBiq7558dJgjUfVZU6ldqGCzV1+lBMaJ2tOlvf30AkKLSH38x9bY5avu3O8
         y2IlFMKhoxdONy11TTm/X0wbYXEb9JYLXC7BUBaw3/IBC5oYHWqEdNGaQrJUuBLY4CXe
         s6/anVulsa3HmFB20EcfqBKJ21weoh8eGbdl4LtlZ3uw2c2nD4Z2o65ju9JseqrMmJyb
         8aucDX18zOSRumiFCjhhdeere19ZOACHminxUesY3CLKBkbPlW727cKhOjRfzkMvgRtK
         jbBg==
X-Forwarded-Encrypted: i=1; AL+hErFfIJnUpnx/epbUjeRBu2YG+q1Ahsfap/Ik3VR5oeNgI/1gwFZhQwRMMgq/mHdBqjcbheX/0EAqq7g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YmL/3CW6fCtHzDXxRoKnOOdVJBazK+KnH8MJM0xV/r7CrkBp1
	uQUCbVU+d0bTx68NAaLfM6K51ipx7LUE0RbkplcpxqabYLwUI0lQeJ4z2cZDBXFdbVDftg56zTL
	Zc9bXDeuVfegCT4gN4MtSa4ouPbf0Irw=
X-Gm-Gg: AYBFou1/DQlH22VQLObWJYuJ5+8IbNsKj04X0A5D84QJmh7J5WuSccxQhpZS0mJwcm/
	iF4xcNuo2jKK4+FkXyzOVNYz5r6mO/ygDRhR84QGoLLXc0d5gEGdhvQKDKPwmAIOd4S7PFtNblP
	Za3uADWiCts6a+qSFjZ8QC91xr2oVtxFM9fVOBvsbW+KxvpkUpN7V5TtAOqg7rlGhL9iMYMFqDU
	EIT4ttff+L+Dd6JNAaQvZPYDzegBmdwv2fv3PBAvx9iiPQOY5bGtR4JBvU6mTd+TSALmZyoCUYf
	oNjWTw5x9a04XZgit+oJ/OWfI6fNs0NeEtxQ84/yGKYZ8+uh3QXo2yrkK1Tj/PVF7OopjdmKI01
	QKG8ZmVR6/ZNRq/mOxqIdBH/zmsDQOdA+KIb58mNE0aA5N3AIALWKpFm1PlDVUkPSKp4=
X-Received: by 2002:a05:6a00:92a1:b0:89d:ec58:ce47 with SMTP id
 d2e1a72fcca58-8beb93aa5cbmr7437580b3a.55.1794740735291; Sun, 15 Nov 2026
 03:05:35 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CALJR0neXyeDb2t3j=CvdK42xwc6Afbo6kQfROedspHuWTZOq6g@mail.gmail.com>
 <20261112211151.GA893502@bhelgaas>
In-Reply-To: <20261112211151.GA893502@bhelgaas>
From: hh c <hhc436476@gmail.com>
Date: Sun, 15 Nov 2026 19:05:21 +0800
X-Gm-Features: AclHuK_8YwoTf5NEYaVpA39arts-8czcrwhKpa1T-kiY-yEllzp9sZdubFYtJ9U
Message-ID: <CALJR0ndj=stbvgRzwzH+u3tGXxuAM1hNZjYh9A_xSMCZ47RRzw@mail.gmail.com>
Subject: Re: 6.8.0-149: forced 2.5GT/s->5GT/s root-port retrain drops XGI Z11
 VGA off the bus, local console goes black
To: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000fddadf06604ea356"

--000000000000fddadf06604ea356
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[cc Maciej, linux-pci, linux-kernel]

> It would be helpful if you could confirm that reverting
> 72780f796468 fixes it.

Confirmed.  Same machine model, third unit (Huawei XH320 V2, XGI Z11
[18ca:0027], BIOS RMIBV519 2018-06-22), vanilla v7.3.4 source, Ubuntu's
own v7.3.4 .config taken from linux-headers-7.3.4-070304-generic, and a
single change: the lift in pcie_failed_link_retrain() is gated again.

A literal revert no longer applies to v7.3.4, because the function was
restructured after 72780f796468 (the pcie_get_speed_cap() early return,
and the early return for a clamped port with no link).  So I put back
what that commit removed - the DLLLA check, the ids[] allowlist and the
comment paragraph describing them - and touched nothing else:

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -120,7 +125,9 @@
  }

  pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
- if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) =3D=3D PCI_EXP_LNKCTL2_TLS_2_5GT) {
+ if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
+    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) =3D=3D PCI_EXP_LNKCTL2_TLS_2_5GT &&
+    pci_match_id(ids, dev)) {
  pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
  ret =3D pcie_set_target_speed(dev, speed_cap, false);
  if (ret)

plus the static ids[] =3D { ASMedia ASM2824 } table and the comment block
(full 40-line diff attached).

Both kernels were booted on the same machine with grub-reboot, so the
only variable is that hunk:

  kernel              PCI devs   18ca:0027   00:1c.3 TLS    00:1c.3 link
  -------------------------------------------------------------------------
  6.8.0-31 (Ubuntu)   79         present     2.5GT/s        2.5GT/s, DLActi=
ve+
  7.3.4 (mainline)    78         absent      5GT/s raised   2.5GT/s, DLActi=
ve-
  7.3.4 + change      79         present     2.5GT/s        2.5GT/s, DLActi=
ve+

  dmesg, 7.3.4:
    pci 0000:00:1c.3: removing 2.5GT/s downstream link speed restriction
    (and no 0000:07:00.0 line at all)

  dmesg, 7.3.4 + change:
    no "removing 2.5GT/s ..." message, and the endpoint comes up normally:
    pci 0000:07:00.0: [18ca:0027] type 00 class 0x030000 PCIe Endpoint
    pci 0000:07:00.0: BAR 0 [mem 0x90000000-0x93ffffff pref]

The local console works in the patched kernel and is black in plain
v7.3.4, which matches the BAR layout: the firmware framebuffer sits at
90000000, inside the endpoint's own BAR, behind that link.

To be precise about the earlier report: I never bisected it.  The
attribution to 72780f796468 came from comparing this function in the
working and the failing kernel, and this revert test is the first direct
evidence for it.  Sorry for not saying that clearly the first time.

The mechanism, as it looks from here: firmware leaves the root port's
Target Link Speed at 2.5GT/s because the endpoint is a Gen1 2.5GT/s-only
device.  Before 72780f796468 that clamp was only lifted for the ASM2824
allowlist; now any downstream port with TLS=3D=3D2.5GT/s and LnkCap > 2.5GT=
/s
is lifted unconditionally, so the C600 PCH is asked to train Gen2 against
a Gen1-only endpoint, the training fails, and the link is down for good -
the endpoint never comes back, not even after a later retrain.

Which direction would you prefer for a fix?

  (a) keep the clamp when the device behind the port advertises 2.5GT/s
      only, i.e. only lift when the link partner can actually use it;

  (b) restore the previous target speed and retrain when the lift fails
      on a port that has a device behind it, as the commit already does
      for the failed clamp path.

I still have this machine and can test either on the same day.

Attached:
  dmesg-7.3.4-revert.txt           full dmesg, patched v7.3.4
  lspci-00-1c.3-7.3.4-revert.txt   lspci -vvv, root port 00:1c.3
  lspci-07-00.0-7.3.4-revert.txt   lspci -vvv, endpoint 07:00.0
  revert-72780f796468.diff         the change applied on top of v7.3.4
  boot-7.3.4-070304-generic.txt    uname/pci count/LnkCtl2, failing boot
  boot-7.3.4-revert.txt            same for the patched boot

I did not keep a full dmesg of the failing mainline boot, only the
summary above - say the word and I will re-boot it and capture one.

Thanks,
chh <hhc436476@gmail.com>

Bjorn Helgaas <helgaas@kernel.org> =E4=BA=8E2026=E5=B9=B411=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=BA=94 05:11=E5=86=99=E9=81=93=EF=BC=9A
>
> [+cc Maciej, regressions list, -cc stable]
>
> On Thu, Nov 12, 2026 at 09:28:25PM +0800, hh c wrote:
> > > These results appear to be on Ubuntu kernels, which upstream has no
> > > influence over.  If you can reproduce the issue with recent unmodifie=
d
> > > upstream kernels, e.g., v7.3, please report as a regression.
> >
> > Reproduced on vanilla v7.3.4 (upstream tarball, no patches), on the sam=
e
> > machine model but a different unit, with a different BIOS (RMIBV519,
> > 2018-06-22, versus RMIBV510, 2015-07-10 on the machine I first reported
> > from), so this is not a one-off firmware or board artefact.
>
> Initially reported at
> https://lore.kernel.org/all/CALJR0nehJ5+d7MrPk8rxkNmee_1L5FFsvuF+-swK1nyJ=
7oJJ8A@mail.gmail.com
> on an Ubuntu kernel and attributed to 72780f796468 ("PCI: Always lift
> 2.5GT/s restriction in PCIe failed link retraining"), though as far as
> I can see it was not actually bisected to 72780f796468.
>
> Thanks for confirming that it affects vanilla v7.3.4 (not just
> Ubuntu).  It would be helpful if you could confirm that reverting
> 72780f796468 fixes it.
>
> >   Linux 7.3.4-070304-generic #202611102049 SMP PREEMPT_DYNAMIC
> >   Huawei XH320 V2, C600/X79 PCH, XGI Z11/Z11M VGA [18ca:0027]
> >
> >   # lspci -nn | grep -i vga
> >   (nothing)                       <- the VGA endpoint is never enumerat=
ed
> >   # lspci -nn | wc -l
> >   78                              <- 79 on a kernel that keeps the cons=
ole
> >
> >   # dmesg | grep -E '2.5GT/s|retrain'
> >   pci 0000:00:1c.3: removing 2.5GT/s downstream link speed restriction
> >
> >   # lspci -vv -s 00:1c.3
> >   LnkCap:  Port #4, Speed 5GT/s, Width x1
> >   LnkSta:  Speed 2.5GT/s, Width x1
> >            DLActive-                       <- link is down after the re=
train
> >   LnkCtl2: Target Link Speed: 5GT/s        <- raised, and left raised
> >
> > This is the case the existing "clamped port with no link" handling does
> > not cover, and v7.3.4 shows it cleanly:
> >
> >   - 00:1c.0 and 00:1c.2 (empty ports, target speed also clamped to
> >     2.5GT/s) print nothing at all, so the early return for clamped port=
s
> >     without a link does its job.
> >
> >   - 00:1c.3 has DLLLA set, so that early return is skipped and the
> >     unconditional lift is reached.  The fact that it printed "removing
> >     2.5GT/s ..." at all proves the link was up: with the link down and
> >     the target clamped, the function returns before the message.
> >
> >   - pcie_set_target_speed() reports success, so no "retraining failed"
> >     is printed and the firmware's target speed is never restored.  The
> >     port ends up with the target raised to 5GT/s and DLActive clear, an=
d
> >     the endpoint is off the bus for the rest of the boot.
> >
> > The clamp is the correct steady state here: LnkCap of 07:00.0 is
> > 2.5GT/s, the PCH cannot train Gen2 against a Gen1-only endpoint, and th=
e
> > failed attempt takes the device down permanently - the display controll=
er
> > does not come back until a platform reset.  The console is black rather
> > than merely blank because the firmware framebuffer sits inside the
> > endpoint's own BAR, behind the dead link:
> >
> >   90000000-93ffffff : 0000:07:00.0
> >     90000000-9012bfff : BOOTFB
> >       90000000-9012bfff : simpledrm
> >
> > so the machine still boots and stays reachable over the network, with n=
o
> > local console at all.  Same behaviour as the distro kernel I originally
> > reported, now on an unmodified upstream kernel.
> >
> > Would a patch be acceptable that either (a) keeps the clamp when the
> > downstream device advertises 2.5GT/s only, or (b) restores the previous
> > target speed and retrains when the lift to a higher speed fails on a po=
rt
> > that has a device behind it?  I have this machine available and can tes=
t
> > a patch the same day.
> >
> > Attached: full dmesg and lspci -vvv of 00:1c.3 from v7.3.4, plus the
> > same from 6.8.0-31 where the console works.
> >
> > Thanks,
> >
> > Greg KH <greg@kroah.com> =E4=BA=8E2026=E5=B9=B411=E6=9C=8812=E6=97=A5=
=E5=91=A8=E5=9B=9B 20:27=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Thu, Nov 12, 2026 at 12:09:07AM +0800, hh c wrote:
> > > > After upgrading from 6.8.0-31 to 6.8.0-149 on a Huawei XH320 V2 (Ro=
mley
> > > > platform, C600/X79 PCH), the local console goes black at kernel han=
dover.
> > > > The machine boots, SSH works, getty@tty1 is active. Booting the SAM=
E
> > > > installation into 6.8.0-31 restores both the console and the VGA de=
vice,
> > > > so this is a regression in the 6.8 SRU stream, not a hardware or BM=
C fault.
> > >
> > > 6.8.0 is very old and obsolete and insecure.  Please use a newer kern=
el
> > > version.
> > >
> > > > ROOT CAUSE
> > > >
> > > > 6.8.0-149 carries the stable backport of upstream commit 72780f7964=
68
> > >
> > > ah, you are using a distro kernel.  Please file a bug with them.
> > >
> > > thanks,
> > >
> > > greg k-h
>
> > 00:1c.3 PCI bridge: Intel Corporation C600/X79 series chipset PCI Expre=
ss Root Port 4 (rev b6) (prog-if 00 [Normal decode])
> >       Subsystem: Huawei Technologies Co., Ltd. C600/X79 series chipset =
PCI Express Root Port 4
> >       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx+
> >       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
> >       Latency: 0, Cache Line Size: 64 bytes
> >       Interrupt: pin D routed to IRQ 33
> >       IOMMU group: 20
> >       Bus: primary=3D00, secondary=3D07, subordinate=3D07, sec-latency=
=3D0
> >       I/O behind bridge: 2000-2fff [size=3D4K] [16-bit]
> >       Memory behind bridge: 94500000-945fffff [size=3D1M] [32-bit]
> >       Prefetchable memory behind bridge: 90000000-93ffffff [size=3D64M]=
 [32-bit]
> >       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- <SERR- <PERR-
> >       BridgeCtl: Parity- SERR+ NoISA- VGA+ VGA16- MAbort- >Reset- FastB=
2B-
> >               PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> >       Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> >               DevCap: MaxPayload 128 bytes, PhantFunc 0
> >                       ExtTag- RBE+
> >               DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> >                       RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> >                       MaxPayload 128 bytes, MaxReadReq 128 bytes
> >               DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+=
 TransPend-
> >               LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit=
 Latency L0s <512ns, L1 <4us
> >                       ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
> >               LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
> >                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >               LnkSta: Speed 2.5GT/s, Width x1
> >                       TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> >               SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- =
Surprise-
> >                       Slot #3, PowerLimit 10W; Interlock- NoCompl+
> >               SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- H=
PIrq- LinkChg-
> >                       Control: AttnInd Unknown, PwrInd Unknown, Power- =
Interlock-
> >               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+=
 Interlock-
> >                       Changed: MRL- PresDet+ LinkState+
> >               RootCap: CRSVisible-
> >               RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEn=
a+ CRSVisible-
> >               RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> >               DevCap2: Completion Timeout: Range BC, TimeoutDis+ NROPrP=
rP- LTR-
> >                        10BitTagComp- 10BitTagReq- OBFF Not Supported, E=
xtFmt- EETLPPrefix-
> >                        EmergencyPowerReduction Not Supported, Emergency=
PowerReductionInit-
> >                        FRS- LN System CLS Not Supported, TPHComp- ExtTP=
HComp- ARIFwd-
> >                        AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
> >               DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LT=
R- 10BitTagReq- OBFF Disabled, ARIFwd-
> >                        AtomicOpsCtl: ReqEn- EgressBlck-
> >               LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- Speed=
Dis-
> >                        Transmit Margin: Normal Operating Range, EnterMo=
difiedCompliance- ComplianceSOS-
> >                        Compliance Preset/De-emphasis: -6dB de-emphasis,=
 0dB preshoot
> >               LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationC=
omplete- EqualizationPhase1-
> >                        EqualizationPhase2- EqualizationPhase3- LinkEqua=
lizationRequest-
> >                        Retimer- 2Retimers- CrosslinkRes: unsupported
> >       Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
> >               Address: fee00378  Data: 0000
> >       Capabilities: [90] Subsystem: Huawei Technologies Co., Ltd. C600/=
X79 series chipset PCI Express Root Port 4
> >       Capabilities: [a0] Power Management version 2
> >               Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,=
D2-,D3hot+,D3cold+)
> >               Status: D3 NoSoftRst- PME-Enable+ DSel=3D0 DScale=3D0 PME=
-
> >       Kernel driver in use: pcieport
> >       Kernel modules: shpchp
> >
>
> > [    0.000000] Linux version 7.3.4-070304-generic (kernel@balboa) (x86_=
64-linux-gnu-gcc-15 (Ubuntu 15.3.0-4ubuntu1) 15.3.0, GNU ld (GNU Binutils f=
or Ubuntu) 2.47) #202611102049 SMP PREEMPT_DYNAMIC Wed Nov 11 00:34:56 UTC =
2026
> > [    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-7.3.4-070304-generic=
 root=3D/dev/mapper/ubuntu--vg-ubuntu--lv ro
> > [    0.000000] KERNEL supported cpus:
> > [    0.000000]   Intel GenuineIntel
> > [    0.000000]   AMD AuthenticAMD
> > [    0.000000]   Hygon HygonGenuine
> > [    0.000000]   Centaur CentaurHauls
> > [    0.000000]   zhaoxin   Shanghai
> > [    0.000000] BIOS-provided physical RAM map:
> > [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009cfff]  =
System RAM
> > [    0.000000] BIOS-e820: [mem 0x000000000009d000-0x000000000009ffff]  =
device reserved
> > [    0.000000] BIOS-e820: [gap 0x00000000000a0000-0x00000000000dffff]
> > [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff]  =
device reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003fffffff]  =
System RAM
> > [    0.000000] BIOS-e820: [mem 0x0000000040000000-0x00000000400fffff]  =
device reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000040100000-0x000000007e4fefff]  =
System RAM
> > [    0.000000] BIOS-e820: [mem 0x000000007e4ff000-0x000000007e8fefff]  =
device reserved
> > [    0.000000] BIOS-e820: [mem 0x000000007e8ff000-0x000000007eefefff]  =
ACPI NVS
> > [    0.000000] BIOS-e820: [mem 0x000000007eeff000-0x000000007effefff]  =
ACPI data
> > [    0.000000] BIOS-e820: [mem 0x000000007efff000-0x000000007effffff]  =
System RAM
> > [    0.000000] BIOS-e820: [mem 0x000000007f000000-0x000000008fffffff]  =
device reserved
> > [    0.000000] BIOS-e820: [gap 0x0000000090000000-0x00000000feafffff]
> > [    0.000000] BIOS-e820: [mem 0x00000000feb00000-0x00000000feb03fff]  =
device reserved
> > [    0.000000] BIOS-e820: [gap 0x00000000feb04000-0x00000000febfffff]
> > [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff]  =
device reserved
> > [    0.000000] BIOS-e820: [gap 0x00000000fec01000-0x00000000fed17fff]
> > [    0.000000] BIOS-e820: [mem 0x00000000fed18000-0x00000000fed18fff]  =
device reserved
> > [    0.000000] BIOS-e820: [gap 0x00000000fed19000-0x00000000fed1bfff]
> > [    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed8ffff]  =
device reserved
> > [    0.000000] BIOS-e820: [gap 0x00000000fed90000-0x00000000fedfffff]
> > [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff]  =
device reserved
> > [    0.000000] BIOS-e820: [gap 0x00000000fee01000-0x00000000ffbfffff]
> > [    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff]  =
device reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000047fffffff]  =
System RAM
> > [    0.000000] NX (Execute Disable) protection: active
> > [    0.000000] APIC: Static calls initialized
> > [    0.000000] DMI: SMBIOS 2.7 present.
> > [    0.000000] DMI: Huawei Technologies Co., Ltd. XH320 V2/BC21RCSA0, B=
IOS RMIBV519 06/22/2018
> > [    0.000000] DMI: Memory slots populated: 1/12
> > [    0.000000] tsc: Fast TSC calibration using PIT
> > [    0.000000] tsc: Detected 1800.068 MHz processor
> > [    0.002117] e820: update [mem 0x00000000-0x00000fff] System RAM =3D=
=3D> device reserved
> > [    0.002122] e820: remove [mem 0x000a0000-0x000fffff] System RAM
> > [    0.002137] last_pfn =3D 0x480000 max_arch_pfn =3D 0x400000000
> > [    0.002151] MTRR map: 9 entries (4 fixed + 5 variable; max 24), buil=
t from 10 variable MTRRs
> > [    0.002155] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC=
- WT
> > [    0.002646] last_pfn =3D 0x7f000 max_arch_pfn =3D 0x400000000
> > [    0.020904] found SMP MP-table at [mem 0x000fe1b0-0x000fe1bf]
> > [    0.020934] Using GB pages for direct mapping
> > [    0.021464] RAMDISK: [mem 0x2f775000-0x33bb1fff]
> > [    0.022505] ACPI: Early table checksum verification disabled
> > [    0.022513] ACPI: RSDP 0x00000000000FE020 000024 (v02 INSYDE)
> > [    0.022521] ACPI: XSDT 0x000000007EFFE170 0000AC (v01 INSYDE Romley =
  00000001      01000013)
> > [    0.022553] ACPI: FACP 0x000000007EFFB000 0000F4 (v04 INSYDE Romley =
  00000001 ACPI 00040000)
> > [    0.022598] ACPI: DSDT 0x000000007EFE9000 00DEE2 (v01 INSYDE Romley =
  00000000 ACPI 00040000)
> > [    0.022604] ACPI: FACS 0x000000007ED89000 000040
> > [    0.022609] ACPI: FACS 0x000000007ED89000 000040
> > [    0.022615] ACPI: SPMI 0x000000007EFFD000 000040 (v05 INSYDE Romley =
  00000001 ACPI 00040000)
> > [    0.022623] ACPI: BOOT 0x000000007EFFC000 000028 (v01 INSYDE Romley =
  00000001 ACPI 00040000)
> > [    0.022629] ACPI: APIC 0x000000007EFF9000 000BAA (v03 INSYDE Romley =
  00000001 ACPI 00040000)
> > [    0.022636] ACPI: MCFG 0x000000007EFF8000 00003C (v01 INSYDE Romley =
  00000001 ACPI 00040000)
> > [    0.022643] ACPI: SLIC 0x000000007EFF7000 000176 (v01 INSYDE Romley =
  00000001 ACPI 00040000)
> > [    0.022650] ACPI: BDAT 0x000000007EFE8000 000030 (v01 INSYDE Romley =
  00000001 ACPI 00040000)
> > [    0.022657] ACPI: PRAD 0x000000007EFE7000 0000BC (v02 INSYDE Romley =
  00000001 ACPI 00040000)
> > [    0.022664] ACPI: MSDM 0x000000007EFE6000 000055 (v03 INSYDE Romley =
  00000001 ACPI 00040000)
> > [    0.022671] ACPI: SSDT 0x000000007EF12000 0D3050 (v02 INSYDE Romley =
  00004000 ACPI 00040000)
> > [    0.022678] ACPI: HPET 0x000000007EFFA000 000038 (v01 INSYDE Romley =
  00000001 ACPI 00040000)
> > [    0.022685] ACPI: WDAT 0x000000007EF11000 000194 (v01 INSYDE INSYDE =
  00000001 MSFT 01000013)
> > [    0.022692] ACPI: DMAR 0x000000007EF10000 0000A0 (v01 INSYDE Romley =
  00000001 ACPI 00000001)
> > [    0.022699] ACPI: HEST 0x000000007EF0F000 0000A8 (v01 INSYDE Romley =
  00000001 ?    00000001)
> > [    0.022706] ACPI: ERST 0x000000007EF0E000 000230 (v01 INSYDE Romley =
  00000001 ?    00000001)
> > [    0.022713] ACPI: BERT 0x000000007EF0D000 000030 (v01 INSYDE Romley =
  00000001 ?    00000001)
> > [    0.022720] ACPI: EINJ 0x000000007EF0C000 000130 (v01 INSYDE Romley =
  00000001 ?    00000001)
> > [    0.022724] ACPI: Reserving FACP table memory at [mem 0x7effb000-0x7=
effb0f3]
> > [    0.022727] ACPI: Reserving DSDT table memory at [mem 0x7efe9000-0x7=
eff6ee1]
> > [    0.022728] ACPI: Reserving FACS table memory at [mem 0x7ed89000-0x7=
ed8903f]
> > [    0.022730] ACPI: Reserving FACS table memory at [mem 0x7ed89000-0x7=
ed8903f]
> > [    0.022732] ACPI: Reserving SPMI table memory at [mem 0x7effd000-0x7=
effd03f]
> > [    0.022733] ACPI: Reserving BOOT table memory at [mem 0x7effc000-0x7=
effc027]
> > [    0.022735] ACPI: Reserving APIC table memory at [mem 0x7eff9000-0x7=
eff9ba9]
> > [    0.022736] ACPI: Reserving MCFG table memory at [mem 0x7eff8000-0x7=
eff803b]
> > [    0.022738] ACPI: Reserving SLIC table memory at [mem 0x7eff7000-0x7=
eff7175]
> > [    0.022739] ACPI: Reserving BDAT table memory at [mem 0x7efe8000-0x7=
efe802f]
> > [    0.022741] ACPI: Reserving PRAD table memory at [mem 0x7efe7000-0x7=
efe70bb]
> > [    0.022742] ACPI: Reserving MSDM table memory at [mem 0x7efe6000-0x7=
efe6054]
> > [    0.022744] ACPI: Reserving SSDT table memory at [mem 0x7ef12000-0x7=
efe504f]
> > [    0.022745] ACPI: Reserving HPET table memory at [mem 0x7effa000-0x7=
effa037]
> > [    0.022747] ACPI: Reserving WDAT table memory at [mem 0x7ef11000-0x7=
ef11193]
> > [    0.022748] ACPI: Reserving DMAR table memory at [mem 0x7ef10000-0x7=
ef1009f]
> > [    0.022750] ACPI: Reserving HEST table memory at [mem 0x7ef0f000-0x7=
ef0f0a7]
> > [    0.022751] ACPI: Reserving ERST table memory at [mem 0x7ef0e000-0x7=
ef0e22f]
> > [    0.022753] ACPI: Reserving BERT table memory at [mem 0x7ef0d000-0x7=
ef0d02f]
> > [    0.022754] ACPI: Reserving EINJ table memory at [mem 0x7ef0c000-0x7=
ef0c12f]
> > [    0.022998] No NUMA configuration found
> > [    0.023000] Faking a node at [mem 0x0000000000000000-0x000000047ffff=
fff]
> > [    0.023015] NODE_DATA(0) allocated [mem 0x47ffd4f80-0x47fffffff]
> > [    0.023684] ACPI: PM-Timer IO Port: 0x408
> > [    0.024056] ACPI: X2APIC_NMI (uid[0xffffffff] high edge lint[0x1])
> > [    0.024118] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> > [    0.024187] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GS=
I 0-23
> > [    0.024195] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GS=
I 24-47
> > [    0.024257] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> > [    0.024262] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high lev=
el)
> > [    0.024385] ACPI: Using ACPI (MADT) for SMP configuration informatio=
n
> > [    0.024388] ACPI: HPET id: 0x8086a701 base: 0xfed00000
> > [    0.024393] TSC deadline timer available
> > [    0.024398] CPU topo: Max. logical packages:   1
> > [    0.024400] CPU topo: Max. logical nodes:      1
> > [    0.024401] CPU topo: Num. nodes per package:  1
> > [    0.024406] CPU topo: Max. logical dies:       1
> > [    0.024407] CPU topo: Max. dies per package:   1
> > [    0.024416] CPU topo: Max. threads per core:   2
> > [    0.024417] CPU topo: Num. cores per package:     8
> > [    0.024419] CPU topo: Num. threads per package:  16
> > [    0.024420] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
> > [    0.024447] PM: hibernation: Registered nosave memory: [mem 0x000000=
00-0x00000fff]
> > [    0.024451] PM: hibernation: Registered nosave memory: [mem 0x0009d0=
00-0x000fffff]
> > [    0.024454] PM: hibernation: Registered nosave memory: [mem 0x400000=
00-0x400fffff]
> > [    0.024457] PM: hibernation: Registered nosave memory: [mem 0x7e4ff0=
00-0x7effefff]
> > [    0.024460] PM: hibernation: Registered nosave memory: [mem 0x7f0000=
00-0xffffffff]
> > [    0.024463] [gap 0x90000000-0xfeafffff] available for PCI devices
> > [    0.024465] Booting paravirtualized kernel on bare hardware
> > [    0.024468] clocksource: refined-jiffies: mask: 0xffffffff max_cycle=
s: 0xffffffff, max_idle_ns: 1910969940391419 ns
> > [    0.024475] Zone ranges:
> > [    0.024476]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> > [    0.024479]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> > [    0.024482]   Normal   [mem 0x0000000100000000-0x000000047fffffff]
> > [    0.024485]   Device   empty
> > [    0.024487] Movable zone start for each node
> > [    0.024492] Early memory node ranges
> > [    0.024493]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
> > [    0.024495]   node   0: [mem 0x0000000000100000-0x000000003fffffff]
> > [    0.024497]   node   0: [mem 0x0000000040100000-0x000000007e4fefff]
> > [    0.024499]   node   0: [mem 0x000000007efff000-0x000000007effffff]
> > [    0.024500]   node   0: [mem 0x0000000100000000-0x000000047fffffff]
> > [    0.024502] Initmem setup node 0 [mem 0x0000000000001000-0x000000047=
fffffff]
> > [    0.024797] On node 0, zone DMA: 1 pages in unavailable ranges
> > [    0.024874] On node 0, zone DMA: 99 pages in unavailable ranges
> > [    0.034241] On node 0, zone DMA32: 256 pages in unavailable ranges
> > [    0.034319] On node 0, zone DMA32: 2816 pages in unavailable ranges
> > [    0.113921] On node 0, zone Normal: 4096 pages in unavailable ranges
> > [    0.113962] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids=
:16 nr_node_ids:1
> > [    0.117212] percpu: Embedded 85 pages/cpu s225280 r8192 d114688 u524=
288
> > [    0.117225] pcpu-alloc: s225280 r8192 d114688 u524288 alloc=3D1*2097=
152
> > [    0.117229] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
> > [    0.117239] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
> > [    0.117280] Kernel command line: BOOT_IMAGE=3D/vmlinuz-7.3.4-070304-=
generic root=3D/dev/mapper/ubuntu--vg-ubuntu--lv ro
> > [    0.117340] printk: log buffer data + meta data: 262144 + 1114112 =
=3D 1376256 bytes
> > [    0.123118] Dentry cache hash table entries: 2097152 (order: 12, 167=
77216 bytes, linear)
> > [    0.125961] Inode-cache hash table entries: 1048576 (order: 11, 8388=
608 bytes, linear)
> > [    0.126492] software IO TLB: area num 16.
> > [    0.172567] Fallback order for Node 0: 0
> > [    0.172582] Built 1 zonelists, mobility grouping on.  Total pages: 4=
187036
> > [    0.172585] Policy zone: Normal
> > [    0.172603] mem auto-init: stack:all(zero), heap alloc:on, heap free=
:off
> > [    0.369742] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
16, Nodes=3D1
> > [    0.370064] Kernel/User page tables isolation: enabled
> > [    0.389635] ftrace: allocating 65147 entries in 256 pages
> > [    0.389638] ftrace: allocated 256 pages with 1 groups
> > [    0.391173] Dynamic Preempt: lazy
> > [    0.391661] rcu: Preemptible hierarchical RCU implementation.
> > [    0.391664] rcu:   RCU restricting CPUs from NR_CPUS=3D8192 to nr_cp=
u_ids=3D16.
> > [    0.391667]        Trampoline variant of Tasks RCU enabled.
> > [    0.391668]        Rude variant of Tasks RCU enabled.
> > [    0.391669]        Tracing variant of Tasks RCU enabled.
> > [    0.391670] rcu: RCU calculated value of scheduler-enlistment delay =
is 100 jiffies.
> > [    0.391671] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu=
_ids=3D16
> > [    0.391709] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_a=
djust=3D1 rcu_task_cpu_ids=3D16.
> > [    0.391715] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task=
_cb_adjust=3D1 rcu_task_cpu_ids=3D16.
> > [    0.410928] NR_IRQS: 524544, nr_irqs: 960, preallocated irqs: 16
> > [    0.411262] rcu: srcu_init: Setting srcu_struct sizes based on conte=
ntion.
> > [    0.411311] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfff=
fffff, max_idle_ns: 1911260446275000 ns
> > [    0.411612] Console: colour dummy device 80x25
> > [    0.411618] printk: legacy console [tty0] enabled
> > [    0.412637] ACPI: Core revision 20260408
> > [    0.519863] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffff=
ff, max_idle_ns: 133484882848 ns
> > [    0.519887] APIC: Switch to symmetric I/O mode setup
> > [    0.519894] DMAR: Host address width 46
> > [    0.519899] DMAR: DRHD base: 0x000000fbffc000 flags: 0x1
> > [    0.519930] DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap d2078c10=
6f0462 ecap f020fe
> > [    0.519940] DMAR: ATSR flags: 0x0
> > [    0.519964] DMAR: RMRR base: 0x0000007e8b5000 end: 0x0000007e8bbfff
> > [    0.519987] DMAR-IR: IOAPIC id 8 under DRHD base  0xfbffc000 IOMMU 0
> > [    0.519993] DMAR-IR: IOAPIC id 9 under DRHD base  0xfbffc000 IOMMU 0
> > [    0.519999] DMAR-IR: HPET id 0 under DRHD base 0xfbffc000
> > [    0.520005] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt=
 out bit.
> > [    0.520006] DMAR-IR: Use 'intremap=3Dno_x2apic_optout' to override t=
he BIOS setting.
> > [    0.520871] DMAR-IR: Enabled IRQ remapping in xapic mode
> > [    0.520879] x2apic: IRQ remapping doesn't support X2APIC mode
> > [    0.521466] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin=
2=3D-1
> > [    0.525888] clocksource: tsc-early: mask: 0xffffffffffffffff max_cyc=
les: 0x19f269ebae4, max_idle_ns: 440795252871 ns
> > [    0.525904] Calibrating delay loop (skipped), value calculated using=
 timer frequency.. 3600.13 BogoMIPS (lpj=3D1800068)
> > [    0.525955] CPU0: Thermal monitoring enabled (TM1)
> > [    0.526059] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
> > [    0.526067] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
> > [    0.526102] process: using mwait in idle threads
> > [    0.526109] mitigations: Enabled attack vectors: user_kernel, user_u=
ser, guest_host, guest_guest, SMT mitigations: auto
> > [    0.526124] Speculative Store Bypass: Mitigation: Speculative Store =
Bypass disabled via prctl
> > [    0.526131] Spectre V2 : Mitigation: Retpolines
> > [    0.526136] Spectre V2 : User space: Mitigation: STIBP via prctl
> > [    0.526141] MDS: Mitigation: Clear CPU buffers
> > [    0.526145] VMSCAPE: Mitigation: IBPB before exit to userspace
> > [    0.526150] Spectre V1 : Mitigation: usercopy/swapgs barriers and __=
user pointer sanitization
> > [    0.526157] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on con=
text switch and VMEXIT
> > [    0.526163] Spectre V2 : Enabling Restricted Speculation for firmwar=
e calls
> > [    0.526169] Spectre V2 : mitigation: Enabling conditional Indirect B=
ranch Prediction Barrier
> > [    0.526186] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating p=
oint registers'
> > [    0.526193] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> > [    0.526198] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> > [    0.526204] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> > [    0.526209] x86/fpu: Enabled xstate features 0x7, context size is 83=
2 bytes, using 'standard' format.
> > [    0.576101] pid_max: default: 32768 minimum: 301
> > [    0.577945] landlock: Up and running.
> > [    0.577953] Yama: becoming mindful.
> > [    0.578157] AppArmor: AppArmor initialized
> > [    0.578485] LSM support for eBPF active
> > [    0.579539] Mount-cache hash table entries: 32768 (order: 6, 262144 =
bytes, linear)
> > [    0.579581] Mountpoint-cache hash table entries: 32768 (order: 6, 26=
2144 bytes, linear)
> > [    0.580049] VFS: Finished mounting rootfs on nullfs
> > [    0.582087] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2450L 0 @ 1.80GHz=
 (family: 0x6, model: 0x2d, stepping: 0x7)
> > [    0.582710] Performance Events: PEBS fmt1+, SandyBridge events, 16-d=
eep LBR, full-width counters, Intel PMU driver.
> > [    0.582751] ... version:                   3
> > [    0.582756] ... bit width:                 48
> > [    0.582760] ... generic counters:          4
> > [    0.582764] ... generic bitmap:            000000000000000f
> > [    0.582769] ... fixed-purpose counters:    3
> > [    0.582773] ... fixed-purpose bitmap:      0000000000000007
> > [    0.582777] ... value mask:                0000ffffffffffff
> > [    0.582782] ... max period:                00007fffffffffff
> > [    0.582786] ... global_ctrl mask:          000000070000000f
> > [    0.583143] signal: max sigframe size: 1776
> > [    0.583181] Estimated ratio of average max frequency by base frequen=
cy (times 1024): 1024
> > [    0.585615] rcu: Hierarchical SRCU implementation.
> > [    0.585624] rcu:   Max phase no-delay instances is 400.
> > [    0.585801] Timer migration: 2 hierarchy levels; 8 children per grou=
p; 2 crossnode level
> > [    0.587677] NMI watchdog: Enabled. Permanently consumes one hw-PMU c=
ounter.
> > [    0.588120] smp: Bringing up secondary CPUs ...
> > [    0.588485] smpboot: x86: Booting SMP configuration:
> > [    0.588493] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  =
#8  #9 #10 #11 #12 #13 #14 #15
> > [    0.605278] MDS CPU bug present and SMT on, data leak possible. See =
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for mor=
e details.
> > [    0.605278] VMSCAPE: SMT on, STIBP is required for full protection. =
See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/vmscape.html=
 for more details.
> > [    0.612023] smp: Brought up 1 node, 16 CPUs
> > [    0.612023] smpboot: Total of 16 processors activated (57602.17 Bogo=
MIPS)
> > [    0.613261] Memory: 16230900K/16748144K available (24388K kernel cod=
e, 4959K rwdata, 17724K rodata, 5468K init, 5728K bss, 488800K reserved, 0K=
 cma-reserved)
> > [    0.615075] devtmpfs: initialized
> > [    0.615075] x86/mm: Memory block size: 128MB
> > [    0.619317] ACPI: PM: Registering ACPI NVS region [mem 0x7e8ff000-0x=
7eefefff] (6291456 bytes)
> > [    0.619317] posixtimers hash table entries: 8192 (order: 5, 131072 b=
ytes, linear)
> > [    0.619317] futex hash table entries: 4096 (262144 bytes on 1 NUMA n=
odes, total 256 KiB, linear).
> > [    0.621640] PM: RTC time: 13:00:07, date: 2026-11-12
> > [    0.622878] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> > [    0.623362] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic al=
locations
> > [    0.623563] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for a=
tomic allocations
> > [    0.623762] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for=
 atomic allocations
> > [    0.623783] audit: initializing netlink subsys (disabled)
> > [    0.623811] audit: type=3D2000 audit(1794488407.103:1): state=3Dinit=
ialized audit_enabled=3D0 res=3D1
> > [    0.653169] thermal_sys: Registered thermal governor 'fair_share'
> > [    0.653178] thermal_sys: Registered thermal governor 'bang_bang'
> > [    0.653190] thermal_sys: Registered thermal governor 'step_wise'
> > [    0.653195] thermal_sys: Registered thermal governor 'user_space'
> > [    0.653199] thermal_sys: Registered thermal governor 'power_allocato=
r'
> > [    0.653236] cpuidle: using governor ladder
> > [    0.653236] cpuidle: using governor menu
> > [    0.653236] Simple Boot Flag at 0x44 set to 0x1
> > [    0.653236] ACPI FADT declares the system doesn't support PCIe ASPM,=
 so disable it
> > [    0.653236] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.=
5
> > [    0.654109] PCI: ECAM [mem 0x80000000-0x8fffffff] (base 0x80000000) =
for domain 0000 [bus 00-ff]
> > [    0.654152] PCI: Using configuration type 1 for base access
> > [    0.654223] core: PMU erratum BJ122, BV98, HSD29 worked around, HT i=
s on
> > [    0.654231] mtrr: your CPUs had inconsistent variable MTRR settings
> > [    0.654235] mtrr: probably your BIOS does not setup all CPUs.
> > [    0.654240] mtrr: corrected configuration.
> > [    0.654244] virt/tdx: TDX not supported by the host platform
> > [    0.654310] kprobes: kprobe jump-optimization is enabled. All kprobe=
s are optimized if possible.
> > [    0.660981] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 =
pages
> > [    0.660981] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB p=
age
> > [    0.660981] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 =
pages
> > [    0.660981] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> > [    0.670589] fbcon: Taking over console
> > [    0.670739] ACPI: Added _OSI(Module Device)
> > [    0.670750] ACPI: Added _OSI(Processor Device)
> > [    0.670758] ACPI: Added _OSI(Processor Aggregator Device)
> > [    1.019541] ACPI: 2 ACPI AML tables successfully acquired and loaded
> > [    1.051086] ACPI: \_SB_: platform _OSC: OS support mask [006e7eff]
> > [    1.052091] ACPI: \_SB_: platform _OSC: OS control mask [006e7eff]
> > [    1.093301] ACPI: Interpreter enabled
> > [    1.093356] ACPI: PM: (supports S0 S4 S5)
> > [    1.093362] ACPI: Using IOAPIC for interrupt routing
> > [    1.099664] HEST: Table parsing has been initialized.
> > [    1.099927] GHES: APEI firmware first mode is enabled by APEI bit an=
d WHEA _OSC.
> > [    1.099942] PCI: Using host bridge windows from ACPI; if necessary, =
use "pci=3Dnocrs" and report a bug
> > [    1.099949] PCI: Using E820 reservations for host bridge windows
> > [    1.100880] ACPI: Enabled 7 GPEs in block 00 to 3F
> > [    1.145817] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
> > [    1.145837] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM =
ClockPM Segments MSI EDR HPX-Type3]
> > [    1.146802] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPC=
Hotplug PME AER PCIeCapability LTR DPC]
> > [    1.146813] acpi PNP0A08:00: FADT indicates ASPM is unsupported, usi=
ng BIOS configuration
> > [    1.148360] PCI host bridge to bus 0000:00
> > [    1.148374] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 wi=
ndow]
> > [    1.148382] pci_bus 0000:00: root bus resource [io  0x1000-0xffff wi=
ndow]
> > [    1.148389] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000=
bffff window]
> > [    1.148396] pci_bus 0000:00: root bus resource [mem 0x90000000-0xfbf=
fefff window]
> > [    1.148404] pci_bus 0000:00: root bus resource [bus 00-fe]
> > [    1.148450] pci 0000:00:00.0: [8086:3c00] type 00 class 0x060000 PCI=
e Root Port
> > [    1.148555] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
> > [    1.148734] pci 0000:00:01.0: [8086:3c02] type 01 class 0x060400 PCI=
e Root Port
> > [    1.148767] pci 0000:00:01.0: PCI bridge to [bus 01]
> > [    1.148864] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
> > [    1.149147] pci 0000:00:01.1: [8086:3c03] type 01 class 0x060400 PCI=
e Root Port
> > [    1.149181] pci 0000:00:01.1: PCI bridge to [bus 02]
> > [    1.149189] pci 0000:00:01.1:   bridge window [io  0x5000-0x5fff]
> > [    1.149198] pci 0000:00:01.1:   bridge window [mem 0x94800000-0x948f=
ffff]
> > [    1.149290] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
> > [    1.149557] pci 0000:00:03.0: [8086:3c08] type 01 class 0x060400 PCI=
e Root Port
> > [    1.149590] pci 0000:00:03.0: PCI bridge to [bus 03]
> > [    1.149598] pci 0000:00:03.0:   bridge window [io  0x4000-0x4fff]
> > [    1.149606] pci 0000:00:03.0:   bridge window [mem 0x94700000-0x947f=
ffff]
> > [    1.149628] pci 0000:00:03.0: enabling Extended Tags
> > [    1.149709] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
> > [    1.149933] pci 0000:00:04.0: [8086:3c20] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.149980] pci 0000:00:04.0: BAR 0 [mem 0x94900000-0x94903fff 64bit=
]
> > [    1.150135] pci 0000:00:04.1: [8086:3c21] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.150181] pci 0000:00:04.1: BAR 0 [mem 0x94904000-0x94907fff 64bit=
]
> > [    1.150329] pci 0000:00:04.2: [8086:3c22] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.150374] pci 0000:00:04.2: BAR 0 [mem 0x94908000-0x9490bfff 64bit=
]
> > [    1.150521] pci 0000:00:04.3: [8086:3c23] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.150566] pci 0000:00:04.3: BAR 0 [mem 0x9490c000-0x9490ffff 64bit=
]
> > [    1.150718] pci 0000:00:04.4: [8086:3c24] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.150763] pci 0000:00:04.4: BAR 0 [mem 0x94910000-0x94913fff 64bit=
]
> > [    1.150911] pci 0000:00:04.5: [8086:3c25] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.150957] pci 0000:00:04.5: BAR 0 [mem 0x94914000-0x94917fff 64bit=
]
> > [    1.151104] pci 0000:00:04.6: [8086:3c26] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.151149] pci 0000:00:04.6: BAR 0 [mem 0x94918000-0x9491bfff 64bit=
]
> > [    1.151294] pci 0000:00:04.7: [8086:3c27] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.151339] pci 0000:00:04.7: BAR 0 [mem 0x9491c000-0x9491ffff 64bit=
]
> > [    1.151489] pci 0000:00:05.0: [8086:3c28] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.151709] pci 0000:00:05.2: [8086:3c2a] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.151876] pci 0000:00:05.4: [8086:3c2c] type 00 class 0x080020 con=
ventional PCI endpoint
> > [    1.151919] pci 0000:00:05.4: BAR 0 [mem 0x94928000-0x94928fff]
> > [    1.152064] pci 0000:00:11.0: [8086:1d3e] type 01 class 0x060400 PCI=
e Root Port
> > [    1.152104] pci 0000:00:11.0: PCI bridge to [bus 04]
> > [    1.152114] pci 0000:00:11.0:   bridge window [io  0x3000-0x3fff]
> > [    1.152122] pci 0000:00:11.0:   bridge window [mem 0x94600000-0x946f=
ffff]
> > [    1.152140] pci 0000:00:11.0:   bridge window [mem 0x94000000-0x944f=
ffff 64bit pref]
> > [    1.152226] pci 0000:00:11.0: PME# supported from D0 D3hot D3cold
> > [    1.152442] pci 0000:00:16.0: [8086:1d3a] type 00 class 0x078000 con=
ventional PCI endpoint
> > [    1.152492] pci 0000:00:16.0: BAR 0 [mem 0x94920000-0x9492000f 64bit=
]
> > [    1.152539] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
> > [    1.152681] pci 0000:00:16.1: [8086:1d3b] type 00 class 0x078000 con=
ventional PCI endpoint
> > [    1.152730] pci 0000:00:16.1: BAR 0 [mem 0x94921000-0x9492100f 64bit=
]
> > [    1.152777] pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
> > [    1.152948] pci 0000:00:1a.0: [8086:1d2d] type 00 class 0x0c0320 con=
ventional PCI endpoint
> > [    1.153829] pci 0000:00:1a.0: BAR 0 [mem 0x94926000-0x949263ff]
> > [    1.153891] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
> > [    1.154050] pci 0000:00:1c.0: [8086:1d10] type 01 class 0x060400 PCI=
e Root Port
> > [    1.154088] pci 0000:00:1c.0: PCI bridge to [bus 05]
> > [    1.154179] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> > [    1.154376] pci 0000:00:1c.2: [8086:1d14] type 01 class 0x060400 PCI=
e Root Port
> > [    1.154413] pci 0000:00:1c.2: PCI bridge to [bus 06]
> > [    1.154503] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
> > [    1.154698] pci 0000:00:1c.3: [8086:1d16] type 01 class 0x060400 PCI=
e Root Port
> > [    1.154735] pci 0000:00:1c.3: PCI bridge to [bus 07]
> > [    1.154744] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
> > [    1.154753] pci 0000:00:1c.3:   bridge window [mem 0x94500000-0x945f=
ffff]
> > [    1.154769] pci 0000:00:1c.3:   bridge window [mem 0x90000000-0x93ff=
ffff 64bit pref]
> > [    1.154801] pci 0000:00:1c.3: removing 2.5GT/s downstream link speed=
 restriction
> > [    1.154863] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
> > [    1.155056] pci 0000:00:1d.0: [8086:1d26] type 00 class 0x0c0320 con=
ventional PCI endpoint
> > [    1.155906] pci 0000:00:1d.0: BAR 0 [mem 0x94925000-0x949253ff]
> > [    1.155968] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> > [    1.156124] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401 con=
ventional PCI bridge
> > [    1.156157] pci 0000:00:1e.0: PCI bridge to [bus 08] (subtractive de=
code)
> > [    1.156347] pci 0000:00:1f.0: [8086:1d41] type 00 class 0x060100 con=
ventional PCI endpoint
> > [    1.156605] pci 0000:00:1f.2: [8086:1d02] type 00 class 0x010601 con=
ventional PCI endpoint
> > [    1.156650] pci 0000:00:1f.2: BAR 0 [io  0x6048-0x604f]
> > [    1.156657] pci 0000:00:1f.2: BAR 1 [io  0x605c-0x605f]
> > [    1.156663] pci 0000:00:1f.2: BAR 2 [io  0x6040-0x6047]
> > [    1.156670] pci 0000:00:1f.2: BAR 3 [io  0x6058-0x605b]
> > [    1.156676] pci 0000:00:1f.2: BAR 4 [io  0x6020-0x603f]
> > [    1.156683] pci 0000:00:1f.2: BAR 5 [mem 0x94924000-0x949247ff]
> > [    1.156730] pci 0000:00:1f.2: PME# supported from D3hot
> > [    1.156867] pci 0000:00:1f.3: [8086:1d22] type 00 class 0x0c0500 con=
ventional PCI endpoint
> > [    1.156916] pci 0000:00:1f.3: BAR 0 [mem 0x94922000-0x949220ff 64bit=
]
> > [    1.156927] pci 0000:00:1f.3: BAR 4 [io  0x6000-0x601f]
> > [    1.157029] pci 0000:00:1f.6: [8086:1d24] type 00 class 0x118000 con=
ventional PCI endpoint
> > [    1.157084] pci 0000:00:1f.6: BAR 0 [mem 0x94923000-0x94923fff 64bit=
]
> > [    1.157256] pci 0000:00:01.0: PCI bridge to [bus 01]
> > [    1.157365] pci 0000:02:00.0: [8086:1521] type 00 class 0x020000 PCI=
e Endpoint
> > [    1.157408] pci 0000:02:00.0: BAR 0 [mem 0x94820000-0x9483ffff]
> > [    1.157416] pci 0000:02:00.0: BAR 2 [io  0x5020-0x503f]
> > [    1.157423] pci 0000:02:00.0: BAR 3 [mem 0x94844000-0x94847fff]
> > [    1.157510] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
> > [    1.157552] pci 0000:02:00.0: VF BAR 0 [mem 0x00000000-0x00003fff 64=
bit pref]
> > [    1.157559] pci 0000:02:00.0: VF BAR 0 [mem 0x00000000-0x0001ffff 64=
bit pref]: contains BAR 0 for 8 VFs
> > [    1.157570] pci 0000:02:00.0: VF BAR 3 [mem 0x00000000-0x00003fff 64=
bit pref]
> > [    1.157576] pci 0000:02:00.0: VF BAR 3 [mem 0x00000000-0x0001ffff 64=
bit pref]: contains BAR 3 for 8 VFs
> > [    1.157790] pci 0000:02:00.1: [8086:1521] type 00 class 0x020000 PCI=
e Endpoint
> > [    1.157833] pci 0000:02:00.1: BAR 0 [mem 0x94800000-0x9481ffff]
> > [    1.157842] pci 0000:02:00.1: BAR 2 [io  0x5000-0x501f]
> > [    1.157848] pci 0000:02:00.1: BAR 3 [mem 0x94840000-0x94843fff]
> > [    1.157930] pci 0000:02:00.1: PME# supported from D0 D3hot D3cold
> > [    1.157968] pci 0000:02:00.1: VF BAR 0 [mem 0x00000000-0x00003fff 64=
bit pref]
> > [    1.157975] pci 0000:02:00.1: VF BAR 0 [mem 0x00000000-0x0001ffff 64=
bit pref]: contains BAR 0 for 8 VFs
> > [    1.157985] pci 0000:02:00.1: VF BAR 3 [mem 0x00000000-0x00003fff 64=
bit pref]
> > [    1.157991] pci 0000:02:00.1: VF BAR 3 [mem 0x00000000-0x0001ffff 64=
bit pref]: contains BAR 3 for 8 VFs
> > [    1.158178] pci 0000:00:01.1: PCI bridge to [bus 02]
> > [    1.158275] pci 0000:03:00.0: [1000:005b] type 00 class 0x010400 PCI=
e Endpoint
> > [    1.158312] pci 0000:03:00.0: BAR 0 [io  0x4000-0x40ff]
> > [    1.158319] pci 0000:03:00.0: BAR 1 [mem 0x94740000-0x94743fff 64bit=
]
> > [    1.158327] pci 0000:03:00.0: BAR 3 [mem 0x94700000-0x9473ffff 64bit=
]
> > [    1.158334] pci 0000:03:00.0: ROM [mem 0xfffe0000-0xffffffff pref]
> > [    1.158345] pci 0000:03:00.0: enabling Extended Tags
> > [    1.158367] pci 0000:03:00.0: [Firmware Bug]: disabling VPD access (=
can't determine size of non-standard VPD format)
> > [    1.158413] pci 0000:03:00.0: supports D1 D2
> > [    1.158541] pci 0000:00:03.0: PCI bridge to [bus 03]
> > [    1.158655] pci 0000:04:00.0: [8086:1d6b] type 00 class 0x010700 PCI=
e Endpoint
> > [    1.158709] pci 0000:04:00.0: BAR 0 [mem 0x94400000-0x94403fff 64bit=
 pref]
> > [    1.158718] pci 0000:04:00.0: BAR 2 [mem 0x94000000-0x943fffff 64bit=
 pref]
> > [    1.158725] pci 0000:04:00.0: BAR 4 [io  0x3000-0x30ff]
> > [    1.158741] pci 0000:04:00.0: enabling Extended Tags
> > [    1.158865] pci 0000:04:00.0: VF BAR 0 [mem 0x00000000-0x00003fff 64=
bit pref]
> > [    1.158871] pci 0000:04:00.0: VF BAR 0 [mem 0x00000000-0x0007bfff 64=
bit pref]: contains BAR 0 for 31 VFs
> > [    1.159207] pci 0000:04:00.3: [8086:1d70] type 00 class 0x0c0500 PCI=
e Endpoint
> > [    1.159265] pci 0000:04:00.3: BAR 0 [mem 0x94600000-0x94600fff]
> > [    1.159277] pci 0000:04:00.3: BAR 4 [io  0x3100-0x311f]
> > [    1.159353] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
> > [    1.159485] pci 0000:00:11.0: PCI bridge to [bus 04]
> > [    1.159581] pci 0000:00:1c.0: PCI bridge to [bus 05]
> > [    1.159677] pci 0000:00:1c.2: PCI bridge to [bus 06]
> > [    1.159908] pci 0000:00:1c.3: PCI bridge to [bus 07]
> > [    1.159945] pci_bus 0000:08: extended config space not accessible
> > [    1.160037] pci 0000:00:1e.0: PCI bridge to [bus 08] (subtractive de=
code)
> > [    1.160053] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 win=
dow] (subtractive decode)
> > [    1.160061] pci 0000:00:1e.0:   bridge window [io  0x1000-0xffff win=
dow] (subtractive decode)
> > [    1.160068] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000b=
ffff window] (subtractive decode)
> > [    1.160076] pci 0000:00:1e.0:   bridge window [mem 0x90000000-0xfbff=
efff window] (subtractive decode)
> > [    1.161984] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus ff])
> > [    1.162204] PCI host bridge to bus 0000:ff
> > [    1.162215] pci_bus 0000:ff: root bus resource [bus ff]
> > [    1.162236] pci 0000:ff:08.0: [8086:3c80] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.162353] pci 0000:ff:08.3: [8086:3c83] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.162483] pci 0000:ff:08.4: [8086:3c84] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.162607] pci 0000:ff:09.0: [8086:3c90] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.162713] pci 0000:ff:09.3: [8086:3c93] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.162836] pci 0000:ff:09.4: [8086:3c94] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.162961] pci 0000:ff:0a.0: [8086:3cc0] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.163064] pci 0000:ff:0a.1: [8086:3cc1] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.163157] pci 0000:ff:0a.2: [8086:3cc2] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.163241] pci 0000:ff:0a.3: [8086:3cd0] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.163334] pci 0000:ff:0b.0: [8086:3ce0] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.163425] pci 0000:ff:0b.3: [8086:3ce3] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.163509] pci 0000:ff:0c.0: [8086:3ce8] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.163599] pci 0000:ff:0c.1: [8086:3ce8] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.163690] pci 0000:ff:0c.2: [8086:3ce8] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.163781] pci 0000:ff:0c.3: [8086:3ce8] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.163872] pci 0000:ff:0c.6: [8086:3cf4] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.164026] pci 0000:ff:0c.7: [8086:3cf6] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.164120] pci 0000:ff:0d.0: [8086:3ce8] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.164204] pci 0000:ff:0d.1: [8086:3ce8] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.164295] pci 0000:ff:0d.2: [8086:3ce8] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.164385] pci 0000:ff:0d.3: [8086:3ce8] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.164476] pci 0000:ff:0d.6: [8086:3cf5] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.164577] pci 0000:ff:0e.0: [8086:3ca0] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.164673] pci 0000:ff:0e.1: [8086:3c46] type 00 class 0x110100 con=
ventional PCI endpoint
> > [    1.164770] pci 0000:ff:0f.0: [8086:3ca8] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.164896] pci 0000:ff:0f.1: [8086:3c71] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.165023] pci 0000:ff:0f.2: [8086:3caa] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.165149] pci 0000:ff:0f.3: [8086:3cab] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.165266] pci 0000:ff:0f.4: [8086:3cac] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.165389] pci 0000:ff:0f.5: [8086:3cad] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.165516] pci 0000:ff:0f.6: [8086:3cae] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.165620] pci 0000:ff:10.0: [8086:3cb0] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.165738] pci 0000:ff:10.1: [8086:3cb1] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.165863] pci 0000:ff:10.2: [8086:3cb2] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.165999] pci 0000:ff:10.3: [8086:3cb3] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.166118] pci 0000:ff:10.5: [8086:3cb5] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.166244] pci 0000:ff:10.6: [8086:3cb6] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.166369] pci 0000:ff:10.7: [8086:3cb7] type 00 class 0x088000 PCI=
e Root Complex Integrated Endpoint
> > [    1.166497] pci 0000:ff:11.0: [8086:3cb8] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.166596] pci 0000:ff:13.0: [8086:3ce4] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.166692] pci 0000:ff:13.1: [8086:3c43] type 00 class 0x110100 con=
ventional PCI endpoint
> > [    1.166787] pci 0000:ff:13.4: [8086:3ce6] type 00 class 0x110100 con=
ventional PCI endpoint
> > [    1.166880] pci 0000:ff:13.5: [8086:3c44] type 00 class 0x110100 con=
ventional PCI endpoint
> > [    1.166976] pci 0000:ff:13.6: [8086:3c45] type 00 class 0x088000 con=
ventional PCI endpoint
> > [    1.176151] ACPI: PCI: Interrupt link LNKA configured for IRQ 3
> > [    1.176293] ACPI: PCI: Interrupt link LNKB configured for IRQ 5
> > [    1.176426] ACPI: PCI: Interrupt link LNKC configured for IRQ 6
> > [    1.176557] ACPI: PCI: Interrupt link LNKD configured for IRQ 7
> > [    1.176685] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
> > [    1.176692] ACPI: PCI: Interrupt link LNKE disabled
> > [    1.176820] ACPI: PCI: Interrupt link LNKF configured for IRQ 10
> > [    1.176956] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
> > [    1.176963] ACPI: PCI: Interrupt link LNKG disabled
> > [    1.177091] ACPI: PCI: Interrupt link LNKH configured for IRQ 9
> > [    1.177404] iommu: Default domain type: Translated
> > [    1.177404] iommu: DMA domain TLB invalidation policy: lazy mode
> > [    1.178353] SCSI subsystem initialized
> > [    1.178377] libata version 3.00 loaded.
> > [    1.178377] ACPI: bus type USB registered
> > [    1.178377] usbcore: registered new interface driver usbfs
> > [    1.178377] usbcore: registered new interface driver hub
> > [    1.178377] usbcore: registered new device driver usb
> > [    1.178377] pps_core: LinuxPPS API ver. 1 registered
> > [    1.178377] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodo=
lfo Giometti <giometti@linux.it>
> > [    1.178377] PTP clock support registered
> > [    1.178939] EDAC MC: Ver: 3.0.0
> > [    1.180014] NetLabel: Initializing
> > [    1.180022] NetLabel:  domain hash size =3D 128
> > [    1.180027] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
> > [    1.180059] NetLabel:  unlabeled traffic allowed by default
> > [    1.180097] mctp: management component transport protocol core
> > [    1.180097] NET: Registered PF_MCTP protocol family
> > [    1.180097] PCI: Using ACPI for IRQ routing
> > [    1.187309] PCI: pci_cache_line_size set to 64 bytes
> > [    1.187453] e820: register RAM buffer resource [mem 0x0009d000-0x000=
9ffff]
> > [    1.187461] e820: register RAM buffer resource [mem 0x7e4ff000-0x7ff=
fffff]
> > [    1.187467] e820: register RAM buffer resource [mem 0x7f000000-0x7ff=
fffff]
> > [    1.187505] vgaarb: loaded
> > [    1.189066] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> > [    1.189066] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
> > [    1.190970] clocksource: Switched to clocksource tsc-early
> > [    1.192158] VFS: Disk quotas dquot_6.6.0
> > [    1.192266] VFS: Dquot-cache hash table entries: 512 (4096 bytes)
> > [    1.192701] AppArmor: AppArmor Filesystem Enabled
> > [    1.192893] acpi PNP0C02:00: Reserved [mem 0xfed1c000-0xfed1ffff]
> > [    1.192917] acpi PNP0C02:00: Reserved [mem 0xfbfff000-0xfbffffff]
> > [    1.192925] acpi PNP0C02:00: Reserved [mem 0xfed20000-0xfed3ffff]
> > [    1.192932] acpi PNP0C02:00: Could not reserve [mem 0xfbffc000-0xfbf=
fdfff]
> > [    1.192938] acpi PNP0C02:00: Could not reserve [mem 0xff000000-0xfff=
fffff]
> > [    1.192944] acpi PNP0C02:00: Could not reserve [mem 0xfee00000-0xfee=
fffff]
> > [    1.192981] acpi PNP0C02:01: Skipped [io  0x002e-0x002f]
> > [    1.192988] acpi PNP0C02:01: Skipped [io  0x004e-0x004f]
> > [    1.192993] acpi PNP0C02:01: Skipped [io  0x0061]
> > [    1.192998] acpi PNP0C02:01: Skipped [io  0x0063]
> > [    1.193003] acpi PNP0C02:01: Skipped [io  0x0065]
> > [    1.193008] acpi PNP0C02:01: Skipped [io  0x0067]
> > [    1.193013] acpi PNP0C02:01: Skipped [io  0x0070]
> > [    1.193017] acpi PNP0C02:01: Skipped [io  0x0080]
> > [    1.193022] acpi PNP0C02:01: Skipped [io  0x0092]
> > [    1.193026] acpi PNP0C02:01: Skipped [io  0x00b2-0x00b3]
> > [    1.193032] acpi PNP0C02:01: Reserved [io  0x0680-0x069f]
> > [    1.193038] acpi PNP0C02:01: Reserved [io  0x0400-0x0453]
> > [    1.193044] acpi PNP0C02:01: Reserved [io  0x0458-0x047f]
> > [    1.193049] acpi PNP0C02:01: Reserved [io  0x0500-0x057f]
> > [    1.193054] acpi PNP0C02:01: Reserved [io  0x164e-0x164f]
> > [    1.193083] pnp: PnP ACPI init
> > [    1.193490] pnp 00:02: [dma 0 disabled]
> > [    1.194428] pnp: PnP ACPI: found 3 devices
> > [    1.202312] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xfffff=
f, max_idle_ns: 2085701024 ns
> > [    1.202808] NET: Registered PF_INET protocol family
> > [    1.203250] IP idents hash table entries: 262144 (order: 9, 2097152 =
bytes, linear)
> > [    1.210302] tcp_listen_portaddr_hash hash table entries: 8192 (order=
: 5, 131072 bytes, linear)
> > [    1.210380] Table-perturb hash table entries: 65536 (order: 6, 26214=
4 bytes, linear)
> > [    1.210574] TCP established hash table entries: 131072 (order: 8, 10=
48576 bytes, linear)
> > [    1.211185] TCP bind hash table entries: 65536 (order: 9, 2097152 by=
tes, linear)
> > [    1.211672] TCP: Hash tables configured (established 131072 bind 655=
36)
> > [    1.212002] MPTCP token hash table entries: 16384 (order: 7, 393216 =
bytes, linear)
> > [    1.212233] UDP hash table entries: 8192 (order: 7, 524288 bytes, li=
near)
> > [    1.212547] NET: Registered PF_UNIX/PF_LOCAL protocol family
> > [    1.212576] NET: Registered PF_XDP protocol family
> > [    1.212589] pci 0000:03:00.0: ROM [mem 0xfffe0000-0xffffffff pref]: =
can't claim; no compatible bridge window
> > [    1.212609] pci_bus 0000:00: max bus depth: 1 pci_try_num: 2
> > [    1.212651] pci 0000:00:01.1: bridge window [mem 0x94a00000-0x94afff=
ff 64bit pref]: assigned
> > [    1.212663] pci 0000:00:03.0: bridge window [mem 0x94b00000-0x94cfff=
ff 64bit pref]: assigned
> > [    1.212672] pci 0000:00:01.0: PCI bridge to [bus 01]
> > [    1.212691] pci 0000:02:00.0: VF BAR 0 [mem 0x94a00000-0x94a1ffff 64=
bit pref]: assigned
> > [    1.212702] pci 0000:02:00.0: VF BAR 3 [mem 0x94a20000-0x94a3ffff 64=
bit pref]: assigned
> > [    1.212711] pci 0000:02:00.1: VF BAR 0 [mem 0x94a40000-0x94a5ffff 64=
bit pref]: assigned
> > [    1.212721] pci 0000:02:00.1: VF BAR 3 [mem 0x94a60000-0x94a7ffff 64=
bit pref]: assigned
> > [    1.212730] pci 0000:00:01.1: PCI bridge to [bus 02]
> > [    1.212736] pci 0000:00:01.1:   bridge window [io  0x5000-0x5fff]
> > [    1.212746] pci 0000:00:01.1:   bridge window [mem 0x94800000-0x948f=
ffff]
> > [    1.212754] pci 0000:00:01.1:   bridge window [mem 0x94a00000-0x94af=
ffff 64bit pref]
> > [    1.212766] pci 0000:03:00.0: ROM [mem 0x94760000-0x9477ffff pref]: =
assigned
> > [    1.212773] pci 0000:00:03.0: PCI bridge to [bus 03]
> > [    1.212779] pci 0000:00:03.0:   bridge window [io  0x4000-0x4fff]
> > [    1.212787] pci 0000:00:03.0:   bridge window [mem 0x94700000-0x947f=
ffff]
> > [    1.212795] pci 0000:00:03.0:   bridge window [mem 0x94b00000-0x94cf=
ffff 64bit pref]
> > [    1.212808] pci 0000:04:00.0: VF BAR 0 [mem 0x94404000-0x9447ffff 64=
bit pref]: assigned
> > [    1.212818] pci 0000:00:11.0: PCI bridge to [bus 04]
> > [    1.212824] pci 0000:00:11.0:   bridge window [io  0x3000-0x3fff]
> > [    1.212834] pci 0000:00:11.0:   bridge window [mem 0x94600000-0x946f=
ffff]
> > [    1.212842] pci 0000:00:11.0:   bridge window [mem 0x94000000-0x944f=
ffff 64bit pref]
> > [    1.212854] pci 0000:00:1c.0: PCI bridge to [bus 05]
> > [    1.212870] pci 0000:00:1c.2: PCI bridge to [bus 06]
> > [    1.212885] pci 0000:00:1c.3: PCI bridge to [bus 07]
> > [    1.212891] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
> > [    1.212908] pci 0000:00:1c.3:   bridge window [mem 0x94500000-0x945f=
ffff]
> > [    1.212918] pci 0000:00:1c.3:   bridge window [mem 0x90000000-0x93ff=
ffff 64bit pref]
> > [    1.212930] pci 0000:00:1e.0: PCI bridge to [bus 08]
> > [    1.212945] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> > [    1.212951] pci_bus 0000:00: resource 5 [io  0x1000-0xffff window]
> > [    1.212957] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff w=
indow]
> > [    1.212963] pci_bus 0000:00: resource 7 [mem 0x90000000-0xfbffefff w=
indow]
> > [    1.212970] pci_bus 0000:02: resource 0 [io  0x5000-0x5fff]
> > [    1.212975] pci_bus 0000:02: resource 1 [mem 0x94800000-0x948fffff]
> > [    1.212981] pci_bus 0000:02: resource 2 [mem 0x94a00000-0x94afffff 6=
4bit pref]
> > [    1.212987] pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
> > [    1.212993] pci_bus 0000:03: resource 1 [mem 0x94700000-0x947fffff]
> > [    1.212998] pci_bus 0000:03: resource 2 [mem 0x94b00000-0x94cfffff 6=
4bit pref]
> > [    1.213005] pci_bus 0000:04: resource 0 [io  0x3000-0x3fff]
> > [    1.213010] pci_bus 0000:04: resource 1 [mem 0x94600000-0x946fffff]
> > [    1.213016] pci_bus 0000:04: resource 2 [mem 0x94000000-0x944fffff 6=
4bit pref]
> > [    1.213023] pci_bus 0000:07: resource 0 [io  0x2000-0x2fff]
> > [    1.213028] pci_bus 0000:07: resource 1 [mem 0x94500000-0x945fffff]
> > [    1.213033] pci_bus 0000:07: resource 2 [mem 0x90000000-0x93ffffff 6=
4bit pref]
> > [    1.213040] pci_bus 0000:08: resource 4 [io  0x0000-0x0cf7 window]
> > [    1.213045] pci_bus 0000:08: resource 5 [io  0x1000-0xffff window]
> > [    1.213051] pci_bus 0000:08: resource 6 [mem 0x000a0000-0x000bffff w=
indow]
> > [    1.213057] pci_bus 0000:08: resource 7 [mem 0x90000000-0xfbffefff w=
indow]
> > [    1.213200] pci 0000:00:05.0: disabled boot interrupts on device [80=
86:3c28]
> > [    1.224081] pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0x180 took=
 10597 usecs
> > [    1.235070] pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x180 took=
 10699 usecs
> > [    1.235227] PCI: CLS 64 bytes, default 64
> > [    1.235353] Trying to unpack rootfs image as initramfs...
> > [    1.235404] DMAR: No SATC found
> > [    1.235411] DMAR: dmar0: Using Queued invalidation
> > [    1.235626] pci 0000:00:00.0: Adding to iommu group 0
> > [    1.235673] pci 0000:00:01.0: Adding to iommu group 1
> > [    1.235712] pci 0000:00:01.1: Adding to iommu group 2
> > [    1.235761] pci 0000:00:03.0: Adding to iommu group 3
> > [    1.235804] pci 0000:00:04.0: Adding to iommu group 4
> > [    1.235841] pci 0000:00:04.1: Adding to iommu group 5
> > [    1.235877] pci 0000:00:04.2: Adding to iommu group 6
> > [    1.235925] pci 0000:00:04.3: Adding to iommu group 7
> > [    1.235963] pci 0000:00:04.4: Adding to iommu group 8
> > [    1.235999] pci 0000:00:04.5: Adding to iommu group 9
> > [    1.236036] pci 0000:00:04.6: Adding to iommu group 10
> > [    1.236082] pci 0000:00:04.7: Adding to iommu group 11
> > [    1.236119] pci 0000:00:05.0: Adding to iommu group 12
> > [    1.236157] pci 0000:00:05.2: Adding to iommu group 13
> > [    1.236215] pci 0000:00:05.4: Adding to iommu group 14
> > [    1.236255] pci 0000:00:11.0: Adding to iommu group 15
> > [    1.236333] pci 0000:00:16.0: Adding to iommu group 16
> > [    1.236379] pci 0000:00:16.1: Adding to iommu group 16
> > [    1.236417] pci 0000:00:1a.0: Adding to iommu group 17
> > [    1.236440] pci 0000:00:1c.0: Enabling MPC IRBNCE
> > [    1.236447] pci 0000:00:1c.0: Intel PCH root port ACS workaround ena=
bled
> > [    1.236494] pci 0000:00:1c.0: Adding to iommu group 18
> > [    1.236512] pci 0000:00:1c.2: Enabling MPC IRBNCE
> > [    1.236519] pci 0000:00:1c.2: Intel PCH root port ACS workaround ena=
bled
> > [    1.236556] pci 0000:00:1c.2: Adding to iommu group 19
> > [    1.236572] pci 0000:00:1c.3: Enabling MPC IRBNCE
> > [    1.236579] pci 0000:00:1c.3: Intel PCH root port ACS workaround ena=
bled
> > [    1.236616] pci 0000:00:1c.3: Adding to iommu group 20
> > [    1.236653] pci 0000:00:1d.0: Adding to iommu group 21
> > [    1.236690] pci 0000:00:1e.0: Adding to iommu group 22
> > [    1.236813] pci 0000:00:1f.0: Adding to iommu group 23
> > [    1.236854] pci 0000:00:1f.2: Adding to iommu group 23
> > [    1.236894] pci 0000:00:1f.3: Adding to iommu group 23
> > [    1.236948] pci 0000:00:1f.6: Adding to iommu group 23
> > [    1.236999] pci 0000:02:00.0: Adding to iommu group 24
> > [    1.237039] pci 0000:02:00.1: Adding to iommu group 25
> > [    1.237078] pci 0000:03:00.0: Adding to iommu group 26
> > [    1.237156] pci 0000:04:00.0: Adding to iommu group 27
> > [    1.237199] pci 0000:04:00.3: Adding to iommu group 27
> > [    1.237257] pci 0000:ff:08.0: Adding to iommu group 28
> > [    1.237297] pci 0000:ff:08.3: Adding to iommu group 29
> > [    1.237335] pci 0000:ff:08.4: Adding to iommu group 30
> > [    1.237402] pci 0000:ff:09.0: Adding to iommu group 31
> > [    1.237442] pci 0000:ff:09.3: Adding to iommu group 32
> > [    1.237480] pci 0000:ff:09.4: Adding to iommu group 33
> > [    1.237601] pci 0000:ff:0a.0: Adding to iommu group 34
> > [    1.237645] pci 0000:ff:0a.1: Adding to iommu group 34
> > [    1.237690] pci 0000:ff:0a.2: Adding to iommu group 34
> > [    1.237734] pci 0000:ff:0a.3: Adding to iommu group 34
> > [    1.237812] pci 0000:ff:0b.0: Adding to iommu group 35
> > [    1.237858] pci 0000:ff:0b.3: Adding to iommu group 35
> > [    1.238065] pci 0000:ff:0c.0: Adding to iommu group 36
> > [    1.238115] pci 0000:ff:0c.1: Adding to iommu group 36
> > [    1.238161] pci 0000:ff:0c.2: Adding to iommu group 36
> > [    1.238207] pci 0000:ff:0c.3: Adding to iommu group 36
> > [    1.238253] pci 0000:ff:0c.6: Adding to iommu group 36
> > [    1.238306] pci 0000:ff:0c.7: Adding to iommu group 36
> > [    1.238449] pci 0000:ff:0d.0: Adding to iommu group 37
> > [    1.238497] pci 0000:ff:0d.1: Adding to iommu group 37
> > [    1.238544] pci 0000:ff:0d.2: Adding to iommu group 37
> > [    1.238593] pci 0000:ff:0d.3: Adding to iommu group 37
> > [    1.238643] pci 0000:ff:0d.6: Adding to iommu group 37
> > [    1.238731] pci 0000:ff:0e.0: Adding to iommu group 38
> > [    1.238780] pci 0000:ff:0e.1: Adding to iommu group 38
> > [    1.238825] pci 0000:ff:0f.0: Adding to iommu group 39
> > [    1.238864] pci 0000:ff:0f.1: Adding to iommu group 40
> > [    1.238913] pci 0000:ff:0f.2: Adding to iommu group 41
> > [    1.238955] pci 0000:ff:0f.3: Adding to iommu group 42
> > [    1.238992] pci 0000:ff:0f.4: Adding to iommu group 43
> > [    1.239030] pci 0000:ff:0f.5: Adding to iommu group 44
> > [    1.239090] pci 0000:ff:0f.6: Adding to iommu group 45
> > [    1.239135] pci 0000:ff:10.0: Adding to iommu group 46
> > [    1.239173] pci 0000:ff:10.1: Adding to iommu group 47
> > [    1.239211] pci 0000:ff:10.2: Adding to iommu group 48
> > [    1.239248] pci 0000:ff:10.3: Adding to iommu group 49
> > [    1.239286] pci 0000:ff:10.5: Adding to iommu group 50
> > [    1.239324] pci 0000:ff:10.6: Adding to iommu group 51
> > [    1.239372] pci 0000:ff:10.7: Adding to iommu group 52
> > [    1.239431] pci 0000:ff:11.0: Adding to iommu group 53
> > [    1.239583] pci 0000:ff:13.0: Adding to iommu group 54
> > [    1.239636] pci 0000:ff:13.1: Adding to iommu group 54
> > [    1.239690] pci 0000:ff:13.4: Adding to iommu group 54
> > [    1.239743] pci 0000:ff:13.5: Adding to iommu group 54
> > [    1.239798] pci 0000:ff:13.6: Adding to iommu group 54
> > [    1.247333] DMAR: Intel(R) Virtualization Technology for Directed I/=
O
> > [    1.247360] PCI-DMA: Using software bounce buffering for IO (SWIOTLB=
)
> > [    1.247365] software IO TLB: mapped [mem 0x000000007a4ff000-0x000000=
007e4ff000] (64MB)
> > [    1.254624] Initialise system trusted keyrings
> > [    1.254689] Key type blacklist registered
> > [    1.254800] workingset: timestamp_bits=3D36 (anon: 31) max_order=3D2=
2 bucket_order=3D0 (anon: 0)
> > [    1.259015] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> > [    1.260148] fuse: init (API version 7.46)
> > [    1.260692] integrity: Platform Keyring initialized
> > [    1.260710] integrity: Machine keyring initialized
> > [    1.283221] Key type asymmetric registered
> > [    1.283242] Asymmetric key parser 'x509' registered
> > [    1.283341] Block layer SCSI generic (bsg) driver version 0.4 loaded=
 (major 242)
> > [    1.283525] io scheduler mq-deadline registered
> > [    1.285049] ledtrig-cpu: registered to indicate activity on CPUs
> > [    1.285716] pcieport 0000:00:01.0: PME: Signaling with IRQ 26
> > [    1.285854] pcieport 0000:00:01.0: AER: enabled with IRQ 26
> > [    1.286395] pcieport 0000:00:01.1: PME: Signaling with IRQ 27
> > [    1.286516] pcieport 0000:00:01.1: AER: enabled with IRQ 27
> > [    1.287028] pcieport 0000:00:03.0: PME: Signaling with IRQ 29
> > [    1.287190] pcieport 0000:00:03.0: AER: enabled with IRQ 29
> > [    1.287247] pcieport 0000:00:03.0: pciehp: Slot #3 AttnBtn- PwrCtrl-=
 MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LL=
ActRep+ (with Cmd Compl erratum)
> > [    1.287774] pcieport 0000:00:11.0: PME: Signaling with IRQ 30
> > [    1.287925] pcieport 0000:00:11.0: AER: enabled with IRQ 30
> > [    1.288041] pcieport 0000:00:1c.0: Intel PCH root port ACS workaroun=
d enabled
> > [    1.288298] pcieport 0000:00:1c.0: PME: Signaling with IRQ 31
> > [    1.288393] pcieport 0000:00:1c.2: Intel PCH root port ACS workaroun=
d enabled
> > [    1.288650] pcieport 0000:00:1c.2: PME: Signaling with IRQ 32
> > [    1.288744] pcieport 0000:00:1c.3: Intel PCH root port ACS workaroun=
d enabled
> > [    1.289012] pcieport 0000:00:1c.3: PME: Signaling with IRQ 33
> > [    1.289649] input: Power Button as /devices/platform/LNXPWRBN:00/inp=
ut/input0
> > [    1.289721] ACPI: button: Power Button [PWRF]
> > [    1.324661] ERST: Error Record Serialization Table (ERST) support is=
 initialized.
> > [    1.324736] pstore: Using crash dump compression: deflate
> > [    1.324744] pstore: Registered erst as persistent store backend
> > [    1.325141] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> > [    1.346043] 00:02: ttyS0 I/O:0x3f8 (irq =3D 4, base_baud =3D 115200)=
 is a 16550A
> > [    1.352660] ACPI: bus type drm_connector registered
> > [    1.363014] loop: module loaded
> > [    1.363692] tun: Universal TUN/TAP device driver, 1.6
> > [    1.364042] PPP generic driver version 2.4.2
> > [    1.364508] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] =
at 0x60,0x64 irq 1,12
> > [    1.364528] ehci-pci 0000:00:1a.0: EHCI Host Controller
> > [    1.364550] ehci-pci 0000:00:1a.0: new USB bus registered, assigned =
bus number 1
> > [    1.364573] ehci-pci 0000:00:1a.0: debug port 2
> > [    1.365022] serio: i8042 KBD port at 0x60,0x64 irq 1
> > [    1.365039] serio: i8042 AUX port at 0x60,0x64 irq 12
> > [    1.365244] mousedev: PS/2 mouse device common for all mice
> > [    1.365460] rtc_cmos PNP0B00:00: RTC can wake from S4
> > [    1.365890] rtc_cmos PNP0B00:00: registered as rtc0
> > [    1.365955] input: AT Translated Set 2 keyboard as /devices/platform=
/i8042/serio0/input/input1
> > [    1.365960] rtc_cmos PNP0B00:00: setting system clock to 2026-11-12T=
13:00:08 UTC (1794488408)
> > [    1.366029] rtc_cmos PNP0B00:00: alarms up to one month, y3k, 242 by=
tes nvram
> > [    1.366088] i2c_dev: i2c /dev entries driver
> > [    1.368603] ehci-pci 0000:00:1a.0: irq 16, io mem 0x94926000
> > [    1.369047] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabl=
ed. Duplicate IMA measurements will not be recorded in the IMA log.
> > [    1.369115] device-mapper: uevent: version 1.0.3
> > [    1.369234] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initiali=
sed: dm-devel@lists.linux.dev
> > [    1.369267] intel_pstate: Intel P-state driver initializing
> > [    1.370179] simple-framebuffer simple-framebuffer.0: [drm] Registere=
d 1 planes with drm panic
> > [    1.370219] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer=
.0 on minor 0
> > [    1.372069] Console: switching to colour frame buffer device 80x30
> > [    1.373299] simple-framebuffer simple-framebuffer.0: [drm] fb0: simp=
ledrmdrmfb frame buffer device
> > [    1.373459] drop_monitor: Initializing network drop monitor service
> > [    1.374892] NET: Registered PF_INET6 protocol family
> > [    1.374914] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
> > [    1.374999] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002, bcdDevice=3D 7.03
> > [    1.375868] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
> > [    1.376438] usb usb1: Product: EHCI Host Controller
> > [    1.376726] usb usb1: Manufacturer: Linux 7.3.4-070304-generic ehci_=
hcd
> > [    1.377035] usb usb1: SerialNumber: 0000:00:1a.0
> > [    1.377535] hub 1-0:1.0: USB hub found
> > [    1.377577] Segment Routing with IPv6
> > [    1.377846] hub 1-0:1.0: 2 ports detected
> > [    1.378311] In-situ OAM (IOAM) with IPv6
> > [    1.378789] ehci-pci 0000:00:1d.0: EHCI Host Controller
> > [    1.379050] NET: Registered PF_PACKET protocol family
> > [    1.379255] ehci-pci 0000:00:1d.0: new USB bus registered, assigned =
bus number 2
> > [    1.379756] Key type dns_resolver registered
> > [    1.380191] ehci-pci 0000:00:1d.0: debug port 2
> > [    1.384869] ehci-pci 0000:00:1d.0: irq 23, io mem 0x94925000
> > [    1.386622] microcode: Current revision: 0x0000071a
> > [    1.386882] microcode: Updated early from: 0x00000714
> > [    1.388668] IPI shorthand broadcast: enabled
> > [    1.390937] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
> > [    1.391281] usb usb2: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002, bcdDevice=3D 7.03
> > [    1.391867] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
> > [    1.392353] usb usb2: Product: EHCI Host Controller
> > [    1.392592] usb usb2: Manufacturer: Linux 7.3.4-070304-generic ehci_=
hcd
> > [    1.392830] usb usb2: SerialNumber: 0000:00:1d.0
> > [    1.393383] hub 2-0:1.0: USB hub found
> > [    1.393669] hub 2-0:1.0: 2 ports detected
> > [    1.394252] sched_clock: Marking stable (1285314818, 108589731)->(14=
58784064, -64879515)
> > [    1.395823] registered taskstats version 1
> > [    1.401915] Loading compiled-in X.509 certificates
> > [    1.406364] Loaded X.509 cert 'Build time autogenerated kernel key: =
bc369202f2670964b9a75b8b11b220b98aacf725'
> > [    1.408022] Loaded X.509 cert 'Canonical Ltd. Live Patch Signing 202=
5 Kmod: d541cef61dc7e793b7eb7e899970a2eef0b5dc8c'
> > [    1.409755] Loaded X.509 cert 'Canonical Ltd. Live Patch Signing: 14=
df34d1a87cf37625abec039ef2bf521249b969'
> > [    1.411435] Loaded X.509 cert 'Canonical Ltd. Kernel Module Signing =
2025 Kmod: 4627603d2357a2a3f81006370894c221175893e9'
> > [    1.413123] Loaded X.509 cert 'Canonical Ltd. Kernel Module Signing:=
 88f752e560a1e0737e31163a466ad7b70a850c19'
> > [    1.413632] blacklist: Loading compiled-in revocation X.509 certific=
ates
> > [    1.413959] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing: 6=
1482aa2830d0ab2ad5af10b7250da9033ddcef0'
> > [    1.414522] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2=
017): 242ade75ac4a15e50d50c84b0d45ff3eae707a03'
> > [    1.415123] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (E=
SM 2018): 365188c1d374d6b07c3c8f240f8ef722433d6a8b'
> > [    1.415721] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2=
019): c0746fd6c5da3ae827864651ad66ae47fe24b3e8'
> > [    1.416334] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2=
021 v1): a8d54bbb3825cfb94fa13c9f8a594a195c107b8d'
> > [    1.416942] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2=
021 v2): 4cf046892d6fd3c9a5b03f98d845f90851dc6a8c'
> > [    1.417548] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (2=
021 v3): 100437bb6de6e469b581e61cd66bce3ef4ed53af'
> > [    1.418245] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing (U=
buntu Core 2019): c1d57b8f6b743f23ee41f4f7ee292f06eecadfb9'
> > [    1.428588] Demotion targets for Node 0: null
> > [    1.429081] Key type .fscrypt registered
> > [    1.429388] Key type fscrypt-provisioning registered
> > [    1.429935] Key type big_key registered
> > [    1.430239] Key type encrypted registered
> > [    1.430529] AppArmor: AppArmor sha256 policy hashing enabled
> > [    1.430817] ima: No TPM chip found, activating TPM-bypass!
> > [    1.431121] Loading compiled-in module X.509 certificates
> > [    1.432586] Loaded X.509 cert 'Build time autogenerated kernel key: =
bc369202f2670964b9a75b8b11b220b98aacf725'
> > [    1.433148] ima: Allocated hash algorithm: sha256
> > [    1.433554] ima: No architecture policies found
> > [    1.433858] evm: Initialising EVM extended attributes:
> > [    1.434145] evm: security.selinux
> > [    1.434406] evm: security.SMACK64
> > [    1.434658] evm: security.SMACK64EXEC
> > [    1.434907] evm: security.SMACK64TRANSMUTE
> > [    1.435148] evm: security.SMACK64MMAP
> > [    1.435375] evm: security.apparmor
> > [    1.435591] evm: security.ima
> > [    1.435798] evm: security.capability
> > [    1.436010] evm: HMAC attrs: 0x1
> > [    1.436759] PM:   Magic number: 2:273:28
> > [    1.437090] memory memory68: hash matches
> > [    1.437826] RAS: Correctable Errors collector initialized.
> > [    1.438757] clk: Disabling unused clocks
> > [    1.438957] PM: genpd: Disabling unused power domains
> > [    1.472611] Freeing initrd memory: 69876K
> > [    1.479423] Freeing unused decrypted memory: 2028K
> > [    1.481129] Freeing unused kernel image (initmem) memory: 5468K
> > [    1.481495] Write protecting the kernel read-only data: 43008k
> > [    1.482384] Freeing unused kernel image (text/rodata gap) memory: 18=
4K
> > [    1.483094] Freeing unused kernel image (rodata/data gap) memory: 70=
8K
> > [    1.571274] x86/mm: Checked W+X mappings: passed, no W+X pages found=
.
> > [    1.571468] x86/mm: Checking user space page tables
> > [    1.616687] usb 1-1: new high-speed USB device number 2 using ehci-p=
ci
> > [    1.632681] usb 2-1: new high-speed USB device number 2 using ehci-p=
ci
> > [    1.634629] workqueue: drm_fb_helper_damage_work hogged CPU for >133=
33us 4 times, consider switching to WQ_UNBOUND
> > [    1.656305] x86/mm: Checked W+X mappings: passed, no W+X pages found=
.
> > [    1.656493] Run /init as init process
> > [    1.656677]   with arguments:
> > [    1.656681]     /init
> > [    1.656683]   with environment:
> > [    1.656685]     HOME=3D/
> > [    1.656687]     TERM=3Dlinux
> > [    1.708626] workqueue: drm_fb_helper_damage_work hogged CPU for >133=
33us 5 times, consider switching to WQ_UNBOUND
> > [    1.745139] usb 1-1: New USB device found, idVendor=3D8087, idProduc=
t=3D0024, bcdDevice=3D 0.00
> > [    1.748188] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, S=
erialNumber=3D0
> > [    1.749673] hub 1-1:1.0: USB hub found
> > [    1.750819] hub 1-1:1.0: 6 ports detected
> > [    1.762819] usb 2-1: New USB device found, idVendor=3D8087, idProduc=
t=3D0024, bcdDevice=3D 0.00
> > [    1.765597] usb 2-1: New USB device strings: Mfr=3D0, Product=3D0, S=
erialNumber=3D0
> > [    1.767116] hub 2-1:1.0: USB hub found
> > [    1.768317] hub 2-1:1.0: 8 ports detected
> > [    1.854624] workqueue: drm_fb_helper_damage_work hogged CPU for >133=
33us 7 times, consider switching to WQ_UNBOUND
> > [    1.995916] dca service started, version 1.12.1
> > [    2.011252] megasas: 07.734.00.00-rc1
> > [    2.012345] megaraid_sas 0000:03:00.0: BAR:0x1  BAR's base_addr(phys=
):0x0000000094740000  mapped virt_addr:0x(____ptrval____)
> > [    2.012357] megaraid_sas 0000:03:00.0: FW now in Ready state
> > [    2.012827] megaraid_sas 0000:03:00.0: 63 bit DMA mask and 32 bit co=
nsistent mask
> > [    2.014376] megaraid_sas 0000:03:00.0: firmware supports msix      :=
 (16)
> > [    2.016185] megaraid_sas 0000:03:00.0: requested/available msix 16/1=
6 poll_queue 0
> > [    2.017146] megaraid_sas 0000:03:00.0: current msix/max num queues :=
 (16/16)
> > [    2.017655] megaraid_sas 0000:03:00.0: RDPQ mode   : (disabled)
> > [    2.018153] megaraid_sas 0000:03:00.0: Current firmware supports max=
imum commands: 1008     LDIO threshold: 0
> > [    2.021509] ahci 0000:00:1f.2: AHCI vers 0001.0300, 32 command slots=
, 6 Gbps, SATA mode
> > [    2.022484] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f=
)
> > [    2.023000] ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck led clo pi=
o slum part ems apst
> > [    2.025723] megaraid_sas 0000:03:00.0: Performance mode :Latency (la=
tency index =3D 1)
> > [    2.026659] megaraid_sas 0000:03:00.0: FW supports sync cache      :=
 No
> > [    2.027135] megaraid_sas 0000:03:00.0: megasas_disable_intr_fusion i=
s called outbound_intr_mask:0x40000009
> > [    2.041246] scsi host1: ahci
> > [    2.042397] scsi host2: ahci
> > [    2.043276] scsi host3: ahci
> > [    2.044088] scsi host4: ahci
> > [    2.045178] scsi host5: ahci
> > [    2.046028] scsi host6: ahci
> > [    2.046568] ata1: SATA max UDMA/133 abar m2048@0x94924000 port 0x949=
24100 irq 50 lpm-pol 1 ext
> > [    2.047262] ata2: SATA max UDMA/133 abar m2048@0x94924000 port 0x949=
24180 irq 50 lpm-pol 1 ext
> > [    2.047866] ata3: SATA max UDMA/133 abar m2048@0x94924000 port 0x949=
24200 irq 50 lpm-pol 1 ext
> > [    2.048382] ata4: SATA max UDMA/133 abar m2048@0x94924000 port 0x949=
24280 irq 50 lpm-pol 1 ext
> > [    2.049254] ata5: SATA max UDMA/133 abar m2048@0x94924000 port 0x949=
24300 irq 50 lpm-pol 1 ext
> > [    2.049909] ata6: SATA max UDMA/133 abar m2048@0x94924000 port 0x949=
24380 irq 50 lpm-pol 1 ext
> > [    2.057404] igb: Intel(R) Gigabit Ethernet Network Driver
> > [    2.057703] igb: Copyright (c) 2007-2014 Intel Corporation.
> > [    2.059632] igb 0000:02:00.0: PHY reset is blocked due to SOL/IDER s=
ession.
> > [    2.063575] isci: Intel(R) C600 SAS Controller Driver - version 1.2.=
0
> > [    2.063907] isci 0000:04:00.0: driver configured for rev: 6 silicon
> > [    2.064184] isci 0000:04:00.0: OEM parameter table found in OROM
> > [    2.064440] isci 0000:04:00.0: [0]: invalid oem parameters detected,=
 falling back to firmware
> > [    2.065055] isci 0000:04:00.0: OEM SAS parameters (version: 1.3) loa=
ded (firmware)
> > [    2.066340] isci 0000:04:00.0: SCU controller 0: phy 3-0 cables: {sh=
ort, short, short, short}
> > [    2.070630] megaraid_sas 0000:03:00.0: FW provided supportMaxExtLDs:=
 0     max_lds: 64
> > [    2.071181] megaraid_sas 0000:03:00.0: controller type     : MR(512M=
B)
> > [    2.071467] megaraid_sas 0000:03:00.0: Online Controller Reset(OCR) =
       : Enabled
> > [    2.071778] megaraid_sas 0000:03:00.0: Secure JBOD support : No
> > [    2.072072] megaraid_sas 0000:03:00.0: NVMe passthru support       :=
 No
> > [    2.072359] megaraid_sas 0000:03:00.0: FW provided TM TaskAbort/Rese=
t timeout      : 0 secs/0 secs
> > [    2.072929] megaraid_sas 0000:03:00.0: JBOD sequence map support   :=
 No
> > [    2.073212] megaraid_sas 0000:03:00.0: PCI Lane Margining support  :=
 No
> > [    2.077295] scsi host7: isci
> > [    2.096609] megaraid_sas 0000:03:00.0: megasas_enable_intr_fusion is=
 called outbound_intr_mask:0x40000000
> > [    2.097159] megaraid_sas 0000:03:00.0: INIT adapter done
> > [    2.097427] megaraid_sas 0000:03:00.0: JBOD sequence map is disabled=
 megasas_setup_jbod_map 5812
> > [    2.098357] megaraid_sas 0000:03:00.0: pci id              : (0x1000=
)/(0x005b)/(0x19e5)/(0xd205)
> > [    2.098905] megaraid_sas 0000:03:00.0: unevenspan support  : no
> > [    2.099172] megaraid_sas 0000:03:00.0: firmware crash dump : no
> > [    2.099435] megaraid_sas 0000:03:00.0: JBOD sequence map   : disable=
d
> > [    2.099908] megaraid_sas 0000:03:00.0: Max firmware commands: 1007 s=
hared with default hw_queues =3D 15 poll_queues 0
> > [    2.100433] scsi host0: Avago SAS based MegaRAID driver
> > [    2.124886] scsi 0:2:0:0: Direct-Access     LSI      LSI            =
  3.19 PQ: 0 ANSI: 5
> > [    2.142025] igb 0000:02:00.0: added PHC on eth0
> > [    2.142477] igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Conn=
ection
> > [    2.142751] igb 0000:02:00.0: eth0: (PCIe:5.0Gb/s:Width x4) 48:46:fb=
:08:86:e1
> > [    2.143118] igb 0000:02:00.0: eth0: PBA No: 106300-000
> > [    2.143357] igb 0000:02:00.0: Using MSI-X interrupts. 8 rx queue(s),=
 8 tx queue(s)
> > [    2.146141] igb 0000:02:00.1: PHY reset is blocked due to SOL/IDER s=
ession.
> > [    2.156614] workqueue: drm_fb_helper_damage_work hogged CPU for >133=
33us 11 times, consider switching to WQ_UNBOUND
> > [    2.219618] igb 0000:02:00.1: added PHC on eth1
> > [    2.220122] igb 0000:02:00.1: Intel(R) Gigabit Ethernet Network Conn=
ection
> > [    2.220377] igb 0000:02:00.1: eth1: (PCIe:5.0Gb/s:Width x4) 48:46:fb=
:08:86:e2
> > [    2.220789] igb 0000:02:00.1: eth1: PBA No: 106300-000
> > [    2.221037] igb 0000:02:00.1: Using MSI-X interrupts. 8 rx queue(s),=
 8 tx queue(s)
> > [    2.280719] tsc: Refined TSC clocksource calibration: 1799.871 MHz
> > [    2.280989] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0=
x19f1afb6df9, max_idle_ns: 440795282544 ns
> > [    2.281830] clocksource: Switched to clocksource tsc
> > [    2.374651] ata6: SATA link down (SStatus 0 SControl 300)
> > [    2.374940] ata1: SATA link down (SStatus 0 SControl 300)
> > [    2.376994] ata5: SATA link down (SStatus 0 SControl 300)
> > [    2.378894] ata2: SATA link down (SStatus 0 SControl 300)
> > [    2.381000] ata3: SATA link down (SStatus 0 SControl 300)
> > [    2.383351] ata4: SATA link down (SStatus 0 SControl 300)
> > [    2.497414] sd 0:2:0:0: [sda] 486326272 512-byte logical blocks: (24=
9 GB/232 GiB)
> > [    2.497827] sd 0:2:0:0: Attached scsi generic sg0 type 0
> > [    2.498036] sd 0:2:0:0: [sda] Write Protect is off
> > [    2.498345] sd 0:2:0:0: [sda] Mode Sense: 1f 00 00 08
> > [    2.498623] sd 0:2:0:0: [sda] Write cache: enabled, read cache: enab=
led, doesn't support DPO or FUA
> > [    2.526139]  sda: sda1 sda2 sda3
> > [    2.528274] sd 0:2:0:0: [sda] Attached SCSI disk
> > [    2.535524] igb 0000:02:00.0 enp2s0f0: renamed from eth0
> > [    2.536306] igb 0000:02:00.1 enp2s0f1: renamed from eth1
> > [    2.806614] random: crng init done
> > [    2.985633] workqueue: drm_fb_helper_damage_work hogged CPU for >133=
33us 19 times, consider switching to WQ_UNBOUND
> > [    3.048123] clocksource: Watchdog hpet read timed out. Readout seque=
nce took: 89746ns
> > [    3.093475] input: PS/2 Generic Mouse as /devices/platform/i8042/ser=
io1/input/input3
> > [    3.132763] xor: automatically using best checksumming function   av=
x
> > [    3.140019] raid6: using ssse3x2 recovery algorithm
> > [    3.144886] raid6: sse2x1   gen()  7129 MB/s
> > [    3.148072] raid6: sse2x2   gen()  8860 MB/s
> > [    3.151231] raid6: sse2x4   gen()  8909 MB/s
> > [    3.151440] raid6: using algorithm sse2x4 gen() 8909 MB/s
> > [    3.154187] raid6: .... xor() 5175 MB/s, rmw enabled
> > [    3.157525] async_tx: api initialized (async)
> > [    3.528450] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
> > [    4.292187] SGI XFS with ACLs, security attributes, realtime, quota,=
 no debug enabled
> > [    4.321690] XFS (dm-0): Mounting V5 Filesystem 0f0e5bf5-7b46-4ea9-90=
36-e94dc2d615f4
> > [    4.337362] XFS (dm-0): Ending clean mount
> > [    4.551977] systemd[1]: Inserted module 'autofs4'
> > [    4.561093] clocksource: Watchdog hpet read timed out. Readout seque=
nce took: 75288ns
> > [    4.634517] systemd[1]: systemd 255.4-1ubuntu8 running in system mod=
e (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPE=
NSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSET=
UP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLI=
B +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=3Dunifi=
ed)
> > [    4.635801] systemd[1]: Detected architecture x86-64.
> > [    4.638494] systemd[1]: Hostname set to <ubuntu>.
> > [    4.971060] systemd[1]: Queued start job for default target graphica=
l.target.
> > [    5.038754] systemd[1]: Created slice system-modprobe.slice - Slice =
/system/modprobe.
> > [    5.063872] systemd[1]: Created slice system-systemd\x2dfsck.slice -=
 Slice /system/systemd-fsck.
> > [    5.084455] systemd[1]: Created slice user.slice - User and Session =
Slice.
> > [    5.093803] systemd[1]: Started systemd-ask-password-wall.path - For=
ward Password Requests to Wall Directory Watch.
> > [    5.109788] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.aut=
omount - Arbitrary Executable File Formats File System Automount Point.
> > [    5.117776] systemd[1]: Expecting device dev-disk-by\x2duuid-4e18c04=
f\x2de511\x2d426c\x2d9809\x2d4898a1ea6937.device - /dev/disk/by-uuid/4e18c0=
4f-e511-426c-9809-4898a1ea6937...
> > [    5.128294] systemd[1]: Reached target integritysetup.target - Local=
 Integrity Protected Volumes.
> > [    5.135733] systemd[1]: Reached target slices.target - Slice Units.
> > [    5.142250] systemd[1]: Reached target snapd.mounts-pre.target - Mou=
nting snaps.
> > [    5.150139] systemd[1]: Reached target snapd.mounts.target - Mounted=
 snaps.
> > [    5.157216] systemd[1]: Reached target veritysetup.target - Local Ve=
rity Protected Volumes.
> > [    5.170373] systemd[1]: Listening on dm-event.socket - Device-mapper=
 event daemon FIFOs.
> > [    5.187365] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 pol=
l daemon socket.
> > [    5.203583] systemd[1]: Listening on multipathd.socket - multipathd =
control socket.
> > [    5.204634] workqueue: drm_fb_helper_damage_work hogged CPU for >133=
33us 35 times, consider switching to WQ_UNBOUND
> > [    5.224646] systemd[1]: Listening on syslog.socket - Syslog Socket.
> > [    5.237429] systemd[1]: Listening on systemd-fsckd.socket - fsck to =
fsckd communication Socket.
> > [    5.249420] systemd[1]: Listening on systemd-initctl.socket - initct=
l Compatibility Named Pipe.
> > [    5.265129] systemd[1]: Listening on systemd-journald-dev-log.socket=
 - Journal Socket (/dev/log).
> > [    5.281102] systemd[1]: Listening on systemd-journald.socket - Journ=
al Socket.
> > [    5.296786] systemd[1]: Listening on systemd-networkd.socket - Netwo=
rk Service Netlink Socket.
> > [    5.305639] systemd[1]: systemd-pcrextend.socket - TPM2 PCR Extensio=
n (Varlink) was skipped because of an unmet condition check (ConditionSecur=
ity=3Dmeasured-uki).
> > [    5.321583] systemd[1]: Listening on systemd-udevd-control.socket - =
udev Control Socket.
> > [    5.336214] systemd[1]: Listening on systemd-udevd-kernel.socket - u=
dev Kernel Socket.
> > [    5.384933] systemd[1]: Mounting dev-hugepages.mount - Huge Pages Fi=
le System...
> > [    5.439135] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Qu=
eue File System...
> > [    5.484455] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Deb=
ug File System...
> > [    5.537728] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel T=
race File System...
> > [    5.596726] systemd[1]: Starting keyboard-setup.service - Set the co=
nsole keyboard layout...
> > [    5.647941] systemd[1]: Starting kmod-static-nodes.service - Create =
List of Static Device Nodes...
> > [    5.688792] systemd[1]: Starting lvm2-monitor.service - Monitoring o=
f LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
> > [    5.733772] systemd[1]: Starting modprobe@configfs.service - Load Ke=
rnel Module configfs...
> > [    5.781679] systemd[1]: Starting modprobe@dm_mod.service - Load Kern=
el Module dm_mod...
> > [    5.825742] systemd[1]: Starting modprobe@drm.service - Load Kernel =
Module drm...
> > [    5.871506] systemd[1]: Starting modprobe@efi_pstore.service - Load =
Kernel Module efi_pstore...
> > [    5.917194] systemd[1]: Starting modprobe@fuse.service - Load Kernel=
 Module fuse...
> > [    5.962968] systemd[1]: Starting modprobe@loop.service - Load Kernel=
 Module loop...
> > [    5.972552] systemd[1]: netplan-ovs-cleanup.service - OpenVSwitch co=
nfiguration for cleanup was skipped because of an unmet condition check (Co=
nditionFileIsExecutable=3D/usr/bin/ovs-vsctl).
> > [    5.981468] systemd[1]: systemd-fsck-root.service - File System Chec=
k on Root Device was skipped because of an unmet condition check (Condition=
PathExists=3D!/run/initramfs/fsck-root).
> > [    6.060022] systemd[1]: Starting systemd-journald.service - Journal =
Service...
> > [    6.063045] systemd[1]: Starting systemd-modules-load.service - Load=
 Kernel Modules...
> > [    6.064119] systemd[1]: systemd-pcrmachine.service - TPM2 PCR Machin=
e ID Measurement was skipped because of an unmet condition check (Condition=
Security=3Dmeasured-uki).
> > [    6.066547] systemd[1]: Starting systemd-remount-fs.service - Remoun=
t Root and Kernel File Systems...
> > [    6.067659] systemd[1]: systemd-tpm2-setup-early.service - TPM2 SRK =
Setup (Early) was skipped because of an unmet condition check (ConditionSec=
urity=3Dmeasured-uki).
> > [    6.070361] systemd[1]: Starting systemd-udev-trigger.service - Cold=
plug All udev Devices...
> > [    6.074167] systemd[1]: Mounted dev-hugepages.mount - Huge Pages Fil=
e System.
> > [    6.075168] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Que=
ue File System.
> > [    6.076426] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debu=
g File System.
> > [    6.077679] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Tr=
ace File System.
> > [    6.079133] systemd[1]: Finished keyboard-setup.service - Set the co=
nsole keyboard layout.
> > [    6.080736] systemd[1]: Finished kmod-static-nodes.service - Create =
List of Static Device Nodes.
> > [    6.082097] systemd-journald[491]: Collecting audit messages is disa=
bled.
> > [    6.082311] systemd[1]: Finished lvm2-monitor.service - Monitoring o=
f LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
> > [    6.084050] systemd[1]: modprobe@configfs.service: Deactivated succe=
ssfully.
> > [    6.084678] systemd[1]: Finished modprobe@configfs.service - Load Ke=
rnel Module configfs.
> > [    6.087442] systemd[1]: modprobe@dm_mod.service: Deactivated success=
fully.
> > [    6.088077] systemd[1]: Finished modprobe@dm_mod.service - Load Kern=
el Module dm_mod.
> > [    6.089707] systemd[1]: modprobe@drm.service: Deactivated successful=
ly.
> > [    6.090306] systemd[1]: Finished modprobe@drm.service - Load Kernel =
Module drm.
> > [    6.091839] systemd[1]: modprobe@efi_pstore.service: Deactivated suc=
cessfully.
> > [    6.092802] systemd[1]: Finished modprobe@efi_pstore.service - Load =
Kernel Module efi_pstore.
> > [    6.094328] systemd[1]: modprobe@fuse.service: Deactivated successfu=
lly.
> > [    6.094931] systemd[1]: Finished modprobe@fuse.service - Load Kernel=
 Module fuse.
> > [    6.096442] systemd[1]: modprobe@loop.service: Deactivated successfu=
lly.
> > [    6.097272] systemd[1]: Finished modprobe@loop.service - Load Kernel=
 Module loop.
> > [    6.098749] systemd[1]: Finished systemd-remount-fs.service - Remoun=
t Root and Kernel File Systems.
> > [    6.115827] systemd[1]: Activating swap swap.img.swap - /swap.img...
> > [    6.118415] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUS=
E Control File System...
> > [    6.121023] systemd[1]: Mounting sys-kernel-config.mount - Kernel Co=
nfiguration File System...
> > [    6.121161] Adding 4194300k swap on /swap.img.  Priority:-1 extents:=
1 across:4194300k
> > [    6.124188] systemd[1]: Starting multipathd.service - Device-Mapper =
Multipath Device Controller...
> > [    6.126188] systemd[1]: systemd-hwdb-update.service - Rebuild Hardwa=
re Database was skipped because of an unmet condition check (ConditionNeeds=
Update=3D/etc).
> > [    6.126909] systemd[1]: systemd-pstore.service - Platform Persistent=
 Storage Archival was skipped because of an unmet condition check (Conditio=
nDirectoryNotEmpty=3D/sys/fs/pstore).
> > [    6.129466] systemd[1]: Starting systemd-random-seed.service - Load/=
Save OS Random Seed...
> > [    6.130636] systemd[1]: systemd-repart.service - Repartition Root Di=
sk was skipped because no trigger condition checks were met.
> > [    6.132745] systemd[1]: Starting systemd-tmpfiles-setup-dev-early.se=
rvice - Create Static Device Nodes in /dev gracefully...
> > [    6.133818] systemd[1]: systemd-tpm2-setup.service - TPM2 SRK Setup =
was skipped because of an unmet condition check (ConditionSecurity=3Dmeasur=
ed-uki).
> > [    6.134565] systemd[1]: Activated swap swap.img.swap - /swap.img.
> > [    6.136978] systemd[1]: Finished systemd-modules-load.service - Load=
 Kernel Modules.
> > [    6.138484] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE=
 Control File System.
> > [    6.139742] systemd[1]: Mounted sys-kernel-config.mount - Kernel Con=
figuration File System.
> > [    6.157307] systemd[1]: Finished systemd-random-seed.service - Load/=
Save OS Random Seed.
> > [    6.181697] systemd[1]: Finished systemd-tmpfiles-setup-dev-early.se=
rvice - Create Static Device Nodes in /dev gracefully.
> > [    6.183351] systemd[1]: Reached target swap.target - Swaps.
> > [    6.190905] systemd[1]: Starting systemd-sysctl.service - Apply Kern=
el Variables...
> > [    6.192038] systemd[1]: systemd-sysusers.service - Create System Use=
rs was skipped because no trigger condition checks were met.
> > [    6.194271] systemd[1]: Starting systemd-tmpfiles-setup-dev.service =
- Create Static Device Nodes in /dev...
> > [    6.195550] systemd[1]: Started multipathd.service - Device-Mapper M=
ultipath Device Controller.
> > [    6.209545] systemd[1]: Finished systemd-sysctl.service - Apply Kern=
el Variables.
> > [    6.216091] systemd[1]: Finished systemd-tmpfiles-setup-dev.service =
- Create Static Device Nodes in /dev.
> > [    6.216713] systemd[1]: Reached target local-fs-pre.target - Prepara=
tion for Local File Systems.
> > [    6.223831] systemd[1]: Mounting run-qemu.mount - Prepare /run/qemu =
to allow still running qemu binaries of former builds (after package upgrad=
es) to fallback-load modules from there...
> > [    6.226523] systemd[1]: Starting systemd-udevd.service - Rule-based =
Manager for Device Events and Files...
> > [    6.228701] systemd[1]: Mounted run-qemu.mount - Prepare /run/qemu t=
o allow still running qemu binaries of former builds (after package upgrade=
s) to fallback-load modules from there.
> > [    6.229547] systemd[1]: Started systemd-journald.service - Journal S=
ervice.
> > [    6.265532] systemd-journald[491]: Received client request to flush =
runtime journal.
> > [    6.276886] systemd-journald[491]: /var/log/journal/f656842898f24f7c=
af37de6a688f6592/system.journal: Journal file uses a different sequence num=
ber ID, rotating.
> > [    6.276899] systemd-journald[491]: Rotating system journal.
> > [    6.582142] ioatdma: Intel(R) QuickData Technology Driver 5.00
> > [    6.614706] mei_me 0000:00:16.0: Device doesn't have valid ME Interf=
ace
> > [    6.626623] igb 0000:02:00.0: DCA enabled
> > [    6.629335] igb 0000:02:00.1: DCA enabled
> > [    6.693730] lpc_ich 0000:00:1f.0: No MFD cells added
> > [    6.724886] IPMI message handler: version 39.2
> > [    6.725077] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
> > [    6.725324] i801_smbus 0000:04:00.3: Enabling SMBus device
> > [    6.725363] i801_smbus 0000:04:00.3: SMBus using PCI interrupt
> > [    6.743499] ipmi device interface
> > [    6.753783] ipmi_si: IPMI System Interface driver
> > [    6.754087] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
> > [    6.754097] ipmi_platform: ipmi_si: SMBIOS: io 0xe4 regsize 1 spacin=
g 1 irq 0
> > [    6.754106] ipmi_si: Adding SMBIOS-specified bt state machine
> > [    6.754615] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 16=
3840 ms ovfl timer
> > [    6.754624] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
> > [    6.754629] RAPL PMU: hw unit of domain package 2^-16 Joules
> > [    6.754633] RAPL PMU: hw unit of domain dram 2^-16 Joules
> > [    6.754995] ipmi_si: Trying SMBIOS-specified bt state machine at i/o=
 address 0xe4, slave address 0x20, irq 0
> > [    6.756637] ipmi_si dmi-ipmi-si.0: bt cap response too short: 3
> > [    6.756647] ipmi_si dmi-ipmi-si.0: using default values
> > [    6.756652] ipmi_si dmi-ipmi-si.0: req2rsp=3D5 secs retries=3D2
> > [    6.831446] ipmi_si dmi-ipmi-si.0: IPMI message handler: Found new B=
MC (man_id: 0x0007db, prod_id: 0xaa11, dev_id: 0x01)
> > [    7.025656] ipmi_si dmi-ipmi-si.0: IPMI bt interface initialized
> > [    7.379572] EXT4-fs (sda2): mounted filesystem 4e18c04f-e511-426c-98=
09-4898a1ea6937 r/w with ordered data mode. Quota mode: none.
> > [    7.437389] audit: type=3D1400 audit(1794488414.569:2): apparmor=3D"=
STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"ch-checkn=
s" pid=3D774 comm=3D"apparmor_parser"
> > [    7.437409] audit: type=3D1400 audit(1794488414.570:3): apparmor=3D"=
STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"crun" pid=
=3D778 comm=3D"apparmor_parser"
> > [    7.437890] audit: type=3D1400 audit(1794488414.571:4): apparmor=3D"=
STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"busybox" =
pid=3D772 comm=3D"apparmor_parser"
> > [    7.438069] audit: type=3D1400 audit(1794488414.571:5): apparmor=3D"=
STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"ch-run" p=
id=3D775 comm=3D"apparmor_parser"
> > [    7.438149] audit: type=3D1400 audit(1794488414.571:6): apparmor=3D"=
STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D4D6F6E676F=
444220436F6D70617373 pid=3D768 comm=3D"apparmor_parser"
> > [    7.438217] audit: type=3D1400 audit(1794488414.571:7): apparmor=3D"=
STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"buildah" =
pid=3D771 comm=3D"apparmor_parser"
> > [    7.438869] audit: type=3D1400 audit(1794488414.572:8): apparmor=3D"=
STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"Discord" =
pid=3D767 comm=3D"apparmor_parser"
> > [    7.438879] audit: type=3D1400 audit(1794488414.572:9): apparmor=3D"=
STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"1password=
" pid=3D766 comm=3D"apparmor_parser"
> > [    7.439054] audit: type=3D1400 audit(1794488414.572:10): apparmor=3D=
"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"devhelp"=
 pid=3D779 comm=3D"apparmor_parser"
> > [    7.439156] audit: type=3D1400 audit(1794488414.572:11): apparmor=3D=
"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"element-=
desktop" pid=3D780 comm=3D"apparmor_parser"
> > [    7.473508] EDAC sbridge: Seeking for: PCI ID 8086:3ca0
> > [    7.473559] EDAC sbridge: Seeking for: PCI ID 8086:3ca0
> > [    7.473571] EDAC sbridge: Seeking for: PCI ID 8086:3ca8
> > [    7.473583] EDAC sbridge: Seeking for: PCI ID 8086:3ca8
> > [    7.473589] EDAC sbridge: Seeking for: PCI ID 8086:3c71
> > [    7.473932] EDAC sbridge: Seeking for: PCI ID 8086:3c71
> > [    7.473940] EDAC sbridge: Seeking for: PCI ID 8086:3caa
> > [    7.473953] EDAC sbridge: Seeking for: PCI ID 8086:3caa
> > [    7.473959] EDAC sbridge: Seeking for: PCI ID 8086:3cab
> > [    7.473972] EDAC sbridge: Seeking for: PCI ID 8086:3cab
> > [    7.473977] EDAC sbridge: Seeking for: PCI ID 8086:3cac
> > [    7.473990] EDAC sbridge: Seeking for: PCI ID 8086:3cac
> > [    7.473995] EDAC sbridge: Seeking for: PCI ID 8086:3cad
> > [    7.474009] EDAC sbridge: Seeking for: PCI ID 8086:3cad
> > [    7.474015] EDAC sbridge: Seeking for: PCI ID 8086:3cb8
> > [    7.474030] EDAC sbridge: Seeking for: PCI ID 8086:3cb8
> > [    7.474036] EDAC sbridge: Seeking for: PCI ID 8086:3cf4
> > [    7.474049] EDAC sbridge: Seeking for: PCI ID 8086:3cf4
> > [    7.474057] EDAC sbridge: Seeking for: PCI ID 8086:3cf6
> > [    7.474071] EDAC sbridge: Seeking for: PCI ID 8086:3cf6
> > [    7.474079] EDAC sbridge: Seeking for: PCI ID 8086:3cf5
> > [    7.474094] EDAC sbridge: Seeking for: PCI ID 8086:3cf5
> > [    7.474278] EDAC MC0: Giving out device to module sb_edac controller=
 Sandy Bridge SrcID#0_Ha#0: DEV 0000:ff:0e.0 (INTERRUPT)
> > [    7.474286] EDAC sbridge:  Ver: 1.1.2
> > [    7.492696] intel_rapl_common: Found RAPL domain package
> > [    7.492707] intel_rapl_common: Found RAPL domain core
> > [    7.492716] intel_rapl_common: Found RAPL domain dram
> > [    7.839206] cfg80211: Loading compiled-in X.509 certificates for reg=
ulatory database
> > [    7.839833] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> > [    7.840211] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c724=
8db18c600'
> > [    7.896134] igb 0000:02:00.0 enp2s0f0: igb: enp2s0f0 NIC Link is Up =
1000 Mbps Full Duplex, Flow Control: RX
> > [    7.994661] /proc/cgroups lists only v1 controllers, use cgroup.cont=
rollers of root cgroup for v2 info
> > [    8.032642] workqueue: drm_fb_helper_damage_work hogged CPU for >133=
33us 67 times, consider switching to WQ_UNBOUND
> > [    8.089123] watchdog_print_freq_timeout: 6 callbacks suppressed
> > [    8.089132] clocksource: Watchdog hpet read timed out. Readout seque=
nce took: 87580ns
> > [    8.126359] loop0: detected capacity change from 0 to 8
> > [    8.161849] NET: Registered PF_QIPCRTR protocol family
> > [    9.096373] clocksource: Watchdog hpet read timed out. Readout seque=
nce took: 84857ns
>
> #regzbot introduced: 72780f796468
> #regzbot link: https://lore.kernel.org/all/CALJR0nehJ5+d7MrPk8rxkNmee_1L5=
FFsvuF+-swK1nyJ7oJJ8A@mail.gmail.com
>

--000000000000fddadf06604ea356
Content-Type: text/plain; charset="US-ASCII"; name="boot-7.3.4-070304-generic.txt"
Content-Disposition: attachment; filename="boot-7.3.4-070304-generic.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mwhq9yj60>
X-Attachment-Id: f_mwhq9yj60

IyMgdW5hbWUKNy4zLjQtMDcwMzA0LWdlbmVyaWMKIyMgcGNpIGRldmljZXMKNzgKIyMgdmdhL2Rp
c3BsYXkKKG5vbmUpCiMjIGRtZXNnOiAyLjVHVC9zIC8gcmV0cmFpbiAvIDE4Y2EKWyAgICAwLjk1
Nzg3Ml0gcGNpIDAwMDA6MDA6MWMuMzogcmVtb3ZpbmcgMi41R1QvcyBkb3duc3RyZWFtIGxpbmsg
c3BlZWQgcmVzdHJpY3Rpb24KIyMgMDA6MWMuMwoJCUxua0NhcDoJUG9ydCAjNCwgU3BlZWQgNUdU
L3MsIFdpZHRoIHgxLCBBU1BNIEwwcyBMMSwgRXhpdCBMYXRlbmN5IEwwcyA8NTEybnMsIEwxIDw0
dXMKCQlMbmtTdGE6CVNwZWVkIDIuNUdUL3MsIFdpZHRoIHgxCgkJTG5rQ3RsMjogVGFyZ2V0IExp
bmsgU3BlZWQ6IDVHVC9zLCBFbnRlckNvbXBsaWFuY2UtIFNwZWVkRGlzLQojIyAwNzowMC4wCihh
YnNlbnQpCiMjIGZiCmZiMCBmYmNvbiAKc2ltcGxlZHJtZHJtZmIKIyMgY21kbGluZQpCT09UX0lN
QUdFPS92bWxpbnV6LTcuMy40LTA3MDMwNC1nZW5lcmljIHJvb3Q9L2Rldi9tYXBwZXIvdWJ1bnR1
LS12Zy11YnVudHUtLWx2IHJvCg==
--000000000000fddadf06604ea356
Content-Type: text/plain; charset="US-ASCII"; name="boot-7.3.4-revert.txt"
Content-Disposition: attachment; filename="boot-7.3.4-revert.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mwhq9yk51>
X-Attachment-Id: f_mwhq9yk51

IyMgdW5hbWUKNy4zLjQtcmV2ZXJ0CiMjIHBjaSBkZXZpY2VzCjc5CiMjIHZnYS9kaXNwbGF5CjA3
OjAwLjAgVkdBIGNvbXBhdGlibGUgY29udHJvbGxlciBbMDMwMF06IFhHSSBUZWNobm9sb2d5IElu
Yy4gKGVYdHJlbWUgR3JhcGhpY3MgSW5ub3ZhdGlvbikgWjExL1oxMU0gWzE4Y2E6MDAyN10KIyMg
ZG1lc2c6IDIuNUdUL3MgLyByZXRyYWluIC8gMThjYQpbICAgIDAuOTM1Njk1XSBwY2kgMDAwMDow
NzowMC4wOiBbMThjYTowMDI3XSB0eXBlIDAwIGNsYXNzIDB4MDMwMDAwIFBDSWUgRW5kcG9pbnQK
IyMgMDA6MWMuMwoJCUxua0NhcDoJUG9ydCAjNCwgU3BlZWQgNUdUL3MsIFdpZHRoIHgxLCBBU1BN
IEwwcyBMMSwgRXhpdCBMYXRlbmN5IEwwcyA8NTEybnMsIEwxIDw0dXMKCQlMbmtTdGE6CVNwZWVk
IDIuNUdUL3MsIFdpZHRoIHgxCgkJTG5rQ3RsMjogVGFyZ2V0IExpbmsgU3BlZWQ6IDIuNUdUL3Ms
IEVudGVyQ29tcGxpYW5jZS0gU3BlZWREaXMtCiMjIDA3OjAwLjAKCQlMbmtDYXA6CVBvcnQgIzAs
IFNwZWVkIDIuNUdUL3MsIFdpZHRoIHgxLCBBU1BNIEwwcyBMMSwgRXhpdCBMYXRlbmN5IEwwcyA8
MXVzLCBMMSA8NHVzCgkJTG5rU3RhOglTcGVlZCAyLjVHVC9zLCBXaWR0aCB4MQojIyBmYgpmYjAg
ZmJjb24gCnNpbXBsZWRybWRybWZiCiMjIGNtZGxpbmUKQk9PVF9JTUFHRT0vdm1saW51ei03LjMu
NC1yZXZlcnQgcm9vdD0vZGV2L21hcHBlci91YnVudHUtLXZnLXVidW50dS0tbHYgcm8K
--000000000000fddadf06604ea356
Content-Type: text/plain; charset="US-ASCII"; name="lspci-07-00.0-7.3.4-revert.txt"
Content-Disposition: attachment; filename="lspci-07-00.0-7.3.4-revert.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mwhq9ylm4>
X-Attachment-Id: f_mwhq9ylm4

MDc6MDAuMCBWR0EgY29tcGF0aWJsZSBjb250cm9sbGVyOiBYR0kgVGVjaG5vbG9neSBJbmMuIChl
WHRyZW1lIEdyYXBoaWNzIElubm92YXRpb24pIFoxMS9aMTFNIChwcm9nLWlmIDAwIFtWR0EgY29u
dHJvbGxlcl0pCglTdWJzeXN0ZW06IEh1YXdlaSBUZWNobm9sb2dpZXMgQ28uLCBMdGQuIFoxMS9a
MTFNCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZH
QVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVz
OiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0g
PFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMCwgQ2FjaGUg
TGluZSBTaXplOiA2NCBieXRlcwoJSU9NTVUgZ3JvdXA6IDI4CglCSVNUIHJlc3VsdDogMDAKCVJl
Z2lvbiAwOiBNZW1vcnkgYXQgOTAwMDAwMDAgKDMyLWJpdCwgcHJlZmV0Y2hhYmxlKSBbc2l6ZT02
NE1dCglSZWdpb24gMTogTWVtb3J5IGF0IDk0NTAwMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFi
bGUpIFtzaXplPTI1NktdCglSZWdpb24gMjogSS9PIHBvcnRzIGF0IDIwMDAgW3NpemU9MTI4XQoJ
RXhwYW5zaW9uIFJPTSBhdCAwMDBjMDAwMCBbdmlydHVhbF0gW2Rpc2FibGVkXSBbc2l6ZT0xMjhL
XQoJQ2FwYWJpbGl0aWVzOiBbNDBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyCgkJRmxhZ3M6
IFBNRUNsay0gRFNJLSBEMSsgRDIrIEF1eEN1cnJlbnQ9MG1BIFBNRShEMC0sRDEtLEQyLSxEM2hv
dC0sRDNjb2xkLSkKCQlTdGF0dXM6IEQwIE5vU29mdFJzdC0gUE1FLUVuYWJsZS0gRFNlbD0wIERT
Y2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczogW2EwXSBFeHByZXNzICh2MSkgRW5kcG9pbnQsIE1T
SSAwMQoJCURldkNhcDoJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIFBoYW50RnVuYyAwLCBMYXRlbmN5
IEwwcyA8MTI4bnMsIEwxIDwxdXMKCQkJRXh0VGFnKyBBdHRuQnRuLSBBdHRuSW5kLSBQd3JJbmQt
IFJCRSsgRkxSZXNldC0gU2xvdFBvd2VyTGltaXQgMTBXCgkJRGV2Q3RsOglDb3JyRXJyKyBOb25G
YXRhbEVycisgRmF0YWxFcnIrIFVuc3VwUmVxKwoJCQlSbHhkT3JkKyBFeHRUYWcrIFBoYW50RnVu
Yy0gQXV4UHdyLSBOb1Nub29wKwoJCQlNYXhQYXlsb2FkIDEyOCBieXRlcywgTWF4UmVhZFJlcSA1
MTIgYnl0ZXMKCQlEZXZTdGE6CUNvcnJFcnIrIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBS
ZXErIEF1eFB3ci0gVHJhbnNQZW5kLQoJCUxua0NhcDoJUG9ydCAjMCwgU3BlZWQgMi41R1Qvcywg
V2lkdGggeDEsIEFTUE0gTDBzIEwxLCBFeGl0IExhdGVuY3kgTDBzIDwxdXMsIEwxIDw0dXMKCQkJ
Q2xvY2tQTS0gU3VycHJpc2UrIExMQWN0UmVwKyBCd05vdC0gQVNQTU9wdENvbXAtCgkJTG5rQ3Rs
OglBU1BNIERpc2FibGVkOyBSQ0IgNjQgYnl0ZXMsIERpc2FibGVkLSBDb21tQ2xrKwoJCQlFeHRT
eW5jaC0gQ2xvY2tQTS0gQXV0V2lkRGlzLSBCV0ludC0gQXV0QldJbnQtCgkJTG5rU3RhOglTcGVl
ZCAyLjVHVC9zLCBXaWR0aCB4MQoJCQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlKyBC
V01nbXQtIEFCV01nbXQtCglDYXBhYmlsaXRpZXM6IFtjMF0gTVNJOiBFbmFibGUtIENvdW50PTEv
MSBNYXNrYWJsZS0gNjRiaXQtCgkJQWRkcmVzczogMDAwMDAwMDAgIERhdGE6IDAwMDAKCUNhcGFi
aWxpdGllczogWzEwMCB2MV0gQWR2YW5jZWQgRXJyb3IgUmVwb3J0aW5nCgkJVUVTdGE6CURMUC0g
U0RFUy0gVExQLSBGQ1AtIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZU
TFAtIEVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sLQoJCVVFTXNrOglETFAtIFNERVMtIFRMUC0gRkNQ
LSBDbXBsdFRPLSBDbXBsdEFicnQtIFVueENtcGx0LSBSeE9GLSBNYWxmVExQLSBFQ1JDLSBVbnN1
cFJlcS0gQUNTVmlvbC0KCQlVRVN2cnQ6CURMUCsgU0RFUysgVExQLSBGQ1ArIENtcGx0VE8tIENt
cGx0QWJydC0gVW54Q21wbHQtIFJ4T0YrIE1hbGZUTFArIEVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9s
LQoJCUNFU3RhOglSeEVyci0gQmFkVExQLSBCYWRETExQLSBSb2xsb3Zlci0gVGltZW91dC0gQWR2
Tm9uRmF0YWxFcnItCgkJQ0VNc2s6CVJ4RXJyLSBCYWRUTFAtIEJhZERMTFAtIFJvbGxvdmVyLSBU
aW1lb3V0LSBBZHZOb25GYXRhbEVyci0KCQlBRVJDYXA6CUZpcnN0IEVycm9yIFBvaW50ZXI6IDE0
LCBFQ1JDR2VuQ2FwLSBFQ1JDR2VuRW4tIEVDUkNDaGtDYXAtIEVDUkNDaGtFbi0KCQkJTXVsdEhk
clJlY0NhcC0gTXVsdEhkclJlY0VuLSBUTFBQZnhQcmVzLSBIZHJMb2dDYXAtCgkJSGVhZGVyTG9n
OiAwNDAwMDAwMSAwMDAwMDAwZiAwNzAxMDAwMCAwMDAwMDAwMAoK
--000000000000fddadf06604ea356
Content-Type: text/plain; charset="US-ASCII"; name="dmesg-7.3.4-revert.txt"
Content-Disposition: attachment; filename="dmesg-7.3.4-revert.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mwhq9ykk2>
X-Attachment-Id: f_mwhq9ykk2

WyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA3LjMuNC1yZXZlcnQgKHJvb3RAdWJ1bnR1KSAo
Z2NjIChVYnVudHUgMTMuMy4wLTZ1YnVudHUyfjI0LjA0LjEpIDEzLjMuMCwgR05VIGxkIChHTlUg
QmludXRpbHMgZm9yIFVidW50dSkgMi40MikgIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBTdW4gTm92
IDE1IDE4OjAyOjQ4IEhLVCAyMDI2ClsgICAgMC4wMDAwMDBdIENvbW1hbmQgbGluZTogQk9PVF9J
TUFHRT0vdm1saW51ei03LjMuNC1yZXZlcnQgcm9vdD0vZGV2L21hcHBlci91YnVudHUtLXZnLXVi
dW50dS0tbHYgcm8KWyAgICAwLjAwMDAwMF0gS0VSTkVMIHN1cHBvcnRlZCBjcHVzOgpbICAgIDAu
MDAwMDAwXSAgIEludGVsIEdlbnVpbmVJbnRlbApbICAgIDAuMDAwMDAwXSAgIEFNRCBBdXRoZW50
aWNBTUQKWyAgICAwLjAwMDAwMF0gICBIeWdvbiBIeWdvbkdlbnVpbmUKWyAgICAwLjAwMDAwMF0g
ICBDZW50YXVyIENlbnRhdXJIYXVscwpbICAgIDAuMDAwMDAwXSAgIHpoYW94aW4gICBTaGFuZ2hh
aSAgClsgICAgMC4wMDAwMDBdIEJJT1MtcHJvdmlkZWQgcGh5c2ljYWwgUkFNIG1hcDoKWyAgICAw
LjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDAwMDAwMDAwMC0weDAwMDAwMDAwMDAw
OWNmZmZdICBTeXN0ZW0gUkFNClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAw
MDAwMDAwOWQwMDAtMHgwMDAwMDAwMDAwMDlmZmZmXSAgZGV2aWNlIHJlc2VydmVkClsgICAgMC4w
MDAwMDBdIEJJT1MtZTgyMDogW2dhcCAweDAwMDAwMDAwMDAwYTAwMDAtMHgwMDAwMDAwMDAwMGRm
ZmZmXQpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDAwMGUwMDAwLTB4
MDAwMDAwMDAwMDBmZmZmZl0gIGRldmljZSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4
MjA6IFttZW0gMHgwMDAwMDAwMDAwMTAwMDAwLTB4MDAwMDAwMDAzZmZmZmZmZl0gIFN5c3RlbSBS
QU0KWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDA0MDAwMDAwMC0weDAw
MDAwMDAwNDAwZmZmZmZdICBkZXZpY2UgcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIw
OiBbbWVtIDB4MDAwMDAwMDA0MDEwMDAwMC0weDAwMDAwMDAwN2U0ZmVmZmZdICBTeXN0ZW0gUkFN
ClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwN2U0ZmYwMDAtMHgwMDAw
MDAwMDdlOGZlZmZmXSAgZGV2aWNlIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDog
W21lbSAweDAwMDAwMDAwN2U4ZmYwMDAtMHgwMDAwMDAwMDdlZWZlZmZmXSAgQUNQSSBOVlMKWyAg
ICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDA3ZWVmZjAwMC0weDAwMDAwMDAw
N2VmZmVmZmZdICBBQ1BJIGRhdGEKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAw
MDAwMDA3ZWZmZjAwMC0weDAwMDAwMDAwN2VmZmZmZmZdICBTeXN0ZW0gUkFNClsgICAgMC4wMDAw
MDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwN2YwMDAwMDAtMHgwMDAwMDAwMDhmZmZmZmZm
XSAgZGV2aWNlIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW2dhcCAweDAwMDAw
MDAwOTAwMDAwMDAtMHgwMDAwMDAwMGZlYWZmZmZmXQpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6
IFttZW0gMHgwMDAwMDAwMGZlYjAwMDAwLTB4MDAwMDAwMDBmZWIwM2ZmZl0gIGRldmljZSByZXNl
cnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFtnYXAgMHgwMDAwMDAwMGZlYjA0MDAwLTB4
MDAwMDAwMDBmZWJmZmZmZl0KWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAw
MDBmZWMwMDAwMC0weDAwMDAwMDAwZmVjMDBmZmZdICBkZXZpY2UgcmVzZXJ2ZWQKWyAgICAwLjAw
MDAwMF0gQklPUy1lODIwOiBbZ2FwIDB4MDAwMDAwMDBmZWMwMTAwMC0weDAwMDAwMDAwZmVkMTdm
ZmZdClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwZmVkMTgwMDAtMHgw
MDAwMDAwMGZlZDE4ZmZmXSAgZGV2aWNlIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgy
MDogW2dhcCAweDAwMDAwMDAwZmVkMTkwMDAtMHgwMDAwMDAwMGZlZDFiZmZmXQpbICAgIDAuMDAw
MDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGZlZDFjMDAwLTB4MDAwMDAwMDBmZWQ4ZmZm
Zl0gIGRldmljZSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFtnYXAgMHgwMDAw
MDAwMGZlZDkwMDAwLTB4MDAwMDAwMDBmZWRmZmZmZl0KWyAgICAwLjAwMDAwMF0gQklPUy1lODIw
OiBbbWVtIDB4MDAwMDAwMDBmZWUwMDAwMC0weDAwMDAwMDAwZmVlMDBmZmZdICBkZXZpY2UgcmVz
ZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbZ2FwIDB4MDAwMDAwMDBmZWUwMTAwMC0w
eDAwMDAwMDAwZmZiZmZmZmZdClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAw
MDAwZmZjMDAwMDAtMHgwMDAwMDAwMGZmZmZmZmZmXSAgZGV2aWNlIHJlc2VydmVkClsgICAgMC4w
MDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAxMDAwMDAwMDAtMHgwMDAwMDAwNDdmZmZm
ZmZmXSAgU3lzdGVtIFJBTQpbICAgIDAuMDAwMDAwXSBOWCAoRXhlY3V0ZSBEaXNhYmxlKSBwcm90
ZWN0aW9uOiBhY3RpdmUKWyAgICAwLjAwMDAwMF0gQVBJQzogU3RhdGljIGNhbGxzIGluaXRpYWxp
emVkClsgICAgMC4wMDAwMDBdIERNSTogU01CSU9TIDIuNyBwcmVzZW50LgpbICAgIDAuMDAwMDAw
XSBETUk6IEh1YXdlaSBUZWNobm9sb2dpZXMgQ28uLCBMdGQuIFhIMzIwIFYyL0JDMjFSQ1NBMCwg
QklPUyBSTUlCVjUxOSAwNi8yMi8yMDE4ClsgICAgMC4wMDAwMDBdIERNSTogTWVtb3J5IHNsb3Rz
IHBvcHVsYXRlZDogMi8xMgpbICAgIDAuMDAwMDAwXSB0c2M6IEZhc3QgVFNDIGNhbGlicmF0aW9u
IHVzaW5nIFBJVApbICAgIDAuMDAwMDAwXSB0c2M6IERldGVjdGVkIDE3OTkuOTY2IE1IeiBwcm9j
ZXNzb3IKWyAgICAwLjAwMjA4NV0gZTgyMDogdXBkYXRlIFttZW0gMHgwMDAwMDAwMC0weDAwMDAw
ZmZmXSBTeXN0ZW0gUkFNID09PiBkZXZpY2UgcmVzZXJ2ZWQKWyAgICAwLjAwMjA5MF0gZTgyMDog
cmVtb3ZlIFttZW0gMHgwMDBhMDAwMC0weDAwMGZmZmZmXSBTeXN0ZW0gUkFNClsgICAgMC4wMDIx
MDRdIGxhc3RfcGZuID0gMHg0ODAwMDAgbWF4X2FyY2hfcGZuID0gMHg0MDAwMDAwMDAKWyAgICAw
LjAwMjExNl0gTVRSUiBtYXA6IDkgZW50cmllcyAoNCBmaXhlZCArIDUgdmFyaWFibGU7IG1heCAy
NCksIGJ1aWx0IGZyb20gMTAgdmFyaWFibGUgTVRSUnMKWyAgICAwLjAwMjEyMF0geDg2L1BBVDog
Q29uZmlndXJhdGlvbiBbMC03XTogV0IgIFdDICBVQy0gVUMgIFdCICBXUCAgVUMtIFdUICAKWyAg
ICAwLjAwMjU5OF0gbGFzdF9wZm4gPSAweDdmMDAwIG1heF9hcmNoX3BmbiA9IDB4NDAwMDAwMDAw
ClsgICAgMC4wMTg5NzBdIGZvdW5kIFNNUCBNUC10YWJsZSBhdCBbbWVtIDB4MDAwZmUxYjAtMHgw
MDBmZTFiZl0KWyAgICAwLjAxODk5Nl0gVXNpbmcgR0IgcGFnZXMgZm9yIGRpcmVjdCBtYXBwaW5n
ClsgICAgMC4wMTk0MTFdIFJBTURJU0s6IFttZW0gMHgyZjcxOTAwMC0weDMzYjgzZmZmXQpbICAg
IDAuMDE5NTA5XSBBQ1BJOiBFYXJseSB0YWJsZSBjaGVja3N1bSB2ZXJpZmljYXRpb24gZGlzYWJs
ZWQKWyAgICAwLjAxOTUxNV0gQUNQSTogUlNEUCAweDAwMDAwMDAwMDAwRkUwMjAgMDAwMDI0ICh2
MDIgSU5TWURFKQpbICAgIDAuMDE5NTIzXSBBQ1BJOiBYU0RUIDB4MDAwMDAwMDA3RUZGRTE3MCAw
MDAwQUMgKHYwMSBJTlNZREUgUm9tbGV5ICAgMDAwMDAwMDEgICAgICAwMTAwMDAxMykKWyAgICAw
LjAxOTU1MV0gQUNQSTogRkFDUCAweDAwMDAwMDAwN0VGRkIwMDAgMDAwMEY0ICh2MDQgSU5TWURF
IFJvbWxleSAgIDAwMDAwMDAxIEFDUEkgMDAwNDAwMDApClsgICAgMC4wMTk1OTBdIEFDUEk6IERT
RFQgMHgwMDAwMDAwMDdFRkU5MDAwIDAwREVFMiAodjAxIElOU1lERSBSb21sZXkgICAwMDAwMDAw
MCBBQ1BJIDAwMDQwMDAwKQpbICAgIDAuMDE5NTk2XSBBQ1BJOiBGQUNTIDB4MDAwMDAwMDA3RUQ4
OTAwMCAwMDAwNDAKWyAgICAwLjAxOTYwMV0gQUNQSTogRkFDUyAweDAwMDAwMDAwN0VEODkwMDAg
MDAwMDQwClsgICAgMC4wMTk2MDddIEFDUEk6IFNQTUkgMHgwMDAwMDAwMDdFRkZEMDAwIDAwMDA0
MCAodjA1IElOU1lERSBSb21sZXkgICAwMDAwMDAwMSBBQ1BJIDAwMDQwMDAwKQpbICAgIDAuMDE5
NjEzXSBBQ1BJOiBCT09UIDB4MDAwMDAwMDA3RUZGQzAwMCAwMDAwMjggKHYwMSBJTlNZREUgUm9t
bGV5ICAgMDAwMDAwMDEgQUNQSSAwMDA0MDAwMCkKWyAgICAwLjAxOTYyMF0gQUNQSTogQVBJQyAw
eDAwMDAwMDAwN0VGRjkwMDAgMDAwQkFBICh2MDMgSU5TWURFIFJvbWxleSAgIDAwMDAwMDAxIEFD
UEkgMDAwNDAwMDApClsgICAgMC4wMTk2MjZdIEFDUEk6IE1DRkcgMHgwMDAwMDAwMDdFRkY4MDAw
IDAwMDAzQyAodjAxIElOU1lERSBSb21sZXkgICAwMDAwMDAwMSBBQ1BJIDAwMDQwMDAwKQpbICAg
IDAuMDE5NjMzXSBBQ1BJOiBTTElDIDB4MDAwMDAwMDA3RUZGNzAwMCAwMDAxNzYgKHYwMSBJTlNZ
REUgUm9tbGV5ICAgMDAwMDAwMDEgQUNQSSAwMDA0MDAwMCkKWyAgICAwLjAxOTY0MF0gQUNQSTog
QkRBVCAweDAwMDAwMDAwN0VGRTgwMDAgMDAwMDMwICh2MDEgSU5TWURFIFJvbWxleSAgIDAwMDAw
MDAxIEFDUEkgMDAwNDAwMDApClsgICAgMC4wMTk2NDZdIEFDUEk6IFBSQUQgMHgwMDAwMDAwMDdF
RkU3MDAwIDAwMDBCQyAodjAyIElOU1lERSBSb21sZXkgICAwMDAwMDAwMSBBQ1BJIDAwMDQwMDAw
KQpbICAgIDAuMDE5NjUyXSBBQ1BJOiBNU0RNIDB4MDAwMDAwMDA3RUZFNjAwMCAwMDAwNTUgKHYw
MyBJTlNZREUgUm9tbGV5ICAgMDAwMDAwMDEgQUNQSSAwMDA0MDAwMCkKWyAgICAwLjAxOTY1OV0g
QUNQSTogU1NEVCAweDAwMDAwMDAwN0VGMTIwMDAgMEQzMDUwICh2MDIgSU5TWURFIFJvbWxleSAg
IDAwMDA0MDAwIEFDUEkgMDAwNDAwMDApClsgICAgMC4wMTk2NjZdIEFDUEk6IEhQRVQgMHgwMDAw
MDAwMDdFRkZBMDAwIDAwMDAzOCAodjAxIElOU1lERSBSb21sZXkgICAwMDAwMDAwMSBBQ1BJIDAw
MDQwMDAwKQpbICAgIDAuMDE5NjcyXSBBQ1BJOiBXREFUIDB4MDAwMDAwMDA3RUYxMTAwMCAwMDAx
OTQgKHYwMSBJTlNZREUgSU5TWURFICAgMDAwMDAwMDEgTVNGVCAwMTAwMDAxMykKWyAgICAwLjAx
OTY3OV0gQUNQSTogRE1BUiAweDAwMDAwMDAwN0VGMTAwMDAgMDAwMEEwICh2MDEgSU5TWURFIFJv
bWxleSAgIDAwMDAwMDAxIEFDUEkgMDAwMDAwMDEpClsgICAgMC4wMTk2ODVdIEFDUEk6IEhFU1Qg
MHgwMDAwMDAwMDdFRjBGMDAwIDAwMDBBOCAodjAxIElOU1lERSBSb21sZXkgICAwMDAwMDAwMSA/
ICAgIDAwMDAwMDAxKQpbICAgIDAuMDE5NjkyXSBBQ1BJOiBFUlNUIDB4MDAwMDAwMDA3RUYwRTAw
MCAwMDAyMzAgKHYwMSBJTlNZREUgUm9tbGV5ICAgMDAwMDAwMDEgPyAgICAwMDAwMDAwMSkKWyAg
ICAwLjAxOTY5OF0gQUNQSTogQkVSVCAweDAwMDAwMDAwN0VGMEQwMDAgMDAwMDMwICh2MDEgSU5T
WURFIFJvbWxleSAgIDAwMDAwMDAxID8gICAgMDAwMDAwMDEpClsgICAgMC4wMTk3MDVdIEFDUEk6
IEVJTkogMHgwMDAwMDAwMDdFRjBDMDAwIDAwMDEzMCAodjAxIElOU1lERSBSb21sZXkgICAwMDAw
MDAwMSA/ICAgIDAwMDAwMDAxKQpbICAgIDAuMDE5NzA5XSBBQ1BJOiBSZXNlcnZpbmcgRkFDUCB0
YWJsZSBtZW1vcnkgYXQgW21lbSAweDdlZmZiMDAwLTB4N2VmZmIwZjNdClsgICAgMC4wMTk3MTJd
IEFDUEk6IFJlc2VydmluZyBEU0RUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4N2VmZTkwMDAtMHg3
ZWZmNmVlMV0KWyAgICAwLjAxOTcxM10gQUNQSTogUmVzZXJ2aW5nIEZBQ1MgdGFibGUgbWVtb3J5
IGF0IFttZW0gMHg3ZWQ4OTAwMC0weDdlZDg5MDNmXQpbICAgIDAuMDE5NzE1XSBBQ1BJOiBSZXNl
cnZpbmcgRkFDUyB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDdlZDg5MDAwLTB4N2VkODkwM2ZdClsg
ICAgMC4wMTk3MTZdIEFDUEk6IFJlc2VydmluZyBTUE1JIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4
N2VmZmQwMDAtMHg3ZWZmZDAzZl0KWyAgICAwLjAxOTcxOF0gQUNQSTogUmVzZXJ2aW5nIEJPT1Qg
dGFibGUgbWVtb3J5IGF0IFttZW0gMHg3ZWZmYzAwMC0weDdlZmZjMDI3XQpbICAgIDAuMDE5NzE5
XSBBQ1BJOiBSZXNlcnZpbmcgQVBJQyB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDdlZmY5MDAwLTB4
N2VmZjliYTldClsgICAgMC4wMTk3MjFdIEFDUEk6IFJlc2VydmluZyBNQ0ZHIHRhYmxlIG1lbW9y
eSBhdCBbbWVtIDB4N2VmZjgwMDAtMHg3ZWZmODAzYl0KWyAgICAwLjAxOTcyMl0gQUNQSTogUmVz
ZXJ2aW5nIFNMSUMgdGFibGUgbWVtb3J5IGF0IFttZW0gMHg3ZWZmNzAwMC0weDdlZmY3MTc1XQpb
ICAgIDAuMDE5NzI0XSBBQ1BJOiBSZXNlcnZpbmcgQkRBVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAw
eDdlZmU4MDAwLTB4N2VmZTgwMmZdClsgICAgMC4wMTk3MjVdIEFDUEk6IFJlc2VydmluZyBQUkFE
IHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4N2VmZTcwMDAtMHg3ZWZlNzBiYl0KWyAgICAwLjAxOTcy
N10gQUNQSTogUmVzZXJ2aW5nIE1TRE0gdGFibGUgbWVtb3J5IGF0IFttZW0gMHg3ZWZlNjAwMC0w
eDdlZmU2MDU0XQpbICAgIDAuMDE5NzI5XSBBQ1BJOiBSZXNlcnZpbmcgU1NEVCB0YWJsZSBtZW1v
cnkgYXQgW21lbSAweDdlZjEyMDAwLTB4N2VmZTUwNGZdClsgICAgMC4wMTk3MzBdIEFDUEk6IFJl
c2VydmluZyBIUEVUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4N2VmZmEwMDAtMHg3ZWZmYTAzN10K
WyAgICAwLjAxOTczMl0gQUNQSTogUmVzZXJ2aW5nIFdEQVQgdGFibGUgbWVtb3J5IGF0IFttZW0g
MHg3ZWYxMTAwMC0weDdlZjExMTkzXQpbICAgIDAuMDE5NzMzXSBBQ1BJOiBSZXNlcnZpbmcgRE1B
UiB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDdlZjEwMDAwLTB4N2VmMTAwOWZdClsgICAgMC4wMTk3
MzVdIEFDUEk6IFJlc2VydmluZyBIRVNUIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4N2VmMGYwMDAt
MHg3ZWYwZjBhN10KWyAgICAwLjAxOTczNl0gQUNQSTogUmVzZXJ2aW5nIEVSU1QgdGFibGUgbWVt
b3J5IGF0IFttZW0gMHg3ZWYwZTAwMC0weDdlZjBlMjJmXQpbICAgIDAuMDE5NzM4XSBBQ1BJOiBS
ZXNlcnZpbmcgQkVSVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweDdlZjBkMDAwLTB4N2VmMGQwMmZd
ClsgICAgMC4wMTk3MzldIEFDUEk6IFJlc2VydmluZyBFSU5KIHRhYmxlIG1lbW9yeSBhdCBbbWVt
IDB4N2VmMGMwMDAtMHg3ZWYwYzEyZl0KWyAgICAwLjAxOTk3MV0gTm8gTlVNQSBjb25maWd1cmF0
aW9uIGZvdW5kClsgICAgMC4wMTk5NzNdIEZha2luZyBhIG5vZGUgYXQgW21lbSAweDAwMDAwMDAw
MDAwMDAwMDAtMHgwMDAwMDAwNDdmZmZmZmZmXQpbICAgIDAuMDE5OTg1XSBOT0RFX0RBVEEoMCkg
YWxsb2NhdGVkIFttZW0gMHg0N2ZmZDRmODAtMHg0N2ZmZmZmZmZdClsgICAgMC4wMjA2MjddIEFD
UEk6IFBNLVRpbWVyIElPIFBvcnQ6IDB4NDA4ClsgICAgMC4wMjA5NzRdIEFDUEk6IFgyQVBJQ19O
TUkgKHVpZFsweGZmZmZmZmZmXSBoaWdoIGVkZ2UgbGludFsweDFdKQpbICAgIDAuMDIxMDI4XSBB
Q1BJOiBMQVBJQ19OTUkgKGFjcGlfaWRbMHhmZl0gaGlnaCBlZGdlIGxpbnRbMHgxXSkKWyAgICAw
LjAyMTA4OV0gSU9BUElDWzBdOiBhcGljX2lkIDgsIHZlcnNpb24gMzIsIGFkZHJlc3MgMHhmZWMw
MDAwMCwgR1NJIDAtMjMKWyAgICAwLjAyMTA5Nl0gSU9BUElDWzFdOiBhcGljX2lkIDksIHZlcnNp
b24gMzIsIGFkZHJlc3MgMHhmZWMwMTAwMCwgR1NJIDI0LTQ3ClsgICAgMC4wMjExNTBdIEFDUEk6
IElOVF9TUkNfT1ZSIChidXMgMCBidXNfaXJxIDAgZ2xvYmFsX2lycSAyIGRmbCBkZmwpClsgICAg
MC4wMjExNTRdIEFDUEk6IElOVF9TUkNfT1ZSIChidXMgMCBidXNfaXJxIDkgZ2xvYmFsX2lycSA5
IGhpZ2ggbGV2ZWwpClsgICAgMC4wMjEyNjFdIEFDUEk6IFVzaW5nIEFDUEkgKE1BRFQpIGZvciBT
TVAgY29uZmlndXJhdGlvbiBpbmZvcm1hdGlvbgpbICAgIDAuMDIxMjYzXSBBQ1BJOiBIUEVUIGlk
OiAweDgwODZhNzAxIGJhc2U6IDB4ZmVkMDAwMDAKWyAgICAwLjAyMTI3MF0gVFNDIGRlYWRsaW5l
IHRpbWVyIGF2YWlsYWJsZQpbICAgIDAuMDIxMjc1XSBDUFUgdG9wbzogTWF4LiBsb2dpY2FsIHBh
Y2thZ2VzOiAgIDEKWyAgICAwLjAyMTI3Nl0gQ1BVIHRvcG86IE1heC4gbG9naWNhbCBub2Rlczog
ICAgICAxClsgICAgMC4wMjEyNzddIENQVSB0b3BvOiBOdW0uIG5vZGVzIHBlciBwYWNrYWdlOiAg
MQpbICAgIDAuMDIxMjgyXSBDUFUgdG9wbzogTWF4LiBsb2dpY2FsIGRpZXM6ICAgICAgIDEKWyAg
ICAwLjAyMTI4M10gQ1BVIHRvcG86IE1heC4gZGllcyBwZXIgcGFja2FnZTogICAxClsgICAgMC4w
MjEyOTFdIENQVSB0b3BvOiBNYXguIHRocmVhZHMgcGVyIGNvcmU6ICAgMgpbICAgIDAuMDIxMjky
XSBDUFUgdG9wbzogTnVtLiBjb3JlcyBwZXIgcGFja2FnZTogICAgIDgKWyAgICAwLjAyMTI5NF0g
Q1BVIHRvcG86IE51bS4gdGhyZWFkcyBwZXIgcGFja2FnZTogIDE2ClsgICAgMC4wMjEyOTVdIENQ
VSB0b3BvOiBBbGxvd2luZyAxNiBwcmVzZW50IENQVXMgcGx1cyAwIGhvdHBsdWcgQ1BVcwpbICAg
IDAuMDIxMzIxXSBQTTogaGliZXJuYXRpb246IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21l
bSAweDAwMDAwMDAwLTB4MDAwMDBmZmZdClsgICAgMC4wMjEzMjVdIFBNOiBoaWJlcm5hdGlvbjog
UmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBbbWVtIDB4MDAwOWQwMDAtMHgwMDBmZmZmZl0KWyAg
ICAwLjAyMTMyOF0gUE06IGhpYmVybmF0aW9uOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IFtt
ZW0gMHg0MDAwMDAwMC0weDQwMGZmZmZmXQpbICAgIDAuMDIxMzMxXSBQTTogaGliZXJuYXRpb246
IFJlZ2lzdGVyZWQgbm9zYXZlIG1lbW9yeTogW21lbSAweDdlNGZmMDAwLTB4N2VmZmVmZmZdClsg
ICAgMC4wMjEzMzRdIFBNOiBoaWJlcm5hdGlvbjogUmVnaXN0ZXJlZCBub3NhdmUgbWVtb3J5OiBb
bWVtIDB4N2YwMDAwMDAtMHhmZmZmZmZmZl0KWyAgICAwLjAyMTMzNl0gW2dhcCAweDkwMDAwMDAw
LTB4ZmVhZmZmZmZdIGF2YWlsYWJsZSBmb3IgUENJIGRldmljZXMKWyAgICAwLjAyMTMzOF0gQm9v
dGluZyBwYXJhdmlydHVhbGl6ZWQga2VybmVsIG9uIGJhcmUgaGFyZHdhcmUKWyAgICAwLjAyMTM0
MV0gY2xvY2tzb3VyY2U6IHJlZmluZWQtamlmZmllczogbWFzazogMHhmZmZmZmZmZiBtYXhfY3lj
bGVzOiAweGZmZmZmZmZmLCBtYXhfaWRsZV9uczogMTkxMDk2OTk0MDM5MTQxOSBucwpbICAgIDAu
MDIxMzQ3XSBab25lIHJhbmdlczoKWyAgICAwLjAyMTM0OF0gICBETUEgICAgICBbbWVtIDB4MDAw
MDAwMDAwMDAwMTAwMC0weDAwMDAwMDAwMDBmZmZmZmZdClsgICAgMC4wMjEzNTJdICAgRE1BMzIg
ICAgW21lbSAweDAwMDAwMDAwMDEwMDAwMDAtMHgwMDAwMDAwMGZmZmZmZmZmXQpbICAgIDAuMDIx
MzU0XSAgIE5vcm1hbCAgIFttZW0gMHgwMDAwMDAwMTAwMDAwMDAwLTB4MDAwMDAwMDQ3ZmZmZmZm
Zl0KWyAgICAwLjAyMTM1N10gICBEZXZpY2UgICBlbXB0eQpbICAgIDAuMDIxMzU5XSBNb3ZhYmxl
IHpvbmUgc3RhcnQgZm9yIGVhY2ggbm9kZQpbICAgIDAuMDIxMzY0XSBFYXJseSBtZW1vcnkgbm9k
ZSByYW5nZXMKWyAgICAwLjAyMTM2NF0gICBub2RlICAgMDogW21lbSAweDAwMDAwMDAwMDAwMDEw
MDAtMHgwMDAwMDAwMDAwMDljZmZmXQpbICAgIDAuMDIxMzY3XSAgIG5vZGUgICAwOiBbbWVtIDB4
MDAwMDAwMDAwMDEwMDAwMC0weDAwMDAwMDAwM2ZmZmZmZmZdClsgICAgMC4wMjEzNjhdICAgbm9k
ZSAgIDA6IFttZW0gMHgwMDAwMDAwMDQwMTAwMDAwLTB4MDAwMDAwMDA3ZTRmZWZmZl0KWyAgICAw
LjAyMTM3MF0gICBub2RlICAgMDogW21lbSAweDAwMDAwMDAwN2VmZmYwMDAtMHgwMDAwMDAwMDdl
ZmZmZmZmXQpbICAgIDAuMDIxMzcxXSAgIG5vZGUgICAwOiBbbWVtIDB4MDAwMDAwMDEwMDAwMDAw
MC0weDAwMDAwMDA0N2ZmZmZmZmZdClsgICAgMC4wMjEzNzRdIEluaXRtZW0gc2V0dXAgbm9kZSAw
IFttZW0gMHgwMDAwMDAwMDAwMDAxMDAwLTB4MDAwMDAwMDQ3ZmZmZmZmZl0KWyAgICAwLjAyMTY0
NV0gT24gbm9kZSAwLCB6b25lIERNQTogMSBwYWdlcyBpbiB1bmF2YWlsYWJsZSByYW5nZXMKWyAg
ICAwLjAyMTY4NF0gT24gbm9kZSAwLCB6b25lIERNQTogOTkgcGFnZXMgaW4gdW5hdmFpbGFibGUg
cmFuZ2VzClsgICAgMC4wMjYyNjNdIE9uIG5vZGUgMCwgem9uZSBETUEzMjogMjU2IHBhZ2VzIGlu
IHVuYXZhaWxhYmxlIHJhbmdlcwpbICAgIDAuMDI2MzExXSBPbiBub2RlIDAsIHpvbmUgRE1BMzI6
IDI4MTYgcGFnZXMgaW4gdW5hdmFpbGFibGUgcmFuZ2VzClsgICAgMC4wNTk1NzFdIE9uIG5vZGUg
MCwgem9uZSBOb3JtYWw6IDQwOTYgcGFnZXMgaW4gdW5hdmFpbGFibGUgcmFuZ2VzClsgICAgMC4w
NTk2MDJdIHNldHVwX3BlcmNwdTogTlJfQ1BVUzo4MTkyIG5yX2NwdW1hc2tfYml0czoxNiBucl9j
cHVfaWRzOjE2IG5yX25vZGVfaWRzOjEKWyAgICAwLjA2MTMzOV0gcGVyY3B1OiBFbWJlZGRlZCA4
NSBwYWdlcy9jcHUgczIyNTI4MCByODE5MiBkMTE0Njg4IHU1MjQyODgKWyAgICAwLjA2MTM1MV0g
cGNwdS1hbGxvYzogczIyNTI4MCByODE5MiBkMTE0Njg4IHU1MjQyODggYWxsb2M9MSoyMDk3MTUy
ClsgICAgMC4wNjEzNTVdIHBjcHUtYWxsb2M6IFswXSAwMCAwMSAwMiAwMyBbMF0gMDQgMDUgMDYg
MDcgClsgICAgMC4wNjEzNjVdIHBjcHUtYWxsb2M6IFswXSAwOCAwOSAxMCAxMSBbMF0gMTIgMTMg
MTQgMTUgClsgICAgMC4wNjE0MDJdIEtlcm5lbCBjb21tYW5kIGxpbmU6IEJPT1RfSU1BR0U9L3Zt
bGludXotNy4zLjQtcmV2ZXJ0IHJvb3Q9L2Rldi9tYXBwZXIvdWJ1bnR1LS12Zy11YnVudHUtLWx2
IHJvClsgICAgMC4wNjE0NTRdIHByaW50azogbG9nIGJ1ZmZlciBkYXRhICsgbWV0YSBkYXRhOiAy
NjIxNDQgKyAxMTE0MTEyID0gMTM3NjI1NiBieXRlcwpbICAgIDAuMDYzODg5XSBEZW50cnkgY2Fj
aGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAyMDk3MTUyIChvcmRlcjogMTIsIDE2Nzc3MjE2IGJ5dGVz
LCBsaW5lYXIpClsgICAgMC4wNjUwODhdIElub2RlLWNhY2hlIGhhc2ggdGFibGUgZW50cmllczog
MTA0ODU3NiAob3JkZXI6IDExLCA4Mzg4NjA4IGJ5dGVzLCBsaW5lYXIpClsgICAgMC4wNjU1NTdd
IHNvZnR3YXJlIElPIFRMQjogYXJlYSBudW0gMTYuClsgICAgMC4wODQ5MzBdIEZhbGxiYWNrIG9y
ZGVyIGZvciBOb2RlIDA6IDAgClsgICAgMC4wODQ5NDJdIEJ1aWx0IDEgem9uZWxpc3RzLCBtb2Jp
bGl0eSBncm91cGluZyBvbi4gIFRvdGFsIHBhZ2VzOiA0MTg3MDM2ClsgICAgMC4wODQ5NDRdIFBv
bGljeSB6b25lOiBOb3JtYWwKWyAgICAwLjA4NDk1OV0gbWVtIGF1dG8taW5pdDogc3RhY2s6YWxs
KHplcm8pLCBoZWFwIGFsbG9jOm9uLCBoZWFwIGZyZWU6b2ZmClsgICAgMC4yMjI3ODVdIFNMVUI6
IEhXYWxpZ249NjQsIE9yZGVyPTAtMywgTWluT2JqZWN0cz0wLCBDUFVzPTE2LCBOb2Rlcz0xClsg
ICAgMC4yMjMwNjBdIEtlcm5lbC9Vc2VyIHBhZ2UgdGFibGVzIGlzb2xhdGlvbjogZW5hYmxlZApb
ICAgIDAuMjQwNTQ3XSBmdHJhY2U6IGFsbG9jYXRpbmcgNjA5ODYgZW50cmllcyBpbiAyNDAgcGFn
ZXMKWyAgICAwLjI0MDU1MF0gZnRyYWNlOiBhbGxvY2F0ZWQgMjQwIHBhZ2VzIHdpdGggNCBncm91
cHMKWyAgICAwLjI0MTgyNF0gRHluYW1pYyBQcmVlbXB0OiBsYXp5ClsgICAgMC4yNDIyNTVdIHJj
dTogUHJlZW1wdGlibGUgaGllcmFyY2hpY2FsIFJDVSBpbXBsZW1lbnRhdGlvbi4KWyAgICAwLjI0
MjI1N10gcmN1OiAJUkNVIHJlc3RyaWN0aW5nIENQVXMgZnJvbSBOUl9DUFVTPTgxOTIgdG8gbnJf
Y3B1X2lkcz0xNi4KWyAgICAwLjI0MjI2MF0gCVRyYW1wb2xpbmUgdmFyaWFudCBvZiBUYXNrcyBS
Q1UgZW5hYmxlZC4KWyAgICAwLjI0MjI2MV0gCVJ1ZGUgdmFyaWFudCBvZiBUYXNrcyBSQ1UgZW5h
YmxlZC4KWyAgICAwLjI0MjI2Ml0gCVRyYWNpbmcgdmFyaWFudCBvZiBUYXNrcyBSQ1UgZW5hYmxl
ZC4KWyAgICAwLjI0MjI2M10gcmN1OiBSQ1UgY2FsY3VsYXRlZCB2YWx1ZSBvZiBzY2hlZHVsZXIt
ZW5saXN0bWVudCBkZWxheSBpcyAxMDAgamlmZmllcy4KWyAgICAwLjI0MjI2NF0gcmN1OiBBZGp1
c3RpbmcgZ2VvbWV0cnkgZm9yIHJjdV9mYW5vdXRfbGVhZj0xNiwgbnJfY3B1X2lkcz0xNgpbICAg
IDAuMjQyMzA1XSBSQ1UgVGFza3M6IFNldHRpbmcgc2hpZnQgdG8gNCBhbmQgbGltIHRvIDEgcmN1
X3Rhc2tfY2JfYWRqdXN0PTEgcmN1X3Rhc2tfY3B1X2lkcz0xNi4KWyAgICAwLjI0MjMxMF0gUkNV
IFRhc2tzIFJ1ZGU6IFNldHRpbmcgc2hpZnQgdG8gNCBhbmQgbGltIHRvIDEgcmN1X3Rhc2tfY2Jf
YWRqdXN0PTEgcmN1X3Rhc2tfY3B1X2lkcz0xNi4KWyAgICAwLjI1NzU2MV0gTlJfSVJRUzogNTI0
NTQ0LCBucl9pcnFzOiA5NjAsIHByZWFsbG9jYXRlZCBpcnFzOiAxNgpbICAgIDAuMjU3OTA4XSBy
Y3U6IHNyY3VfaW5pdDogU2V0dGluZyBzcmN1X3N0cnVjdCBzaXplcyBiYXNlZCBvbiBjb250ZW50
aW9uLgpbICAgIDAuMjU3OTQ4XSBjbG9ja3NvdXJjZTogamlmZmllczogbWFzazogMHhmZmZmZmZm
ZiBtYXhfY3ljbGVzOiAweGZmZmZmZmZmLCBtYXhfaWRsZV9uczogMTkxMTI2MDQ0NjI3NTAwMCBu
cwpbICAgIDAuMjU4MjIyXSBDb25zb2xlOiBjb2xvdXIgZHVtbXkgZGV2aWNlIDgweDI1ClsgICAg
MC4yNTgyMjddIHByaW50azogbGVnYWN5IGNvbnNvbGUgW3R0eTBdIGVuYWJsZWQKWyAgICAwLjI1
OTE5MF0gQUNQSTogQ29yZSByZXZpc2lvbiAyMDI2MDQwOApbICAgIDAuMzQ4NTg1XSBjbG9ja3Nv
dXJjZTogaHBldDogbWFzazogMHhmZmZmZmZmZiBtYXhfY3ljbGVzOiAweGZmZmZmZmZmLCBtYXhf
aWRsZV9uczogMTMzNDg0ODgyODQ4IG5zClsgICAgMC4zNDg2MDddIEFQSUM6IFN3aXRjaCB0byBz
eW1tZXRyaWMgSS9PIG1vZGUgc2V0dXAKWyAgICAwLjM0ODYxNF0gRE1BUjogSG9zdCBhZGRyZXNz
IHdpZHRoIDQ2ClsgICAgMC4zNDg2MTldIERNQVI6IERSSEQgYmFzZTogMHgwMDAwMDBmYmZmYzAw
MCBmbGFnczogMHgxClsgICAgMC4zNDg2NDFdIERNQVI6IGRtYXIwOiByZWdfYmFzZV9hZGRyIGZi
ZmZjMDAwIHZlciAxOjAgY2FwIGQyMDc4YzEwNmYwNDYyIGVjYXAgZjAyMGZlClsgICAgMC4zNDg2
NTBdIERNQVI6IEFUU1IgZmxhZ3M6IDB4MApbICAgIDAuMzQ4NjcyXSBETUFSOiBSTVJSIGJhc2U6
IDB4MDAwMDAwN2U4YjUwMDAgZW5kOiAweDAwMDAwMDdlOGJiZmZmClsgICAgMC4zNDg2ODFdIERN
QVItSVI6IElPQVBJQyBpZCA4IHVuZGVyIERSSEQgYmFzZSAgMHhmYmZmYzAwMCBJT01NVSAwClsg
ICAgMC4zNDg2ODddIERNQVItSVI6IElPQVBJQyBpZCA5IHVuZGVyIERSSEQgYmFzZSAgMHhmYmZm
YzAwMCBJT01NVSAwClsgICAgMC4zNDg2OTJdIERNQVItSVI6IEhQRVQgaWQgMCB1bmRlciBEUkhE
IGJhc2UgMHhmYmZmYzAwMApbICAgIDAuMzQ4Njk4XSBETUFSLUlSOiB4MmFwaWMgaXMgZGlzYWJs
ZWQgYmVjYXVzZSBCSU9TIHNldHMgeDJhcGljIG9wdCBvdXQgYml0LgpbICAgIDAuMzQ4Njk5XSBE
TUFSLUlSOiBVc2UgJ2ludHJlbWFwPW5vX3gyYXBpY19vcHRvdXQnIHRvIG92ZXJyaWRlIHRoZSBC
SU9TIHNldHRpbmcuClsgICAgMC4zNDkxNzNdIERNQVItSVI6IEVuYWJsZWQgSVJRIHJlbWFwcGlu
ZyBpbiB4YXBpYyBtb2RlClsgICAgMC4zNDkxODFdIHgyYXBpYzogSVJRIHJlbWFwcGluZyBkb2Vz
bid0IHN1cHBvcnQgWDJBUElDIG1vZGUKWyAgICAwLjM0OTc0Ml0gLi5USU1FUjogdmVjdG9yPTB4
MzAgYXBpYzE9MCBwaW4xPTIgYXBpYzI9LTEgcGluMj0tMQpbICAgIDAuMzU0NjEwXSBjbG9ja3Nv
dXJjZTogdHNjLWVhcmx5OiBtYXNrOiAweGZmZmZmZmZmZmZmZmZmZmYgbWF4X2N5Y2xlczogMHgx
OWYyMDk3MTc5YiwgbWF4X2lkbGVfbnM6IDQ0MDc5NTI3MTA1OSBucwpbICAgIDAuMzU0NjI1XSBD
YWxpYnJhdGluZyBkZWxheSBsb29wIChza2lwcGVkKSwgdmFsdWUgY2FsY3VsYXRlZCB1c2luZyB0
aW1lciBmcmVxdWVuY3kuLiAzNTk5LjkzIEJvZ29NSVBTIChscGo9MTc5OTk2NikKWyAgICAwLjM1
NDY3M10gQ1BVMDogVGhlcm1hbCBtb25pdG9yaW5nIGVuYWJsZWQgKFRNMSkKWyAgICAwLjM1NDc1
NV0gTGFzdCBsZXZlbCBpVExCIGVudHJpZXM6IDRLQiA1MTIsIDJNQiA4LCA0TUIgOApbICAgIDAu
MzU0NzYyXSBMYXN0IGxldmVsIGRUTEIgZW50cmllczogNEtCIDUxMiwgMk1CIDMyLCA0TUIgMzIs
IDFHQiAwClsgICAgMC4zNTQ3ODRdIHByb2Nlc3M6IHVzaW5nIG13YWl0IGluIGlkbGUgdGhyZWFk
cwpbICAgIDAuMzU0NzkxXSBtaXRpZ2F0aW9uczogRW5hYmxlZCBhdHRhY2sgdmVjdG9yczogdXNl
cl9rZXJuZWwsIHVzZXJfdXNlciwgZ3Vlc3RfaG9zdCwgZ3Vlc3RfZ3Vlc3QsIFNNVCBtaXRpZ2F0
aW9uczogYXV0bwpbICAgIDAuMzU0ODA1XSBTcGVjdWxhdGl2ZSBTdG9yZSBCeXBhc3M6IE1pdGln
YXRpb246IFNwZWN1bGF0aXZlIFN0b3JlIEJ5cGFzcyBkaXNhYmxlZCB2aWEgcHJjdGwKWyAgICAw
LjM1NDgxM10gU3BlY3RyZSBWMiA6IE1pdGlnYXRpb246IFJldHBvbGluZXMKWyAgICAwLjM1NDgx
OF0gU3BlY3RyZSBWMiA6IFVzZXIgc3BhY2U6IE1pdGlnYXRpb246IFNUSUJQIHZpYSBwcmN0bApb
ICAgIDAuMzU0ODIyXSBNRFM6IE1pdGlnYXRpb246IENsZWFyIENQVSBidWZmZXJzClsgICAgMC4z
NTQ4MjddIFZNU0NBUEU6IE1pdGlnYXRpb246IElCUEIgYmVmb3JlIGV4aXQgdG8gdXNlcnNwYWNl
ClsgICAgMC4zNTQ4MzJdIFNwZWN0cmUgVjEgOiBNaXRpZ2F0aW9uOiB1c2VyY29weS9zd2FwZ3Mg
YmFycmllcnMgYW5kIF9fdXNlciBwb2ludGVyIHNhbml0aXphdGlvbgpbICAgIDAuMzU0ODM4XSBT
cGVjdHJlIFYyIDogU3BlY3RyZSB2MiAvIFNwZWN0cmVSU0I6IEZpbGxpbmcgUlNCIG9uIGNvbnRl
eHQgc3dpdGNoIGFuZCBWTUVYSVQKWyAgICAwLjM1NDg0NF0gU3BlY3RyZSBWMiA6IEVuYWJsaW5n
IFJlc3RyaWN0ZWQgU3BlY3VsYXRpb24gZm9yIGZpcm13YXJlIGNhbGxzClsgICAgMC4zNTQ4NTBd
IFNwZWN0cmUgVjIgOiBtaXRpZ2F0aW9uOiBFbmFibGluZyBjb25kaXRpb25hbCBJbmRpcmVjdCBC
cmFuY2ggUHJlZGljdGlvbiBCYXJyaWVyClsgICAgMC4zNTQ4NjRdIHg4Ni9mcHU6IFN1cHBvcnRp
bmcgWFNBVkUgZmVhdHVyZSAweDAwMTogJ3g4NyBmbG9hdGluZyBwb2ludCByZWdpc3RlcnMnClsg
ICAgMC4zNTQ4NzBdIHg4Ni9mcHU6IFN1cHBvcnRpbmcgWFNBVkUgZmVhdHVyZSAweDAwMjogJ1NT
RSByZWdpc3RlcnMnClsgICAgMC4zNTQ4NzVdIHg4Ni9mcHU6IFN1cHBvcnRpbmcgWFNBVkUgZmVh
dHVyZSAweDAwNDogJ0FWWCByZWdpc3RlcnMnClsgICAgMC4zNTQ4ODFdIHg4Ni9mcHU6IHhzdGF0
ZV9vZmZzZXRbMl06ICA1NzYsIHhzdGF0ZV9zaXplc1syXTogIDI1NgpbICAgIDAuMzU0ODg2XSB4
ODYvZnB1OiBFbmFibGVkIHhzdGF0ZSBmZWF0dXJlcyAweDcsIGNvbnRleHQgc2l6ZSBpcyA4MzIg
Ynl0ZXMsIHVzaW5nICdzdGFuZGFyZCcgZm9ybWF0LgpbICAgIDAuMzk5MzA0XSBwaWRfbWF4OiBk
ZWZhdWx0OiAzMjc2OCBtaW5pbXVtOiAzMDEKWyAgICAwLjQwMTExM10gbGFuZGxvY2s6IFVwIGFu
ZCBydW5uaW5nLgpbICAgIDAuNDAxMTIwXSBZYW1hOiBiZWNvbWluZyBtaW5kZnVsLgpbICAgIDAu
NDAxMzA2XSBBcHBBcm1vcjogQXBwQXJtb3IgaW5pdGlhbGl6ZWQKWyAgICAwLjQwMTYzMF0gTFNN
IHN1cHBvcnQgZm9yIGVCUEYgYWN0aXZlClsgICAgMC40MDI2MjZdIE1vdW50LWNhY2hlIGhhc2gg
dGFibGUgZW50cmllczogMzI3NjggKG9yZGVyOiA2LCAyNjIxNDQgYnl0ZXMsIGxpbmVhcikKWyAg
ICAwLjQwMjY2NF0gTW91bnRwb2ludC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDMyNzY4IChv
cmRlcjogNiwgMjYyMTQ0IGJ5dGVzLCBsaW5lYXIpClsgICAgMC40MDMxMDhdIFZGUzogRmluaXNo
ZWQgbW91bnRpbmcgcm9vdGZzIG9uIG51bGxmcwpbICAgIDAuNDA1Nzg2XSBzbXBib290OiBDUFUw
OiBJbnRlbChSKSBYZW9uKFIpIENQVSBFNS0yNDUwTCAwIEAgMS44MEdIeiAoZmFtaWx5OiAweDYs
IG1vZGVsOiAweDJkLCBzdGVwcGluZzogMHg3KQpbICAgIDAuNDA2MzM4XSBQZXJmb3JtYW5jZSBF
dmVudHM6IFBFQlMgZm10MSssIFNhbmR5QnJpZGdlIGV2ZW50cywgMTYtZGVlcCBMQlIsIGZ1bGwt
d2lkdGggY291bnRlcnMsIEludGVsIFBNVSBkcml2ZXIuClsgICAgMC40MDYzNzZdIC4uLiB2ZXJz
aW9uOiAgICAgICAgICAgICAgICAgICAzClsgICAgMC40MDYzODBdIC4uLiBiaXQgd2lkdGg6ICAg
ICAgICAgICAgICAgICA0OApbICAgIDAuNDA2Mzg0XSAuLi4gZ2VuZXJpYyBjb3VudGVyczogICAg
ICAgICAgNApbICAgIDAuNDA2Mzg4XSAuLi4gZ2VuZXJpYyBiaXRtYXA6ICAgICAgICAgICAgMDAw
MDAwMDAwMDAwMDAwZgpbICAgIDAuNDA2MzkyXSAuLi4gZml4ZWQtcHVycG9zZSBjb3VudGVyczog
ICAgMwpbICAgIDAuNDA2Mzk2XSAuLi4gZml4ZWQtcHVycG9zZSBiaXRtYXA6ICAgICAgMDAwMDAw
MDAwMDAwMDAwNwpbICAgIDAuNDA2NDAwXSAuLi4gdmFsdWUgbWFzazogICAgICAgICAgICAgICAg
MDAwMGZmZmZmZmZmZmZmZgpbICAgIDAuNDA2NDA0XSAuLi4gbWF4IHBlcmlvZDogICAgICAgICAg
ICAgICAgMDAwMDdmZmZmZmZmZmZmZgpbICAgIDAuNDA2NDA4XSAuLi4gZ2xvYmFsX2N0cmwgbWFz
azogICAgICAgICAgMDAwMDAwMDcwMDAwMDAwZgpbICAgIDAuNDA2NzYwXSBzaWduYWw6IG1heCBz
aWdmcmFtZSBzaXplOiAxNzc2ClsgICAgMC40MDY3OTRdIEVzdGltYXRlZCByYXRpbyBvZiBhdmVy
YWdlIG1heCBmcmVxdWVuY3kgYnkgYmFzZSBmcmVxdWVuY3kgKHRpbWVzIDEwMjQpOiAxMDI0Clsg
ICAgMC40MDkyMjldIHJjdTogSGllcmFyY2hpY2FsIFNSQ1UgaW1wbGVtZW50YXRpb24uClsgICAg
MC40MDkyMzddIHJjdTogCU1heCBwaGFzZSBuby1kZWxheSBpbnN0YW5jZXMgaXMgNDAwLgpbICAg
IDAuNDA5Mzg0XSBUaW1lciBtaWdyYXRpb246IDIgaGllcmFyY2h5IGxldmVsczsgOCBjaGlsZHJl
biBwZXIgZ3JvdXA7IDIgY3Jvc3Nub2RlIGxldmVsClsgICAgMC40MTExOTNdIE5NSSB3YXRjaGRv
ZzogRW5hYmxlZC4gUGVybWFuZW50bHkgY29uc3VtZXMgb25lIGh3LVBNVSBjb3VudGVyLgpbICAg
IDAuNDExNTc2XSBzbXA6IEJyaW5naW5nIHVwIHNlY29uZGFyeSBDUFVzIC4uLgpbICAgIDAuNDEx
OTI2XSBzbXBib290OiB4ODY6IEJvb3RpbmcgU01QIGNvbmZpZ3VyYXRpb246ClsgICAgMC40MTE5
MzNdIC4uLi4gbm9kZSAgIzAsIENQVXM6ICAgICAgICAjMSAgIzIgICMzICAjNCAgIzUgICM2ICAj
NyAgIzggICM5ICMxMCAjMTEgIzEyICMxMyAjMTQgIzE1ClsgICAgMC40Mjc5NDRdIE1EUyBDUFUg
YnVnIHByZXNlbnQgYW5kIFNNVCBvbiwgZGF0YSBsZWFrIHBvc3NpYmxlLiBTZWUgaHR0cHM6Ly93
d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvYWRtaW4tZ3VpZGUvaHctdnVsbi9tZHMuaHRt
bCBmb3IgbW9yZSBkZXRhaWxzLgpbICAgIDAuNDI3OTQ0XSBWTVNDQVBFOiBTTVQgb24sIFNUSUJQ
IGlzIHJlcXVpcmVkIGZvciBmdWxsIHByb3RlY3Rpb24uIFNlZSBodHRwczovL3d3dy5rZXJuZWwu
b3JnL2RvYy9odG1sL2xhdGVzdC9hZG1pbi1ndWlkZS9ody12dWxuL3Ztc2NhcGUuaHRtbCBmb3Ig
bW9yZSBkZXRhaWxzLgpbICAgIDAuNDM0NzI3XSBzbXA6IEJyb3VnaHQgdXAgMSBub2RlLCAxNiBD
UFVzClsgICAgMC40MzQ3MjddIHNtcGJvb3Q6IFRvdGFsIG9mIDE2IHByb2Nlc3NvcnMgYWN0aXZh
dGVkICg1NzU5OC45MSBCb2dvTUlQUykKWyAgICAwLjQzNTk4NV0gTWVtb3J5OiAxNjIzOTY0MEsv
MTY3NDgxNDRLIGF2YWlsYWJsZSAoMjMxMzFLIGtlcm5lbCBjb2RlLCA0ODk2SyByd2RhdGEsIDk2
MTJLIHJvZGF0YSwgNTQ2MEsgaW5pdCwgNTgwMEsgYnNzLCA0ODA3ODBLIHJlc2VydmVkLCAwSyBj
bWEtcmVzZXJ2ZWQpClsgICAgMC40MzcyMzFdIGRldnRtcGZzOiBpbml0aWFsaXplZApbICAgIDAu
NDM3Njc2XSB4ODYvbW06IE1lbW9yeSBibG9jayBzaXplOiAxMjhNQgpbICAgIDAuNDQxNjQ3XSBB
Q1BJOiBQTTogUmVnaXN0ZXJpbmcgQUNQSSBOVlMgcmVnaW9uIFttZW0gMHg3ZThmZjAwMC0weDdl
ZWZlZmZmXSAoNjI5MTQ1NiBieXRlcykKWyAgICAwLjQ0MTkzNF0gcG9zaXh0aW1lcnMgaGFzaCB0
YWJsZSBlbnRyaWVzOiA4MTkyIChvcmRlcjogNSwgMTMxMDcyIGJ5dGVzLCBsaW5lYXIpClsgICAg
MC40NDE5MzRdIGZ1dGV4IGhhc2ggdGFibGUgZW50cmllczogNDA5NiAoMjYyMTQ0IGJ5dGVzIG9u
IDEgTlVNQSBub2RlcywgdG90YWwgMjU2IEtpQiwgbGluZWFyKS4KWyAgICAwLjQ0Mzg0NF0gUE06
IFJUQyB0aW1lOiAxMDoyOTozNCwgZGF0ZTogMjAyNi0xMS0xNQpbICAgIDAuNDQ1MDQ2XSBORVQ6
IFJlZ2lzdGVyZWQgUEZfTkVUTElOSy9QRl9ST1VURSBwcm90b2NvbCBmYW1pbHkKWyAgICAwLjQ0
NTUwMV0gRE1BOiBwcmVhbGxvY2F0ZWQgMjA0OCBLaUIgR0ZQX0tFUk5FTCBwb29sIGZvciBhdG9t
aWMgYWxsb2NhdGlvbnMKWyAgICAwLjQ0NTcwM10gRE1BOiBwcmVhbGxvY2F0ZWQgMjA0OCBLaUIg
R0ZQX0tFUk5FTHxHRlBfRE1BIHBvb2wgZm9yIGF0b21pYyBhbGxvY2F0aW9ucwpbICAgIDAuNDQ1
OTAxXSBETUE6IHByZWFsbG9jYXRlZCAyMDQ4IEtpQiBHRlBfS0VSTkVMfEdGUF9ETUEzMiBwb29s
IGZvciBhdG9taWMgYWxsb2NhdGlvbnMKWyAgICAwLjQ0NTkyMV0gYXVkaXQ6IGluaXRpYWxpemlu
ZyBuZXRsaW5rIHN1YnN5cyAoZGlzYWJsZWQpClsgICAgMC40NDU5NDJdIGF1ZGl0OiB0eXBlPTIw
MDAgYXVkaXQoMTc5NDczODU3My4wOTY6MSk6IHN0YXRlPWluaXRpYWxpemVkIGF1ZGl0X2VuYWJs
ZWQ9MCByZXM9MQpbICAgIDAuNDQ1OTQyXSB0aGVybWFsX3N5czogUmVnaXN0ZXJlZCB0aGVybWFs
IGdvdmVybm9yICdmYWlyX3NoYXJlJwpbICAgIDAuNDQ1OTQyXSB0aGVybWFsX3N5czogUmVnaXN0
ZXJlZCB0aGVybWFsIGdvdmVybm9yICdiYW5nX2JhbmcnClsgICAgMC40NDU5NDJdIHRoZXJtYWxf
c3lzOiBSZWdpc3RlcmVkIHRoZXJtYWwgZ292ZXJub3IgJ3N0ZXBfd2lzZScKWyAgICAwLjQ0NTk0
Ml0gdGhlcm1hbF9zeXM6IFJlZ2lzdGVyZWQgdGhlcm1hbCBnb3Zlcm5vciAndXNlcl9zcGFjZScK
WyAgICAwLjQ0NTk0Ml0gdGhlcm1hbF9zeXM6IFJlZ2lzdGVyZWQgdGhlcm1hbCBnb3Zlcm5vciAn
cG93ZXJfYWxsb2NhdG9yJwpbICAgIDAuNDQ1OTUyXSBjcHVpZGxlOiB1c2luZyBnb3Zlcm5vciBs
YWRkZXIKWyAgICAwLjQ0NTk1Ml0gY3B1aWRsZTogdXNpbmcgZ292ZXJub3IgbWVudQpbICAgIDAu
NDQ1OTUyXSBTaW1wbGUgQm9vdCBGbGFnIGF0IDB4NDQgc2V0IHRvIDB4MQpbICAgIDAuNDQ1OTUy
XSBBQ1BJIEZBRFQgZGVjbGFyZXMgdGhlIHN5c3RlbSBkb2Vzbid0IHN1cHBvcnQgUENJZSBBU1BN
LCBzbyBkaXNhYmxlIGl0ClsgICAgMC40NDU5NTJdIGFjcGlwaHA6IEFDUEkgSG90IFBsdWcgUENJ
IENvbnRyb2xsZXIgRHJpdmVyIHZlcnNpb246IDAuNQpbICAgIDAuNDQ3MTA0XSBQQ0k6IEVDQU0g
W21lbSAweDgwMDAwMDAwLTB4OGZmZmZmZmZdIChiYXNlIDB4ODAwMDAwMDApIGZvciBkb21haW4g
MDAwMCBbYnVzIDAwLWZmXQpbICAgIDAuNDQ3MTM1XSBQQ0k6IFVzaW5nIGNvbmZpZ3VyYXRpb24g
dHlwZSAxIGZvciBiYXNlIGFjY2VzcwpbICAgIDAuNDQ3MjAyXSBjb3JlOiBQTVUgZXJyYXR1bSBC
SjEyMiwgQlY5OCwgSFNEMjkgd29ya2VkIGFyb3VuZCwgSFQgaXMgb24KWyAgICAwLjQ0NzIwOF0g
bXRycjogeW91ciBDUFVzIGhhZCBpbmNvbnNpc3RlbnQgdmFyaWFibGUgTVRSUiBzZXR0aW5ncwpb
ICAgIDAuNDQ3MjEzXSBtdHJyOiBwcm9iYWJseSB5b3VyIEJJT1MgZG9lcyBub3Qgc2V0dXAgYWxs
IENQVXMuClsgICAgMC40NDcyMTddIG10cnI6IGNvcnJlY3RlZCBjb25maWd1cmF0aW9uLgpbICAg
IDAuNDQ3MjIwXSB2aXJ0L3RkeDogVERYIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIGhvc3QgcGxhdGZv
cm0KWyAgICAwLjQ0NzI2N10ga3Byb2Jlczoga3Byb2JlIGp1bXAtb3B0aW1pemF0aW9uIGlzIGVu
YWJsZWQuIEFsbCBrcHJvYmVzIGFyZSBvcHRpbWl6ZWQgaWYgcG9zc2libGUuClsgICAgMC40NTM4
MTZdIEh1Z2VUTEI6IHJlZ2lzdGVyZWQgMS4wMCBHaUIgcGFnZSBzaXplLCBwcmUtYWxsb2NhdGVk
IDAgcGFnZXMKWyAgICAwLjQ1MzgxNl0gSHVnZVRMQjogMTYzODAgS2lCIHZtZW1tYXAgY2FuIGJl
IGZyZWVkIGZvciBhIDEuMDAgR2lCIHBhZ2UKWyAgICAwLjQ1MzgxNl0gSHVnZVRMQjogcmVnaXN0
ZXJlZCAyLjAwIE1pQiBwYWdlIHNpemUsIHByZS1hbGxvY2F0ZWQgMCBwYWdlcwpbICAgIDAuNDUz
ODE2XSBIdWdlVExCOiAyOCBLaUIgdm1lbW1hcCBjYW4gYmUgZnJlZWQgZm9yIGEgMi4wMCBNaUIg
cGFnZQpbICAgIDAuNDYzNTQ1XSBmYmNvbjogVGFraW5nIG92ZXIgY29uc29sZQpbICAgIDAuNDYz
NzE4XSBBQ1BJOiBBZGRlZCBfT1NJKE1vZHVsZSBEZXZpY2UpClsgICAgMC40NjM3MjldIEFDUEk6
IEFkZGVkIF9PU0koUHJvY2Vzc29yIERldmljZSkKWyAgICAwLjQ2MzczN10gQUNQSTogQWRkZWQg
X09TSShQcm9jZXNzb3IgQWdncmVnYXRvciBEZXZpY2UpClsgICAgMC43OTcxODhdIEFDUEk6IDIg
QUNQSSBBTUwgdGFibGVzIHN1Y2Nlc3NmdWxseSBhY3F1aXJlZCBhbmQgbG9hZGVkClsgICAgMC44
Mjk4OTVdIEFDUEk6IFxfU0JfOiBwbGF0Zm9ybSBfT1NDOiBPUyBzdXBwb3J0IG1hc2sgWzAwNmU3
ZWZmXQpbICAgIDAuODMwOTMxXSBBQ1BJOiBcX1NCXzogcGxhdGZvcm0gX09TQzogT1MgY29udHJv
bCBtYXNrIFswMDZlN2VmZl0KWyAgICAwLjg2OTk3OF0gQUNQSTogSW50ZXJwcmV0ZXIgZW5hYmxl
ZApbICAgIDAuODcwMDIyXSBBQ1BJOiBQTTogKHN1cHBvcnRzIFMwIFM0IFM1KQpbICAgIDAuODcw
MDI3XSBBQ1BJOiBVc2luZyBJT0FQSUMgZm9yIGludGVycnVwdCByb3V0aW5nClsgICAgMC44NzY1
NzddIEhFU1Q6IFRhYmxlIHBhcnNpbmcgaGFzIGJlZW4gaW5pdGlhbGl6ZWQuClsgICAgMC44NzY5
MjldIEdIRVM6IEFQRUkgZmlybXdhcmUgZmlyc3QgbW9kZSBpcyBlbmFibGVkIGJ5IEFQRUkgYml0
IGFuZCBXSEVBIF9PU0MuClsgICAgMC44NzY5NDNdIFBDSTogVXNpbmcgaG9zdCBicmlkZ2Ugd2lu
ZG93cyBmcm9tIEFDUEk7IGlmIG5lY2Vzc2FyeSwgdXNlICJwY2k9bm9jcnMiIGFuZCByZXBvcnQg
YSBidWcKWyAgICAwLjg3Njk1MF0gUENJOiBVc2luZyBFODIwIHJlc2VydmF0aW9ucyBmb3IgaG9z
dCBicmlkZ2Ugd2luZG93cwpbICAgIDAuODc3ODkzXSBBQ1BJOiBFbmFibGVkIDcgR1BFcyBpbiBi
bG9jayAwMCB0byAzRgpbICAgIDAuOTIyMTUyXSBBQ1BJOiBQQ0kgUm9vdCBCcmlkZ2UgW1BDSTBd
IChkb21haW4gMDAwMCBbYnVzIDAwLWZlXSkKWyAgICAwLjkyMjE3MV0gYWNwaSBQTlAwQTA4OjAw
OiBfT1NDOiBPUyBzdXBwb3J0cyBbRXh0ZW5kZWRDb25maWcgQVNQTSBDbG9ja1BNIFNlZ21lbnRz
IE1TSSBFRFIgSFBYLVR5cGUzXQpbICAgIDAuOTIzMDkyXSBhY3BpIFBOUDBBMDg6MDA6IF9PU0M6
IE9TIG5vdyBjb250cm9scyBbUENJZUhvdHBsdWcgU0hQQ0hvdHBsdWcgUE1FIEFFUiBQQ0llQ2Fw
YWJpbGl0eSBMVFIgRFBDXQpbICAgIDAuOTIzMTAzXSBhY3BpIFBOUDBBMDg6MDA6IEZBRFQgaW5k
aWNhdGVzIEFTUE0gaXMgdW5zdXBwb3J0ZWQsIHVzaW5nIEJJT1MgY29uZmlndXJhdGlvbgpbICAg
IDAuOTI0NTgwXSBQQ0kgaG9zdCBicmlkZ2UgdG8gYnVzIDAwMDA6MDAKWyAgICAwLjkyNDU5M10g
cGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbaW8gIDB4MDAwMC0weDBjZjcgd2lu
ZG93XQpbICAgIDAuOTI0NjAxXSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFtp
byAgMHgxMDAwLTB4ZmZmZiB3aW5kb3ddClsgICAgMC45MjQ2MDddIHBjaV9idXMgMDAwMDowMDog
cm9vdCBidXMgcmVzb3VyY2UgW21lbSAweDAwMGEwMDAwLTB4MDAwYmZmZmYgd2luZG93XQpbICAg
IDAuOTI0NjE0XSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFttZW0gMHg5MDAw
MDAwMC0weGZiZmZlZmZmIHdpbmRvd10KWyAgICAwLjkyNDYyMF0gcGNpX2J1cyAwMDAwOjAwOiBy
b290IGJ1cyByZXNvdXJjZSBbYnVzIDAwLWZlXQpbICAgIDAuOTI0NjY4XSBwY2kgMDAwMDowMDow
MC4wOiBbODA4NjozYzAwXSB0eXBlIDAwIGNsYXNzIDB4MDYwMDAwIFBDSWUgUm9vdCBQb3J0Clsg
ICAgMC45MjQ3NzJdIHBjaSAwMDAwOjAwOjAwLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNo
b3QgRDNjb2xkClsgICAgMC45MjQ5NDNdIHBjaSAwMDAwOjAwOjAxLjA6IFs4MDg2OjNjMDJdIHR5
cGUgMDEgY2xhc3MgMHgwNjA0MDAgUENJZSBSb290IFBvcnQKWyAgICAwLjkyNDk3Nl0gcGNpIDAw
MDA6MDA6MDEuMDogUENJIGJyaWRnZSB0byBbYnVzIDAxXQpbICAgIDAuOTI1MDcxXSBwY2kgMDAw
MDowMDowMS4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAgIDAuOTI1
MzY1XSBwY2kgMDAwMDowMDowMS4xOiBbODA4NjozYzAzXSB0eXBlIDAxIGNsYXNzIDB4MDYwNDAw
IFBDSWUgUm9vdCBQb3J0ClsgICAgMC45MjUzOThdIHBjaSAwMDAwOjAwOjAxLjE6IFBDSSBicmlk
Z2UgdG8gW2J1cyAwMl0KWyAgICAwLjkyNTQwNl0gcGNpIDAwMDA6MDA6MDEuMTogICBicmlkZ2Ug
d2luZG93IFtpbyAgMHg1MDAwLTB4NWZmZl0KWyAgICAwLjkyNTQxNF0gcGNpIDAwMDA6MDA6MDEu
MTogICBicmlkZ2Ugd2luZG93IFttZW0gMHg5NDgwMDAwMC0weDk0OGZmZmZmXQpbICAgIDAuOTI1
NTA2XSBwY2kgMDAwMDowMDowMS4xOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29s
ZApbICAgIDAuOTI1Nzg1XSBwY2kgMDAwMDowMDowMy4wOiBbODA4NjozYzA4XSB0eXBlIDAxIGNs
YXNzIDB4MDYwNDAwIFBDSWUgUm9vdCBQb3J0ClsgICAgMC45MjU4MThdIHBjaSAwMDAwOjAwOjAz
LjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwM10KWyAgICAwLjkyNTgyNl0gcGNpIDAwMDA6MDA6MDMu
MDogICBicmlkZ2Ugd2luZG93IFtpbyAgMHg0MDAwLTB4NGZmZl0KWyAgICAwLjkyNTgzNF0gcGNp
IDAwMDA6MDA6MDMuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHg5NDcwMDAwMC0weDk0N2ZmZmZm
XQpbICAgIDAuOTI1ODU1XSBwY2kgMDAwMDowMDowMy4wOiBlbmFibGluZyBFeHRlbmRlZCBUYWdz
ClsgICAgMC45MjU5MzNdIHBjaSAwMDAwOjAwOjAzLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAg
RDNob3QgRDNjb2xkClsgICAgMC45MjYxNTJdIHBjaSAwMDAwOjAwOjA0LjA6IFs4MDg2OjNjMjBd
IHR5cGUgMDAgY2xhc3MgMHgwODgwMDAgUENJZSBSb290IENvbXBsZXggSW50ZWdyYXRlZCBFbmRw
b2ludApbICAgIDAuOTI2MTk4XSBwY2kgMDAwMDowMDowNC4wOiBCQVIgMCBbbWVtIDB4OTQ5MDAw
MDAtMHg5NDkwM2ZmZiA2NGJpdF0KWyAgICAwLjkyNjM1Ml0gcGNpIDAwMDA6MDA6MDQuMTogWzgw
ODY6M2MyMV0gdHlwZSAwMCBjbGFzcyAweDA4ODAwMCBQQ0llIFJvb3QgQ29tcGxleCBJbnRlZ3Jh
dGVkIEVuZHBvaW50ClsgICAgMC45MjYzOTddIHBjaSAwMDAwOjAwOjA0LjE6IEJBUiAwIFttZW0g
MHg5NDkwNDAwMC0weDk0OTA3ZmZmIDY0Yml0XQpbICAgIDAuOTI2NTQ0XSBwY2kgMDAwMDowMDow
NC4yOiBbODA4NjozYzIyXSB0eXBlIDAwIGNsYXNzIDB4MDg4MDAwIFBDSWUgUm9vdCBDb21wbGV4
IEludGVncmF0ZWQgRW5kcG9pbnQKWyAgICAwLjkyNjU4OV0gcGNpIDAwMDA6MDA6MDQuMjogQkFS
IDAgW21lbSAweDk0OTA4MDAwLTB4OTQ5MGJmZmYgNjRiaXRdClsgICAgMC45MjY3MjldIHBjaSAw
MDAwOjAwOjA0LjM6IFs4MDg2OjNjMjNdIHR5cGUgMDAgY2xhc3MgMHgwODgwMDAgUENJZSBSb290
IENvbXBsZXggSW50ZWdyYXRlZCBFbmRwb2ludApbICAgIDAuOTI2Nzc2XSBwY2kgMDAwMDowMDow
NC4zOiBCQVIgMCBbbWVtIDB4OTQ5MGMwMDAtMHg5NDkwZmZmZiA2NGJpdF0KWyAgICAwLjkyNjky
MV0gcGNpIDAwMDA6MDA6MDQuNDogWzgwODY6M2MyNF0gdHlwZSAwMCBjbGFzcyAweDA4ODAwMCBQ
Q0llIFJvb3QgQ29tcGxleCBJbnRlZ3JhdGVkIEVuZHBvaW50ClsgICAgMC45MjY5NjVdIHBjaSAw
MDAwOjAwOjA0LjQ6IEJBUiAwIFttZW0gMHg5NDkxMDAwMC0weDk0OTEzZmZmIDY0Yml0XQpbICAg
IDAuOTI3MTEwXSBwY2kgMDAwMDowMDowNC41OiBbODA4NjozYzI1XSB0eXBlIDAwIGNsYXNzIDB4
MDg4MDAwIFBDSWUgUm9vdCBDb21wbGV4IEludGVncmF0ZWQgRW5kcG9pbnQKWyAgICAwLjkyNzE1
NF0gcGNpIDAwMDA6MDA6MDQuNTogQkFSIDAgW21lbSAweDk0OTE0MDAwLTB4OTQ5MTdmZmYgNjRi
aXRdClsgICAgMC45MjczMDJdIHBjaSAwMDAwOjAwOjA0LjY6IFs4MDg2OjNjMjZdIHR5cGUgMDAg
Y2xhc3MgMHgwODgwMDAgUENJZSBSb290IENvbXBsZXggSW50ZWdyYXRlZCBFbmRwb2ludApbICAg
IDAuOTI3MzQ3XSBwY2kgMDAwMDowMDowNC42OiBCQVIgMCBbbWVtIDB4OTQ5MTgwMDAtMHg5NDkx
YmZmZiA2NGJpdF0KWyAgICAwLjkyNzQ5Ml0gcGNpIDAwMDA6MDA6MDQuNzogWzgwODY6M2MyN10g
dHlwZSAwMCBjbGFzcyAweDA4ODAwMCBQQ0llIFJvb3QgQ29tcGxleCBJbnRlZ3JhdGVkIEVuZHBv
aW50ClsgICAgMC45Mjc1MzZdIHBjaSAwMDAwOjAwOjA0Ljc6IEJBUiAwIFttZW0gMHg5NDkxYzAw
MC0weDk0OTFmZmZmIDY0Yml0XQpbICAgIDAuOTI3Njg2XSBwY2kgMDAwMDowMDowNS4wOiBbODA4
NjozYzI4XSB0eXBlIDAwIGNsYXNzIDB4MDg4MDAwIFBDSWUgUm9vdCBDb21wbGV4IEludGVncmF0
ZWQgRW5kcG9pbnQKWyAgICAwLjkyNzkwN10gcGNpIDAwMDA6MDA6MDUuMjogWzgwODY6M2MyYV0g
dHlwZSAwMCBjbGFzcyAweDA4ODAwMCBQQ0llIFJvb3QgQ29tcGxleCBJbnRlZ3JhdGVkIEVuZHBv
aW50ClsgICAgMC45MjgwNzFdIHBjaSAwMDAwOjAwOjA1LjQ6IFs4MDg2OjNjMmNdIHR5cGUgMDAg
Y2xhc3MgMHgwODAwMjAgY29udmVudGlvbmFsIFBDSSBlbmRwb2ludApbICAgIDAuOTI4MTEzXSBw
Y2kgMDAwMDowMDowNS40OiBCQVIgMCBbbWVtIDB4OTQ5MjgwMDAtMHg5NDkyOGZmZl0KWyAgICAw
LjkyODI1M10gcGNpIDAwMDA6MDA6MTEuMDogWzgwODY6MWQzZV0gdHlwZSAwMSBjbGFzcyAweDA2
MDQwMCBQQ0llIFJvb3QgUG9ydApbICAgIDAuOTI4Mjk0XSBwY2kgMDAwMDowMDoxMS4wOiBQQ0kg
YnJpZGdlIHRvIFtidXMgMDRdClsgICAgMC45MjgzMDRdIHBjaSAwMDAwOjAwOjExLjA6ICAgYnJp
ZGdlIHdpbmRvdyBbaW8gIDB4MzAwMC0weDNmZmZdClsgICAgMC45MjgzMTNdIHBjaSAwMDAwOjAw
OjExLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4OTQ2MDAwMDAtMHg5NDZmZmZmZl0KWyAgICAw
LjkyODMzMF0gcGNpIDAwMDA6MDA6MTEuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHg5NDAwMDAw
MC0weDk0NGZmZmZmIDY0Yml0IHByZWZdClsgICAgMC45Mjg0MTZdIHBjaSAwMDAwOjAwOjExLjA6
IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QgRDNjb2xkClsgICAgMC45Mjg2MjBdIHBjaSAw
MDAwOjAwOjE2LjA6IFs4MDg2OjFkM2FdIHR5cGUgMDAgY2xhc3MgMHgwNzgwMDAgY29udmVudGlv
bmFsIFBDSSBlbmRwb2ludApbICAgIDAuOTI4NjcxXSBwY2kgMDAwMDowMDoxNi4wOiBCQVIgMCBb
bWVtIDB4OTQ5MjAwMDAtMHg5NDkyMDAwZiA2NGJpdF0KWyAgICAwLjkyODcxOF0gcGNpIDAwMDA6
MDA6MTYuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2NvbGQKWyAgICAwLjkyODg1
N10gcGNpIDAwMDA6MDA6MTYuMTogWzgwODY6MWQzYl0gdHlwZSAwMCBjbGFzcyAweDA3ODAwMCBj
b252ZW50aW9uYWwgUENJIGVuZHBvaW50ClsgICAgMC45Mjg5MDZdIHBjaSAwMDAwOjAwOjE2LjE6
IEJBUiAwIFttZW0gMHg5NDkyMTAwMC0weDk0OTIxMDBmIDY0Yml0XQpbICAgIDAuOTI4OTUzXSBw
Y2kgMDAwMDowMDoxNi4xOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAg
IDAuOTI5MTE0XSBwY2kgMDAwMDowMDoxYS4wOiBbODA4NjoxZDJkXSB0eXBlIDAwIGNsYXNzIDB4
MGMwMzIwIGNvbnZlbnRpb25hbCBQQ0kgZW5kcG9pbnQKWyAgICAwLjkyOTg2MV0gcGNpIDAwMDA6
MDA6MWEuMDogQkFSIDAgW21lbSAweDk0OTI2MDAwLTB4OTQ5MjYzZmZdClsgICAgMC45Mjk5MjJd
IHBjaSAwMDAwOjAwOjFhLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QgRDNjb2xkClsg
ICAgMC45MzAwODldIHBjaSAwMDAwOjAwOjFjLjA6IFs4MDg2OjFkMTBdIHR5cGUgMDEgY2xhc3Mg
MHgwNjA0MDAgUENJZSBSb290IFBvcnQKWyAgICAwLjkzMDEyNl0gcGNpIDAwMDA6MDA6MWMuMDog
UENJIGJyaWRnZSB0byBbYnVzIDA1XQpbICAgIDAuOTMwMjE3XSBwY2kgMDAwMDowMDoxYy4wOiBQ
TUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAgIDAuOTMwNDI0XSBwY2kgMDAw
MDowMDoxYy4yOiBbODA4NjoxZDE0XSB0eXBlIDAxIGNsYXNzIDB4MDYwNDAwIFBDSWUgUm9vdCBQ
b3J0ClsgICAgMC45MzA0NjFdIHBjaSAwMDAwOjAwOjFjLjI6IFBDSSBicmlkZ2UgdG8gW2J1cyAw
Nl0KWyAgICAwLjkzMDU1Ml0gcGNpIDAwMDA6MDA6MWMuMjogUE1FIyBzdXBwb3J0ZWQgZnJvbSBE
MCBEM2hvdCBEM2NvbGQKWyAgICAwLjkzMDc1Ml0gcGNpIDAwMDA6MDA6MWMuMzogWzgwODY6MWQx
Nl0gdHlwZSAwMSBjbGFzcyAweDA2MDQwMCBQQ0llIFJvb3QgUG9ydApbICAgIDAuOTMwNzkwXSBw
Y2kgMDAwMDowMDoxYy4zOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDddClsgICAgMC45MzA3OThdIHBj
aSAwMDAwOjAwOjFjLjM6ICAgYnJpZGdlIHdpbmRvdyBbaW8gIDB4MjAwMC0weDJmZmZdClsgICAg
MC45MzA4MDZdIHBjaSAwMDAwOjAwOjFjLjM6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4OTQ1MDAw
MDAtMHg5NDVmZmZmZl0KWyAgICAwLjkzMDgyMl0gcGNpIDAwMDA6MDA6MWMuMzogICBicmlkZ2Ug
d2luZG93IFttZW0gMHg5MDAwMDAwMC0weDkzZmZmZmZmIDY0Yml0IHByZWZdClsgICAgMC45MzA4
OTldIHBjaSAwMDAwOjAwOjFjLjM6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QgRDNjb2xk
ClsgICAgMC45MzEwODZdIHBjaSAwMDAwOjAwOjFkLjA6IFs4MDg2OjFkMjZdIHR5cGUgMDAgY2xh
c3MgMHgwYzAzMjAgY29udmVudGlvbmFsIFBDSSBlbmRwb2ludApbICAgIDAuOTMxODY0XSBwY2kg
MDAwMDowMDoxZC4wOiBCQVIgMCBbbWVtIDB4OTQ5MjUwMDAtMHg5NDkyNTNmZl0KWyAgICAwLjkz
MTkyNV0gcGNpIDAwMDA6MDA6MWQuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2Nv
bGQKWyAgICAwLjkzMjA4MF0gcGNpIDAwMDA6MDA6MWUuMDogWzgwODY6MjQ0ZV0gdHlwZSAwMSBj
bGFzcyAweDA2MDQwMSBjb252ZW50aW9uYWwgUENJIGJyaWRnZQpbICAgIDAuOTMyMTEzXSBwY2kg
MDAwMDowMDoxZS4wOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDhdIChzdWJ0cmFjdGl2ZSBkZWNvZGUp
ClsgICAgMC45MzIyOTNdIHBjaSAwMDAwOjAwOjFmLjA6IFs4MDg2OjFkNDFdIHR5cGUgMDAgY2xh
c3MgMHgwNjAxMDAgY29udmVudGlvbmFsIFBDSSBlbmRwb2ludApbICAgIDAuOTMyNTQ4XSBwY2kg
MDAwMDowMDoxZi4yOiBbODA4NjoxZDAyXSB0eXBlIDAwIGNsYXNzIDB4MDEwNjAxIGNvbnZlbnRp
b25hbCBQQ0kgZW5kcG9pbnQKWyAgICAwLjkzMjU5M10gcGNpIDAwMDA6MDA6MWYuMjogQkFSIDAg
W2lvICAweDYwNDgtMHg2MDRmXQpbICAgIDAuOTMyNjAwXSBwY2kgMDAwMDowMDoxZi4yOiBCQVIg
MSBbaW8gIDB4NjA1Yy0weDYwNWZdClsgICAgMC45MzI2MDZdIHBjaSAwMDAwOjAwOjFmLjI6IEJB
UiAyIFtpbyAgMHg2MDQwLTB4NjA0N10KWyAgICAwLjkzMjYxMl0gcGNpIDAwMDA6MDA6MWYuMjog
QkFSIDMgW2lvICAweDYwNTgtMHg2MDViXQpbICAgIDAuOTMyNjE4XSBwY2kgMDAwMDowMDoxZi4y
OiBCQVIgNCBbaW8gIDB4NjAyMC0weDYwM2ZdClsgICAgMC45MzI2MjZdIHBjaSAwMDAwOjAwOjFm
LjI6IEJBUiA1IFttZW0gMHg5NDkyNDAwMC0weDk0OTI0N2ZmXQpbICAgIDAuOTMyNjc0XSBwY2kg
MDAwMDowMDoxZi4yOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQzaG90ClsgICAgMC45MzI4MTJdIHBj
aSAwMDAwOjAwOjFmLjM6IFs4MDg2OjFkMjJdIHR5cGUgMDAgY2xhc3MgMHgwYzA1MDAgY29udmVu
dGlvbmFsIFBDSSBlbmRwb2ludApbICAgIDAuOTMyODYwXSBwY2kgMDAwMDowMDoxZi4zOiBCQVIg
MCBbbWVtIDB4OTQ5MjIwMDAtMHg5NDkyMjBmZiA2NGJpdF0KWyAgICAwLjkzMjg2OV0gcGNpIDAw
MDA6MDA6MWYuMzogQkFSIDQgW2lvICAweDYwMDAtMHg2MDFmXQpbICAgIDAuOTMyOTc2XSBwY2kg
MDAwMDowMDoxZi42OiBbODA4NjoxZDI0XSB0eXBlIDAwIGNsYXNzIDB4MTE4MDAwIGNvbnZlbnRp
b25hbCBQQ0kgZW5kcG9pbnQKWyAgICAwLjkzMzAzMV0gcGNpIDAwMDA6MDA6MWYuNjogQkFSIDAg
W21lbSAweDk0OTIzMDAwLTB4OTQ5MjNmZmYgNjRiaXRdClsgICAgMC45MzMyMDNdIHBjaSAwMDAw
OjAwOjAxLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwMV0KWyAgICAwLjkzMzMxMV0gcGNpIDAwMDA6
MDI6MDAuMDogWzgwODY6MTUyMV0gdHlwZSAwMCBjbGFzcyAweDAyMDAwMCBQQ0llIEVuZHBvaW50
ClsgICAgMC45MzMzNTRdIHBjaSAwMDAwOjAyOjAwLjA6IEJBUiAwIFttZW0gMHg5NDgyMDAwMC0w
eDk0ODNmZmZmXQpbICAgIDAuOTMzMzYxXSBwY2kgMDAwMDowMjowMC4wOiBCQVIgMiBbaW8gIDB4
NTAyMC0weDUwM2ZdClsgICAgMC45MzMzNjhdIHBjaSAwMDAwOjAyOjAwLjA6IEJBUiAzIFttZW0g
MHg5NDg0NDAwMC0weDk0ODQ3ZmZmXQpbICAgIDAuOTMzNDUyXSBwY2kgMDAwMDowMjowMC4wOiBQ
TUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAgIDAuOTMzNDk0XSBwY2kgMDAw
MDowMjowMC4wOiBWRiBCQVIgMCBbbWVtIDB4MDAwMDAwMDAtMHgwMDAwM2ZmZiA2NGJpdCBwcmVm
XQpbICAgIDAuOTMzNTAxXSBwY2kgMDAwMDowMjowMC4wOiBWRiBCQVIgMCBbbWVtIDB4MDAwMDAw
MDAtMHgwMDAxZmZmZiA2NGJpdCBwcmVmXTogY29udGFpbnMgQkFSIDAgZm9yIDggVkZzClsgICAg
MC45MzM1MTFdIHBjaSAwMDAwOjAyOjAwLjA6IFZGIEJBUiAzIFttZW0gMHgwMDAwMDAwMC0weDAw
MDAzZmZmIDY0Yml0IHByZWZdClsgICAgMC45MzM1MTddIHBjaSAwMDAwOjAyOjAwLjA6IFZGIEJB
UiAzIFttZW0gMHgwMDAwMDAwMC0weDAwMDFmZmZmIDY0Yml0IHByZWZdOiBjb250YWlucyBCQVIg
MyBmb3IgOCBWRnMKWyAgICAwLjkzMzczNF0gcGNpIDAwMDA6MDI6MDAuMTogWzgwODY6MTUyMV0g
dHlwZSAwMCBjbGFzcyAweDAyMDAwMCBQQ0llIEVuZHBvaW50ClsgICAgMC45MzM3NzddIHBjaSAw
MDAwOjAyOjAwLjE6IEJBUiAwIFttZW0gMHg5NDgwMDAwMC0weDk0ODFmZmZmXQpbICAgIDAuOTMz
Nzg1XSBwY2kgMDAwMDowMjowMC4xOiBCQVIgMiBbaW8gIDB4NTAwMC0weDUwMWZdClsgICAgMC45
MzM3OTFdIHBjaSAwMDAwOjAyOjAwLjE6IEJBUiAzIFttZW0gMHg5NDg0MDAwMC0weDk0ODQzZmZm
XQpbICAgIDAuOTMzODczXSBwY2kgMDAwMDowMjowMC4xOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQw
IEQzaG90IEQzY29sZApbICAgIDAuOTMzOTEwXSBwY2kgMDAwMDowMjowMC4xOiBWRiBCQVIgMCBb
bWVtIDB4MDAwMDAwMDAtMHgwMDAwM2ZmZiA2NGJpdCBwcmVmXQpbICAgIDAuOTMzOTE2XSBwY2kg
MDAwMDowMjowMC4xOiBWRiBCQVIgMCBbbWVtIDB4MDAwMDAwMDAtMHgwMDAxZmZmZiA2NGJpdCBw
cmVmXTogY29udGFpbnMgQkFSIDAgZm9yIDggVkZzClsgICAgMC45MzM5MjZdIHBjaSAwMDAwOjAy
OjAwLjE6IFZGIEJBUiAzIFttZW0gMHgwMDAwMDAwMC0weDAwMDAzZmZmIDY0Yml0IHByZWZdClsg
ICAgMC45MzM5MzFdIHBjaSAwMDAwOjAyOjAwLjE6IFZGIEJBUiAzIFttZW0gMHgwMDAwMDAwMC0w
eDAwMDFmZmZmIDY0Yml0IHByZWZdOiBjb250YWlucyBCQVIgMyBmb3IgOCBWRnMKWyAgICAwLjkz
NDExNF0gcGNpIDAwMDA6MDA6MDEuMTogUENJIGJyaWRnZSB0byBbYnVzIDAyXQpbICAgIDAuOTM0
MjExXSBwY2kgMDAwMDowMzowMC4wOiBbMTAwMDowMDViXSB0eXBlIDAwIGNsYXNzIDB4MDEwNDAw
IFBDSWUgRW5kcG9pbnQKWyAgICAwLjkzNDI0N10gcGNpIDAwMDA6MDM6MDAuMDogQkFSIDAgW2lv
ICAweDQwMDAtMHg0MGZmXQpbICAgIDAuOTM0MjU1XSBwY2kgMDAwMDowMzowMC4wOiBCQVIgMSBb
bWVtIDB4OTQ3NDAwMDAtMHg5NDc0M2ZmZiA2NGJpdF0KWyAgICAwLjkzNDI2Ml0gcGNpIDAwMDA6
MDM6MDAuMDogQkFSIDMgW21lbSAweDk0NzAwMDAwLTB4OTQ3M2ZmZmYgNjRiaXRdClsgICAgMC45
MzQyNjldIHBjaSAwMDAwOjAzOjAwLjA6IFJPTSBbbWVtIDB4ZmZmZTAwMDAtMHhmZmZmZmZmZiBw
cmVmXQpbICAgIDAuOTM0MjgwXSBwY2kgMDAwMDowMzowMC4wOiBlbmFibGluZyBFeHRlbmRlZCBU
YWdzClsgICAgMC45MzQzMDJdIHBjaSAwMDAwOjAzOjAwLjA6IFtGaXJtd2FyZSBCdWddOiBkaXNh
YmxpbmcgVlBEIGFjY2VzcyAoY2FuJ3QgZGV0ZXJtaW5lIHNpemUgb2Ygbm9uLXN0YW5kYXJkIFZQ
RCBmb3JtYXQpClsgICAgMC45MzQzNDZdIHBjaSAwMDAwOjAzOjAwLjA6IHN1cHBvcnRzIEQxIEQy
ClsgICAgMC45MzQ0NzNdIHBjaSAwMDAwOjAwOjAzLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwM10K
WyAgICAwLjkzNDU4OF0gcGNpIDAwMDA6MDQ6MDAuMDogWzgwODY6MWQ2Yl0gdHlwZSAwMCBjbGFz
cyAweDAxMDcwMCBQQ0llIEVuZHBvaW50ClsgICAgMC45MzQ2NDNdIHBjaSAwMDAwOjA0OjAwLjA6
IEJBUiAwIFttZW0gMHg5NDQwMDAwMC0weDk0NDAzZmZmIDY0Yml0IHByZWZdClsgICAgMC45MzQ2
NTNdIHBjaSAwMDAwOjA0OjAwLjA6IEJBUiAyIFttZW0gMHg5NDAwMDAwMC0weDk0M2ZmZmZmIDY0
Yml0IHByZWZdClsgICAgMC45MzQ2NjBdIHBjaSAwMDAwOjA0OjAwLjA6IEJBUiA0IFtpbyAgMHgz
MDAwLTB4MzBmZl0KWyAgICAwLjkzNDY3NF0gcGNpIDAwMDA6MDQ6MDAuMDogZW5hYmxpbmcgRXh0
ZW5kZWQgVGFncwpbICAgIDAuOTM0Nzk5XSBwY2kgMDAwMDowNDowMC4wOiBWRiBCQVIgMCBbbWVt
IDB4MDAwMDAwMDAtMHgwMDAwM2ZmZiA2NGJpdCBwcmVmXQpbICAgIDAuOTM0ODA1XSBwY2kgMDAw
MDowNDowMC4wOiBWRiBCQVIgMCBbbWVtIDB4MDAwMDAwMDAtMHgwMDA3YmZmZiA2NGJpdCBwcmVm
XTogY29udGFpbnMgQkFSIDAgZm9yIDMxIFZGcwpbICAgIDAuOTM1MTIxXSBwY2kgMDAwMDowNDow
MC4zOiBbODA4NjoxZDcwXSB0eXBlIDAwIGNsYXNzIDB4MGMwNTAwIFBDSWUgRW5kcG9pbnQKWyAg
ICAwLjkzNTE3OV0gcGNpIDAwMDA6MDQ6MDAuMzogQkFSIDAgW21lbSAweDk0NjAwMDAwLTB4OTQ2
MDBmZmZdClsgICAgMC45MzUxOTBdIHBjaSAwMDAwOjA0OjAwLjM6IEJBUiA0IFtpbyAgMHgzMTAw
LTB4MzExZl0KWyAgICAwLjkzNTI2Nl0gcGNpIDAwMDA6MDQ6MDAuMzogUE1FIyBzdXBwb3J0ZWQg
ZnJvbSBEMCBEM2hvdCBEM2NvbGQKWyAgICAwLjkzNTM5NV0gcGNpIDAwMDA6MDA6MTEuMDogUENJ
IGJyaWRnZSB0byBbYnVzIDA0XQpbICAgIDAuOTM1NDk2XSBwY2kgMDAwMDowMDoxYy4wOiBQQ0kg
YnJpZGdlIHRvIFtidXMgMDVdClsgICAgMC45MzU1NzldIHBjaSAwMDAwOjAwOjFjLjI6IFBDSSBi
cmlkZ2UgdG8gW2J1cyAwNl0KWyAgICAwLjkzNTY5NV0gcGNpIDAwMDA6MDc6MDAuMDogWzE4Y2E6
MDAyN10gdHlwZSAwMCBjbGFzcyAweDAzMDAwMCBQQ0llIEVuZHBvaW50ClsgICAgMC45MzU3NzRd
IHBjaSAwMDAwOjA3OjAwLjA6IEJBUiAwIFttZW0gMHg5MDAwMDAwMC0weDkzZmZmZmZmIHByZWZd
ClsgICAgMC45MzU3ODJdIHBjaSAwMDAwOjA3OjAwLjA6IEJBUiAxIFttZW0gMHg5NDUwMDAwMC0w
eDk0NTNmZmZmXQpbICAgIDAuOTM1Nzg5XSBwY2kgMDAwMDowNzowMC4wOiBCQVIgMiBbaW8gIDB4
MjAwMC0weDIwN2ZdClsgICAgMC45MzU4MTNdIHBjaSAwMDAwOjA3OjAwLjA6IGVuYWJsaW5nIEV4
dGVuZGVkIFRhZ3MKWyAgICAwLjkzNTg0OF0gcGNpIDAwMDA6MDc6MDAuMDogVmlkZW8gZGV2aWNl
IHdpdGggc2hhZG93ZWQgUk9NIGF0IFttZW0gMHgwMDBjMDAwMC0weDAwMGRmZmZmXQpbICAgIDAu
OTM1OTE5XSBwY2kgMDAwMDowNzowMC4wOiBzdXBwb3J0cyBEMSBEMgpbICAgIDAuOTM2MDc3XSBw
Y2kgMDAwMDowMDoxYy4zOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDddClsgICAgMC45MzYxMTJdIHBj
aV9idXMgMDAwMDowODogZXh0ZW5kZWQgY29uZmlnIHNwYWNlIG5vdCBhY2Nlc3NpYmxlClsgICAg
MC45MzYyMDRdIHBjaSAwMDAwOjAwOjFlLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwOF0gKHN1YnRy
YWN0aXZlIGRlY29kZSkKWyAgICAwLjkzNjIxOV0gcGNpIDAwMDA6MDA6MWUuMDogICBicmlkZ2Ug
d2luZG93IFtpbyAgMHgwMDAwLTB4MGNmNyB3aW5kb3ddIChzdWJ0cmFjdGl2ZSBkZWNvZGUpClsg
ICAgMC45MzYyMjZdIHBjaSAwMDAwOjAwOjFlLjA6ICAgYnJpZGdlIHdpbmRvdyBbaW8gIDB4MTAw
MC0weGZmZmYgd2luZG93XSAoc3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDAuOTM2MjMzXSBwY2kg
MDAwMDowMDoxZS4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDAwMGEwMDAwLTB4MDAwYmZmZmYg
d2luZG93XSAoc3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDAuOTM2MjQwXSBwY2kgMDAwMDowMDox
ZS4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDkwMDAwMDAwLTB4ZmJmZmVmZmYgd2luZG93XSAo
c3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDAuOTM4MTkwXSBBQ1BJOiBQQ0kgUm9vdCBCcmlkZ2Ug
W1VOQzBdIChkb21haW4gMDAwMCBbYnVzIGZmXSkKWyAgICAwLjkzODQxMF0gUENJIGhvc3QgYnJp
ZGdlIHRvIGJ1cyAwMDAwOmZmClsgICAgMC45Mzg0MjFdIHBjaV9idXMgMDAwMDpmZjogcm9vdCBi
dXMgcmVzb3VyY2UgW2J1cyBmZl0KWyAgICAwLjkzODQ0Ml0gcGNpIDAwMDA6ZmY6MDguMDogWzgw
ODY6M2M4MF0gdHlwZSAwMCBjbGFzcyAweDA4ODAwMCBjb252ZW50aW9uYWwgUENJIGVuZHBvaW50
ClsgICAgMC45Mzg1NjNdIHBjaSAwMDAwOmZmOjA4LjM6IFs4MDg2OjNjODNdIHR5cGUgMDAgY2xh
c3MgMHgwODgwMDAgUENJZSBSb290IENvbXBsZXggSW50ZWdyYXRlZCBFbmRwb2ludApbICAgIDAu
OTM4Njk3XSBwY2kgMDAwMDpmZjowOC40OiBbODA4NjozYzg0XSB0eXBlIDAwIGNsYXNzIDB4MDg4
MDAwIFBDSWUgUm9vdCBDb21wbGV4IEludGVncmF0ZWQgRW5kcG9pbnQKWyAgICAwLjkzODgyNF0g
cGNpIDAwMDA6ZmY6MDkuMDogWzgwODY6M2M5MF0gdHlwZSAwMCBjbGFzcyAweDA4ODAwMCBjb252
ZW50aW9uYWwgUENJIGVuZHBvaW50ClsgICAgMC45Mzg5MjhdIHBjaSAwMDAwOmZmOjA5LjM6IFs4
MDg2OjNjOTNdIHR5cGUgMDAgY2xhc3MgMHgwODgwMDAgUENJZSBSb290IENvbXBsZXggSW50ZWdy
YXRlZCBFbmRwb2ludApbICAgIDAuOTM5MDUyXSBwY2kgMDAwMDpmZjowOS40OiBbODA4NjozYzk0
XSB0eXBlIDAwIGNsYXNzIDB4MDg4MDAwIFBDSWUgUm9vdCBDb21wbGV4IEludGVncmF0ZWQgRW5k
cG9pbnQKWyAgICAwLjkzOTE3Ml0gcGNpIDAwMDA6ZmY6MGEuMDogWzgwODY6M2NjMF0gdHlwZSAw
MCBjbGFzcyAweDA4ODAwMCBjb252ZW50aW9uYWwgUENJIGVuZHBvaW50ClsgICAgMC45MzkyNjRd
IHBjaSAwMDAwOmZmOjBhLjE6IFs4MDg2OjNjYzFdIHR5cGUgMDAgY2xhc3MgMHgwODgwMDAgY29u
dmVudGlvbmFsIFBDSSBlbmRwb2ludApbICAgIDAuOTM5MzU3XSBwY2kgMDAwMDpmZjowYS4yOiBb
ODA4NjozY2MyXSB0eXBlIDAwIGNsYXNzIDB4MDg4MDAwIGNvbnZlbnRpb25hbCBQQ0kgZW5kcG9p
bnQKWyAgICAwLjkzOTQ0OV0gcGNpIDAwMDA6ZmY6MGEuMzogWzgwODY6M2NkMF0gdHlwZSAwMCBj
bGFzcyAweDA4ODAwMCBjb252ZW50aW9uYWwgUENJIGVuZHBvaW50ClsgICAgMC45Mzk1NDJdIHBj
aSAwMDAwOmZmOjBiLjA6IFs4MDg2OjNjZTBdIHR5cGUgMDAgY2xhc3MgMHgwODgwMDAgY29udmVu
dGlvbmFsIFBDSSBlbmRwb2ludApbICAgIDAuOTM5NjM3XSBwY2kgMDAwMDpmZjowYi4zOiBbODA4
NjozY2UzXSB0eXBlIDAwIGNsYXNzIDB4MDg4MDAwIGNvbnZlbnRpb25hbCBQQ0kgZW5kcG9pbnQK
WyAgICAwLjkzOTcyMl0gcGNpIDAwMDA6ZmY6MGMuMDogWzgwODY6M2NlOF0gdHlwZSAwMCBjbGFz
cyAweDA4ODAwMCBjb252ZW50aW9uYWwgUENJIGVuZHBvaW50ClsgICAgMC45Mzk4MTJdIHBjaSAw
MDAwOmZmOjBjLjE6IFs4MDg2OjNjZThdIHR5cGUgMDAgY2xhc3MgMHgwODgwMDAgY29udmVudGlv
bmFsIFBDSSBlbmRwb2ludApbICAgIDAuOTM5OTAyXSBwY2kgMDAwMDpmZjowYy4yOiBbODA4Njoz
Y2U4XSB0eXBlIDAwIGNsYXNzIDB4MDg4MDAwIGNvbnZlbnRpb25hbCBQQ0kgZW5kcG9pbnQKWyAg
ICAwLjkzOTk4NF0gcGNpIDAwMDA6ZmY6MGMuMzogWzgwODY6M2NlOF0gdHlwZSAwMCBjbGFzcyAw
eDA4ODAwMCBjb252ZW50aW9uYWwgUENJIGVuZHBvaW50ClsgICAgMC45NDAwODFdIHBjaSAwMDAw
OmZmOjBjLjY6IFs4MDg2OjNjZjRdIHR5cGUgMDAgY2xhc3MgMHgwODgwMDAgY29udmVudGlvbmFs
IFBDSSBlbmRwb2ludApbICAgIDAuOTQwMjI4XSBwY2kgMDAwMDpmZjowYy43OiBbODA4NjozY2Y2
XSB0eXBlIDAwIGNsYXNzIDB4MDg4MDAwIGNvbnZlbnRpb25hbCBQQ0kgZW5kcG9pbnQKWyAgICAw
Ljk0MDMyMV0gcGNpIDAwMDA6ZmY6MGQuMDogWzgwODY6M2NlOF0gdHlwZSAwMCBjbGFzcyAweDA4
ODAwMCBjb252ZW50aW9uYWwgUENJIGVuZHBvaW50ClsgICAgMC45NDA0MDJdIHBjaSAwMDAwOmZm
OjBkLjE6IFs4MDg2OjNjZThdIHR5cGUgMDAgY2xhc3MgMHgwODgwMDAgY29udmVudGlvbmFsIFBD
SSBlbmRwb2ludApbICAgIDAuOTQwNDkyXSBwY2kgMDAwMDpmZjowZC4yOiBbODA4NjozY2U4XSB0
eXBlIDAwIGNsYXNzIDB4MDg4MDAwIGNvbnZlbnRpb25hbCBQQ0kgZW5kcG9pbnQKWyAgICAwLjk0
MDU4Ml0gcGNpIDAwMDA6ZmY6MGQuMzogWzgwODY6M2NlOF0gdHlwZSAwMCBjbGFzcyAweDA4ODAw
MCBjb252ZW50aW9uYWwgUENJIGVuZHBvaW50ClsgICAgMC45NDA2NzFdIHBjaSAwMDAwOmZmOjBk
LjY6IFs4MDg2OjNjZjVdIHR5cGUgMDAgY2xhc3MgMHgwODgwMDAgY29udmVudGlvbmFsIFBDSSBl
bmRwb2ludApbICAgIDAuOTQwNzY1XSBwY2kgMDAwMDpmZjowZS4wOiBbODA4NjozY2EwXSB0eXBl
IDAwIGNsYXNzIDB4MDg4MDAwIGNvbnZlbnRpb25hbCBQQ0kgZW5kcG9pbnQKWyAgICAwLjk0MDg2
MF0gcGNpIDAwMDA6ZmY6MGUuMTogWzgwODY6M2M0Nl0gdHlwZSAwMCBjbGFzcyAweDExMDEwMCBj
b252ZW50aW9uYWwgUENJIGVuZHBvaW50ClsgICAgMC45NDA5NjRdIHBjaSAwMDAwOmZmOjBmLjA6
IFs4MDg2OjNjYThdIHR5cGUgMDAgY2xhc3MgMHgwODgwMDAgUENJZSBSb290IENvbXBsZXggSW50
ZWdyYXRlZCBFbmRwb2ludApbICAgIDAuOTQxMDgzXSBwY2kgMDAwMDpmZjowZi4xOiBbODA4Njoz
YzcxXSB0eXBlIDAwIGNsYXNzIDB4MDg4MDAwIFBDSWUgUm9vdCBDb21wbGV4IEludGVncmF0ZWQg
RW5kcG9pbnQKWyAgICAwLjk0MTIwMV0gcGNpIDAwMDA6ZmY6MGYuMjogWzgwODY6M2NhYV0gdHlw
ZSAwMCBjbGFzcyAweDA4ODAwMCBQQ0llIFJvb3QgQ29tcGxleCBJbnRlZ3JhdGVkIEVuZHBvaW50
ClsgICAgMC45NDEzMjZdIHBjaSAwMDAwOmZmOjBmLjM6IFs4MDg2OjNjYWJdIHR5cGUgMDAgY2xh
c3MgMHgwODgwMDAgUENJZSBSb290IENvbXBsZXggSW50ZWdyYXRlZCBFbmRwb2ludApbICAgIDAu
OTQxNDM3XSBwY2kgMDAwMDpmZjowZi40OiBbODA4NjozY2FjXSB0eXBlIDAwIGNsYXNzIDB4MDg4
MDAwIFBDSWUgUm9vdCBDb21wbGV4IEludGVncmF0ZWQgRW5kcG9pbnQKWyAgICAwLjk0MTU1NV0g
cGNpIDAwMDA6ZmY6MGYuNTogWzgwODY6M2NhZF0gdHlwZSAwMCBjbGFzcyAweDA4ODAwMCBQQ0ll
IFJvb3QgQ29tcGxleCBJbnRlZ3JhdGVkIEVuZHBvaW50ClsgICAgMC45NDE2ODFdIHBjaSAwMDAw
OmZmOjBmLjY6IFs4MDg2OjNjYWVdIHR5cGUgMDAgY2xhc3MgMHgwODgwMDAgY29udmVudGlvbmFs
IFBDSSBlbmRwb2ludApbICAgIDAuOTQxNzc2XSBwY2kgMDAwMDpmZjoxMC4wOiBbODA4NjozY2Iw
XSB0eXBlIDAwIGNsYXNzIDB4MDg4MDAwIFBDSWUgUm9vdCBDb21wbGV4IEludGVncmF0ZWQgRW5k
cG9pbnQKWyAgICAwLjk0MTkwMl0gcGNpIDAwMDA6ZmY6MTAuMTogWzgwODY6M2NiMV0gdHlwZSAw
MCBjbGFzcyAweDA4ODAwMCBQQ0llIFJvb3QgQ29tcGxleCBJbnRlZ3JhdGVkIEVuZHBvaW50Clsg
ICAgMC45NDIwMjBdIHBjaSAwMDAwOmZmOjEwLjI6IFs4MDg2OjNjYjJdIHR5cGUgMDAgY2xhc3Mg
MHgwODgwMDAgUENJZSBSb290IENvbXBsZXggSW50ZWdyYXRlZCBFbmRwb2ludApbICAgIDAuOTQy
MTM3XSBwY2kgMDAwMDpmZjoxMC4zOiBbODA4NjozY2IzXSB0eXBlIDAwIGNsYXNzIDB4MDg4MDAw
IFBDSWUgUm9vdCBDb21wbGV4IEludGVncmF0ZWQgRW5kcG9pbnQKWyAgICAwLjk0MjI0N10gcGNp
IDAwMDA6ZmY6MTAuNTogWzgwODY6M2NiNV0gdHlwZSAwMCBjbGFzcyAweDA4ODAwMCBQQ0llIFJv
b3QgQ29tcGxleCBJbnRlZ3JhdGVkIEVuZHBvaW50ClsgICAgMC45NDIzNjZdIHBjaSAwMDAwOmZm
OjEwLjY6IFs4MDg2OjNjYjZdIHR5cGUgMDAgY2xhc3MgMHgwODgwMDAgUENJZSBSb290IENvbXBs
ZXggSW50ZWdyYXRlZCBFbmRwb2ludApbICAgIDAuOTQyNDgzXSBwY2kgMDAwMDpmZjoxMC43OiBb
ODA4NjozY2I3XSB0eXBlIDAwIGNsYXNzIDB4MDg4MDAwIFBDSWUgUm9vdCBDb21wbGV4IEludGVn
cmF0ZWQgRW5kcG9pbnQKWyAgICAwLjk0MjU5OF0gcGNpIDAwMDA6ZmY6MTEuMDogWzgwODY6M2Ni
OF0gdHlwZSAwMCBjbGFzcyAweDA4ODAwMCBjb252ZW50aW9uYWwgUENJIGVuZHBvaW50ClsgICAg
MC45NDI3MDBdIHBjaSAwMDAwOmZmOjEzLjA6IFs4MDg2OjNjZTRdIHR5cGUgMDAgY2xhc3MgMHgw
ODgwMDAgY29udmVudGlvbmFsIFBDSSBlbmRwb2ludApbICAgIDAuOTQyODAyXSBwY2kgMDAwMDpm
ZjoxMy4xOiBbODA4NjozYzQzXSB0eXBlIDAwIGNsYXNzIDB4MTEwMTAwIGNvbnZlbnRpb25hbCBQ
Q0kgZW5kcG9pbnQKWyAgICAwLjk0Mjg5Nl0gcGNpIDAwMDA6ZmY6MTMuNDogWzgwODY6M2NlNl0g
dHlwZSAwMCBjbGFzcyAweDExMDEwMCBjb252ZW50aW9uYWwgUENJIGVuZHBvaW50ClsgICAgMC45
NDI5OTVdIHBjaSAwMDAwOmZmOjEzLjU6IFs4MDg2OjNjNDRdIHR5cGUgMDAgY2xhc3MgMHgxMTAx
MDAgY29udmVudGlvbmFsIFBDSSBlbmRwb2ludApbICAgIDAuOTQzMDg3XSBwY2kgMDAwMDpmZjox
My42OiBbODA4NjozYzQ1XSB0eXBlIDAwIGNsYXNzIDB4MDg4MDAwIGNvbnZlbnRpb25hbCBQQ0kg
ZW5kcG9pbnQKWyAgICAwLjk1MjAxN10gQUNQSTogUENJOiBJbnRlcnJ1cHQgbGluayBMTktBIGNv
bmZpZ3VyZWQgZm9yIElSUSAzClsgICAgMC45NTIxNDldIEFDUEk6IFBDSTogSW50ZXJydXB0IGxp
bmsgTE5LQiBjb25maWd1cmVkIGZvciBJUlEgNQpbICAgIDAuOTUyMjc2XSBBQ1BJOiBQQ0k6IElu
dGVycnVwdCBsaW5rIExOS0MgY29uZmlndXJlZCBmb3IgSVJRIDYKWyAgICAwLjk1MjQwMl0gQUNQ
STogUENJOiBJbnRlcnJ1cHQgbGluayBMTktEIGNvbmZpZ3VyZWQgZm9yIElSUSA3ClsgICAgMC45
NTI1MjddIEFDUEk6IFBDSTogSW50ZXJydXB0IGxpbmsgTE5LRSBjb25maWd1cmVkIGZvciBJUlEg
MApbICAgIDAuOTUyNTM0XSBBQ1BJOiBQQ0k6IEludGVycnVwdCBsaW5rIExOS0UgZGlzYWJsZWQK
WyAgICAwLjk1MjY2NV0gQUNQSTogUENJOiBJbnRlcnJ1cHQgbGluayBMTktGIGNvbmZpZ3VyZWQg
Zm9yIElSUSAxMApbICAgIDAuOTUyNzkyXSBBQ1BJOiBQQ0k6IEludGVycnVwdCBsaW5rIExOS0cg
Y29uZmlndXJlZCBmb3IgSVJRIDAKWyAgICAwLjk1Mjc5OF0gQUNQSTogUENJOiBJbnRlcnJ1cHQg
bGluayBMTktHIGRpc2FibGVkClsgICAgMC45NTI5MjFdIEFDUEk6IFBDSTogSW50ZXJydXB0IGxp
bmsgTE5LSCBjb25maWd1cmVkIGZvciBJUlEgOQpbICAgIDAuOTUzMjE3XSBpb21tdTogRGVmYXVs
dCBkb21haW4gdHlwZTogVHJhbnNsYXRlZApbICAgIDAuOTUzMjE3XSBpb21tdTogRE1BIGRvbWFp
biBUTEIgaW52YWxpZGF0aW9uIHBvbGljeTogbGF6eSBtb2RlClsgICAgMC45NTQwNDddIFNDU0kg
c3Vic3lzdGVtIGluaXRpYWxpemVkClsgICAgMC45NTQwNzBdIGxpYmF0YSB2ZXJzaW9uIDMuMDAg
bG9hZGVkLgpbICAgIDAuOTU0MDcwXSBBQ1BJOiBidXMgdHlwZSBVU0IgcmVnaXN0ZXJlZApbICAg
IDAuOTU0MDcwXSB1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHVzYmZz
ClsgICAgMC45NTQwNzBdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIg
aHViClsgICAgMC45NTQwNzBdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGRldmljZSBkcml2ZXIg
dXNiClsgICAgMC45NTQwNzBdIHBwc19jb3JlOiBMaW51eFBQUyBBUEkgdmVyLiAxIHJlZ2lzdGVy
ZWQKWyAgICAwLjk1NDA3MF0gcHBzX2NvcmU6IFNvZnR3YXJlIHZlci4gNS4zLjYgLSBDb3B5cmln
aHQgMjAwNS0yMDA3IFJvZG9sZm8gR2lvbWV0dGkgPGdpb21ldHRpQGxpbnV4Lml0PgpbICAgIDAu
OTU0MDcwXSBQVFAgY2xvY2sgc3VwcG9ydCByZWdpc3RlcmVkClsgICAgMC45NTQ2NjJdIEVEQUMg
TUM6IFZlcjogMy4wLjAKWyAgICAwLjk1NTY2MV0gTmV0TGFiZWw6IEluaXRpYWxpemluZwpbICAg
IDAuOTU1NjY5XSBOZXRMYWJlbDogIGRvbWFpbiBoYXNoIHNpemUgPSAxMjgKWyAgICAwLjk1NTY3
M10gTmV0TGFiZWw6ICBwcm90b2NvbHMgPSBVTkxBQkVMRUQgQ0lQU092NCBDQUxJUFNPClsgICAg
MC45NTU3MDZdIE5ldExhYmVsOiAgdW5sYWJlbGVkIHRyYWZmaWMgYWxsb3dlZCBieSBkZWZhdWx0
ClsgICAgMC45NTU3NTJdIG1jdHA6IG1hbmFnZW1lbnQgY29tcG9uZW50IHRyYW5zcG9ydCBwcm90
b2NvbCBjb3JlClsgICAgMC45NTU3NTJdIE5FVDogUmVnaXN0ZXJlZCBQRl9NQ1RQIHByb3RvY29s
IGZhbWlseQpbICAgIDAuOTU1NzUyXSBQQ0k6IFVzaW5nIEFDUEkgZm9yIElSUSByb3V0aW5nClsg
ICAgMC45NjI5MjNdIFBDSTogcGNpX2NhY2hlX2xpbmVfc2l6ZSBzZXQgdG8gNjQgYnl0ZXMKWyAg
ICAwLjk2MzA2OF0gZTgyMDogcmVnaXN0ZXIgUkFNIGJ1ZmZlciByZXNvdXJjZSBbbWVtIDB4MDAw
OWQwMDAtMHgwMDA5ZmZmZl0KWyAgICAwLjk2MzA3Nl0gZTgyMDogcmVnaXN0ZXIgUkFNIGJ1ZmZl
ciByZXNvdXJjZSBbbWVtIDB4N2U0ZmYwMDAtMHg3ZmZmZmZmZl0KWyAgICAwLjk2MzA4Ml0gZTgy
MDogcmVnaXN0ZXIgUkFNIGJ1ZmZlciByZXNvdXJjZSBbbWVtIDB4N2YwMDAwMDAtMHg3ZmZmZmZm
Zl0KWyAgICAwLjk2MzExN10gcGNpIDAwMDA6MDc6MDAuMDogdmdhYXJiOiBzZXR0aW5nIGFzIGJv
b3QgVkdBIGRldmljZQpbICAgIDAuOTYzMTE3XSBwY2kgMDAwMDowNzowMC4wOiB2Z2FhcmI6IGJy
aWRnZSBjb250cm9sIHBvc3NpYmxlClsgICAgMC45NjMxMTddIHBjaSAwMDAwOjA3OjAwLjA6IHZn
YWFyYjogVkdBIGRldmljZSBhZGRlZDogZGVjb2Rlcz1pbyttZW0sb3ducz1pbyttZW0sbG9ja3M9
bm9uZQpbICAgIDAuOTYzMTE3XSB2Z2FhcmI6IGxvYWRlZApbICAgIDAuOTY0NzQxXSBocGV0MDog
YXQgTU1JTyAweGZlZDAwMDAwLCBJUlFzIDIsIDgsIDAsIDAsIDAsIDAsIDAsIDAKWyAgICAwLjk2
NDc0MV0gaHBldDA6IDggY29tcGFyYXRvcnMsIDY0LWJpdCAxNC4zMTgxODAgTUh6IGNvdW50ZXIK
WyAgICAwLjk2NjY4Nl0gY2xvY2tzb3VyY2U6IFN3aXRjaGVkIHRvIGNsb2Nrc291cmNlIHRzYy1l
YXJseQpbICAgIDAuOTY3ODM2XSBWRlM6IERpc2sgcXVvdGFzIGRxdW90XzYuNi4wClsgICAgMC45
Njc5NDJdIFZGUzogRHF1b3QtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA1MTIgKDQwOTYgYnl0
ZXMpClsgICAgMC45NjgzNDFdIEFwcEFybW9yOiBBcHBBcm1vciBGaWxlc3lzdGVtIEVuYWJsZWQK
WyAgICAwLjk2ODUxOV0gYWNwaSBQTlAwQzAyOjAwOiBSZXNlcnZlZCBbbWVtIDB4ZmVkMWMwMDAt
MHhmZWQxZmZmZl0KWyAgICAwLjk2ODUzMF0gYWNwaSBQTlAwQzAyOjAwOiBSZXNlcnZlZCBbbWVt
IDB4ZmJmZmYwMDAtMHhmYmZmZmZmZl0KWyAgICAwLjk2ODUzNV0gYWNwaSBQTlAwQzAyOjAwOiBS
ZXNlcnZlZCBbbWVtIDB4ZmVkMjAwMDAtMHhmZWQzZmZmZl0KWyAgICAwLjk2ODU0Ml0gYWNwaSBQ
TlAwQzAyOjAwOiBDb3VsZCBub3QgcmVzZXJ2ZSBbbWVtIDB4ZmJmZmMwMDAtMHhmYmZmZGZmZl0K
WyAgICAwLjk2ODU0N10gYWNwaSBQTlAwQzAyOjAwOiBDb3VsZCBub3QgcmVzZXJ2ZSBbbWVtIDB4
ZmYwMDAwMDAtMHhmZmZmZmZmZl0KWyAgICAwLjk2ODU1M10gYWNwaSBQTlAwQzAyOjAwOiBDb3Vs
ZCBub3QgcmVzZXJ2ZSBbbWVtIDB4ZmVlMDAwMDAtMHhmZWVmZmZmZl0KWyAgICAwLjk2ODU4Nl0g
YWNwaSBQTlAwQzAyOjAxOiBTa2lwcGVkIFtpbyAgMHgwMDJlLTB4MDAyZl0KWyAgICAwLjk2ODU5
Ml0gYWNwaSBQTlAwQzAyOjAxOiBTa2lwcGVkIFtpbyAgMHgwMDRlLTB4MDA0Zl0KWyAgICAwLjk2
ODU5N10gYWNwaSBQTlAwQzAyOjAxOiBTa2lwcGVkIFtpbyAgMHgwMDYxXQpbICAgIDAuOTY4NjAy
XSBhY3BpIFBOUDBDMDI6MDE6IFNraXBwZWQgW2lvICAweDAwNjNdClsgICAgMC45Njg2MDZdIGFj
cGkgUE5QMEMwMjowMTogU2tpcHBlZCBbaW8gIDB4MDA2NV0KWyAgICAwLjk2ODYxMV0gYWNwaSBQ
TlAwQzAyOjAxOiBTa2lwcGVkIFtpbyAgMHgwMDY3XQpbICAgIDAuOTY4NjE1XSBhY3BpIFBOUDBD
MDI6MDE6IFNraXBwZWQgW2lvICAweDAwNzBdClsgICAgMC45Njg2MTldIGFjcGkgUE5QMEMwMjow
MTogU2tpcHBlZCBbaW8gIDB4MDA4MF0KWyAgICAwLjk2ODYzOF0gYWNwaSBQTlAwQzAyOjAxOiBT
a2lwcGVkIFtpbyAgMHgwMDkyXQpbICAgIDAuOTY4NjQyXSBhY3BpIFBOUDBDMDI6MDE6IFNraXBw
ZWQgW2lvICAweDAwYjItMHgwMGIzXQpbICAgIDAuOTY4NjQ4XSBhY3BpIFBOUDBDMDI6MDE6IFJl
c2VydmVkIFtpbyAgMHgwNjgwLTB4MDY5Zl0KWyAgICAwLjk2ODY1M10gYWNwaSBQTlAwQzAyOjAx
OiBSZXNlcnZlZCBbaW8gIDB4MDQwMC0weDA0NTNdClsgICAgMC45Njg2NTldIGFjcGkgUE5QMEMw
MjowMTogUmVzZXJ2ZWQgW2lvICAweDA0NTgtMHgwNDdmXQpbICAgIDAuOTY4NjYzXSBhY3BpIFBO
UDBDMDI6MDE6IFJlc2VydmVkIFtpbyAgMHgwNTAwLTB4MDU3Zl0KWyAgICAwLjk2ODY2OF0gYWNw
aSBQTlAwQzAyOjAxOiBSZXNlcnZlZCBbaW8gIDB4MTY0ZS0weDE2NGZdClsgICAgMC45Njg2OTZd
IHBucDogUG5QIEFDUEkgaW5pdApbICAgIDAuOTY5MDgzXSBwbnAgMDA6MDI6IFtkbWEgMCBkaXNh
YmxlZF0KWyAgICAwLjk2OTk4MF0gcG5wOiBQblAgQUNQSTogZm91bmQgMyBkZXZpY2VzClsgICAg
MC45Nzc2ODddIGNsb2Nrc291cmNlOiBhY3BpX3BtOiBtYXNrOiAweGZmZmZmZiBtYXhfY3ljbGVz
OiAweGZmZmZmZiwgbWF4X2lkbGVfbnM6IDIwODU3MDEwMjQgbnMKWyAgICAwLjk3ODE5M10gTkVU
OiBSZWdpc3RlcmVkIFBGX0lORVQgcHJvdG9jb2wgZmFtaWx5ClsgICAgMC45Nzg1MDFdIElQIGlk
ZW50cyBoYXNoIHRhYmxlIGVudHJpZXM6IDI2MjE0NCAob3JkZXI6IDksIDIwOTcxNTIgYnl0ZXMs
IGxpbmVhcikKWyAgICAwLjk4NTU5Nl0gdGNwX2xpc3Rlbl9wb3J0YWRkcl9oYXNoIGhhc2ggdGFi
bGUgZW50cmllczogODE5MiAob3JkZXI6IDUsIDEzMTA3MiBieXRlcywgbGluZWFyKQpbICAgIDAu
OTg1NjY3XSBUYWJsZS1wZXJ0dXJiIGhhc2ggdGFibGUgZW50cmllczogNjU1MzYgKG9yZGVyOiA2
LCAyNjIxNDQgYnl0ZXMsIGxpbmVhcikKWyAgICAwLjk4NTgwOF0gVENQIGVzdGFibGlzaGVkIGhh
c2ggdGFibGUgZW50cmllczogMTMxMDcyIChvcmRlcjogOCwgMTA0ODU3NiBieXRlcywgbGluZWFy
KQpbICAgIDAuOTg2MjQ4XSBUQ1AgYmluZCBoYXNoIHRhYmxlIGVudHJpZXM6IDY1NTM2IChvcmRl
cjogOSwgMjA5NzE1MiBieXRlcywgbGluZWFyKQpbICAgIDAuOTg2NzIyXSBUQ1A6IEhhc2ggdGFi
bGVzIGNvbmZpZ3VyZWQgKGVzdGFibGlzaGVkIDEzMTA3MiBiaW5kIDY1NTM2KQpbICAgIDAuOTg2
OTk5XSBNUFRDUCB0b2tlbiBoYXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0IChvcmRlcjogNywgMzkz
MjE2IGJ5dGVzLCBsaW5lYXIpClsgICAgMC45ODcxNTddIFVEUCBoYXNoIHRhYmxlIGVudHJpZXM6
IDgxOTIgKG9yZGVyOiA3LCA1MjQyODggYnl0ZXMsIGxpbmVhcikKWyAgICAwLjk4NzQ2MV0gTkVU
OiBSZWdpc3RlcmVkIFBGX1VOSVgvUEZfTE9DQUwgcHJvdG9jb2wgZmFtaWx5ClsgICAgMC45ODc0
ODZdIE5FVDogUmVnaXN0ZXJlZCBQRl9YRFAgcHJvdG9jb2wgZmFtaWx5ClsgICAgMC45ODc0OTld
IHBjaSAwMDAwOjAzOjAwLjA6IFJPTSBbbWVtIDB4ZmZmZTAwMDAtMHhmZmZmZmZmZiBwcmVmXTog
Y2FuJ3QgY2xhaW07IG5vIGNvbXBhdGlibGUgYnJpZGdlIHdpbmRvdwpbICAgIDAuOTg3NTE3XSBw
Y2lfYnVzIDAwMDA6MDA6IG1heCBidXMgZGVwdGg6IDEgcGNpX3RyeV9udW06IDIKWyAgICAwLjk4
NzU1NV0gcGNpIDAwMDA6MDA6MDEuMTogYnJpZGdlIHdpbmRvdyBbbWVtIDB4OTRhMDAwMDAtMHg5
NGFmZmZmZiA2NGJpdCBwcmVmXTogYXNzaWduZWQKWyAgICAwLjk4NzU2Nl0gcGNpIDAwMDA6MDA6
MDMuMDogYnJpZGdlIHdpbmRvdyBbbWVtIDB4OTRiMDAwMDAtMHg5NGNmZmZmZiA2NGJpdCBwcmVm
XTogYXNzaWduZWQKWyAgICAwLjk4NzU3NV0gcGNpIDAwMDA6MDA6MDEuMDogUENJIGJyaWRnZSB0
byBbYnVzIDAxXQpbICAgIDAuOTg3NTkyXSBwY2kgMDAwMDowMjowMC4wOiBWRiBCQVIgMCBbbWVt
IDB4OTRhMDAwMDAtMHg5NGExZmZmZiA2NGJpdCBwcmVmXTogYXNzaWduZWQKWyAgICAwLjk4NzYw
M10gcGNpIDAwMDA6MDI6MDAuMDogVkYgQkFSIDMgW21lbSAweDk0YTIwMDAwLTB4OTRhM2ZmZmYg
NjRiaXQgcHJlZl06IGFzc2lnbmVkClsgICAgMC45ODc2MTJdIHBjaSAwMDAwOjAyOjAwLjE6IFZG
IEJBUiAwIFttZW0gMHg5NGE0MDAwMC0weDk0YTVmZmZmIDY0Yml0IHByZWZdOiBhc3NpZ25lZApb
ICAgIDAuOTg3NjI4XSBwY2kgMDAwMDowMjowMC4xOiBWRiBCQVIgMyBbbWVtIDB4OTRhNjAwMDAt
MHg5NGE3ZmZmZiA2NGJpdCBwcmVmXTogYXNzaWduZWQKWyAgICAwLjk4NzY0MV0gcGNpIDAwMDA6
MDA6MDEuMTogUENJIGJyaWRnZSB0byBbYnVzIDAyXQpbICAgIDAuOTg3NjQ3XSBwY2kgMDAwMDow
MDowMS4xOiAgIGJyaWRnZSB3aW5kb3cgW2lvICAweDUwMDAtMHg1ZmZmXQpbICAgIDAuOTg3NjU2
XSBwY2kgMDAwMDowMDowMS4xOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDk0ODAwMDAwLTB4OTQ4
ZmZmZmZdClsgICAgMC45ODc2NjNdIHBjaSAwMDAwOjAwOjAxLjE6ICAgYnJpZGdlIHdpbmRvdyBb
bWVtIDB4OTRhMDAwMDAtMHg5NGFmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAuOTg3Njc1XSBwY2kg
MDAwMDowMzowMC4wOiBST00gW21lbSAweDk0NzYwMDAwLTB4OTQ3N2ZmZmYgcHJlZl06IGFzc2ln
bmVkClsgICAgMC45ODc2ODJdIHBjaSAwMDAwOjAwOjAzLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAw
M10KWyAgICAwLjk4NzY4OF0gcGNpIDAwMDA6MDA6MDMuMDogICBicmlkZ2Ugd2luZG93IFtpbyAg
MHg0MDAwLTB4NGZmZl0KWyAgICAwLjk4NzY5Nl0gcGNpIDAwMDA6MDA6MDMuMDogICBicmlkZ2Ug
d2luZG93IFttZW0gMHg5NDcwMDAwMC0weDk0N2ZmZmZmXQpbICAgIDAuOTg3NzA0XSBwY2kgMDAw
MDowMDowMy4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDk0YjAwMDAwLTB4OTRjZmZmZmYgNjRi
aXQgcHJlZl0KWyAgICAwLjk4NzcxN10gcGNpIDAwMDA6MDQ6MDAuMDogVkYgQkFSIDAgW21lbSAw
eDk0NDA0MDAwLTB4OTQ0N2ZmZmYgNjRiaXQgcHJlZl06IGFzc2lnbmVkClsgICAgMC45ODc3Mjdd
IHBjaSAwMDAwOjAwOjExLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwNF0KWyAgICAwLjk4NzczM10g
cGNpIDAwMDA6MDA6MTEuMDogICBicmlkZ2Ugd2luZG93IFtpbyAgMHgzMDAwLTB4M2ZmZl0KWyAg
ICAwLjk4Nzc0Ml0gcGNpIDAwMDA6MDA6MTEuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHg5NDYw
MDAwMC0weDk0NmZmZmZmXQpbICAgIDAuOTg3NzUwXSBwY2kgMDAwMDowMDoxMS4wOiAgIGJyaWRn
ZSB3aW5kb3cgW21lbSAweDk0MDAwMDAwLTB4OTQ0ZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjk4
Nzc2Ml0gcGNpIDAwMDA6MDA6MWMuMDogUENJIGJyaWRnZSB0byBbYnVzIDA1XQpbICAgIDAuOTg3
Nzc3XSBwY2kgMDAwMDowMDoxYy4yOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDZdClsgICAgMC45ODc3
OTNdIHBjaSAwMDAwOjAwOjFjLjM6IFBDSSBicmlkZ2UgdG8gW2J1cyAwN10KWyAgICAwLjk4Nzc5
OV0gcGNpIDAwMDA6MDA6MWMuMzogICBicmlkZ2Ugd2luZG93IFtpbyAgMHgyMDAwLTB4MmZmZl0K
WyAgICAwLjk4NzgwN10gcGNpIDAwMDA6MDA6MWMuMzogICBicmlkZ2Ugd2luZG93IFttZW0gMHg5
NDUwMDAwMC0weDk0NWZmZmZmXQpbICAgIDAuOTg3ODE1XSBwY2kgMDAwMDowMDoxYy4zOiAgIGJy
aWRnZSB3aW5kb3cgW21lbSAweDkwMDAwMDAwLTB4OTNmZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAw
Ljk4NzgyNl0gcGNpIDAwMDA6MDA6MWUuMDogUENJIGJyaWRnZSB0byBbYnVzIDA4XQpbICAgIDAu
OTg3ODQxXSBwY2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDQgW2lvICAweDAwMDAtMHgwY2Y3IHdp
bmRvd10KWyAgICAwLjk4Nzg0Nl0gcGNpX2J1cyAwMDAwOjAwOiByZXNvdXJjZSA1IFtpbyAgMHgx
MDAwLTB4ZmZmZiB3aW5kb3ddClsgICAgMC45ODc4NTJdIHBjaV9idXMgMDAwMDowMDogcmVzb3Vy
Y2UgNiBbbWVtIDB4MDAwYTAwMDAtMHgwMDBiZmZmZiB3aW5kb3ddClsgICAgMC45ODc4NTddIHBj
aV9idXMgMDAwMDowMDogcmVzb3VyY2UgNyBbbWVtIDB4OTAwMDAwMDAtMHhmYmZmZWZmZiB3aW5k
b3ddClsgICAgMC45ODc4NjNdIHBjaV9idXMgMDAwMDowMjogcmVzb3VyY2UgMCBbaW8gIDB4NTAw
MC0weDVmZmZdClsgICAgMC45ODc4NjhdIHBjaV9idXMgMDAwMDowMjogcmVzb3VyY2UgMSBbbWVt
IDB4OTQ4MDAwMDAtMHg5NDhmZmZmZl0KWyAgICAwLjk4Nzg3NF0gcGNpX2J1cyAwMDAwOjAyOiBy
ZXNvdXJjZSAyIFttZW0gMHg5NGEwMDAwMC0weDk0YWZmZmZmIDY0Yml0IHByZWZdClsgICAgMC45
ODc4ODBdIHBjaV9idXMgMDAwMDowMzogcmVzb3VyY2UgMCBbaW8gIDB4NDAwMC0weDRmZmZdClsg
ICAgMC45ODc4ODVdIHBjaV9idXMgMDAwMDowMzogcmVzb3VyY2UgMSBbbWVtIDB4OTQ3MDAwMDAt
MHg5NDdmZmZmZl0KWyAgICAwLjk4Nzg5MV0gcGNpX2J1cyAwMDAwOjAzOiByZXNvdXJjZSAyIFtt
ZW0gMHg5NGIwMDAwMC0weDk0Y2ZmZmZmIDY0Yml0IHByZWZdClsgICAgMC45ODc4OTddIHBjaV9i
dXMgMDAwMDowNDogcmVzb3VyY2UgMCBbaW8gIDB4MzAwMC0weDNmZmZdClsgICAgMC45ODc5MDJd
IHBjaV9idXMgMDAwMDowNDogcmVzb3VyY2UgMSBbbWVtIDB4OTQ2MDAwMDAtMHg5NDZmZmZmZl0K
WyAgICAwLjk4NzkwN10gcGNpX2J1cyAwMDAwOjA0OiByZXNvdXJjZSAyIFttZW0gMHg5NDAwMDAw
MC0weDk0NGZmZmZmIDY0Yml0IHByZWZdClsgICAgMC45ODc5MTRdIHBjaV9idXMgMDAwMDowNzog
cmVzb3VyY2UgMCBbaW8gIDB4MjAwMC0weDJmZmZdClsgICAgMC45ODc5MTldIHBjaV9idXMgMDAw
MDowNzogcmVzb3VyY2UgMSBbbWVtIDB4OTQ1MDAwMDAtMHg5NDVmZmZmZl0KWyAgICAwLjk4Nzky
NF0gcGNpX2J1cyAwMDAwOjA3OiByZXNvdXJjZSAyIFttZW0gMHg5MDAwMDAwMC0weDkzZmZmZmZm
IDY0Yml0IHByZWZdClsgICAgMC45ODc5MzBdIHBjaV9idXMgMDAwMDowODogcmVzb3VyY2UgNCBb
aW8gIDB4MDAwMC0weDBjZjcgd2luZG93XQpbICAgIDAuOTg3OTM2XSBwY2lfYnVzIDAwMDA6MDg6
IHJlc291cmNlIDUgW2lvICAweDEwMDAtMHhmZmZmIHdpbmRvd10KWyAgICAwLjk4Nzk0MV0gcGNp
X2J1cyAwMDAwOjA4OiByZXNvdXJjZSA2IFttZW0gMHgwMDBhMDAwMC0weDAwMGJmZmZmIHdpbmRv
d10KWyAgICAwLjk4Nzk0Nl0gcGNpX2J1cyAwMDAwOjA4OiByZXNvdXJjZSA3IFttZW0gMHg5MDAw
MDAwMC0weGZiZmZlZmZmIHdpbmRvd10KWyAgICAwLjk4ODA4OV0gcGNpIDAwMDA6MDA6MDUuMDog
ZGlzYWJsZWQgYm9vdCBpbnRlcnJ1cHRzIG9uIGRldmljZSBbODA4NjozYzI4XQpbICAgIDAuOTk5
Nzk3XSBwY2kgMDAwMDowMDoxYS4wOiBxdWlya191c2JfZWFybHlfaGFuZG9mZisweDAvMHg3YjAg
dG9vayAxMTQwNiB1c2VjcwpbICAgIDEuMDEwNzg5XSBwY2kgMDAwMDowMDoxZC4wOiBxdWlya191
c2JfZWFybHlfaGFuZG9mZisweDAvMHg3YjAgdG9vayAxMDcwMCB1c2VjcwpbICAgIDEuMDEwOTQ5
XSBQQ0k6IENMUyA2NCBieXRlcywgZGVmYXVsdCA2NApbICAgIDEuMDExMDczXSBUcnlpbmcgdG8g
dW5wYWNrIHJvb3RmcyBpbWFnZSBhcyBpbml0cmFtZnMuLi4KWyAgICAxLjAxMTExMl0gRE1BUjog
Tm8gU0FUQyBmb3VuZApbICAgIDEuMDExMTE5XSBETUFSOiBkbWFyMDogVXNpbmcgUXVldWVkIGlu
dmFsaWRhdGlvbgpbICAgIDEuMDExMzEyXSBwY2kgMDAwMDowMDowMC4wOiBBZGRpbmcgdG8gaW9t
bXUgZ3JvdXAgMApbICAgIDEuMDExMzU4XSBwY2kgMDAwMDowMDowMS4wOiBBZGRpbmcgdG8gaW9t
bXUgZ3JvdXAgMQpbICAgIDEuMDExMzk4XSBwY2kgMDAwMDowMDowMS4xOiBBZGRpbmcgdG8gaW9t
bXUgZ3JvdXAgMgpbICAgIDEuMDExNDQ2XSBwY2kgMDAwMDowMDowMy4wOiBBZGRpbmcgdG8gaW9t
bXUgZ3JvdXAgMwpbICAgIDEuMDExNDg0XSBwY2kgMDAwMDowMDowNC4wOiBBZGRpbmcgdG8gaW9t
bXUgZ3JvdXAgNApbICAgIDEuMDExNTIxXSBwY2kgMDAwMDowMDowNC4xOiBBZGRpbmcgdG8gaW9t
bXUgZ3JvdXAgNQpbICAgIDEuMDExNTU4XSBwY2kgMDAwMDowMDowNC4yOiBBZGRpbmcgdG8gaW9t
bXUgZ3JvdXAgNgpbICAgIDEuMDExNTk1XSBwY2kgMDAwMDowMDowNC4zOiBBZGRpbmcgdG8gaW9t
bXUgZ3JvdXAgNwpbICAgIDEuMDExNjQ0XSBwY2kgMDAwMDowMDowNC40OiBBZGRpbmcgdG8gaW9t
bXUgZ3JvdXAgOApbICAgIDEuMDExNjgyXSBwY2kgMDAwMDowMDowNC41OiBBZGRpbmcgdG8gaW9t
bXUgZ3JvdXAgOQpbICAgIDEuMDExNzE5XSBwY2kgMDAwMDowMDowNC42OiBBZGRpbmcgdG8gaW9t
bXUgZ3JvdXAgMTAKWyAgICAxLjAxMTc2Nl0gcGNpIDAwMDA6MDA6MDQuNzogQWRkaW5nIHRvIGlv
bW11IGdyb3VwIDExClsgICAgMS4wMTE4MDNdIHBjaSAwMDAwOjAwOjA1LjA6IEFkZGluZyB0byBp
b21tdSBncm91cCAxMgpbICAgIDEuMDExODM5XSBwY2kgMDAwMDowMDowNS4yOiBBZGRpbmcgdG8g
aW9tbXUgZ3JvdXAgMTMKWyAgICAxLjAxMTg5OF0gcGNpIDAwMDA6MDA6MDUuNDogQWRkaW5nIHRv
IGlvbW11IGdyb3VwIDE0ClsgICAgMS4wMTE5MzddIHBjaSAwMDAwOjAwOjExLjA6IEFkZGluZyB0
byBpb21tdSBncm91cCAxNQpbICAgIDEuMDEyMDI0XSBwY2kgMDAwMDowMDoxNi4wOiBBZGRpbmcg
dG8gaW9tbXUgZ3JvdXAgMTYKWyAgICAxLjAxMjA2Ml0gcGNpIDAwMDA6MDA6MTYuMTogQWRkaW5n
IHRvIGlvbW11IGdyb3VwIDE2ClsgICAgMS4wMTIwOThdIHBjaSAwMDAwOjAwOjFhLjA6IEFkZGlu
ZyB0byBpb21tdSBncm91cCAxNwpbICAgIDEuMDEyMTIwXSBwY2kgMDAwMDowMDoxYy4wOiBFbmFi
bGluZyBNUEMgSVJCTkNFClsgICAgMS4wMTIxMjddIHBjaSAwMDAwOjAwOjFjLjA6IEludGVsIFBD
SCByb290IHBvcnQgQUNTIHdvcmthcm91bmQgZW5hYmxlZApbICAgIDEuMDEyMTc0XSBwY2kgMDAw
MDowMDoxYy4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMTgKWyAgICAxLjAxMjE5Ml0gcGNpIDAw
MDA6MDA6MWMuMjogRW5hYmxpbmcgTVBDIElSQk5DRQpbICAgIDEuMDEyMTk4XSBwY2kgMDAwMDow
MDoxYy4yOiBJbnRlbCBQQ0ggcm9vdCBwb3J0IEFDUyB3b3JrYXJvdW5kIGVuYWJsZWQKWyAgICAx
LjAxMjIzNF0gcGNpIDAwMDA6MDA6MWMuMjogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDE5ClsgICAg
MS4wMTIyNTBdIHBjaSAwMDAwOjAwOjFjLjM6IEVuYWJsaW5nIE1QQyBJUkJOQ0UKWyAgICAxLjAx
MjI1Nl0gcGNpIDAwMDA6MDA6MWMuMzogSW50ZWwgUENIIHJvb3QgcG9ydCBBQ1Mgd29ya2Fyb3Vu
ZCBlbmFibGVkClsgICAgMS4wMTIyOTRdIHBjaSAwMDAwOjAwOjFjLjM6IEFkZGluZyB0byBpb21t
dSBncm91cCAyMApbICAgIDEuMDEyMzMwXSBwY2kgMDAwMDowMDoxZC4wOiBBZGRpbmcgdG8gaW9t
bXUgZ3JvdXAgMjEKWyAgICAxLjAxMjM2Nl0gcGNpIDAwMDA6MDA6MWUuMDogQWRkaW5nIHRvIGlv
bW11IGdyb3VwIDIyClsgICAgMS4wMTI0OTBdIHBjaSAwMDAwOjAwOjFmLjA6IEFkZGluZyB0byBp
b21tdSBncm91cCAyMwpbICAgIDEuMDEyNTMxXSBwY2kgMDAwMDowMDoxZi4yOiBBZGRpbmcgdG8g
aW9tbXUgZ3JvdXAgMjMKWyAgICAxLjAxMjU3MF0gcGNpIDAwMDA6MDA6MWYuMzogQWRkaW5nIHRv
IGlvbW11IGdyb3VwIDIzClsgICAgMS4wMTI2MTBdIHBjaSAwMDAwOjAwOjFmLjY6IEFkZGluZyB0
byBpb21tdSBncm91cCAyMwpbICAgIDEuMDEyNjcxXSBwY2kgMDAwMDowMjowMC4wOiBBZGRpbmcg
dG8gaW9tbXUgZ3JvdXAgMjQKWyAgICAxLjAxMjcxMl0gcGNpIDAwMDA6MDI6MDAuMTogQWRkaW5n
IHRvIGlvbW11IGdyb3VwIDI1ClsgICAgMS4wMTI3NTBdIHBjaSAwMDAwOjAzOjAwLjA6IEFkZGlu
ZyB0byBpb21tdSBncm91cCAyNgpbICAgIDEuMDEyODI5XSBwY2kgMDAwMDowNDowMC4wOiBBZGRp
bmcgdG8gaW9tbXUgZ3JvdXAgMjcKWyAgICAxLjAxMjg3M10gcGNpIDAwMDA6MDQ6MDAuMzogQWRk
aW5nIHRvIGlvbW11IGdyb3VwIDI3ClsgICAgMS4wMTI5MTZdIHBjaSAwMDAwOjA3OjAwLjA6IEFk
ZGluZyB0byBpb21tdSBncm91cCAyOApbICAgIDEuMDEyOTc3XSBwY2kgMDAwMDpmZjowOC4wOiBB
ZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMjkKWyAgICAxLjAxMzAxNF0gcGNpIDAwMDA6ZmY6MDguMzog
QWRkaW5nIHRvIGlvbW11IGdyb3VwIDMwClsgICAgMS4wMTMwNTldIHBjaSAwMDAwOmZmOjA4LjQ6
IEFkZGluZyB0byBpb21tdSBncm91cCAzMQpbICAgIDEuMDEzMTE4XSBwY2kgMDAwMDpmZjowOS4w
OiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMzIKWyAgICAxLjAxMzE1NV0gcGNpIDAwMDA6ZmY6MDku
MzogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDMzClsgICAgMS4wMTMxOTJdIHBjaSAwMDAwOmZmOjA5
LjQ6IEFkZGluZyB0byBpb21tdSBncm91cCAzNApbICAgIDEuMDEzMzE1XSBwY2kgMDAwMDpmZjow
YS4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMzUKWyAgICAxLjAxMzM2MF0gcGNpIDAwMDA6ZmY6
MGEuMTogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDM1ClsgICAgMS4wMTM0MDVdIHBjaSAwMDAwOmZm
OjBhLjI6IEFkZGluZyB0byBpb21tdSBncm91cCAzNQpbICAgIDEuMDEzNDQ5XSBwY2kgMDAwMDpm
ZjowYS4zOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMzUKWyAgICAxLjAxMzUyN10gcGNpIDAwMDA6
ZmY6MGIuMDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDM2ClsgICAgMS4wMTM1ODFdIHBjaSAwMDAw
OmZmOjBiLjM6IEFkZGluZyB0byBpb21tdSBncm91cCAzNgpbICAgIDEuMDEzNzU4XSBwY2kgMDAw
MDpmZjowYy4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMzcKWyAgICAxLjAxMzgwNl0gcGNpIDAw
MDA6ZmY6MGMuMTogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDM3ClsgICAgMS4wMTM4NTJdIHBjaSAw
MDAwOmZmOjBjLjI6IEFkZGluZyB0byBpb21tdSBncm91cCAzNwpbICAgIDEuMDEzODk4XSBwY2kg
MDAwMDpmZjowYy4zOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMzcKWyAgICAxLjAxMzk0NF0gcGNp
IDAwMDA6ZmY6MGMuNjogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDM3ClsgICAgMS4wMTM5OTBdIHBj
aSAwMDAwOmZmOjBjLjc6IEFkZGluZyB0byBpb21tdSBncm91cCAzNwpbICAgIDEuMDE0MTM0XSBw
Y2kgMDAwMDpmZjowZC4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMzgKWyAgICAxLjAxNDE4Ml0g
cGNpIDAwMDA6ZmY6MGQuMTogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDM4ClsgICAgMS4wMTQyMzFd
IHBjaSAwMDAwOmZmOjBkLjI6IEFkZGluZyB0byBpb21tdSBncm91cCAzOApbICAgIDEuMDE0Mjgw
XSBwY2kgMDAwMDpmZjowZC4zOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMzgKWyAgICAxLjAxNDMy
OF0gcGNpIDAwMDA6ZmY6MGQuNjogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDM4ClsgICAgMS4wMTQ0
MTVdIHBjaSAwMDAwOmZmOjBlLjA6IEFkZGluZyB0byBpb21tdSBncm91cCAzOQpbICAgIDEuMDE0
NDczXSBwY2kgMDAwMDpmZjowZS4xOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMzkKWyAgICAxLjAx
NDUxMF0gcGNpIDAwMDA6ZmY6MGYuMDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDQwClsgICAgMS4w
MTQ1NTldIHBjaSAwMDAwOmZmOjBmLjE6IEFkZGluZyB0byBpb21tdSBncm91cCA0MQpbICAgIDEu
MDE0NTk3XSBwY2kgMDAwMDpmZjowZi4yOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgNDIKWyAgICAx
LjAxNDY0M10gcGNpIDAwMDA6ZmY6MGYuMzogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDQzClsgICAg
MS4wMTQ2ODJdIHBjaSAwMDAwOmZmOjBmLjQ6IEFkZGluZyB0byBpb21tdSBncm91cCA0NApbICAg
IDEuMDE0NzE5XSBwY2kgMDAwMDpmZjowZi41OiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgNDUKWyAg
ICAxLjAxNDc4N10gcGNpIDAwMDA6ZmY6MGYuNjogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDQ2Clsg
ICAgMS4wMTQ4MjVdIHBjaSAwMDAwOmZmOjEwLjA6IEFkZGluZyB0byBpb21tdSBncm91cCA0Nwpb
ICAgIDEuMDE0ODYyXSBwY2kgMDAwMDpmZjoxMC4xOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgNDgK
WyAgICAxLjAxNDg5OF0gcGNpIDAwMDA6ZmY6MTAuMjogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDQ5
ClsgICAgMS4wMTQ5MzVdIHBjaSAwMDAwOmZmOjEwLjM6IEFkZGluZyB0byBpb21tdSBncm91cCA1
MApbICAgIDEuMDE0OTczXSBwY2kgMDAwMDpmZjoxMC41OiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAg
NTEKWyAgICAxLjAxNTAxOV0gcGNpIDAwMDA6ZmY6MTAuNjogQWRkaW5nIHRvIGlvbW11IGdyb3Vw
IDUyClsgICAgMS4wMTUwNTddIHBjaSAwMDAwOmZmOjEwLjc6IEFkZGluZyB0byBpb21tdSBncm91
cCA1MwpbICAgIDEuMDE1MTI0XSBwY2kgMDAwMDpmZjoxMS4wOiBBZGRpbmcgdG8gaW9tbXUgZ3Jv
dXAgNTQKWyAgICAxLjAxNTI3MF0gcGNpIDAwMDA6ZmY6MTMuMDogQWRkaW5nIHRvIGlvbW11IGdy
b3VwIDU1ClsgICAgMS4wMTUzMjRdIHBjaSAwMDAwOmZmOjEzLjE6IEFkZGluZyB0byBpb21tdSBn
cm91cCA1NQpbICAgIDEuMDE1Mzc3XSBwY2kgMDAwMDpmZjoxMy40OiBBZGRpbmcgdG8gaW9tbXUg
Z3JvdXAgNTUKWyAgICAxLjAxNTQzMV0gcGNpIDAwMDA6ZmY6MTMuNTogQWRkaW5nIHRvIGlvbW11
IGdyb3VwIDU1ClsgICAgMS4wMTU0ODVdIHBjaSAwMDAwOmZmOjEzLjY6IEFkZGluZyB0byBpb21t
dSBncm91cCA1NQpbICAgIDEuMDIyMDkyXSBETUFSOiBJbnRlbChSKSBWaXJ0dWFsaXphdGlvbiBU
ZWNobm9sb2d5IGZvciBEaXJlY3RlZCBJL08KWyAgICAxLjAyMjEwOF0gUENJLURNQTogVXNpbmcg
c29mdHdhcmUgYm91bmNlIGJ1ZmZlcmluZyBmb3IgSU8gKFNXSU9UTEIpClsgICAgMS4wMjIxMTNd
IHNvZnR3YXJlIElPIFRMQjogbWFwcGVkIFttZW0gMHgwMDAwMDAwMDdhNGZmMDAwLTB4MDAwMDAw
MDA3ZTRmZjAwMF0gKDY0TUIpClsgICAgMS4wMjY1NTZdIEluaXRpYWxpc2Ugc3lzdGVtIHRydXN0
ZWQga2V5cmluZ3MKWyAgICAxLjAyNjY0N10gS2V5IHR5cGUgYmxhY2tsaXN0IHJlZ2lzdGVyZWQK
WyAgICAxLjAyNjgwMF0gd29ya2luZ3NldDogdGltZXN0YW1wX2JpdHM9MzYgKGFub246IDMxKSBt
YXhfb3JkZXI9MjIgYnVja2V0X29yZGVyPTAgKGFub246IDApClsgICAgMS4wMzEwNzNdIHNxdWFz
aGZzOiB2ZXJzaW9uIDQuMCAoMjAwOS8wMS8zMSkgUGhpbGxpcCBMb3VnaGVyClsgICAgMS4wMzIx
NjddIGZ1c2U6IGluaXQgKEFQSSB2ZXJzaW9uIDcuNDYpClsgICAgMS4wMzI3MjVdIGludGVncml0
eTogUGxhdGZvcm0gS2V5cmluZyBpbml0aWFsaXplZApbICAgIDEuMDMyNzU1XSBpbnRlZ3JpdHk6
IE1hY2hpbmUga2V5cmluZyBpbml0aWFsaXplZApbICAgIDEuMDU1NjQyXSBLZXkgdHlwZSBhc3lt
bWV0cmljIHJlZ2lzdGVyZWQKWyAgICAxLjA1NTY1MF0gQXN5bW1ldHJpYyBrZXkgcGFyc2VyICd4
NTA5JyByZWdpc3RlcmVkClsgICAgMS4wNTU3MDZdIEJsb2NrIGxheWVyIFNDU0kgZ2VuZXJpYyAo
YnNnKSBkcml2ZXIgdmVyc2lvbiAwLjQgbG9hZGVkIChtYWpvciAyNDIpClsgICAgMS4wNTU4MTdd
IGlvIHNjaGVkdWxlciBtcS1kZWFkbGluZSByZWdpc3RlcmVkClsgICAgMS4wNTc3NjVdIGxlZHRy
aWctY3B1OiByZWdpc3RlcmVkIHRvIGluZGljYXRlIGFjdGl2aXR5IG9uIENQVXMKWyAgICAxLjA1
ODM5N10gcGNpZXBvcnQgMDAwMDowMDowMS4wOiBQTUU6IFNpZ25hbGluZyB3aXRoIElSUSAyNgpb
ICAgIDEuMDU4NTQwXSBwY2llcG9ydCAwMDAwOjAwOjAxLjA6IEFFUjogZW5hYmxlZCB3aXRoIElS
USAyNgpbICAgIDEuMDU5MDI3XSBwY2llcG9ydCAwMDAwOjAwOjAxLjE6IFBNRTogU2lnbmFsaW5n
IHdpdGggSVJRIDI3ClsgICAgMS4wNTkxMzZdIHBjaWVwb3J0IDAwMDA6MDA6MDEuMTogQUVSOiBl
bmFibGVkIHdpdGggSVJRIDI3ClsgICAgMS4wNTk2MDNdIHBjaWVwb3J0IDAwMDA6MDA6MDMuMDog
UE1FOiBTaWduYWxpbmcgd2l0aCBJUlEgMjkKWyAgICAxLjA1OTc0NV0gcGNpZXBvcnQgMDAwMDow
MDowMy4wOiBBRVI6IGVuYWJsZWQgd2l0aCBJUlEgMjkKWyAgICAxLjA1OTgwMl0gcGNpZXBvcnQg
MDAwMDowMDowMy4wOiBwY2llaHA6IFNsb3QgIzMgQXR0bkJ0bi0gUHdyQ3RybC0gTVJMLSBBdHRu
SW5kLSBQd3JJbmQtIEhvdFBsdWcrIFN1cnByaXNlLSBJbnRlcmxvY2stIE5vQ29tcGwtIEliUHJl
c0Rpcy0gTExBY3RSZXArICh3aXRoIENtZCBDb21wbCBlcnJhdHVtKQpbICAgIDEuMDYwMzA1XSBw
Y2llcG9ydCAwMDAwOjAwOjExLjA6IFBNRTogU2lnbmFsaW5nIHdpdGggSVJRIDMwClsgICAgMS4w
NjA0MjVdIHBjaWVwb3J0IDAwMDA6MDA6MTEuMDogQUVSOiBlbmFibGVkIHdpdGggSVJRIDMwClsg
ICAgMS4wNjA1MzNdIHBjaWVwb3J0IDAwMDA6MDA6MWMuMDogSW50ZWwgUENIIHJvb3QgcG9ydCBB
Q1Mgd29ya2Fyb3VuZCBlbmFibGVkClsgICAgMS4wNjA4MjFdIHBjaWVwb3J0IDAwMDA6MDA6MWMu
MDogUE1FOiBTaWduYWxpbmcgd2l0aCBJUlEgMzEKWyAgICAxLjA2MDkxM10gcGNpZXBvcnQgMDAw
MDowMDoxYy4yOiBJbnRlbCBQQ0ggcm9vdCBwb3J0IEFDUyB3b3JrYXJvdW5kIGVuYWJsZWQKWyAg
ICAxLjA2MTE1Nl0gcGNpZXBvcnQgMDAwMDowMDoxYy4yOiBQTUU6IFNpZ25hbGluZyB3aXRoIElS
USAzMgpbICAgIDEuMDYxMjQ4XSBwY2llcG9ydCAwMDAwOjAwOjFjLjM6IEludGVsIFBDSCByb290
IHBvcnQgQUNTIHdvcmthcm91bmQgZW5hYmxlZApbICAgIDEuMDYxNDgxXSBwY2llcG9ydCAwMDAw
OjAwOjFjLjM6IFBNRTogU2lnbmFsaW5nIHdpdGggSVJRIDMzClsgICAgMS4wNjIwOTJdIGlucHV0
OiBQb3dlciBCdXR0b24gYXMgL2RldmljZXMvcGxhdGZvcm0vTE5YUFdSQk46MDAvaW5wdXQvaW5w
dXQwClsgICAgMS4wNjIxNjZdIEFDUEk6IGJ1dHRvbjogUG93ZXIgQnV0dG9uIFtQV1JGXQpbICAg
IDEuMDk3MTQ2XSBFUlNUOiBFcnJvciBSZWNvcmQgU2VyaWFsaXphdGlvbiBUYWJsZSAoRVJTVCkg
c3VwcG9ydCBpcyBpbml0aWFsaXplZC4KWyAgICAxLjA5NzIxMF0gcHN0b3JlOiBVc2luZyBjcmFz
aCBkdW1wIGNvbXByZXNzaW9uOiBkZWZsYXRlClsgICAgMS4wOTcyMTddIHBzdG9yZTogUmVnaXN0
ZXJlZCBlcnN0IGFzIHBlcnNpc3RlbnQgc3RvcmUgYmFja2VuZApbICAgIDEuMDk3NjAzXSBTZXJp
YWw6IDgyNTAvMTY1NTAgZHJpdmVyLCAzMiBwb3J0cywgSVJRIHNoYXJpbmcgZW5hYmxlZApbICAg
IDEuMTE4NDg4XSAwMDowMjogdHR5UzAgSS9POjB4M2Y4IChpcnEgPSA0LCBiYXNlX2JhdWQgPSAx
MTUyMDApIGlzIGEgMTY1NTBBClsgICAgMS4xMjQ4NjddIEFDUEk6IGJ1cyB0eXBlIGRybV9jb25u
ZWN0b3IgcmVnaXN0ZXJlZApbICAgIDEuMTMxNDYwXSBsb29wOiBtb2R1bGUgbG9hZGVkClsgICAg
MS4xMzIxNTNdIHR1bjogVW5pdmVyc2FsIFRVTi9UQVAgZGV2aWNlIGRyaXZlciwgMS42ClsgICAg
MS4xMzIyMjZdIFBQUCBnZW5lcmljIGRyaXZlciB2ZXJzaW9uIDIuNC4yClsgICAgMS4xMzI2OTFd
IGk4MDQyOiBQTlA6IFBTLzIgQ29udHJvbGxlciBbUE5QMDMwMzpQUzJLLFBOUDBmMTM6UFMyTV0g
YXQgMHg2MCwweDY0IGlycSAxLDEyClsgICAgMS4xMzI4ODRdIGVoY2ktcGNpIDAwMDA6MDA6MWEu
MDogRUhDSSBIb3N0IENvbnRyb2xsZXIKWyAgICAxLjEzMjkwM10gZWhjaS1wY2kgMDAwMDowMDox
YS4wOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDEKWyAgICAx
LjEzMjkzM10gZWhjaS1wY2kgMDAwMDowMDoxYS4wOiBkZWJ1ZyBwb3J0IDIKWyAgICAxLjEzMzE0
MF0gc2VyaW86IGk4MDQyIEtCRCBwb3J0IGF0IDB4NjAsMHg2NCBpcnEgMQpbICAgIDEuMTMzMTU3
XSBzZXJpbzogaTgwNDIgQVVYIHBvcnQgYXQgMHg2MCwweDY0IGlycSAxMgpbICAgIDEuMTMzMzc1
XSBtb3VzZWRldjogUFMvMiBtb3VzZSBkZXZpY2UgY29tbW9uIGZvciBhbGwgbWljZQpbICAgIDEu
MTMzNjg1XSBydGNfY21vcyBQTlAwQjAwOjAwOiBSVEMgY2FuIHdha2UgZnJvbSBTNApbICAgIDEu
MTMzNzQ3XSBpbnB1dDogQVQgVHJhbnNsYXRlZCBTZXQgMiBrZXlib2FyZCBhcyAvZGV2aWNlcy9w
bGF0Zm9ybS9pODA0Mi9zZXJpbzAvaW5wdXQvaW5wdXQxClsgICAgMS4xMzQxOTNdIHJ0Y19jbW9z
IFBOUDBCMDA6MDA6IHJlZ2lzdGVyZWQgYXMgcnRjMApbICAgIDEuMTM0MjUyXSBydGNfY21vcyBQ
TlAwQjAwOjAwOiBzZXR0aW5nIHN5c3RlbSBjbG9jayB0byAyMDI2LTExLTE1VDEwOjI5OjM0IFVU
QyAoMTc5NDczODU3NCkKWyAgICAxLjEzNDMxMF0gcnRjX2Ntb3MgUE5QMEIwMDowMDogYWxhcm1z
IHVwIHRvIG9uZSBtb250aCwgeTNrLCAyNDIgYnl0ZXMgbnZyYW0KWyAgICAxLjEzNDM2MV0gaTJj
X2RldjogaTJjIC9kZXYgZW50cmllcyBkcml2ZXIKWyAgICAxLjEzNjk1OF0gZWhjaS1wY2kgMDAw
MDowMDoxYS4wOiBpcnEgMTYsIGlvIG1lbSAweDk0OTI2MDAwClsgICAgMS4xMzc3NDFdIGRldmlj
ZS1tYXBwZXI6IGNvcmU6IENPTkZJR19JTUFfRElTQUJMRV9IVEFCTEUgaXMgZGlzYWJsZWQuIER1
cGxpY2F0ZSBJTUEgbWVhc3VyZW1lbnRzIHdpbGwgbm90IGJlIHJlY29yZGVkIGluIHRoZSBJTUEg
bG9nLgpbICAgIDEuMTM3ODE4XSBkZXZpY2UtbWFwcGVyOiB1ZXZlbnQ6IHZlcnNpb24gMS4wLjMK
WyAgICAxLjEzNzk4OF0gZGV2aWNlLW1hcHBlcjogaW9jdGw6IDQuNTAuMC1pb2N0bCAoMjAyNS0w
NC0yOCkgaW5pdGlhbGlzZWQ6IGRtLWRldmVsQGxpc3RzLmxpbnV4LmRldgpbICAgIDEuMTM4MDIx
XSBpbnRlbF9wc3RhdGU6IEludGVsIFAtc3RhdGUgZHJpdmVyIGluaXRpYWxpemluZwpbICAgIDEu
MTM5MTg2XSBzaW1wbGUtZnJhbWVidWZmZXIgc2ltcGxlLWZyYW1lYnVmZmVyLjA6IFtkcm1dIFJl
Z2lzdGVyZWQgMSBwbGFuZXMgd2l0aCBkcm0gcGFuaWMKWyAgICAxLjEzOTIzNF0gW2RybV0gSW5p
dGlhbGl6ZWQgc2ltcGxlZHJtIDEuMC4wIGZvciBzaW1wbGUtZnJhbWVidWZmZXIuMCBvbiBtaW5v
ciAwClsgICAgMS4xNDI2NDddIGVoY2ktcGNpIDAwMDA6MDA6MWEuMDogVVNCIDIuMCBzdGFydGVk
LCBFSENJIDEuMDAKWyAgICAxLjE0MjcxNF0gdXNiIHVzYjE6IE5ldyBVU0IgZGV2aWNlIGZvdW5k
LCBpZFZlbmRvcj0xZDZiLCBpZFByb2R1Y3Q9MDAwMiwgYmNkRGV2aWNlPSA3LjAzClsgICAgMS4x
NDI4MDVdIHVzYiB1c2IxOiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MywgUHJvZHVjdD0y
LCBTZXJpYWxOdW1iZXI9MQpbICAgIDEuMTQyODA4XSB1c2IgdXNiMTogUHJvZHVjdDogRUhDSSBI
b3N0IENvbnRyb2xsZXIKWyAgICAxLjE0MjgxMF0gdXNiIHVzYjE6IE1hbnVmYWN0dXJlcjogTGlu
dXggNy4zLjQtcmV2ZXJ0IGVoY2lfaGNkClsgICAgMS4xNDI4MTJdIHVzYiB1c2IxOiBTZXJpYWxO
dW1iZXI6IDAwMDA6MDA6MWEuMApbICAgIDEuMTQzMDE0XSBodWIgMS0wOjEuMDogVVNCIGh1YiBm
b3VuZApbICAgIDEuMTQzMDQyXSBodWIgMS0wOjEuMDogMiBwb3J0cyBkZXRlY3RlZApbICAgIDEu
MTQzMzAwXSBlaGNpLXBjaSAwMDAwOjAwOjFkLjA6IEVIQ0kgSG9zdCBDb250cm9sbGVyClsgICAg
MS4xNDMzMjJdIGVoY2ktcGNpIDAwMDA6MDA6MWQuMDogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwg
YXNzaWduZWQgYnVzIG51bWJlciAyClsgICAgMS4xNDMzNzldIGVoY2ktcGNpIDAwMDA6MDA6MWQu
MDogZGVidWcgcG9ydCAyClsgICAgMS4xNDY4NDZdIENvbnNvbGU6IHN3aXRjaGluZyB0byBjb2xv
dXIgZnJhbWUgYnVmZmVyIGRldmljZSA4MHgzMApbICAgIDEuMTQ3NDk2XSBlaGNpLXBjaSAwMDAw
OjAwOjFkLjA6IGlycSAyMywgaW8gbWVtIDB4OTQ5MjUwMDAKWyAgICAxLjE1MjY0N10gZWhjaS1w
Y2kgMDAwMDowMDoxZC4wOiBVU0IgMi4wIHN0YXJ0ZWQsIEVIQ0kgMS4wMApbICAgIDEuMTUyNzIz
XSB1c2IgdXNiMjogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTFkNmIsIGlkUHJvZHVj
dD0wMDAyLCBiY2REZXZpY2U9IDcuMDMKWyAgICAxLjE1MjgwOV0gdXNiIHVzYjI6IE5ldyBVU0Ig
ZGV2aWNlIHN0cmluZ3M6IE1mcj0zLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJlcj0xClsgICAgMS4x
NTI4MTJdIHVzYiB1c2IyOiBQcm9kdWN0OiBFSENJIEhvc3QgQ29udHJvbGxlcgpbICAgIDEuMTUy
ODE0XSB1c2IgdXNiMjogTWFudWZhY3R1cmVyOiBMaW51eCA3LjMuNC1yZXZlcnQgZWhjaV9oY2QK
WyAgICAxLjE1MjgxNl0gdXNiIHVzYjI6IFNlcmlhbE51bWJlcjogMDAwMDowMDoxZC4wClsgICAg
MS4xNTMwMDJdIGh1YiAyLTA6MS4wOiBVU0IgaHViIGZvdW5kClsgICAgMS4xNTMwMzJdIGh1YiAy
LTA6MS4wOiAyIHBvcnRzIGRldGVjdGVkClsgICAgMS4xNjY0NTddIHNpbXBsZS1mcmFtZWJ1ZmZl
ciBzaW1wbGUtZnJhbWVidWZmZXIuMDogW2RybV0gZmIwOiBzaW1wbGVkcm1kcm1mYiBmcmFtZSBi
dWZmZXIgZGV2aWNlClsgICAgMS4xNjgwMjFdIGRyb3BfbW9uaXRvcjogSW5pdGlhbGl6aW5nIG5l
dHdvcmsgZHJvcCBtb25pdG9yIHNlcnZpY2UKWyAgICAxLjE2OTQ1OF0gTkVUOiBSZWdpc3RlcmVk
IFBGX0lORVQ2IHByb3RvY29sIGZhbWlseQpbICAgIDEuMTcxNzQ3XSBTZWdtZW50IFJvdXRpbmcg
d2l0aCBJUHY2ClsgICAgMS4xNzIzNTddIEluLXNpdHUgT0FNIChJT0FNKSB3aXRoIElQdjYKWyAg
ICAxLjE3Mjk5Ml0gTkVUOiBSZWdpc3RlcmVkIFBGX1BBQ0tFVCBwcm90b2NvbCBmYW1pbHkKWyAg
ICAxLjE3MzY5MF0gS2V5IHR5cGUgZG5zX3Jlc29sdmVyIHJlZ2lzdGVyZWQKWyAgICAxLjE4MDky
NV0gbWljcm9jb2RlOiBDdXJyZW50IHJldmlzaW9uOiAweDAwMDAwNzFhClsgICAgMS4xODE0MTJd
IG1pY3JvY29kZTogVXBkYXRlZCBlYXJseSBmcm9tOiAweDAwMDAwNzE0ClsgICAgMS4xODM5NzBd
IElQSSBzaG9ydGhhbmQgYnJvYWRjYXN0OiBlbmFibGVkClsgICAgMS4xOTMwNjVdIHNjaGVkX2Ns
b2NrOiBNYXJraW5nIHN0YWJsZSAoMTEwMDk1MDcxMiwgOTE2NzI5MzIpLT4oMTIzNjM4OTE0NSwg
LTQzNzY1NTAxKQpbICAgIDEuMTk1NTYzXSByZWdpc3RlcmVkIHRhc2tzdGF0cyB2ZXJzaW9uIDEK
WyAgICAxLjIwMjUxNV0gTG9hZGluZyBjb21waWxlZC1pbiBYLjUwOSBjZXJ0aWZpY2F0ZXMKWyAg
ICAxLjIwNTEzOF0gTG9hZGVkIFguNTA5IGNlcnQgJ0J1aWxkIHRpbWUgYXV0b2dlbmVyYXRlZCBr
ZXJuZWwga2V5OiBhMzVhYjVhMTBkZGE1M2FlMWJjMGU2ZWNkYjliYjViOTEzNGNhYjRjJwpbICAg
IDEuMjE5Mjg4XSBEZW1vdGlvbiB0YXJnZXRzIGZvciBOb2RlIDA6IG51bGwKWyAgICAxLjIxOTcz
NV0gS2V5IHR5cGUgLmZzY3J5cHQgcmVnaXN0ZXJlZApbICAgIDEuMjE5OTc4XSBLZXkgdHlwZSBm
c2NyeXB0LXByb3Zpc2lvbmluZyByZWdpc3RlcmVkClsgICAgMS4yMjA0MjZdIEtleSB0eXBlIGJp
Z19rZXkgcmVnaXN0ZXJlZApbICAgIDEuMjIwNjc3XSBLZXkgdHlwZSBlbmNyeXB0ZWQgcmVnaXN0
ZXJlZApbICAgIDEuMjIwODkzXSBBcHBBcm1vcjogQXBwQXJtb3Igc2hhMjU2IHBvbGljeSBoYXNo
aW5nIGVuYWJsZWQKWyAgICAxLjIyMTExMF0gaW1hOiBObyBUUE0gY2hpcCBmb3VuZCwgYWN0aXZh
dGluZyBUUE0tYnlwYXNzIQpbICAgIDEuMjIxMzI2XSBMb2FkaW5nIGNvbXBpbGVkLWluIG1vZHVs
ZSBYLjUwOSBjZXJ0aWZpY2F0ZXMKWyAgICAxLjIyMjgwN10gTG9hZGVkIFguNTA5IGNlcnQgJ0J1
aWxkIHRpbWUgYXV0b2dlbmVyYXRlZCBrZXJuZWwga2V5OiBhMzVhYjVhMTBkZGE1M2FlMWJjMGU2
ZWNkYjliYjViOTEzNGNhYjRjJwpbICAgIDEuMjIzMjMzXSBpbWE6IEFsbG9jYXRlZCBoYXNoIGFs
Z29yaXRobTogc2hhMjU2ClsgICAgMS4yMjM1NTldIGltYTogTm8gYXJjaGl0ZWN0dXJlIHBvbGlj
aWVzIGZvdW5kClsgICAgMS4yMjM4MzJdIGV2bTogSW5pdGlhbGlzaW5nIEVWTSBleHRlbmRlZCBh
dHRyaWJ1dGVzOgpbICAgIDEuMjI0MDQ5XSBldm06IHNlY3VyaXR5LnNlbGludXgKWyAgICAxLjIy
NDI1NV0gZXZtOiBzZWN1cml0eS5TTUFDSzY0ClsgICAgMS4yMjQ0NTNdIGV2bTogc2VjdXJpdHku
U01BQ0s2NEVYRUMKWyAgICAxLjIyNDY1OF0gZXZtOiBzZWN1cml0eS5TTUFDSzY0VFJBTlNNVVRF
ClsgICAgMS4yMjQ4NDhdIGV2bTogc2VjdXJpdHkuU01BQ0s2NE1NQVAKWyAgICAxLjIyNTAzNV0g
ZXZtOiBzZWN1cml0eS5hcHBhcm1vcgpbICAgIDEuMjI1MjE3XSBldm06IHNlY3VyaXR5LmltYQpb
ICAgIDEuMjI1Mzk0XSBldm06IHNlY3VyaXR5LmNhcGFiaWxpdHkKWyAgICAxLjIyNTU3MV0gZXZt
OiBITUFDIGF0dHJzOiAweDEKWyAgICAxLjIyNjM1Nl0gUE06ICAgTWFnaWMgbnVtYmVyOiAyOjE0
NTo0NzcKWyAgICAxLjIyNzA5MF0gUkFTOiBDb3JyZWN0YWJsZSBFcnJvcnMgY29sbGVjdG9yIGlu
aXRpYWxpemVkLgpbICAgIDEuMjI3NDk0XSBjbGs6IERpc2FibGluZyB1bnVzZWQgY2xvY2tzClsg
ICAgMS4yMjc2OTBdIFBNOiBnZW5wZDogRGlzYWJsaW5nIHVudXNlZCBwb3dlciBkb21haW5zClsg
ICAgMS4zODA3MzRdIHVzYiAxLTE6IG5ldyBoaWdoLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDIg
dXNpbmcgZWhjaS1wY2kKWyAgICAxLjM4ODY4OF0gdXNiIDItMTogbmV3IGhpZ2gtc3BlZWQgVVNC
IGRldmljZSBudW1iZXIgMiB1c2luZyBlaGNpLXBjaQpbICAgIDEuNTA4OTc4XSB1c2IgMS0xOiBO
ZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9ODA4NywgaWRQcm9kdWN0PTAwMjQsIGJjZERl
dmljZT0gMC4wMApbICAgIDEuNTEyNjg5XSB1c2IgMS0xOiBOZXcgVVNCIGRldmljZSBzdHJpbmdz
OiBNZnI9MCwgUHJvZHVjdD0wLCBTZXJpYWxOdW1iZXI9MApbICAgIDEuNTE0NzM2XSBodWIgMS0x
OjEuMDogVVNCIGh1YiBmb3VuZApbICAgIDEuNTE1Njg4XSBodWIgMS0xOjEuMDogNiBwb3J0cyBk
ZXRlY3RlZApbICAgIDEuNTE3ODM3XSB1c2IgMi0xOiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRW
ZW5kb3I9ODA4NywgaWRQcm9kdWN0PTAwMjQsIGJjZERldmljZT0gMC4wMApbICAgIDEuNTE5Njky
XSB1c2IgMi0xOiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MCwgUHJvZHVjdD0wLCBTZXJp
YWxOdW1iZXI9MApbICAgIDEuNTIxNzM3XSBodWIgMi0xOjEuMDogVVNCIGh1YiBmb3VuZApbICAg
IDEuNTIyNjkwXSBodWIgMi0xOjEuMDogOCBwb3J0cyBkZXRlY3RlZApbICAgIDEuNzI2NTE0XSBG
cmVlaW5nIGluaXRyZCBtZW1vcnk6IDcwMDYwSwpbICAgIDEuNzMxOTM0XSBGcmVlaW5nIHVudXNl
ZCBkZWNyeXB0ZWQgbWVtb3J5OiAyMDI4SwpbICAgIDEuNzMzODM4XSBGcmVlaW5nIHVudXNlZCBr
ZXJuZWwgaW1hZ2UgKGluaXRtZW0pIG1lbW9yeTogNTQ2MEsKWyAgICAxLjczNDE2Ml0gV3JpdGUg
cHJvdGVjdGluZyB0aGUga2VybmVsIHJlYWQtb25seSBkYXRhOiAzNDgxNmsKWyAgICAxLjczNTY2
NV0gRnJlZWluZyB1bnVzZWQga2VybmVsIGltYWdlICh0ZXh0L3JvZGF0YSBnYXApIG1lbW9yeTog
MTQ0NEsKWyAgICAxLjczNjQwMV0gRnJlZWluZyB1bnVzZWQga2VybmVsIGltYWdlIChyb2RhdGEv
ZGF0YSBnYXApIG1lbW9yeTogNjI4SwpbICAgIDEuODE4MDEzXSB4ODYvbW06IENoZWNrZWQgVytY
IG1hcHBpbmdzOiBwYXNzZWQsIG5vIFcrWCBwYWdlcyBmb3VuZC4KWyAgICAxLjgxODIyMV0geDg2
L21tOiBDaGVja2luZyB1c2VyIHNwYWNlIHBhZ2UgdGFibGVzClsgICAgMS44OTgyODddIHg4Ni9t
bTogQ2hlY2tlZCBXK1ggbWFwcGluZ3M6IHBhc3NlZCwgbm8gVytYIHBhZ2VzIGZvdW5kLgpbICAg
IDEuODk4NTc1XSBSdW4gL2luaXQgYXMgaW5pdCBwcm9jZXNzClsgICAgMS44OTg4NjddICAgd2l0
aCBhcmd1bWVudHM6ClsgICAgMS44OTg4NzRdICAgICAvaW5pdApbICAgIDEuODk4ODc3XSAgIHdp
dGggZW52aXJvbm1lbnQ6ClsgICAgMS44OTg4ODBdICAgICBIT01FPS8KWyAgICAxLjg5ODg4M10g
ICAgIFRFUk09bGludXgKWyAgICAyLjA0NDcwMV0gdHNjOiBSZWZpbmVkIFRTQyBjbG9ja3NvdXJj
ZSBjYWxpYnJhdGlvbjogMTc5OS45OTkgTUh6ClsgICAgMi4wNDQ5NTRdIGNsb2Nrc291cmNlOiB0
c2M6IG1hc2s6IDB4ZmZmZmZmZmZmZmZmZmZmZiBtYXhfY3ljbGVzOiAweDE5ZjIyOGFiN2EyLCBt
YXhfaWRsZV9uczogNDQwNzk1Mjg5MjUyIG5zClsgICAgMi4wNDY1MjJdIGNsb2Nrc291cmNlOiBT
d2l0Y2hlZCB0byBjbG9ja3NvdXJjZSB0c2MKWyAgICAyLjIzMjE5OF0gZGNhIHNlcnZpY2Ugc3Rh
cnRlZCwgdmVyc2lvbiAxLjEyLjEKWyAgICAyLjIzOTI1M10gbWVnYXNhczogMDcuNzM0LjAwLjAw
LXJjMQpbICAgIDIuMjQwMjIwXSBtZWdhcmFpZF9zYXMgMDAwMDowMzowMC4wOiBCQVI6MHgxICBC
QVIncyBiYXNlX2FkZHIocGh5cyk6MHgwMDAwMDAwMDk0NzQwMDAwICBtYXBwZWQgdmlydF9hZGRy
OjB4KF9fX19wdHJ2YWxfX19fKQpbICAgIDIuMjQwMjM1XSBtZWdhcmFpZF9zYXMgMDAwMDowMzow
MC4wOiBGVyBub3cgaW4gUmVhZHkgc3RhdGUKWyAgICAyLjI0MDY2N10gbWVnYXJhaWRfc2FzIDAw
MDA6MDM6MDAuMDogNjMgYml0IERNQSBtYXNrIGFuZCAzMiBiaXQgY29uc2lzdGVudCBtYXNrClsg
ICAgMi4yNDE5ODZdIG1lZ2FyYWlkX3NhcyAwMDAwOjAzOjAwLjA6IGZpcm13YXJlIHN1cHBvcnRz
IG1zaXgJOiAoMTYpClsgICAgMi4yNDMyNzVdIG1lZ2FyYWlkX3NhcyAwMDAwOjAzOjAwLjA6IHJl
cXVlc3RlZC9hdmFpbGFibGUgbXNpeCAxNi8xNiBwb2xsX3F1ZXVlIDAKWyAgICAyLjI0NDAwNF0g
bWVnYXJhaWRfc2FzIDAwMDA6MDM6MDAuMDogY3VycmVudCBtc2l4L21heCBudW0gcXVldWVzCTog
KDE2LzE2KQpbICAgIDIuMjQ0Mzg1XSBtZWdhcmFpZF9zYXMgMDAwMDowMzowMC4wOiBSRFBRIG1v
ZGUJOiAoZGlzYWJsZWQpClsgICAgMi4yNDQ4MjFdIG1lZ2FyYWlkX3NhcyAwMDAwOjAzOjAwLjA6
IEN1cnJlbnQgZmlybXdhcmUgc3VwcG9ydHMgbWF4aW11bSBjb21tYW5kczogMTAwOAkgTERJTyB0
aHJlc2hvbGQ6IDAKWyAgICAyLjI0NTY5OV0gYWhjaSAwMDAwOjAwOjFmLjI6IEFIQ0kgdmVycyAw
MDAxLjAzMDAsIDMyIGNvbW1hbmQgc2xvdHMsIDYgR2JwcywgU0FUQSBtb2RlClsgICAgMi4yNDY0
MjJdIGFoY2kgMDAwMDowMDoxZi4yOiA2LzYgcG9ydHMgaW1wbGVtZW50ZWQgKHBvcnQgbWFzayAw
eDNmKQpbICAgIDIuMjQ2Nzk0XSBhaGNpIDAwMDA6MDA6MWYuMjogZmxhZ3M6IDY0Yml0IG5jcSBz
bnRmIGlsY2sgbGVkIGNsbyBwaW8gc2x1bSBwYXJ0IGVtcyBhcHN0IApbICAgIDIuMjUxMzg1XSBt
ZWdhcmFpZF9zYXMgMDAwMDowMzowMC4wOiBQZXJmb3JtYW5jZSBtb2RlIDpMYXRlbmN5IChsYXRl
bmN5IGluZGV4ID0gMSkKWyAgICAyLjI1MTkxOV0gbWVnYXJhaWRfc2FzIDAwMDA6MDM6MDAuMDog
Rlcgc3VwcG9ydHMgc3luYyBjYWNoZQk6IE5vClsgICAgMi4yNTIxODhdIG1lZ2FyYWlkX3NhcyAw
MDAwOjAzOjAwLjA6IG1lZ2FzYXNfZGlzYWJsZV9pbnRyX2Z1c2lvbiBpcyBjYWxsZWQgb3V0Ym91
bmRfaW50cl9tYXNrOjB4NDAwMDAwMDkKWyAgICAyLjI2MDY2NV0gc2NzaSBob3N0MTogYWhjaQpb
ICAgIDIuMjYxMzk3XSBzY3NpIGhvc3QyOiBhaGNpClsgICAgMi4yNjIwMzRdIGlnYjogSW50ZWwo
UikgR2lnYWJpdCBFdGhlcm5ldCBOZXR3b3JrIERyaXZlcgpbICAgIDIuMjYyMjI2XSBzY3NpIGhv
c3QzOiBhaGNpClsgICAgMi4yNjIzMTRdIGlnYjogQ29weXJpZ2h0IChjKSAyMDA3LTIwMTQgSW50
ZWwgQ29ycG9yYXRpb24uClsgICAgMi4yNjMwNTRdIHNjc2kgaG9zdDQ6IGFoY2kKWyAgICAyLjI2
Mzg5N10gc2NzaSBob3N0NTogYWhjaQpbICAgIDIuMjY0MTk3XSBpZ2IgMDAwMDowMjowMC4wOiBQ
SFkgcmVzZXQgaXMgYmxvY2tlZCBkdWUgdG8gU09ML0lERVIgc2Vzc2lvbi4KWyAgICAyLjI2NDU4
M10gc2NzaSBob3N0NjogYWhjaQpbICAgIDIuMjY1Mjg1XSBhdGExOiBTQVRBIG1heCBVRE1BLzEz
MyBhYmFyIG0yMDQ4QDB4OTQ5MjQwMDAgcG9ydCAweDk0OTI0MTAwIGlycSA1MCBscG0tcG9sIDEg
ZXh0ClsgICAgMi4yNjYyMzddIGF0YTI6IFNBVEEgbWF4IFVETUEvMTMzIGFiYXIgbTIwNDhAMHg5
NDkyNDAwMCBwb3J0IDB4OTQ5MjQxODAgaXJxIDUwIGxwbS1wb2wgMSBleHQKWyAgICAyLjI2NzE4
NF0gYXRhMzogU0FUQSBtYXggVURNQS8xMzMgYWJhciBtMjA0OEAweDk0OTI0MDAwIHBvcnQgMHg5
NDkyNDIwMCBpcnEgNTAgbHBtLXBvbCAxIGV4dApbICAgIDIuMjY4MTU3XSBhdGE0OiBTQVRBIG1h
eCBVRE1BLzEzMyBhYmFyIG0yMDQ4QDB4OTQ5MjQwMDAgcG9ydCAweDk0OTI0MjgwIGlycSA1MCBs
cG0tcG9sIDEgZXh0ClsgICAgMi4yNjkxNTZdIGF0YTU6IFNBVEEgbWF4IFVETUEvMTMzIGFiYXIg
bTIwNDhAMHg5NDkyNDAwMCBwb3J0IDB4OTQ5MjQzMDAgaXJxIDUwIGxwbS1wb2wgMSBleHQKWyAg
ICAyLjI3MDE1N10gYXRhNjogU0FUQSBtYXggVURNQS8xMzMgYWJhciBtMjA0OEAweDk0OTI0MDAw
IHBvcnQgMHg5NDkyNDM4MCBpcnEgNTAgbHBtLXBvbCAxIGV4dApbICAgIDIuMjc3MDE1XSBpc2Np
OiBJbnRlbChSKSBDNjAwIFNBUyBDb250cm9sbGVyIERyaXZlciAtIHZlcnNpb24gMS4yLjAKWyAg
ICAyLjI3NzgzNl0gaXNjaSAwMDAwOjA0OjAwLjA6IGRyaXZlciBjb25maWd1cmVkIGZvciByZXY6
IDYgc2lsaWNvbgpbICAgIDIuMjc4NTAxXSBpc2NpIDAwMDA6MDQ6MDAuMDogT0VNIHBhcmFtZXRl
ciB0YWJsZSBmb3VuZCBpbiBPUk9NClsgICAgMi4yNzkxMzRdIGlzY2kgMDAwMDowNDowMC4wOiBb
MF06IGludmFsaWQgb2VtIHBhcmFtZXRlcnMgZGV0ZWN0ZWQsIGZhbGxpbmcgYmFjayB0byBmaXJt
d2FyZQpbICAgIDIuMjgwNTgwXSBpc2NpIDAwMDA6MDQ6MDAuMDogT0VNIFNBUyBwYXJhbWV0ZXJz
ICh2ZXJzaW9uOiAxLjMpIGxvYWRlZCAoZmlybXdhcmUpClsgICAgMi4yODI1NTBdIGlzY2kgMDAw
MDowNDowMC4wOiBTQ1UgY29udHJvbGxlciAwOiBwaHkgMy0wIGNhYmxlczoge3Nob3J0LCBzaG9y
dCwgc2hvcnQsIHNob3J0fQpbICAgIDIuMjg5MDY5XSBzY3NpIGhvc3Q3OiBpc2NpClsgICAgMi4y
OTY3MTFdIG1lZ2FyYWlkX3NhcyAwMDAwOjAzOjAwLjA6IEZXIHByb3ZpZGVkIHN1cHBvcnRNYXhF
eHRMRHM6IDAJbWF4X2xkczogNjQKWyAgICAyLjI5NzI5M10gbWVnYXJhaWRfc2FzIDAwMDA6MDM6
MDAuMDogY29udHJvbGxlciB0eXBlCTogTVIoNTEyTUIpClsgICAgMi4yOTc1OTNdIG1lZ2FyYWlk
X3NhcyAwMDAwOjAzOjAwLjA6IE9ubGluZSBDb250cm9sbGVyIFJlc2V0KE9DUikJOiBFbmFibGVk
ClsgICAgMi4yOTc5MTBdIG1lZ2FyYWlkX3NhcyAwMDAwOjAzOjAwLjA6IFNlY3VyZSBKQk9EIHN1
cHBvcnQJOiBObwpbICAgIDIuMjk4MjAyXSBtZWdhcmFpZF9zYXMgMDAwMDowMzowMC4wOiBOVk1l
IHBhc3N0aHJ1IHN1cHBvcnQJOiBObwpbICAgIDIuMjk4NDkwXSBtZWdhcmFpZF9zYXMgMDAwMDow
MzowMC4wOiBGVyBwcm92aWRlZCBUTSBUYXNrQWJvcnQvUmVzZXQgdGltZW91dAk6IDAgc2Vjcy8w
IHNlY3MKWyAgICAyLjI5OTA2NF0gbWVnYXJhaWRfc2FzIDAwMDA6MDM6MDAuMDogSkJPRCBzZXF1
ZW5jZSBtYXAgc3VwcG9ydAk6IE5vClsgICAgMi4yOTkzNDddIG1lZ2FyYWlkX3NhcyAwMDAwOjAz
OjAwLjA6IFBDSSBMYW5lIE1hcmdpbmluZyBzdXBwb3J0CTogTm8KWyAgICAyLjMwNjU2MF0gaWdi
IDAwMDA6MDI6MDAuMDogYWRkZWQgUEhDIG9uIGV0aDAKWyAgICAyLjMwNjkxNF0gaWdiIDAwMDA6
MDI6MDAuMDogSW50ZWwoUikgR2lnYWJpdCBFdGhlcm5ldCBOZXR3b3JrIENvbm5lY3Rpb24KWyAg
ICAyLjMwNzE5MV0gaWdiIDAwMDA6MDI6MDAuMDogZXRoMDogKFBDSWU6NS4wR2IvczpXaWR0aCB4
NCkgZGM6ZDI6ZmM6OWE6MmQ6NGUKWyAgICAyLjMwNzU0Ml0gaWdiIDAwMDA6MDI6MDAuMDogZXRo
MDogUEJBIE5vOiAxMDYxMDAtMDAwClsgICAgMi4zMDc4MjhdIGlnYiAwMDAwOjAyOjAwLjA6IFVz
aW5nIE1TSS1YIGludGVycnVwdHMuIDggcnggcXVldWUocyksIDggdHggcXVldWUocykKWyAgICAy
LjMwOTI3OV0gaWdiIDAwMDA6MDI6MDAuMTogUEhZIHJlc2V0IGlzIGJsb2NrZWQgZHVlIHRvIFNP
TC9JREVSIHNlc3Npb24uClsgICAgMi4zMjExMjJdIG1lZ2FyYWlkX3NhcyAwMDAwOjAzOjAwLjA6
IG1lZ2FzYXNfZW5hYmxlX2ludHJfZnVzaW9uIGlzIGNhbGxlZCBvdXRib3VuZF9pbnRyX21hc2s6
MHg0MDAwMDAwMApbICAgIDIuMzIxNjU1XSBtZWdhcmFpZF9zYXMgMDAwMDowMzowMC4wOiBJTklU
IGFkYXB0ZXIgZG9uZQpbICAgIDIuMzIxOTk2XSBtZWdhcmFpZF9zYXMgMDAwMDowMzowMC4wOiBK
Qk9EIHNlcXVlbmNlIG1hcCBpcyBkaXNhYmxlZCBtZWdhc2FzX3NldHVwX2pib2RfbWFwIDU4MTIK
WyAgICAyLjMyMzQzNl0gbWVnYXJhaWRfc2FzIDAwMDA6MDM6MDAuMDogcGNpIGlkCQk6ICgweDEw
MDApLygweDAwNWIpLygweDE5ZTUpLygweGQyMDQpClsgICAgMi4zMjQ2MDldIG1lZ2FyYWlkX3Nh
cyAwMDAwOjAzOjAwLjA6IHVuZXZlbnNwYW4gc3VwcG9ydAk6IG5vClsgICAgMi4zMjUyMTBdIG1l
Z2FyYWlkX3NhcyAwMDAwOjAzOjAwLjA6IGZpcm13YXJlIGNyYXNoIGR1bXAJOiBubwpbICAgIDIu
MzI1ODAyXSBtZWdhcmFpZF9zYXMgMDAwMDowMzowMC4wOiBKQk9EIHNlcXVlbmNlIG1hcAk6IGRp
c2FibGVkClsgICAgMi4zMjY1ODZdIG1lZ2FyYWlkX3NhcyAwMDAwOjAzOjAwLjA6IE1heCBmaXJt
d2FyZSBjb21tYW5kczogMTAwNyBzaGFyZWQgd2l0aCBkZWZhdWx0IGh3X3F1ZXVlcyA9IDE1IHBv
bGxfcXVldWVzIDAKWyAgICAyLjMyNzY4OF0gc2NzaSBob3N0MDogQXZhZ28gU0FTIGJhc2VkIE1l
Z2FSQUlEIGRyaXZlcgpbICAgIDIuMzQ3MTYyXSBpZ2IgMDAwMDowMjowMC4xOiBhZGRlZCBQSEMg
b24gZXRoMQpbICAgIDIuMzQ3NDM0XSBpZ2IgMDAwMDowMjowMC4xOiBJbnRlbChSKSBHaWdhYml0
IEV0aGVybmV0IE5ldHdvcmsgQ29ubmVjdGlvbgpbICAgIDIuMzQ3NjkyXSBpZ2IgMDAwMDowMjow
MC4xOiBldGgxOiAoUENJZTo1LjBHYi9zOldpZHRoIHg0KSBkYzpkMjpmYzo5YToyZDo0ZgpbICAg
IDIuMzQ4MDEwXSBpZ2IgMDAwMDowMjowMC4xOiBldGgxOiBQQkEgTm86IDEwNjEwMC0wMDAKWyAg
ICAyLjM0ODI0OV0gaWdiIDAwMDA6MDI6MDAuMTogVXNpbmcgTVNJLVggaW50ZXJydXB0cy4gOCBy
eCBxdWV1ZShzKSwgOCB0eCBxdWV1ZShzKQpbICAgIDIuMzUwODIzXSBzY3NpIDA6MjowOjA6IERp
cmVjdC1BY2Nlc3MgICAgIExTSSAgICAgIExTSSAgICAgICAgICAgICAgMy4xOSBQUTogMCBBTlNJ
OiA1ClsgICAgMi41ODY2MTZdIGF0YTQ6IFNBVEEgbGluayBkb3duIChTU3RhdHVzIDAgU0NvbnRy
b2wgMzAwKQpbICAgIDIuNTg3MTcyXSBhdGEzOiBTQVRBIGxpbmsgZG93biAoU1N0YXR1cyAwIFND
b250cm9sIDMwMCkKWyAgICAyLjU5NDYwMF0gYXRhMjogU0FUQSBsaW5rIGRvd24gKFNTdGF0dXMg
MCBTQ29udHJvbCAzMDApClsgICAgMi41OTUwMjVdIGF0YTE6IFNBVEEgbGluayBkb3duIChTU3Rh
dHVzIDAgU0NvbnRyb2wgMzAwKQpbICAgIDIuNTk1NDIxXSBhdGE1OiBTQVRBIGxpbmsgZG93biAo
U1N0YXR1cyAwIFNDb250cm9sIDMwMCkKWyAgICAyLjU5NTgyNl0gYXRhNjogU0FUQSBsaW5rIGRv
d24gKFNTdGF0dXMgMCBTQ29udHJvbCAzMDApClsgICAgMi43MTMwOThdIHNkIDA6MjowOjA6IEF0
dGFjaGVkIHNjc2kgZ2VuZXJpYyBzZzAgdHlwZSAwClsgICAgMi43MTM0MzddIHNkIDA6MjowOjA6
IFtzZGFdIDE5NTExNzA1NjAgNTEyLWJ5dGUgbG9naWNhbCBibG9ja3M6ICg5OTkgR0IvOTMwIEdp
QikKWyAgICAyLjcxMzk1NV0gc2QgMDoyOjA6MDogW3NkYV0gV3JpdGUgUHJvdGVjdCBpcyBvZmYK
WyAgICAyLjcxNDE3Nl0gc2QgMDoyOjA6MDogW3NkYV0gTW9kZSBTZW5zZTogMWYgMDAgMDAgMDgK
WyAgICAyLjcxNDI1NF0gc2QgMDoyOjA6MDogW3NkYV0gV3JpdGUgY2FjaGU6IGVuYWJsZWQsIHJl
YWQgY2FjaGU6IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3IgRlVBClsgICAgMi44NTU4
MTFdICBzZGE6IHNkYTEgc2RhMiBzZGEzClsgICAgMi44NTcxNDRdIHNkIDA6MjowOjA6IFtzZGFd
IEF0dGFjaGVkIFNDU0kgZGlzawpbICAgIDIuODY2NzUzXSBpZ2IgMDAwMDowMjowMC4wIGVucDJz
MGYwOiByZW5hbWVkIGZyb20gZXRoMApbICAgIDIuODY3NTAyXSBpZ2IgMDAwMDowMjowMC4xIGVu
cDJzMGYxOiByZW5hbWVkIGZyb20gZXRoMQpbICAgIDMuMjcwMzA2XSBpbnB1dDogUFMvMiBHZW5l
cmljIE1vdXNlIGFzIC9kZXZpY2VzL3BsYXRmb3JtL2k4MDQyL3NlcmlvMS9pbnB1dC9pbnB1dDMK
WyAgICAzLjM3ODcwM10gcmFuZG9tOiBjcm5nIGluaXQgZG9uZQpbICAgIDMuNjY4MDM3XSB4b3I6
IGF1dG9tYXRpY2FsbHkgdXNpbmcgYmVzdCBjaGVja3N1bW1pbmcgZnVuY3Rpb24gICBhdnggICAg
ICAgClsgICAgMy42NzMzMjhdIHJhaWQ2OiB1c2luZyBzc3NlM3gyIHJlY292ZXJ5IGFsZ29yaXRo
bQpbICAgIDMuNjc3NjE5XSByYWlkNjogc3NlMngxICAgZ2VuKCkgIDcxNTEgTUIvcwpbICAgIDMu
NjgwODUzXSByYWlkNjogc3NlMngyICAgZ2VuKCkgIDg3MjAgTUIvcwpbICAgIDMuNjg0MTcwXSBy
YWlkNjogc3NlMng0ICAgZ2VuKCkgIDg0MzggTUIvcwpbICAgIDMuNjg0NjAyXSByYWlkNjogdXNp
bmcgYWxnb3JpdGhtIHNzZTJ4MiBnZW4oKSA4NzIwIE1CL3MKWyAgICAzLjY4NzI4N10gcmFpZDY6
IC4uLi4geG9yKCkgNTMwMSBNQi9zLCBybXcgZW5hYmxlZApbICAgIDMuNjg5OTkyXSBhc3luY190
eDogYXBpIGluaXRpYWxpemVkIChhc3luYykKWyAgICA0LjAzMjA2M10gQnRyZnMgbG9hZGVkLCB6
b25lZD15ZXMsIGZzdmVyaXR5PXllcwpbICAgIDQuOTY0MDA4XSBTR0kgWEZTIHdpdGggQUNMcywg
c2VjdXJpdHkgYXR0cmlidXRlcywgcmVhbHRpbWUsIHF1b3RhLCBubyBkZWJ1ZyBlbmFibGVkClsg
ICAgNC45OTc3MzVdIFhGUyAoZG0tMCk6IE1vdW50aW5nIFY1IEZpbGVzeXN0ZW0gMTcxNjU4Zjgt
OTA0My00MzY2LWFiNGMtYTllYTU0ODZkN2E0ClsgICAgNS4yMjExNjldIFhGUyAoZG0tMCk6IEVu
ZGluZyBjbGVhbiBtb3VudApbICAgIDYuOTU2MzA3XSBzeXN0ZW1kWzFdOiBJbnNlcnRlZCBtb2R1
bGUgJ2F1dG9mczQnClsgICAgNy4yOTgwNzVdIHN5c3RlbWRbMV06IHN5c3RlbWQgMjU1LjQtMXVi
dW50dTggcnVubmluZyBpbiBzeXN0ZW0gbW9kZSAoK1BBTSArQVVESVQgK1NFTElOVVggK0FQUEFS
TU9SICtJTUEgK1NNQUNLICtTRUNDT01QICtHQ1JZUFQgLUdOVVRMUyArT1BFTlNTTCArQUNMICtC
TEtJRCArQ1VSTCArRUxGVVRJTFMgK0ZJRE8yICtJRE4yIC1JRE4gK0lQVEMgK0tNT0QgK0xJQkNS
WVBUU0VUVVAgK0xJQkZESVNLICtQQ1JFMiAtUFdRVUFMSVRZICtQMTFLSVQgK1FSRU5DT0RFICtU
UE0yICtCWklQMiArTFo0ICtYWiArWkxJQiArWlNURCAtQlBGX0ZSQU1FV09SSyAtWEtCQ09NTU9O
ICtVVE1QICtTWVNWSU5JVCBkZWZhdWx0LWhpZXJhcmNoeT11bmlmaWVkKQpbICAgIDcuMjk5MjY3
XSBzeXN0ZW1kWzFdOiBEZXRlY3RlZCBhcmNoaXRlY3R1cmUgeDg2LTY0LgpbICAgIDcuMzYwNjYw
XSBzeXN0ZW1kWzFdOiBIb3N0bmFtZSBzZXQgdG8gPHVidW50dT4uClsgICAxMC44OTAwNTFdIHN5
c3RlbWRbMV06IFF1ZXVlZCBzdGFydCBqb2IgZm9yIGRlZmF1bHQgdGFyZ2V0IGdyYXBoaWNhbC50
YXJnZXQuClsgICAxMC44OTg4MTFdIHN5c3RlbWRbMV06IENyZWF0ZWQgc2xpY2Ugc3lzdGVtLW1v
ZHByb2JlLnNsaWNlIC0gU2xpY2UgL3N5c3RlbS9tb2Rwcm9iZS4KWyAgIDEwLjkwMzI3MF0gc3lz
dGVtZFsxXTogQ3JlYXRlZCBzbGljZSBzeXN0ZW0tc3lzdGVtZFx4MmRmc2NrLnNsaWNlIC0gU2xp
Y2UgL3N5c3RlbS9zeXN0ZW1kLWZzY2suClsgICAxMC45MDQ2MTZdIHN5c3RlbWRbMV06IENyZWF0
ZWQgc2xpY2UgdXNlci5zbGljZSAtIFVzZXIgYW5kIFNlc3Npb24gU2xpY2UuClsgICAxMC45MDYx
MTNdIHN5c3RlbWRbMV06IFN0YXJ0ZWQgc3lzdGVtZC1hc2stcGFzc3dvcmQtd2FsbC5wYXRoIC0g
Rm9yd2FyZCBQYXNzd29yZCBSZXF1ZXN0cyB0byBXYWxsIERpcmVjdG9yeSBXYXRjaC4KWyAgIDEw
LjkwOTEzOV0gc3lzdGVtZFsxXTogU2V0IHVwIGF1dG9tb3VudCBwcm9jLXN5cy1mcy1iaW5mbXRf
bWlzYy5hdXRvbW91bnQgLSBBcmJpdHJhcnkgRXhlY3V0YWJsZSBGaWxlIEZvcm1hdHMgRmlsZSBT
eXN0ZW0gQXV0b21vdW50IFBvaW50LgpbICAgMTAuOTExMjY3XSBzeXN0ZW1kWzFdOiBFeHBlY3Rp
bmcgZGV2aWNlIGRldi1kaXNrLWJ5XHgyZHV1aWQtZjJhOTE0ZDBceDJkOWQ1Y1x4MmQ0MzVkXHgy
ZDlkMzBceDJkNjk5M2NkNThhZTg2LmRldmljZSAtIC9kZXYvZGlzay9ieS11dWlkL2YyYTkxNGQw
LTlkNWMtNDM1ZC05ZDMwLTY5OTNjZDU4YWU4Ni4uLgpbICAgMTAuOTE0MDkwXSBzeXN0ZW1kWzFd
OiBSZWFjaGVkIHRhcmdldCBpbnRlZ3JpdHlzZXR1cC50YXJnZXQgLSBMb2NhbCBJbnRlZ3JpdHkg
UHJvdGVjdGVkIFZvbHVtZXMuClsgICAxMC45MTYzMTldIHN5c3RlbWRbMV06IFJlYWNoZWQgdGFy
Z2V0IHNsaWNlcy50YXJnZXQgLSBTbGljZSBVbml0cy4KWyAgIDEwLjkxNzkxNF0gc3lzdGVtZFsx
XTogUmVhY2hlZCB0YXJnZXQgc25hcGQubW91bnRzLXByZS50YXJnZXQgLSBNb3VudGluZyBzbmFw
cy4KWyAgIDEwLjkyMDExNF0gc3lzdGVtZFsxXTogUmVhY2hlZCB0YXJnZXQgc25hcGQubW91bnRz
LnRhcmdldCAtIE1vdW50ZWQgc25hcHMuClsgICAxMC45MjE4MzddIHN5c3RlbWRbMV06IFJlYWNo
ZWQgdGFyZ2V0IHZlcml0eXNldHVwLnRhcmdldCAtIExvY2FsIFZlcml0eSBQcm90ZWN0ZWQgVm9s
dW1lcy4KWyAgIDEwLjkyNDUzN10gc3lzdGVtZFsxXTogTGlzdGVuaW5nIG9uIGRtLWV2ZW50LnNv
Y2tldCAtIERldmljZS1tYXBwZXIgZXZlbnQgZGFlbW9uIEZJRk9zLgpbICAgMTAuOTM4MjIyXSBz
eXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gbHZtMi1sdm1wb2xsZC5zb2NrZXQgLSBMVk0yIHBvbGwg
ZGFlbW9uIHNvY2tldC4KWyAgIDEwLjk0MDY0NV0gc3lzdGVtZFsxXTogTGlzdGVuaW5nIG9uIG11
bHRpcGF0aGQuc29ja2V0IC0gbXVsdGlwYXRoZCBjb250cm9sIHNvY2tldC4KWyAgIDEwLjk1NTIz
M10gc3lzdGVtZFsxXTogTGlzdGVuaW5nIG9uIHN5c2xvZy5zb2NrZXQgLSBTeXNsb2cgU29ja2V0
LgpbICAgMTAuOTU2NDYzXSBzeXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gc3lzdGVtZC1mc2NrZC5z
b2NrZXQgLSBmc2NrIHRvIGZzY2tkIGNvbW11bmljYXRpb24gU29ja2V0LgpbICAgMTAuOTU3NjIw
XSBzeXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gc3lzdGVtZC1pbml0Y3RsLnNvY2tldCAtIGluaXRj
dGwgQ29tcGF0aWJpbGl0eSBOYW1lZCBQaXBlLgpbICAgMTAuOTY3OTg2XSBzeXN0ZW1kWzFdOiBM
aXN0ZW5pbmcgb24gc3lzdGVtZC1qb3VybmFsZC1kZXYtbG9nLnNvY2tldCAtIEpvdXJuYWwgU29j
a2V0ICgvZGV2L2xvZykuClsgICAxMC45NjkzMjhdIHN5c3RlbWRbMV06IExpc3RlbmluZyBvbiBz
eXN0ZW1kLWpvdXJuYWxkLnNvY2tldCAtIEpvdXJuYWwgU29ja2V0LgpbICAgMTAuOTcwNzA5XSBz
eXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gc3lzdGVtZC1uZXR3b3JrZC5zb2NrZXQgLSBOZXR3b3Jr
IFNlcnZpY2UgTmV0bGluayBTb2NrZXQuClsgICAxMC45NzE3ODVdIHN5c3RlbWRbMV06IHN5c3Rl
bWQtcGNyZXh0ZW5kLnNvY2tldCAtIFRQTTIgUENSIEV4dGVuc2lvbiAoVmFybGluaykgd2FzIHNr
aXBwZWQgYmVjYXVzZSBvZiBhbiB1bm1ldCBjb25kaXRpb24gY2hlY2sgKENvbmRpdGlvblNlY3Vy
aXR5PW1lYXN1cmVkLXVraSkuClsgICAxMC45Nzg3MTVdIHN5c3RlbWRbMV06IExpc3RlbmluZyBv
biBzeXN0ZW1kLXVkZXZkLWNvbnRyb2wuc29ja2V0IC0gdWRldiBDb250cm9sIFNvY2tldC4KWyAg
IDEwLjk4MDAwNl0gc3lzdGVtZFsxXTogTGlzdGVuaW5nIG9uIHN5c3RlbWQtdWRldmQta2VybmVs
LnNvY2tldCAtIHVkZXYgS2VybmVsIFNvY2tldC4KWyAgIDEwLjk5NTk1OV0gc3lzdGVtZFsxXTog
TW91bnRpbmcgZGV2LWh1Z2VwYWdlcy5tb3VudCAtIEh1Z2UgUGFnZXMgRmlsZSBTeXN0ZW0uLi4K
WyAgIDExLjAwMzE1Nl0gc3lzdGVtZFsxXTogTW91bnRpbmcgZGV2LW1xdWV1ZS5tb3VudCAtIFBP
U0lYIE1lc3NhZ2UgUXVldWUgRmlsZSBTeXN0ZW0uLi4KWyAgIDExLjAwODY5M10gc3lzdGVtZFsx
XTogTW91bnRpbmcgc3lzLWtlcm5lbC1kZWJ1Zy5tb3VudCAtIEtlcm5lbCBEZWJ1ZyBGaWxlIFN5
c3RlbS4uLgpbICAgMTEuMDE0MjgyXSBzeXN0ZW1kWzFdOiBNb3VudGluZyBzeXMta2VybmVsLXRy
YWNpbmcubW91bnQgLSBLZXJuZWwgVHJhY2UgRmlsZSBTeXN0ZW0uLi4KWyAgIDExLjAyNzc0OV0g
c3lzdGVtZFsxXTogU3RhcnRpbmcga2V5Ym9hcmQtc2V0dXAuc2VydmljZSAtIFNldCB0aGUgY29u
c29sZSBrZXlib2FyZCBsYXlvdXQuLi4KWyAgIDExLjAzNjIxMl0gc3lzdGVtZFsxXTogU3RhcnRp
bmcga21vZC1zdGF0aWMtbm9kZXMuc2VydmljZSAtIENyZWF0ZSBMaXN0IG9mIFN0YXRpYyBEZXZp
Y2UgTm9kZXMuLi4KWyAgIDExLjA0MTgxM10gc3lzdGVtZFsxXTogU3RhcnRpbmcgbHZtMi1tb25p
dG9yLnNlcnZpY2UgLSBNb25pdG9yaW5nIG9mIExWTTIgbWlycm9ycywgc25hcHNob3RzIGV0Yy4g
dXNpbmcgZG1ldmVudGQgb3IgcHJvZ3Jlc3MgcG9sbGluZy4uLgpbICAgMTEuMDQ3OTc2XSBzeXN0
ZW1kWzFdOiBTdGFydGluZyBtb2Rwcm9iZUBjb25maWdmcy5zZXJ2aWNlIC0gTG9hZCBLZXJuZWwg
TW9kdWxlIGNvbmZpZ2ZzLi4uClsgICAxMS4wNTM4NjldIHN5c3RlbWRbMV06IFN0YXJ0aW5nIG1v
ZHByb2JlQGRtX21vZC5zZXJ2aWNlIC0gTG9hZCBLZXJuZWwgTW9kdWxlIGRtX21vZC4uLgpbICAg
MTEuMDU5NjYyXSBzeXN0ZW1kWzFdOiBTdGFydGluZyBtb2Rwcm9iZUBkcm0uc2VydmljZSAtIExv
YWQgS2VybmVsIE1vZHVsZSBkcm0uLi4KWyAgIDExLjA2NTU5OV0gc3lzdGVtZFsxXTogU3RhcnRp
bmcgbW9kcHJvYmVAZWZpX3BzdG9yZS5zZXJ2aWNlIC0gTG9hZCBLZXJuZWwgTW9kdWxlIGVmaV9w
c3RvcmUuLi4KWyAgIDExLjA3MTUyOV0gc3lzdGVtZFsxXTogU3RhcnRpbmcgbW9kcHJvYmVAZnVz
ZS5zZXJ2aWNlIC0gTG9hZCBLZXJuZWwgTW9kdWxlIGZ1c2UuLi4KWyAgIDExLjA3NzM3M10gc3lz
dGVtZFsxXTogU3RhcnRpbmcgbW9kcHJvYmVAbG9vcC5zZXJ2aWNlIC0gTG9hZCBLZXJuZWwgTW9k
dWxlIGxvb3AuLi4KWyAgIDExLjA3OTc2NF0gc3lzdGVtZFsxXTogbmV0cGxhbi1vdnMtY2xlYW51
cC5zZXJ2aWNlIC0gT3BlblZTd2l0Y2ggY29uZmlndXJhdGlvbiBmb3IgY2xlYW51cCB3YXMgc2tp
cHBlZCBiZWNhdXNlIG9mIGFuIHVubWV0IGNvbmRpdGlvbiBjaGVjayAoQ29uZGl0aW9uRmlsZUlz
RXhlY3V0YWJsZT0vdXNyL2Jpbi9vdnMtdnNjdGwpLgpbICAgMTEuMDgyMjc3XSBzeXN0ZW1kWzFd
OiBzeXN0ZW1kLWZzY2stcm9vdC5zZXJ2aWNlIC0gRmlsZSBTeXN0ZW0gQ2hlY2sgb24gUm9vdCBE
ZXZpY2Ugd2FzIHNraXBwZWQgYmVjYXVzZSBvZiBhbiB1bm1ldCBjb25kaXRpb24gY2hlY2sgKENv
bmRpdGlvblBhdGhFeGlzdHM9IS9ydW4vaW5pdHJhbWZzL2ZzY2stcm9vdCkuClsgICAxMS4wOTI2
OTBdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIHN5c3RlbWQtam91cm5hbGQuc2VydmljZSAtIEpvdXJu
YWwgU2VydmljZS4uLgpbICAgMTEuMDk1NDg0XSBzeXN0ZW1kWzFdOiBTdGFydGluZyBzeXN0ZW1k
LW1vZHVsZXMtbG9hZC5zZXJ2aWNlIC0gTG9hZCBLZXJuZWwgTW9kdWxlcy4uLgpbICAgMTEuMDk2
NTY0XSBzeXN0ZW1kWzFdOiBzeXN0ZW1kLXBjcm1hY2hpbmUuc2VydmljZSAtIFRQTTIgUENSIE1h
Y2hpbmUgSUQgTWVhc3VyZW1lbnQgd2FzIHNraXBwZWQgYmVjYXVzZSBvZiBhbiB1bm1ldCBjb25k
aXRpb24gY2hlY2sgKENvbmRpdGlvblNlY3VyaXR5PW1lYXN1cmVkLXVraSkuClsgICAxMS4wOTkw
MjRdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIHN5c3RlbWQtcmVtb3VudC1mcy5zZXJ2aWNlIC0gUmVt
b3VudCBSb290IGFuZCBLZXJuZWwgRmlsZSBTeXN0ZW1zLi4uClsgICAxMS4xMDAxNDNdIHN5c3Rl
bWRbMV06IHN5c3RlbWQtdHBtMi1zZXR1cC1lYXJseS5zZXJ2aWNlIC0gVFBNMiBTUksgU2V0dXAg
KEVhcmx5KSB3YXMgc2tpcHBlZCBiZWNhdXNlIG9mIGFuIHVubWV0IGNvbmRpdGlvbiBjaGVjayAo
Q29uZGl0aW9uU2VjdXJpdHk9bWVhc3VyZWQtdWtpKS4KWyAgIDExLjEwMjU1N10gc3lzdGVtZFsx
XTogU3RhcnRpbmcgc3lzdGVtZC11ZGV2LXRyaWdnZXIuc2VydmljZSAtIENvbGRwbHVnIEFsbCB1
ZGV2IERldmljZXMuLi4KWyAgIDExLjEwNTk5N10gc3lzdGVtZFsxXTogTW91bnRlZCBkZXYtaHVn
ZXBhZ2VzLm1vdW50IC0gSHVnZSBQYWdlcyBGaWxlIFN5c3RlbS4KWyAgIDExLjEwNjk3Ml0gc3lz
dGVtZFsxXTogTW91bnRlZCBkZXYtbXF1ZXVlLm1vdW50IC0gUE9TSVggTWVzc2FnZSBRdWV1ZSBG
aWxlIFN5c3RlbS4KWyAgIDExLjEwODIwN10gc3lzdGVtZFsxXTogTW91bnRlZCBzeXMta2VybmVs
LWRlYnVnLm1vdW50IC0gS2VybmVsIERlYnVnIEZpbGUgU3lzdGVtLgpbICAgMTEuMTA5NDI5XSBz
eXN0ZW1kWzFdOiBNb3VudGVkIHN5cy1rZXJuZWwtdHJhY2luZy5tb3VudCAtIEtlcm5lbCBUcmFj
ZSBGaWxlIFN5c3RlbS4KWyAgIDExLjExMDg2Nl0gc3lzdGVtZFsxXTogRmluaXNoZWQga21vZC1z
dGF0aWMtbm9kZXMuc2VydmljZSAtIENyZWF0ZSBMaXN0IG9mIFN0YXRpYyBEZXZpY2UgTm9kZXMu
ClsgICAxMS4xMTI1MTNdIHN5c3RlbWRbMV06IG1vZHByb2JlQGNvbmZpZ2ZzLnNlcnZpY2U6IERl
YWN0aXZhdGVkIHN1Y2Nlc3NmdWxseS4KWyAgIDExLjExMzE0MV0gc3lzdGVtZFsxXTogRmluaXNo
ZWQgbW9kcHJvYmVAY29uZmlnZnMuc2VydmljZSAtIExvYWQgS2VybmVsIE1vZHVsZSBjb25maWdm
cy4KWyAgIDExLjExNDY4N10gc3lzdGVtZFsxXTogbW9kcHJvYmVAZG1fbW9kLnNlcnZpY2U6IERl
YWN0aXZhdGVkIHN1Y2Nlc3NmdWxseS4KWyAgIDExLjExNTI3OV0gc3lzdGVtZFsxXTogRmluaXNo
ZWQgbW9kcHJvYmVAZG1fbW9kLnNlcnZpY2UgLSBMb2FkIEtlcm5lbCBNb2R1bGUgZG1fbW9kLgpb
ICAgMTEuMTE2ODAyXSBzeXN0ZW1kWzFdOiBtb2Rwcm9iZUBkcm0uc2VydmljZTogRGVhY3RpdmF0
ZWQgc3VjY2Vzc2Z1bGx5LgpbICAgMTEuMTE3Mzg3XSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBtb2Rw
cm9iZUBkcm0uc2VydmljZSAtIExvYWQgS2VybmVsIE1vZHVsZSBkcm0uClsgICAxMS4xMTg5MDZd
IHN5c3RlbWRbMV06IG1vZHByb2JlQGZ1c2Uuc2VydmljZTogRGVhY3RpdmF0ZWQgc3VjY2Vzc2Z1
bGx5LgpbICAgMTEuMTE5NDkxXSBzeXN0ZW1kWzFdOiBGaW5pc2hlZCBtb2Rwcm9iZUBmdXNlLnNl
cnZpY2UgLSBMb2FkIEtlcm5lbCBNb2R1bGUgZnVzZS4KWyAgIDExLjEyMTA0NV0gc3lzdGVtZFsx
XTogbW9kcHJvYmVAbG9vcC5zZXJ2aWNlOiBEZWFjdGl2YXRlZCBzdWNjZXNzZnVsbHkuClsgICAx
MS4xMjE2MjRdIHN5c3RlbWRbMV06IEZpbmlzaGVkIG1vZHByb2JlQGxvb3Auc2VydmljZSAtIExv
YWQgS2VybmVsIE1vZHVsZSBsb29wLgpbICAgMTEuMTI0NTQ2XSBzeXN0ZW1kWzFdOiBNb3VudGlu
ZyBzeXMtZnMtZnVzZS1jb25uZWN0aW9ucy5tb3VudCAtIEZVU0UgQ29udHJvbCBGaWxlIFN5c3Rl
bS4uLgpbICAgMTEuMTI3MDgwXSBzeXN0ZW1kWzFdOiBNb3VudGluZyBzeXMta2VybmVsLWNvbmZp
Zy5tb3VudCAtIEtlcm5lbCBDb25maWd1cmF0aW9uIEZpbGUgU3lzdGVtLi4uClsgICAxMS4xMjgx
NjNdIHN5c3RlbWRbMV06IHN5c3RlbWQtcmVwYXJ0LnNlcnZpY2UgLSBSZXBhcnRpdGlvbiBSb290
IERpc2sgd2FzIHNraXBwZWQgYmVjYXVzZSBubyB0cmlnZ2VyIGNvbmRpdGlvbiBjaGVja3Mgd2Vy
ZSBtZXQuClsgICAxMS4xMzAyNzVdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIHN5c3RlbWQtdG1wZmls
ZXMtc2V0dXAtZGV2LWVhcmx5LnNlcnZpY2UgLSBDcmVhdGUgU3RhdGljIERldmljZSBOb2RlcyBp
biAvZGV2IGdyYWNlZnVsbHkuLi4KWyAgIDExLjEzNTEzMV0gc3lzdGVtZFsxXTogTW91bnRlZCBz
eXMtZnMtZnVzZS1jb25uZWN0aW9ucy5tb3VudCAtIEZVU0UgQ29udHJvbCBGaWxlIFN5c3RlbS4K
WyAgIDExLjEzNzgzM10gc3lzdGVtZFsxXTogTW91bnRlZCBzeXMta2VybmVsLWNvbmZpZy5tb3Vu
dCAtIEtlcm5lbCBDb25maWd1cmF0aW9uIEZpbGUgU3lzdGVtLgpbICAgMTEuMzQ4MTE0XSBzeXN0
ZW1kLWpvdXJuYWxkWzQ3N106IENvbGxlY3RpbmcgYXVkaXQgbWVzc2FnZXMgaXMgZGlzYWJsZWQu
ClsgICAxMS40MTk2NDldIHN5c3RlbWRbMV06IEZpbmlzaGVkIHN5c3RlbWQtcmVtb3VudC1mcy5z
ZXJ2aWNlIC0gUmVtb3VudCBSb290IGFuZCBLZXJuZWwgRmlsZSBTeXN0ZW1zLgpbICAgMTEuNDM2
OTI1XSBzeXN0ZW1kWzFdOiBBY3RpdmF0aW5nIHN3YXAgc3dhcC5pbWcuc3dhcCAtIC9zd2FwLmlt
Zy4uLgpbICAgMTEuNDM5NjQ2XSBzeXN0ZW1kWzFdOiBTdGFydGluZyBtdWx0aXBhdGhkLnNlcnZp
Y2UgLSBEZXZpY2UtTWFwcGVyIE11bHRpcGF0aCBEZXZpY2UgQ29udHJvbGxlci4uLgpbICAgMTEu
NDQwODYzXSBzeXN0ZW1kWzFdOiBzeXN0ZW1kLWh3ZGItdXBkYXRlLnNlcnZpY2UgLSBSZWJ1aWxk
IEhhcmR3YXJlIERhdGFiYXNlIHdhcyBza2lwcGVkIGJlY2F1c2Ugb2YgYW4gdW5tZXQgY29uZGl0
aW9uIGNoZWNrIChDb25kaXRpb25OZWVkc1VwZGF0ZT0vZXRjKS4KWyAgIDExLjQ0MzEzOF0gc3lz
dGVtZFsxXTogU3RhcnRpbmcgc3lzdGVtZC1yYW5kb20tc2VlZC5zZXJ2aWNlIC0gTG9hZC9TYXZl
IE9TIFJhbmRvbSBTZWVkLi4uClsgICAxMS40NDQyMDFdIHN5c3RlbWRbMV06IHN5c3RlbWQtdHBt
Mi1zZXR1cC5zZXJ2aWNlIC0gVFBNMiBTUksgU2V0dXAgd2FzIHNraXBwZWQgYmVjYXVzZSBvZiBh
biB1bm1ldCBjb25kaXRpb24gY2hlY2sgKENvbmRpdGlvblNlY3VyaXR5PW1lYXN1cmVkLXVraSku
ClsgICAxMS40NDU0MjhdIHN5c3RlbWRbMV06IEZpbmlzaGVkIHN5c3RlbWQtdWRldi10cmlnZ2Vy
LnNlcnZpY2UgLSBDb2xkcGx1ZyBBbGwgdWRldiBEZXZpY2VzLgpbICAgMTEuNTE1ODU0XSBzeXN0
ZW1kWzFdOiBtb2Rwcm9iZUBlZmlfcHN0b3JlLnNlcnZpY2U6IERlYWN0aXZhdGVkIHN1Y2Nlc3Nm
dWxseS4KWyAgIDExLjUxNjc4M10gc3lzdGVtZFsxXTogRmluaXNoZWQgbW9kcHJvYmVAZWZpX3Bz
dG9yZS5zZXJ2aWNlIC0gTG9hZCBLZXJuZWwgTW9kdWxlIGVmaV9wc3RvcmUuClsgICAxMS41MTgx
MjFdIHN5c3RlbWRbMV06IHN5c3RlbWQtcHN0b3JlLnNlcnZpY2UgLSBQbGF0Zm9ybSBQZXJzaXN0
ZW50IFN0b3JhZ2UgQXJjaGl2YWwgd2FzIHNraXBwZWQgYmVjYXVzZSBvZiBhbiB1bm1ldCBjb25k
aXRpb24gY2hlY2sgKENvbmRpdGlvbkRpcmVjdG9yeU5vdEVtcHR5PS9zeXMvZnMvcHN0b3JlKS4K
WyAgIDExLjYyODQ5Nl0gc3lzdGVtZFsxXTogRmluaXNoZWQgc3lzdGVtZC1tb2R1bGVzLWxvYWQu
c2VydmljZSAtIExvYWQgS2VybmVsIE1vZHVsZXMuClsgICAxMS42MzM0MjFdIHN5c3RlbWRbMV06
IFN0YXJ0aW5nIHN5c3RlbWQtc3lzY3RsLnNlcnZpY2UgLSBBcHBseSBLZXJuZWwgVmFyaWFibGVz
Li4uClsgICAxMS43MDg3MDJdIHN5c3RlbWRbMV06IFN0YXJ0ZWQgc3lzdGVtZC1qb3VybmFsZC5z
ZXJ2aWNlIC0gSm91cm5hbCBTZXJ2aWNlLgpbICAgMTEuODc1NTMzXSBBZGRpbmcgNDE5NDMwMGsg
c3dhcCBvbiAvc3dhcC5pbWcuICBQcmlvcml0eTotMSBleHRlbnRzOjEgYWNyb3NzOjQxOTQzMDBr
IApbICAgMTEuOTk5OTE3XSBzeXN0ZW1kLWpvdXJuYWxkWzQ3N106IFJlY2VpdmVkIGNsaWVudCBy
ZXF1ZXN0IHRvIGZsdXNoIHJ1bnRpbWUgam91cm5hbC4KWyAgIDEyLjkxMDEwMl0gc3lzdGVtZC1q
b3VybmFsZFs0NzddOiAvdmFyL2xvZy9qb3VybmFsL2UyNmNjZDAwYzQxNTQ5ZTU4M2YxOTEzMjgz
YmJjZTY1L3N5c3RlbS5qb3VybmFsOiBKb3VybmFsIGZpbGUgdXNlcyBhIGRpZmZlcmVudCBzZXF1
ZW5jZSBudW1iZXIgSUQsIHJvdGF0aW5nLgpbICAgMTIuOTEwMTIzXSBzeXN0ZW1kLWpvdXJuYWxk
WzQ3N106IFJvdGF0aW5nIHN5c3RlbSBqb3VybmFsLgpbICAgMTQuOTUxNzM2XSBtZWlfbWUgMDAw
MDowMDoxNi4wOiBEZXZpY2UgZG9lc24ndCBoYXZlIHZhbGlkIE1FIEludGVyZmFjZQpbICAgMTUu
MTAyMTE2XSBpb2F0ZG1hOiBJbnRlbChSKSBRdWlja0RhdGEgVGVjaG5vbG9neSBEcml2ZXIgNS4w
MApbICAgMTUuMTE0ODg2XSBpZ2IgMDAwMDowMjowMC4wOiBEQ0EgZW5hYmxlZApbICAgMTUuMTE0
OTIwXSBpZ2IgMDAwMDowMjowMC4xOiBEQ0EgZW5hYmxlZApbICAgMTUuMTQ2ODE3XSBJUE1JIG1l
c3NhZ2UgaGFuZGxlcjogdmVyc2lvbiAzOS4yClsgICAxNS4xODA0MzldIGxwY19pY2ggMDAwMDow
MDoxZi4wOiBObyBNRkQgY2VsbHMgYWRkZWQKWyAgIDE1LjE4MTUwN10gaXBtaSBkZXZpY2UgaW50
ZXJmYWNlClsgICAxNS4zMDk2NjJdIFJBUEwgUE1VOiBBUEkgdW5pdCBpcyAyXi0zMiBKb3VsZXMs
IDMgZml4ZWQgY291bnRlcnMsIDE2Mzg0MCBtcyBvdmZsIHRpbWVyClsgICAxNS4zMDk2NzBdIFJB
UEwgUE1VOiBodyB1bml0IG9mIGRvbWFpbiBwcDAtY29yZSAyXi0xNiBKb3VsZXMKWyAgIDE1LjMw
OTY4NF0gUkFQTCBQTVU6IGh3IHVuaXQgb2YgZG9tYWluIHBhY2thZ2UgMl4tMTYgSm91bGVzClsg
ICAxNS4zMDk2ODZdIFJBUEwgUE1VOiBodyB1bml0IG9mIGRvbWFpbiBkcmFtIDJeLTE2IEpvdWxl
cwpbICAgMTUuMzIyNzQ0XSBpcG1pX3NpOiBJUE1JIFN5c3RlbSBJbnRlcmZhY2UgZHJpdmVyClsg
ICAxNS4zMjI3NzldIGlwbWlfc2kgZG1pLWlwbWktc2kuMDogaXBtaV9wbGF0Zm9ybTogcHJvYmlu
ZyB2aWEgU01CSU9TClsgICAxNS4zMjI3ODVdIGlwbWlfcGxhdGZvcm06IGlwbWlfc2k6IFNNQklP
UzogaW8gMHhlNCByZWdzaXplIDEgc3BhY2luZyAxIGlycSAwClsgICAxNS4zMjI3OTBdIGlwbWlf
c2k6IEFkZGluZyBTTUJJT1Mtc3BlY2lmaWVkIGJ0IHN0YXRlIG1hY2hpbmUKWyAgIDE1LjMyMjg4
M10gaXBtaV9zaTogVHJ5aW5nIFNNQklPUy1zcGVjaWZpZWQgYnQgc3RhdGUgbWFjaGluZSBhdCBp
L28gYWRkcmVzcyAweGU0LCBzbGF2ZSBhZGRyZXNzIDB4MjAsIGlycSAwClsgICAxNS4zMjQ3NjBd
IGlwbWlfc2kgZG1pLWlwbWktc2kuMDogYnQgY2FwIHJlc3BvbnNlIHRvbyBzaG9ydDogMwpbICAg
MTUuMzI0NzY4XSBpcG1pX3NpIGRtaS1pcG1pLXNpLjA6IHVzaW5nIGRlZmF1bHQgdmFsdWVzClsg
ICAxNS4zMjQ3NzFdIGlwbWlfc2kgZG1pLWlwbWktc2kuMDogcmVxMnJzcD01IHNlY3MgcmV0cmll
cz0yClsgICAxNS4zNTg4ODddIGlwbWlfc2kgZG1pLWlwbWktc2kuMDogSVBNSSBtZXNzYWdlIGhh
bmRsZXI6IEZvdW5kIG5ldyBCTUMgKG1hbl9pZDogMHgwMDA3ZGIsIHByb2RfaWQ6IDB4YWExMSwg
ZGV2X2lkOiAweDAxKQpbICAgMTUuMzcwMDA0XSBpODAxX3NtYnVzIDAwMDA6MDQ6MDAuMzogRW5h
YmxpbmcgU01CdXMgZGV2aWNlClsgICAxNS4zNzAwNDZdIGk4MDFfc21idXMgMDAwMDowNDowMC4z
OiBTTUJ1cyB1c2luZyBQQ0kgaW50ZXJydXB0ClsgICAxNS4zNzAwNjFdIGk4MDFfc21idXMgMDAw
MDowMDoxZi4zOiBTTUJ1cyB1c2luZyBQQ0kgaW50ZXJydXB0ClsgICAxNS41NDMwMjldIGlwbWlf
c2kgZG1pLWlwbWktc2kuMDogSVBNSSBidCBpbnRlcmZhY2UgaW5pdGlhbGl6ZWQKWyAgIDE2LjQ0
NTQ1OF0gRVhUNC1mcyAoc2RhMik6IG1vdW50ZWQgZmlsZXN5c3RlbSBmMmE5MTRkMC05ZDVjLTQz
NWQtOWQzMC02OTkzY2Q1OGFlODYgci93IHdpdGggb3JkZXJlZCBkYXRhIG1vZGUuIFF1b3RhIG1v
ZGU6IG5vbmUuClsgICAxNi41MzExNTldIEVEQUMgc2JyaWRnZTogU2Vla2luZyBmb3I6IFBDSSBJ
RCA4MDg2OjNjYTAKWyAgIDE2LjUzMTE4Nl0gRURBQyBzYnJpZGdlOiBTZWVraW5nIGZvcjogUENJ
IElEIDgwODY6M2NhMApbICAgMTYuNTMxMTk0XSBFREFDIHNicmlkZ2U6IFNlZWtpbmcgZm9yOiBQ
Q0kgSUQgODA4NjozY2E4ClsgICAxNi41MzEyMDJdIEVEQUMgc2JyaWRnZTogU2Vla2luZyBmb3I6
IFBDSSBJRCA4MDg2OjNjYTgKWyAgIDE2LjUzMTIwNl0gRURBQyBzYnJpZGdlOiBTZWVraW5nIGZv
cjogUENJIElEIDgwODY6M2M3MQpbICAgMTYuNTMxMjE0XSBFREFDIHNicmlkZ2U6IFNlZWtpbmcg
Zm9yOiBQQ0kgSUQgODA4NjozYzcxClsgICAxNi41MzEyMTddIEVEQUMgc2JyaWRnZTogU2Vla2lu
ZyBmb3I6IFBDSSBJRCA4MDg2OjNjYWEKWyAgIDE2LjUzMTIyNV0gRURBQyBzYnJpZGdlOiBTZWVr
aW5nIGZvcjogUENJIElEIDgwODY6M2NhYQpbICAgMTYuNTMxMjI5XSBFREFDIHNicmlkZ2U6IFNl
ZWtpbmcgZm9yOiBQQ0kgSUQgODA4NjozY2FiClsgICAxNi41MzEyMzddIEVEQUMgc2JyaWRnZTog
U2Vla2luZyBmb3I6IFBDSSBJRCA4MDg2OjNjYWIKWyAgIDE2LjUzMTI0MF0gRURBQyBzYnJpZGdl
OiBTZWVraW5nIGZvcjogUENJIElEIDgwODY6M2NhYwpbICAgMTYuNTMxMjQ5XSBFREFDIHNicmlk
Z2U6IFNlZWtpbmcgZm9yOiBQQ0kgSUQgODA4NjozY2FjClsgICAxNi41MzEyNTJdIEVEQUMgc2Jy
aWRnZTogU2Vla2luZyBmb3I6IFBDSSBJRCA4MDg2OjNjYWQKWyAgIDE2LjUzMTI2MF0gRURBQyBz
YnJpZGdlOiBTZWVraW5nIGZvcjogUENJIElEIDgwODY6M2NhZApbICAgMTYuNTMxMjYzXSBFREFD
IHNicmlkZ2U6IFNlZWtpbmcgZm9yOiBQQ0kgSUQgODA4NjozY2I4ClsgICAxNi41MzEyNzJdIEVE
QUMgc2JyaWRnZTogU2Vla2luZyBmb3I6IFBDSSBJRCA4MDg2OjNjYjgKWyAgIDE2LjUzMTI3NF0g
RURBQyBzYnJpZGdlOiBTZWVraW5nIGZvcjogUENJIElEIDgwODY6M2NmNApbICAgMTYuNTMxMjgy
XSBFREFDIHNicmlkZ2U6IFNlZWtpbmcgZm9yOiBQQ0kgSUQgODA4NjozY2Y0ClsgICAxNi41MzEy
ODZdIEVEQUMgc2JyaWRnZTogU2Vla2luZyBmb3I6IFBDSSBJRCA4MDg2OjNjZjYKWyAgIDE2LjUz
MTI5M10gRURBQyBzYnJpZGdlOiBTZWVraW5nIGZvcjogUENJIElEIDgwODY6M2NmNgpbICAgMTYu
NTMxMjk3XSBFREFDIHNicmlkZ2U6IFNlZWtpbmcgZm9yOiBQQ0kgSUQgODA4NjozY2Y1ClsgICAx
Ni41MzEzMDVdIEVEQUMgc2JyaWRnZTogU2Vla2luZyBmb3I6IFBDSSBJRCA4MDg2OjNjZjUKWyAg
IDE2LjUzMTQyMF0gRURBQyBNQzA6IEdpdmluZyBvdXQgZGV2aWNlIHRvIG1vZHVsZSBzYl9lZGFj
IGNvbnRyb2xsZXIgU2FuZHkgQnJpZGdlIFNyY0lEIzBfSGEjMDogREVWIDAwMDA6ZmY6MGUuMCAo
SU5URVJSVVBUKQpbICAgMTYuNTMxNDI1XSBFREFDIHNicmlkZ2U6ICBWZXI6IDEuMS4yIApbICAg
MTYuODQzMjM4XSBpbnRlbF9yYXBsX2NvbW1vbjogRm91bmQgUkFQTCBkb21haW4gcGFja2FnZQpb
ICAgMTYuODQzMjQ2XSBpbnRlbF9yYXBsX2NvbW1vbjogRm91bmQgUkFQTCBkb21haW4gY29yZQpb
ICAgMTYuODQzMjUxXSBpbnRlbF9yYXBsX2NvbW1vbjogRm91bmQgUkFQTCBkb21haW4gZHJhbQpb
ICAgMTcuOTk2NzM1XSBjbG9ja3NvdXJjZTogV2F0Y2hkb2cgcmVtb3RlIENQVSAxIHJlYWQgdGlt
ZWQgb3V0ClsgICAxOC4wMDU5NTJdIGNmZzgwMjExOiBMb2FkaW5nIGNvbXBpbGVkLWluIFguNTA5
IGNlcnRpZmljYXRlcyBmb3IgcmVndWxhdG9yeSBkYXRhYmFzZQpbICAgMTguMDA2NjExXSBMb2Fk
ZWQgWC41MDkgY2VydCAnc2ZvcnNoZWU6IDAwYjI4ZGRmNDdhZWY5Y2VhNycKWyAgIDE4LjAwNjk5
OV0gTG9hZGVkIFguNTA5IGNlcnQgJ3dlbnM6IDYxYzAzODY1MWFhYmRjZjk0YmQwYWM3ZmYwNmM3
MjQ4ZGIxOGM2MDAnClsgICAxOC4wMjI0MDFdIGF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTc5NDcz
ODU5MS4zODc6Mik6IGFwcGFybW9yPSJTVEFUVVMiIG9wZXJhdGlvbj0icHJvZmlsZV9sb2FkIiBw
cm9maWxlPSJ1bmNvbmZpbmVkIiBuYW1lPSJEaXNjb3JkIiBwaWQ9NzYxIGNvbW09ImFwcGFybW9y
X3BhcnNlciIKWyAgIDE4LjAyMjg4NV0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzk0NzM4NTkx
LjM4NzozKTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9uPSJwcm9maWxlX2xvYWQiIHByb2Zp
bGU9InVuY29uZmluZWQiIG5hbWU9NEQ2RjZFNjc2RjQ0NDIyMDQzNkY2RDcwNjE3MzczIHBpZD03
NjIgY29tbT0iYXBwYXJtb3JfcGFyc2VyIgpbICAgMTguMDIyODk3XSBhdWRpdDogdHlwZT0xNDAw
IGF1ZGl0KDE3OTQ3Mzg1OTEuMzg3OjQpOiBhcHBhcm1vcj0iU1RBVFVTIiBvcGVyYXRpb249InBy
b2ZpbGVfbG9hZCIgcHJvZmlsZT0idW5jb25maW5lZCIgbmFtZT0iZGV2aGVscCIgcGlkPTc3MyBj
b21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICAxOC4wMjI5MDNdIGF1ZGl0OiB0eXBlPTE0MDAgYXVk
aXQoMTc5NDczODU5MS4zODc6NSk6IGFwcGFybW9yPSJTVEFUVVMiIG9wZXJhdGlvbj0icHJvZmls
ZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZpbmVkIiBuYW1lPSJidXN5Ym94IiBwaWQ9NzY2IGNvbW09
ImFwcGFybW9yX3BhcnNlciIKWyAgIDE4LjAyMjkwOV0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgx
Nzk0NzM4NTkxLjM4Nzo2KTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9uPSJwcm9maWxlX2xv
YWQiIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9ImNydW4iIHBpZD03NzIgY29tbT0iYXBwYXJt
b3JfcGFyc2VyIgpbICAgMTguMDIyOTE0XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3OTQ3Mzg1
OTEuMzg4OjcpOiBhcHBhcm1vcj0iU1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfbG9hZCIgcHJv
ZmlsZT0idW5jb25maW5lZCIgbmFtZT0iY2hyb21lIiBwaWQ9NzcwIGNvbW09ImFwcGFybW9yX3Bh
cnNlciIKWyAgIDE4LjAyMjkxOV0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzk0NzM4NTkxLjM4
ODo4KTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9uPSJwcm9maWxlX2xvYWQiIHByb2ZpbGU9
InVuY29uZmluZWQiIG5hbWU9ImNoLXJ1biIgcGlkPTc2OSBjb21tPSJhcHBhcm1vcl9wYXJzZXIi
ClsgICAxOC4wMjI5MjNdIGF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTc5NDczODU5MS4zODg6OSk6
IGFwcGFybW9yPSJTVEFUVVMiIG9wZXJhdGlvbj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1bmNv
bmZpbmVkIiBuYW1lPSJlbGVtZW50LWRlc2t0b3AiIHBpZD03NzQgY29tbT0iYXBwYXJtb3JfcGFy
c2VyIgpbICAgMTguMDIyOTI5XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3OTQ3Mzg1OTEuMzg4
OjEwKTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9uPSJwcm9maWxlX2xvYWQiIHByb2ZpbGU9
InVuY29uZmluZWQiIG5hbWU9ImVwaXBoYW55IiBwaWQ9Nzc1IGNvbW09ImFwcGFybW9yX3BhcnNl
ciIKWyAgIDE4LjAyMjk2OF0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzk0NzM4NTkxLjM4ODox
MSk6IGFwcGFybW9yPSJTVEFUVVMiIG9wZXJhdGlvbj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1
bmNvbmZpbmVkIiBuYW1lPSJidWlsZGFoIiBwaWQ9NzY1IGNvbW09ImFwcGFybW9yX3BhcnNlciIK
WyAgIDE4LjMyODAxMF0gaWdiIDAwMDA6MDI6MDAuMCBlbnAyczBmMDogaWdiOiBlbnAyczBmMCBO
SUMgTGluayBpcyBVcCAxMDAwIE1icHMgRnVsbCBEdXBsZXgsIEZsb3cgQ29udHJvbDogUlgKWyAg
IDI1Ljc4Mjk5N10gL3Byb2MvY2dyb3VwcyBsaXN0cyBvbmx5IHYxIGNvbnRyb2xsZXJzLCB1c2Ug
Y2dyb3VwLmNvbnRyb2xsZXJzIG9mIHJvb3QgY2dyb3VwIGZvciB2MiBpbmZvClsgICAyNy42ODUz
NTRdIGxvb3AwOiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDgKWyAgIDI4LjQx
NjA2NV0gTkVUOiBSZWdpc3RlcmVkIFBGX1FJUENSVFIgcHJvdG9jb2wgZmFtaWx5ClsgICAyOC41
NjExMjRdIGthdWRpdGRfcHJpbnRrX3NrYjogOTQgY2FsbGJhY2tzIHN1cHByZXNzZWQKWyAgIDI4
LjU2MTEzMV0gYXVkaXQ6IHR5cGU9MTQwMCBhdWRpdCgxNzk0NzM4NjAxLjk0MzoxMDYpOiBhcHBh
cm1vcj0iU1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfcmVwbGFjZSIgcHJvZmlsZT0idW5jb25m
aW5lZCIgbmFtZT0iL3Vzci9saWIvc25hcGQvc25hcC1jb25maW5lIiBwaWQ9MTA3MiBjb21tPSJh
cHBhcm1vcl9wYXJzZXIiClsgICAyOC41Njk5MjhdIGF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTc5
NDczODYwMS45NTE6MTA3KTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9uPSJwcm9maWxlX3Jl
cGxhY2UiIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9Ii91c3IvbGliL3NuYXBkL3NuYXAtY29u
ZmluZS8vbW91bnQtbmFtZXNwYWNlLWNhcHR1cmUtaGVscGVyIiBwaWQ9MTA3MiBjb21tPSJhcHBh
cm1vcl9wYXJzZXIiCg==
--000000000000fddadf06604ea356
Content-Type: text/plain; charset="US-ASCII"; name="lspci-00-1c.3-7.3.4-revert.txt"
Content-Disposition: attachment; filename="lspci-00-1c.3-7.3.4-revert.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mwhq9yl13>
X-Attachment-Id: f_mwhq9yl13

MDA6MWMuMyBQQ0kgYnJpZGdlOiBJbnRlbCBDb3Jwb3JhdGlvbiBDNjAwL1g3OSBzZXJpZXMgY2hp
cHNldCBQQ0kgRXhwcmVzcyBSb290IFBvcnQgNCAocmV2IGI2KSAocHJvZy1pZiAwMCBbTm9ybWFs
IGRlY29kZV0pCglTdWJzeXN0ZW06IEh1YXdlaSBUZWNobm9sb2dpZXMgQ28uLCBMdGQuIEM2MDAv
WDc5IHNlcmllcyBjaGlwc2V0IFBDSSBFeHByZXNzIFJvb3QgUG9ydCA0CglDb250cm9sOiBJL08r
IE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0
ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYt
IEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0g
PlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiA2NCBieXRl
cwoJSW50ZXJydXB0OiBwaW4gRCByb3V0ZWQgdG8gSVJRIDMzCglJT01NVSBncm91cDogMjAKCUJ1
czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5PTA3LCBzdWJvcmRpbmF0ZT0wNywgc2VjLWxhdGVuY3k9
MAoJSS9PIGJlaGluZCBicmlkZ2U6IDIwMDAtMmZmZiBbc2l6ZT00S10gWzE2LWJpdF0KCU1lbW9y
eSBiZWhpbmQgYnJpZGdlOiA5NDUwMDAwMC05NDVmZmZmZiBbc2l6ZT0xTV0gWzMyLWJpdF0KCVBy
ZWZldGNoYWJsZSBtZW1vcnkgYmVoaW5kIGJyaWRnZTogOTAwMDAwMDAtOTNmZmZmZmYgW3NpemU9
NjRNXSBbMzItYml0XQoJU2Vjb25kYXJ5IHN0YXR1czogNjZNSHotIEZhc3RCMkItIFBhckVyci0g
REVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPFNFUlItIDxQRVJSLQoJQnJp
ZGdlQ3RsOiBQYXJpdHktIFNFUlIrIE5vSVNBLSBWR0ErIFZHQTE2LSBNQWJvcnQtID5SZXNldC0g
RmFzdEIyQi0KCQlQcmlEaXNjVG1yLSBTZWNEaXNjVG1yLSBEaXNjVG1yU3RhdC0gRGlzY1RtclNF
UlJFbi0KCUNhcGFiaWxpdGllczogWzQwXSBFeHByZXNzICh2MikgUm9vdCBQb3J0IChTbG90Kyks
IE1TSSAwMAoJCURldkNhcDoJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIFBoYW50RnVuYyAwCgkJCUV4
dFRhZy0gUkJFKwoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1
cFJlcS0KCQkJUmx4ZE9yZC0gRXh0VGFnLSBQaGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9vcC0KCQkJ
TWF4UGF5bG9hZCAxMjggYnl0ZXMsIE1heFJlYWRSZXEgMTI4IGJ5dGVzCgkJRGV2U3RhOglDb3Jy
RXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLSBBdXhQd3IrIFRyYW5zUGVuZC0K
CQlMbmtDYXA6CVBvcnQgIzQsIFNwZWVkIDVHVC9zLCBXaWR0aCB4MSwgQVNQTSBMMHMgTDEsIEV4
aXQgTGF0ZW5jeSBMMHMgPDUxMm5zLCBMMSA8NHVzCgkJCUNsb2NrUE0tIFN1cnByaXNlLSBMTEFj
dFJlcCsgQndOb3QtIEFTUE1PcHRDb21wLQoJCUxua0N0bDoJQVNQTSBEaXNhYmxlZDsgUkNCIDY0
IGJ5dGVzLCBEaXNhYmxlZC0gQ29tbUNsaysKCQkJRXh0U3luY2gtIENsb2NrUE0tIEF1dFdpZERp
cy0gQldJbnQtIEF1dEJXSW50LQoJCUxua1N0YToJU3BlZWQgMi41R1QvcywgV2lkdGggeDEKCQkJ
VHJFcnItIFRyYWluLSBTbG90Q2xrKyBETEFjdGl2ZSsgQldNZ210KyBBQldNZ210LQoJCVNsdENh
cDoJQXR0bkJ0bi0gUHdyQ3RybC0gTVJMLSBBdHRuSW5kLSBQd3JJbmQtIEhvdFBsdWctIFN1cnBy
aXNlLQoJCQlTbG90ICMzLCBQb3dlckxpbWl0IDEwVzsgSW50ZXJsb2NrLSBOb0NvbXBsKwoJCVNs
dEN0bDoJRW5hYmxlOiBBdHRuQnRuLSBQd3JGbHQtIE1STC0gUHJlc0RldC0gQ21kQ3BsdC0gSFBJ
cnEtIExpbmtDaGctCgkJCUNvbnRyb2w6IEF0dG5JbmQgVW5rbm93biwgUHdySW5kIFVua25vd24s
IFBvd2VyLSBJbnRlcmxvY2stCgkJU2x0U3RhOglTdGF0dXM6IEF0dG5CdG4tIFBvd2VyRmx0LSBN
UkwtIENtZENwbHQtIFByZXNEZXQrIEludGVybG9jay0KCQkJQ2hhbmdlZDogTVJMLSBQcmVzRGV0
LSBMaW5rU3RhdGUrCgkJUm9vdENhcDogQ1JTVmlzaWJsZS0KCQlSb290Q3RsOiBFcnJDb3JyZWN0
YWJsZS0gRXJyTm9uLUZhdGFsLSBFcnJGYXRhbC0gUE1FSW50RW5hKyBDUlNWaXNpYmxlLQoJCVJv
b3RTdGE6IFBNRSBSZXFJRCAwMDAwLCBQTUVTdGF0dXMtIFBNRVBlbmRpbmctCgkJRGV2Q2FwMjog
Q29tcGxldGlvbiBUaW1lb3V0OiBSYW5nZSBCQywgVGltZW91dERpcysgTlJPUHJQclAtIExUUi0K
CQkJIDEwQml0VGFnQ29tcC0gMTBCaXRUYWdSZXEtIE9CRkYgTm90IFN1cHBvcnRlZCwgRXh0Rm10
LSBFRVRMUFByZWZpeC0KCQkJIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uIE5vdCBTdXBwb3J0ZWQs
IEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uSW5pdC0KCQkJIEZSUy0gTE4gU3lzdGVtIENMUyBOb3Qg
U3VwcG9ydGVkLCBUUEhDb21wLSBFeHRUUEhDb21wLSBBUklGd2QtCgkJCSBBdG9taWNPcHNDYXA6
IFJvdXRpbmctIDMyYml0LSA2NGJpdC0gMTI4Yml0Q0FTLQoJCURldkN0bDI6IENvbXBsZXRpb24g
VGltZW91dDogNTB1cyB0byA1MG1zLCBUaW1lb3V0RGlzLSBMVFItIDEwQml0VGFnUmVxLSBPQkZG
IERpc2FibGVkLCBBUklGd2QtCgkJCSBBdG9taWNPcHNDdGw6IFJlcUVuLSBFZ3Jlc3NCbGNrLQoJ
CUxua0N0bDI6IFRhcmdldCBMaW5rIFNwZWVkOiAyLjVHVC9zLCBFbnRlckNvbXBsaWFuY2UtIFNw
ZWVkRGlzLQoJCQkgVHJhbnNtaXQgTWFyZ2luOiBOb3JtYWwgT3BlcmF0aW5nIFJhbmdlLCBFbnRl
ck1vZGlmaWVkQ29tcGxpYW5jZS0gQ29tcGxpYW5jZVNPUy0KCQkJIENvbXBsaWFuY2UgUHJlc2V0
L0RlLWVtcGhhc2lzOiAtNmRCIGRlLWVtcGhhc2lzLCAwZEIgcHJlc2hvb3QKCQlMbmtTdGEyOiBD
dXJyZW50IERlLWVtcGhhc2lzIExldmVsOiAtMy41ZEIsIEVxdWFsaXphdGlvbkNvbXBsZXRlLSBF
cXVhbGl6YXRpb25QaGFzZTEtCgkJCSBFcXVhbGl6YXRpb25QaGFzZTItIEVxdWFsaXphdGlvblBo
YXNlMy0gTGlua0VxdWFsaXphdGlvblJlcXVlc3QtCgkJCSBSZXRpbWVyLSAyUmV0aW1lcnMtIENy
b3NzbGlua1JlczogdW5zdXBwb3J0ZWQKCUNhcGFiaWxpdGllczogWzgwXSBNU0k6IEVuYWJsZSsg
Q291bnQ9MS8xIE1hc2thYmxlLSA2NGJpdC0KCQlBZGRyZXNzOiBmZWUwMDM3OCAgRGF0YTogMDAw
MAoJQ2FwYWJpbGl0aWVzOiBbOTBdIFN1YnN5c3RlbTogSHVhd2VpIFRlY2hub2xvZ2llcyBDby4s
IEx0ZC4gQzYwMC9YNzkgc2VyaWVzIGNoaXBzZXQgUENJIEV4cHJlc3MgUm9vdCBQb3J0IDQKCUNh
cGFiaWxpdGllczogW2EwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMgoJCUZsYWdzOiBQTUVD
bGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQz
Y29sZCspCgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9
MCBQTUUtCglLZXJuZWwgZHJpdmVyIGluIHVzZTogcGNpZXBvcnQKCUtlcm5lbCBtb2R1bGVzOiBz
aHBjaHAKCg==
--000000000000fddadf06604ea356
Content-Type: application/octet-stream; name="revert-72780f796468.diff"
Content-Disposition: attachment; filename="revert-72780f796468.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mwhq9ylz5>
X-Attachment-Id: f_mwhq9ylz5

LS0tIGEvZHJpdmVycy9wY2kvcXVpcmtzLmMKKysrIGIvZHJpdmVycy9wY2kvcXVpcmtzLmMKQEAg
LTgwLDEwICs4MCwxMSBAQAogICogUmVzdHJpY3QgdGhlIHNwZWVkIHRvIDIuNUdUL3MgdGhlbiB3
aXRoIHRoZSBUYXJnZXQgTGluayBTcGVlZCBmaWVsZCwKICAqIHJlcXVlc3QgYSByZXRyYWluIGFu
ZCBjaGVjayB0aGUgcmVzdWx0LgogICoKLSAqIElmIHRoaXMgdHVybnMgb3V0IHN1Y2Nlc3NmdWws
IG9yIHdoZXJlIGEgMi41R1QvcyBzcGVlZCByZXN0cmljdGlvbiBoYXMKLSAqIGJlZW4gcHJldmlv
dXNseSBhcnJhbmdlZCBieSB0aGUgZmlybXdhcmUgYW5kIHRoZSBwb3J0IHJlcG9ydHMgaXRzIGxp
bmsKLSAqIGFscmVhZHkgYmVpbmcgdXAsIGxpZnQgdGhlIHJlc3RyaWN0aW9uLCBpbiBhIGhvcGUg
aXQgaXMgc2FmZSB0byBkbyBzbywKLSAqIGxldHRpbmcgdGhlIGRldmljZXMgbmVnb3RpYXRlIGEg
aGlnaGVyIHNwZWVkLgorICogSWYgdGhpcyB0dXJucyBvdXQgc3VjY2Vzc2Z1bCBhbmQgd2Uga25v
dyBieSB0aGUgVmVuZG9yOkRldmljZSBJRCBpdCBpcworICogc2FmZSB0byBkbyBzbywgdGhlbiBs
aWZ0IHRoZSByZXN0cmljdGlvbiwgbGV0dGluZyB0aGUgZGV2aWNlcyBuZWdvdGlhdGUKKyAqIGEg
aGlnaGVyIHNwZWVkLiBBbHNvIGNoZWNrIGZvciBhIHNpbWlsYXIgMi41R1QvcyBzcGVlZCByZXN0
cmljdGlvbiB0aGUKKyAqIGZpcm13YXJlIG1heSBoYXZlIGFscmVhZHkgYXJyYW5nZWQgYW5kIGxp
ZnQgaXQgd2l0aCBwb3J0cyB0aGF0IGFscmVhZHkKKyAqIHJlcG9ydCB0aGVpciBkYXRhIGxpbmsg
YmVpbmcgdXAuCiAgKgogICogT3RoZXJ3aXNlIHJldmVydCB0aGUgc3BlZWQgdG8gdGhlIG9yaWdp
bmFsIHNldHRpbmcgYW5kIHJlcXVlc3QgYSByZXRyYWluCiAgKiBhZ2FpbiB0byByZW1vdmUgYW55
IHJlc2lkdWFsIHN0YXRlLCBpZ25vcmluZyB0aGUgcmVzdWx0IGFzIGl0J3Mgc3VwcG9zZWQKQEAg
LTk0LDYgKzk1LDEwIEBACiAgKi8KIGludCBwY2llX2ZhaWxlZF9saW5rX3JldHJhaW4oc3RydWN0
IHBjaV9kZXYgKmRldikKIHsKKwlzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgaWRz
W10gPSB7CisJCXsgUENJX1ZERVZJQ0UoQVNNRURJQSwgMHgyODI0KSB9LAkvKiBBU01lZGlhIEFT
TTI4MjQgKi8KKwkJe30KKwl9OwogCXUxNiBsbmtzdGEsIGxua2N0bDIsIG9sZGxua2N0bDI7CiAJ
ZW51bSBwY2lfYnVzX3NwZWVkIHNwZWVkX2NhcDsKIAlpbnQgcmV0ID0gLUVOT1RUWTsKQEAgLTEy
MCw3ICsxMjUsOSBAQAogCX0KIAogCXBjaWVfY2FwYWJpbGl0eV9yZWFkX3dvcmQoZGV2LCBQQ0lf
RVhQX0xOS0NUTDIsICZsbmtjdGwyKTsKLQlpZiAoKGxua2N0bDIgJiBQQ0lfRVhQX0xOS0NUTDJf
VExTKSA9PSBQQ0lfRVhQX0xOS0NUTDJfVExTXzJfNUdUKSB7CisJaWYgKChsbmtzdGEgJiBQQ0lf
RVhQX0xOS1NUQV9ETExMQSkgJiYKKwkgICAgKGxua2N0bDIgJiBQQ0lfRVhQX0xOS0NUTDJfVExT
KSA9PSBQQ0lfRVhQX0xOS0NUTDJfVExTXzJfNUdUICYmCisJICAgIHBjaV9tYXRjaF9pZChpZHMs
IGRldikpIHsKIAkJcGNpX2luZm8oZGV2LCAicmVtb3ZpbmcgMi41R1QvcyBkb3duc3RyZWFtIGxp
bmsgc3BlZWQgcmVzdHJpY3Rpb25cbiIpOwogCQlyZXQgPSBwY2llX3NldF90YXJnZXRfc3BlZWQo
ZGV2LCBzcGVlZF9jYXAsIGZhbHNlKTsKIAkJaWYgKHJldCkK
--000000000000fddadf06604ea356--
