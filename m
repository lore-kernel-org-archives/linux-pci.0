Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EB33563F0
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781253666; cv=pass; b=kvxpJX0toVxGi/imbbh2OEGLYLtSSUkuBq3RVrrLjPAYPCTSHR9ntnSV+q/Rqz8FoFIxmpYJRUfb+SWD/TK3OfQKeMqHZTz2OGmYzedvDEOYsDyG9R99F53JvKeBxX5EdNiwFurkn/ZGF6/PPbSQJIDnWZHiM+kIzKsQdiGRmRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781253666; c=relaxed/simple;
	bh=+m7I0CkjADMVYbMlq9bhnum1ScczX6vFg3jUPezTHpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc5XZL8o+sQnddRIQGYFbHhOYy23FH1ZfY+8xJzqIC5kO4qji2qkWUsb2J7oYsT4YQN4JE0B+9g8pbnyjJhRyhnE4CaG03ImAdVkv/Raid9BRTJmVIrDD0YmKT2xNMCKCvE/imwa6/tj3Bjoxpkg17aR+P0uUt/O34E368YTK5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCsjwFoc; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCsjwFoc"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69e43b02308so325379eaf.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 01:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781253664; cv=none;
        d=google.com; s=arc-20240605;
        b=Qyd9hoknu7n5CEz5qfcdH1x0HM9L9ghP6/s1ep7hsW8eeH+GSTmxrCF/xodrRWBLB8
         67kOrLm16ljnY8rf0fG19KLsQ62q0FO/s0VVFfsa/VRNI+XtHyMT2/AIA8xyVcaouK1N
         kPOJKbmsMMy5VSfGKq0nSLsrlQAlG+/NT9yEkCsspqt2uplUbmZwLv9D3pWAApk5X9lH
         1r2ZwhEfdVkvfZxdf1F9bnbe8zso22U25lWEpMgVlUWNwj5sc5EHXmqmKAaHqlsTxnxj
         cOX+ApV3DOolAYQBGyqYuXKCuDyg+9UnEnA4QupBkr21OjncUg7VeZAO2RU0bAxpISKJ
         mSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qDXT+VpnUZOvTmZ9QfMSI9maJrx+MRQBI+WJcmPy6JU=;
        fh=GVA+DAybPvRt2kEvksRUFsO7X2/+vVEz7Pu4Q6DJDSc=;
        b=I4f4mdxd+iZA6TtAT/g5uG2rCANSYp6lpZLbV8XXXWRKdx9tmE178QrahHs95rDapz
         fHPgSGfAF2Erx1EBhiSpJnnwRgGIPVDUcOVdNmKotEW4vQsJ09WRCk9SjAVTLE1ijwk0
         e+11EtxeyZyAJVF+a38SGlZ4hAOgaruMIJZrkQ1IYQnwwYt8qHdZfOfKbRDMku4uUEC0
         D2FmVIH6nes+Vni8PZ9qr3acjIFF1aImFrdY++auE7f4APLVs/+joWWF5vt95UpRuSqq
         Qgyb6MesP9tYO1XGUhSIMuTZRS3P7CMmrRFQlKJ2iTvAW7lIOPI6ttPDNGf4L3S1d/6o
         bHSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781253664; x=1781858464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDXT+VpnUZOvTmZ9QfMSI9maJrx+MRQBI+WJcmPy6JU=;
        b=DCsjwFocz+ITiFdDD/RMvZ+ldHOXvBMG/CxDXCTJWtxv2SxHeG1pKHAjxn7fPw9cA5
         uNrdtXA9GTErlQ6B0A9LLhkP6drcZBpcsz5uIgsOe0ZGLCh45o/Bc2HUMhBPAW8N/edt
         MO4ohkCA78bmWhPXpvXaophxZYljOT5twQXzz+b0RIyhx+1BtqOAQ51y5W7WtpqInE6P
         LZuNfqz+f75tQiJPnPPyB6JKoAen26jN8mTywU8usxw7UjtWF6r/vmQ3onaY7vbhNrpT
         WVJeZugIoqVUcWD9d9jfS1AkRuCwPODETKKEwSQn+NiBBp+josS7R16S5Kk0YmUCqe0g
         iH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781253664; x=1781858464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qDXT+VpnUZOvTmZ9QfMSI9maJrx+MRQBI+WJcmPy6JU=;
        b=DX++M2W8cjci7LNqG/1VdRE2g0/U0y4WZhQLNg0OP+LOoDjOc3cO54lVNluM1ZMPLT
         u/Yrtf+2ov+/1gMtLR4tLI4qOeM8EopWd+oaX/aO4mQMWPFzIVddhH2IOngJFtxkAxuZ
         A+TrYqMTt1+PEMVw7ZK2m28T0Fnnl8XLw3vHe6Uot7ckw06gkUbhOgFDse3gl5Op/+EL
         RLWcraYuz7NTWDQegbiEvCll0cp6MkOhuJga9sTx8IMqThhay2kiCmBy7P0Mq7NeAfk7
         5uauPOVUP3UOakuc5QbO+sGJWHWzsvP6a7bezv7rnGAdmk/uwjTscXELIkoFZAE8Gjow
         5t7A==
