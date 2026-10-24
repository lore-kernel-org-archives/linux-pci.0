Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792812385;
	b=aeO0WFrWmLatlxSCbwONv81ydYY2q+2QS0n1KY5uIUobqj1eMLUZXCigt//I80WW1lSP
	 I3mAYefMqSb1xwTX+cGeR/TeMckDy3imAgxXo4CUbioAEXAO6k3t8x2OoKvS2NS0mqxlc
	 x6WE1w+fEXExTVGBAi6ZDx3InPYmaqydHYkf86N0vBLD9bOVKLFXtHCu3WM+kBBg+StSy
	 uNj/h7uhIRgfa/PU95Lp1BoWQWSTUraiPtD4egLuw/5RlCDYWMQ4w4x5hcd1R9Pqce1y5
	 A0dTsLGwZOGwVaWOITIRkwSQCeT9KbmVIEAZUSVkxIIDZ+MjBa5GlW9fZQJQFNTkCSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792812385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FicJIZs2+/qCTDE+0FRHSg6kJmTqD7XGGr4iZ+o1ZRU=;
	b=xx4hyp2M9nMMkgvrmEVpBblLqoKupF2HvnSBHkYnExOsTbVK0bf1I2EKT3bjlXlQ1x1e
	 IYDpn3J2+v3EViGeU4aZs9TIJSe6fR6jBdutQ0rBjOcv/M2Ug85KhyxzUzxtatnMNqEbv
	 YmSykQMUdiNvXX1tOMxmzfwkjBUZvNSbj6/ODLLK9Fctlmn8WB4d2Mg3GSwy/OOws5Ne7
	 kbdplFU71LUzu6HLSzvHfMxXxBE7dTtNb09QKwlP5IWPJoiUK/DlVoxbY9ihIVtemPnCo
	 61O0z+B14DRx42Y3XqwSAV0awDGAh3oYM9L7ccIJTXEKr3rPiwgYm4j7aBqqFZgKDJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JPkEfqc3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE5606A31A
	for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 03:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CBE5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JPkEfqc3
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53665358476so14162531cf.2
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2026 20:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792812383; cv=none;
        d=google.com; s=arc-20260327;
        b=aoOFhHCnWYTYxsD7CK5m7Jz4+UDrfKFXEmMO1/cQLJ8ayXvuCN2pyCH//61WBcCl3o
         MZO/mHCWpJolHUHci+BChfHquVFx+W0rphj8UoPjEziEnrWcJxos+fjjTCd01ktbU4R9
         iDtcDOAXaIlEZlHJBrlNFHGMrPd1OsZ943KdItWTQWYlc6l1DFqd0rEl6vLVkOdsEY01
         9XOEAF7LwTDMEjvwjQDkaprcy4rpNaVimZiXC+1qkiKBmIW6PZKdXnVioQqX8xl2UZqo
         u2GOtwktlV3d1uIjU8iDze740a1XdX1wPcmrvhC0KlfC37YWvmvUfNvrYld+ivKfa39/
         KsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FicJIZs2+/qCTDE+0FRHSg6kJmTqD7XGGr4iZ+o1ZRU=;
        fh=M+4scIZd54wlBEHkR0C3fblQtQjBh12rTHD9tQJNwEY=;
        b=GE2QOC3kBqTWIBgrn68ggT0FqfzL6x35L+JBov+Fiqmzh48OzZYi67VlAzZN6km4u6
         fbzWEz4jSjlSusTNN+DCa4gPmNq318FeTObe76uqo7CCgg9hNIo6eNN+PzgK0kanVMz1
         91LE11lSOZNftugbcFfI6fO8vvZGn0MKn6N/5KY0+xBxUGaGHHKlaAiIu3V1GzzecF4X
         zv7QD8N9gJ4YD2uiQ8Ouhobr1ykbpi9yy8NXXT1AltqsQ+2NJcf6gxUQ9IzGu7ryj/qo
         5SQxxxTjBpHNiuILVNghvGA4cOAIei4ZcrL7ltobBXAGZYbBA1J3WvlIx8RonMlcyPKb
         xLTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792812383; x=1793417183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FicJIZs2+/qCTDE+0FRHSg6kJmTqD7XGGr4iZ+o1ZRU=;
        b=JPkEfqc38rmVYfBrogvq0HcazTissN0pHHCPFvXuEHZAFWWFfqeXm++eSjOmi06YDL
         SJcUq8tZjdWdtztCDSE4OnOhc7+JupfiOahyimATsNI2DfpxgRDl5VikOe1KqEa2bxRb
         x1Rag0wSOPQT489sGmvn7vOkDJuwKRhf+nSYqDBb5NDmOkXbbnhTvioy1WS843k1+m+c
         xKeJxq8dwAHDkVgGayc+kNBX3ADw63+op6lwCt6enK2g45SEnzjzijeu+PztTXcvcSlW
         W2dxvy2YcGbWnjqU8E64E6zMvOffo43W9UpFDUpygE8FkeyCWGKHL2+ICOJZuwYBlmkv
         Mu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792812383; x=1793417183;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FicJIZs2+/qCTDE+0FRHSg6kJmTqD7XGGr4iZ+o1ZRU=;
        b=t4ZS/Slvo4WVhNoflKkpbpDyjdXbiMbkUCQLxUOAtljukTy+mCKfDeTXkMEw+HLutL
         p3Kah/PDMSrpPLfhtWTGgW7Oim6pAhFnNX0081o/uMUbuiiVQUFqkJ5GTtNQuZM5GPPA
         GmR84Q/lpWiSoss5VVMIKEEEhF5CAaR94zstgIz/CgPKvUBbUUe+pk8YV3wF1m51TdvV
         nr7o5Nu9A4X1cmyQEikxLd3eSFvDXB0f8O+2CmYBLVM0GQEsImyBxk/xVBFCc74+l7PU
         USSxrl6o5obN1fQIv0Lgf83HAa9FfiRxfK8l4XTEhppfauob1tG8rzzZzWaOBC+oRXKD
         ZyHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzagm+cw/+zYnuPHfBmtmJugz3ZK81tfBeTJvG/I+LMuGZRZrx5JLJoVwVxnLlfKLUdvI/d92aW1P4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvzfcyC0jLT7m/NzUv+UZQMkQ23ohWRMLjUcPTRUm39mUwDfoR
	LIhfVmNQJAFlSEQDl55hDa97zQ8WXcxAxd/JICL/AnrLgiKdQCjylJ1aBRnJcP8y6CIf47C5NhY
	3PgfiIexRHADixfnlhTTmfqiaCsz+k1g=