X-Forwarded-Encrypted: i=1; AFNElJ/M7ucB0qYDrdu+2RTeN9of78WkV4940NX88CFaLZZgjJZpbIQgrCnWq1K8d/Id7VRL1wbQSVPet80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzskvorivnUV7GAndbzUK9NKAPHWiDWtJz96wOKk6rlp91Z4tGu
	T+GO9tosBJp1XA7vTf5Ck71aChAxZ74V8zlumI2UDGvMsPeu73NxxBHFYfKvLcnMmJ92DTbYyXZ
	BjMOzGVisOQzeOP7KqkS4vJcOID4Cwl0=
X-Gm-Gg: Acq92OHDJD6kO3KilyJ8e7oRzYs22SOjCwCW0wlcIdDx5BTtN2/OnrHvMQNw3rNwzri
	FtpBrPDD4hE7FSczXyr24kozLiFbpyhwWEHakS2rR6xD20ck8aAKgwVqwd9RtPylGbf3IWJUg4f
	GJX75wckj+dbqw2iHpyvqSvSfILXQPeddo6B9FylXAC1oWAfbzpBIdtplTSa3eMdhmetN+EEVSN
	pUffQN+Mr2dumW7piHYbCmX7eqtJYnFfmHWpR6s1s+8rk4m01SlK9br96ZwVMev0/Y36tONNjM5
	Vxg1aBbr
X-Received: by 2002:a05:6820:1694:b0:69e:2f7c:693c with SMTP id
 006d021491bc7-69edc6f3f5emr1141562eaf.35.1781253663726; Fri, 12 Jun 2026
 01:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610135709.1630627-1-hugoolli@tencent.com>
 <20260610135709.1630627-3-hugoolli@tencent.com> <ef439f87-46dc-8c29-ecb4-10813eff98d0@linux.intel.com>
In-Reply-To: <ef439f87-46dc-8c29-ecb4-10813eff98d0@linux.intel.com>
From: hugo lee <cs.hugolee@gmail.com>
Date: Fri, 12 Jun 2026 16:40:53 +0800
X-Gm-Features: AVVi8CdNtyMw7w8UlkGHZBipiaGlNtDUiwU1zh3ygd3NhrTzseYf6vt_-NORCEY
Message-ID: <CAAdeq_+ekeLnFqbET12bVVDqOHyKDs07h5evD3BQQ=7LH4Kfmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: setup-res: Guard against bus->self == NULL in _pci_assign_resource()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, 
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Yinghai Lu <yinghai@kernel.org>, Yuguo Li <hugoolli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 5:57=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 10 Jun 2026, Yuguo Li wrote:
>
> > _pci_assign_resource() walks up the parent buses looking for a
> > transparent bridge to retry resource allocation against.  The
> > termination check dereferences bus->self->transparent without first
> > testing bus->self.
> >
> > For SR-IOV virtual buses created by virtfn_add_bus() via
> > pci_add_new_bus(parent, NULL, busnr) -- which happens when a VF lands
> > on a bus number different from its PF -- bus->self is NULL.  When
> > __pci_assign_resource() is invoked on such a VF (e.g. via
> > pci_assign_resource() from userspace-triggered LTP coverage) and the
> > allocation fails on the first iteration, the !bus->parent test passes
> > because the virtual bus does have a parent, and the next term then
> > NULL-derefs bus->self.
> >
> > Add an explicit !bus->self check, mirroring the established pattern
> > elsewhere in drivers/pci/ (e.g. pci.c, probe.c, pciehp_hpc.c).
> >
> > Reproduced on mainline 7.1.0-rc7+ on x86_64 with an SR-IOV PF whose
> > VFs span multiple bus numbers, by triggering pci_assign_resource() on
> > a VF that lives on a virtual bus:
> >
> >     BUG: kernel NULL pointer dereference, address: 0000000000000860
> >     RIP: 0010:_pci_assign_resource+0x63/0x130
> >     Call Trace:
> >      pci_assign_resource+0xe9/0x370
> >      ... (LTP tpci test-case 12 driving pci_assign_resource via sysfs)
>
> Hi,
>
> And who called _*pci_assign_resource(), etc.? I actually wanted to check
> the code... :-( Please don't strip PCI core related parts of the
> callchain.
>

Hi Ilpo,
Thanks for the review.  A clarification on the call chain, results
of running your suggested form, and a question on the right shape.

1. Call chain
The "..." in last mail was LTP module frames and the syscall layer,
not PCI core frames -- the chain hits _pci_assign_resource() in one
core hop :
    pci_assign_resource+0xe9/0x370
    test_case+0x202/0x6e0       [ltp_tpci]
    sys_tcase+0x51/0x80         [ltp_tpci]
    kernfs_fop_write_iter+0x117/0x1f0
    vfs_write+0x28d/0x450
    ksys_write+0x69/0xe0
    do_syscall_64+0xab/0x500

The trigger is upstream LTP test_pci. Patch 1 is reached via
sub-case BUS_SCAN (case 6, pci_rescan_bus()). Patch 2
is reached via sub-case PCI_RESOURCES(case 12), which on
every prefetchable MMIO BAR runs:

    pci_release_resource(dev, i);
    ret =3D pci_assign_resource(dev, i);

https://github.com/linux-test-project/ltp/blob/d631e9c/testcases/kernel/dev=
ice-drivers/pci/tpci_kernel/ltp_tpci.c#L428

> >      do_syscall_64+0xab/0x500
> >
> > This is the same SR-IOV-virtual-bus / self =3D=3D NULL pattern fixed fo=
r
> > pci_read_bridge_bases() in commit ("PCI: Bail out of
> > pci_read_bridge_bases() for SR-IOV virtual buses").
> >
> > Fixes: d09ee9687e02 ("PCI: improve resource allocation under transparen=
t bridges")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yuguo Li <hugoolli@tencent.com>
> > ---
> >  drivers/pci/setup-res.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> > index 991d3ed543f5..e8bd3d4ff923 100644
> > --- a/drivers/pci/setup-res.c
> > +++ b/drivers/pci/setup-res.c
> > @@ -353,7 +353,7 @@ static int _pci_assign_resource(struct pci_dev *dev=
, int resno,
> >
> >       bus =3D dev->bus;
> >       while ((ret =3D __pci_assign_resource(bus, dev, resno, size, min_=
align))) {
> > -             if (!bus->parent || !bus->self->transparent)
> > +             if (!bus->parent || !bus->self || !bus->self->transparent=
)
>
> I'd like to know if this should not break in case of !bus->self because
> I couldn't immediately find the code which would add window resources to
> the VF virtual bus so I'm not convinced this check is right.
>
> __pci_assign_resource() obviously must have failed to assign the resource
> if you can trigger NULL deref here so that hints VF bus does not have the
> resource that could parent dev's resource present (another explanation
> could be that it just doesn't fit there but I cannot say it based on the
> limited information).
>
> Did the resource fail to assign? What is the resulting resource tree with
> this change?
>
> The more approriate check might be this one:
>
>                 if (!bus->parent || (bus->self && !bus->self->transparent=
))
>
> --
>  i.
>

2.SRIOV VF and pci resource management

Yes, resource failed to assign. Confirmed on a system carrying
these two patches: cross-bus VFs end up with resource[0] either
0/0/0 or "start=3D0, end=3Dsize-1, flags preserved" (the residue
pci_release_resource() leaves), while same-bus VFs on the same
PF remain assigned, but the result comes from the generic allocator
on the PF bus, not from the SR-IOV slice that virtfn_add_bus()
set up. Either way, dev->resource[] no longer reflects what the
hardware decodes.

VF resources don't normally come from _pci_assign_resource(). At
probe time, pci_iov_add_virtfn() programs them as a deterministic
slice of the PF VF BAR window. So it is inappropriate to call
pci_release_resource()/pci_assign_resource() for a VF.

Maybe we should add an early bail-out on dev->is_virtfn at
the top of both -- with -EBUSY from _pci_assign_resource(), which
ltp_tpci already treats as TPASS, and keep dev->resource[] consistent
with the probe-time slice.