X-Gm-Gg: AYBFou2ZRazlEx5XfkP+KaP6kgMh2FNtfL3aM5mPtxeuyGOK27Ze2Nhe4PcZh1Zt0qD
	nf9Z8QRls0ut2JXfFqYK3pggjibvsD40ZMSiEy2c6lohMBxo8kp6FM9T7l8LTc/4U5PVrkJakE1
	vbRL5bjTa1H4W3hjZb+2QmvHQ3JdSDc6VrzXtMjcfrpj2UJlVQobg+FX0uwVcEie6OX+3keU35c
	cqDKWwWssnxFt1W5B1OJfDfZFCABcR760R6h3uOBHFHqYkCnlhDe0qMqnbA5bwqk+bYycHAzQZj
	1lntagTpaRZ7F7p1DQ1Efm48lZH3U/xDE7zee8AtjRiYvPc5I8vYYS3dtJbmWB5JThWsfNIF3uS
	LkHG08UPITEGMHlhunXGYMzcD9ypLCvwtH7ibP6M2rwZrRlnVWiouby4vunG/Rn+XvWqxbRCsGU
	Bh2pZS1hOY9AEEymGhFSQ=
X-Received: by 2002:ac8:5f93:0:b0:535:11e7:fdb3 with SMTP id
 d75a77b69052e-5383b4fd48cmr11061231cf.34.1792812382943; Fri, 23 Oct 2026
 20:26:22 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018201727.96924-1-williamwoodstock79@gmail.com> <20261019141053.7b2d8e23@nvidia.com>
In-Reply-To: <20261019141053.7b2d8e23@nvidia.com>
From: William Woodstock <williamwoodstock79@gmail.com>
Date: Fri, 23 Oct 2026 20:26:12 -0700
X-Gm-Features: AclHuK-yfT4LvkJ-ln5yWRznOXG4xObhTaFvAUkqkJ-ddhw8muvQiG6pyIjtX5o
Message-ID: <CAC_eNMPu=3Tez6L0jO2f-OkRWPL9-ub8BS+7uftcRqSGKbCFQA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Avoid bus reset on NVIDIA GB202 and GB203 GPUs
To: Alex Williamson <alwilliamson@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending because html was rejected, and I also tried kernel 7.3, with
no success.

> What's your RTX 5080 vBIOS version and system information?  Is it the
> same Asus X870E as the other 5090 reports or something else?

vBIOS: 98.03.3b.c0.0b
Card:  Zotac GeForce RTX 5080 (10de:2c02, subsystem 19da:1765),
       primary PCIEX16 slot, bifurcation Auto
Board: Gigabyte X870E Aorus Master, BIOS F14d (not the Asus board)
CPU:   AMD Ryzen 9 9950X3D2, GPU on root port 00:01.1 [1022:14db]
Host:  Proxmox VE, kernel 7.0.14-20-pve; guest Windows 11 Pro,
       GPU passed through with vfio-pci

It reproduces without a VM. On the host, with the link at 32GT/s x16:

  echo 1 > /sys/bus/pci/devices/0000:00:01.1/reset_subordinate

brings it back at x8. A bwctrl retrain restores the speed but not the
width; only a cold boot gets x16 back.

> Is the issue still present on kernel v7.3?

Yes. I built v7.3 from kernel.org with no patches, using the Proxmox
7.0.14-20-pve config (make olddefconfig, LOCALVERSION=3D-stock), and ran
the same host-only test with no VM running:

  uname -r: 7.3.0-stock

  before: 01:00.0 LnkSta: Speed 2.5GT/s (downgraded), Width x16
  after:  01:00.0 LnkSta: Speed 32GT/s, Width x8 (downgraded)

  [  211.617016] vfio-pci 0000:01:00.0: resetting
  [  211.617225] vfio-pci 0000:01:00.1: resetting
  [  212.898377] vfio-pci 0000:01:00.0: not ready 1023ms after bus
reset; waiting
  [  279.586064] vfio-pci 0000:01:00.0: not ready 65535ms after bus
reset; giving up
  [  279.587022] vfio-pci 0000:01:00.0: reset done
  [  279.589284] vfio-pci 0000:01:00.1: reset done

The 65 s "not ready" wait didn't happen on 7.0.14, where the reset
finished in about a second. On this run the guest had been
force-stopped just before the reset, so that may explain it rather
than 7.3. The x8 result is the same either way.

> Disabling bus reset entirely should be a last resort, it has
> implications for device isolation when no other reset mechanism exists.

Understood. What I measured:

- 01:00.0 (GPU) reports reset_method "flr bus"; 01:00.1 (HDA) none.
- With only .0 assigned, FLR is used and the link stays x16.
- With .1 assigned too, vfio falls back to a bus reset and the link
  drops to x8.

So the bus reset is only reached because the audio function has no
reset of its own. Would you rather see a quirk that gives the HDA
function a usable reset, or keep the bus reset and restore the link
width afterwards? Happy to test either.
Thanks,
mark-ship-it


On Mon, Oct 19, 2026 at 1:11=E2=80=AFPM Alex Williamson <alwilliamson@nvidi=
a.com> wrote:
>
> On Sun, 18 Oct 2026 13:17:27 -0700
> mark-ship-it <williamwoodstock79@gmail.com> wrote:
>
> > NVIDIA GB202 (GeForce RTX 5090, RTX PRO 6000) and GB203 (GeForce RTX
> > 5080/5070 Ti/5070) GPUs train their link at x16 at boot, but after a
> > Secondary Bus Reset the link comes back at x8 and stays there until the
> > next cold boot.
> >
> > The GPU's HD Audio function (e.g. 10de:22e9 on GB203) has no reset meth=
od,
> > so when both functions are assigned to a VM, vfio-pci falls back to a b=
us
> > reset at VM start and again at release, and the GPU then runs at half
> > width. Assigning only function 0 avoids the bus reset because the GPU
> > itself supports FLR, which is why the problem is usually reported as
> > "passing the audio function breaks x16".
> >
> > Observed on an RTX 5080 (10de:2c02) behind an AMD Root Port, kernel
> > 7.0.14, Proxmox VE host with a Windows 11 Pro guest:
> >
> >   boot:                         LnkSta: Speed 32GT/s, Width x16
> >   echo 1 > /sys/bus/pci/devices/<root port>/reset_subordinate
> >                                 LnkSta: Speed 32GT/s, Width x8 (downgra=
ded)
> >
> > No VM is involved in that reproduction. Stepping the link speed through
> > bwctrl (Gen5 -> Gen4 -> Gen5) retrains the link and the speed follows,
> > but the width stays at x8. With a VM started frozen (-S), the link is
> > already at x8 before any guest code has run, so the guest driver is not
> > involved.
> >
> > With this patch applied, reset_method for the GPU is "flr" only, both
> > functions can be assigned, and the link stays at x16 Gen5 across VM
> > start, shutdown and restart, with the Windows guest driver working.
> >
> > The same symptom has been reported with an RTX 5090 (10de:2b85) on an
> > AMD X870E board, where passing only function 0 was the only thing that
> > kept x16.
> >
> > Link: https://forum.proxmox.com/threads/asus-x870e-pcie-x8-bifurcation-=
bug-with-rtx-5090-vfio-passthrough.178461/
> >
> > Signed-off-by: mark-ship-it <williamwoodstock79@gmail.com>
> > ---
> >  drivers/pci/quirks.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 1aa87a3ef..a4adcc3e7 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3769,10 +3769,17 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, =
0x22D0, quirk_no_bus_reset);
> >  /*
> >   * Some NVIDIA GPU devices do not work with bus reset, SBR needs to be
> >   * prevented for those affected devices.
> > + *
> > + * GB202 (0x2b80-0x2bbf) and GB203 (0x2c00-0x2c7f) GPUs train at x16 a=
t
> > + * boot, but after a Secondary Bus Reset the link comes back at x8 and
> > + * stays there until the next cold boot; a link retrain restores the s=
peed
> > + * but not the width.  Function Level Reset does not have this problem=
.
> >   */
> >  static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
> >  {
> > -     if ((dev->device & 0xffc0) =3D=3D 0x2340)
> > +     if ((dev->device & 0xffc0) =3D=3D 0x2340 ||
> > +         (dev->device & 0xffc0) =3D=3D 0x2b80 ||
> > +         (dev->device & 0xff80) =3D=3D 0x2c00)
> >               quirk_no_bus_reset(dev);
> >  }
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>
> What's your RTX 5080 vBIOS version and system information?  Is it the
> same Asus X870E as the other 5090 reports or something else?
>
> Is the issue still present on kernel v7.3?
>
> Disabling bus reset entirely should be a last resort, it has
> implications for device isolation when no other reset mechanism exists.
> Thanks,
>
> Alex
