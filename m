Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8EA30C35F
	for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2026 05:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776058981; cv=pass; b=WsfTdTxg69qXVCDHdq1qAY/qX4xnTjqLkVa+FZ+chk5QXVNQyiFIA2J+NMmALfxmMCnsdZotZ3nUS+twjYXtXVPQreZ7e87nKGsxo/0fwDvP0u8ojKenY1useqrESdWy4+PjB6oFLI/i8b622Vv1YDQoDDQfl8TVgAOKMkDFWQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776058981; c=relaxed/simple;
	bh=dAn0LMJ8LSrZnwznsiD1+TQY7yIAyTPX5qsVMG4SqtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8HEeNz2Wk1mnxoCVDSvP7JDyVPQ4MROmZ58Uf8iVxMTYrTsNDh833MzQvj+Qv8u07EAKrwZw51UOWUu2mMfrqNK9PnyqUd1vm996BHqsbOdBYSt1gh1oYoCrqA2fBNKUjkwkYC83ojAPfgnEWS1N4kCI2lG9WzLlP0ffPAMGtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYYHrDJV; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYYHrDJV"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8f97c626aaso620485866b.2
        for <linux-pci@vger.kernel.org>; Sun, 12 Apr 2026 22:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776058978; cv=none;
        d=google.com; s=arc-20240605;
        b=UnaciC4UsIwyuvhF/JMWVU4RC69FIGAws6utIwkFUSsRe0vbviQ6Emc9VpuH4S/wzP
         Ugn39QCek9dQk0EtlKwmHX6ZZ3zQwKPCTpAGLRLE76BzYxMbeeMrmbabjmTxaHw074RV
         kapfqhP46JuQ01gb6zpE2aQuhyNE3W3b0LAnoguLFpsyYbV13hysBPsRfHqDC7x7eIME
         QNn96yGTeyFSYG0Dr0fZu871D/vhmfz7/vFtpojOf48EF2fjgxpZNawDSbkeDorM2DOC
         KF579+AKqkJ9gFL/bEtWWd4oARD2ExZ3rkPg1V1Arm6VAlB5GYK2M58SFPOiS/0nh0fW
         cunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LCK902ZEqjdW+lUbQsLeaFO8ujBemNd6Hq/l8OuysNg=;
        fh=86J6+GdfT+hlVHAcjUwLxFVHVLBI2kpsqcbRFH9YepE=;
        b=WTGoClwe5t54Pu7P/8NLMlCvGmKez7xRXOznFNOaSTCwh/eEpTzTPJdyqbDZ8WF+0Y
         v5lYo8WDF7lDdZ/HRjYX6ZiUkxX8kO56N2T0Mtx0MOPzdUT1pBR6ysfroya8KaJRXSOR
         GudnLzQD7/ACoxZIGtQ/3QJVNsg7Usoo0ZOlVo2Z5U8A5wE+t/2Eiy53fg892tO1AzJj
         CY3zyAsJQSXKPlFH7qG5jK/3RJlWAbpVJYwgVzArDz9ppUVeoIhVvergxREpHIsJxuVC
         oTtozWh/9JK9d7oCCVXWWUZhQv3RNMSuc8fzADKywNuuy9vRIXBAsd5JQuouu/K/0Wwp
         z9PQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776058978; x=1776663778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCK902ZEqjdW+lUbQsLeaFO8ujBemNd6Hq/l8OuysNg=;
        b=IYYHrDJVT8GQjg1BGIR7Sm0j3OdQFYIozG4SbQuIh0xQlVG5Cxz32j6bOuq87GX00Q
         zMoFusEKYCeIbsEvOeeZuFqghEO1tx1fX0c5Tmce+6vvkMTDuB95VqTi/B7w9wEt1fCu
         y9qddJ/VKCOaZe+wBEzdhCLjR4IocdzR+jdLDIthRM3SyXdR471SLTiC1SFcDkWYBxaJ
         Qhd3ZAmXz9xp9AtZa5hiP2FsZrRYM21KnZy8rrnFlE00V6HZNv6Qg2h4Imk3wBOXQNgj
         TtfAN7ye5Q1fTbSd0gKnY9djdjhkWCqzJv0dGd9QjUSnSzPTZlk3v7DpPKZYFQLJeZb+
         IfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776058978; x=1776663778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LCK902ZEqjdW+lUbQsLeaFO8ujBemNd6Hq/l8OuysNg=;
        b=JXKx2xCoWuEjVY7ItsotN8OxQ18WchsIULLwXhcDIR2KNIklouf4s8s0c1ZZn8HfS7
         Vy3EgeFexjZCKyEo5zA3Toyu8zWkng9EW2NbXxsvCSTwnbH62/iHeKBkS9+BXjNSfFyM
         msPpU7WLIfnA8jkT5ZbetNxboJTNgZY0x4XQYe/UD15dIDw5miZ8w9ehxrnQlfzOuiDL
         c9Yf2vg55sd4ivRgl+q/ySavn2VX6s2e6dK0leF6CJEnJxFzqXlwCQk+GC2UVtpxqlyL
         lesL3n3PxZrLO0EBsAphHvRWmnrtVVSe+SorAYP6/JGexpPHJB2jZg5VbhIVUvE4MmBt
         IeSA==
X-Forwarded-Encrypted: i=1; AFNElJ/+RtwM+AkMLuZo6CxQBbJxw99S0jYW9pNFtHJ9KGLQdLWlsZ/wRNcM7/WuRGoK+0Ded8cHHkx4CAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqflSbliY9yQZM3ieKk6BwgcDfvbk7uEUctKL1BIJ6brIXv7zC
	/TizDMfmTLQ7N+L+XEgiGSRdtU173fASlWsXZcCZDRiiedax4UZcbPblYc7pIPfCpHx3ei9iHB3
	gun7as4NY5lvp49I6FF+3hzy3I5gcngQ=
X-Gm-Gg: AeBDievUHX1RwBvn+SEKxsSCX8GAuxZyczFg8L/K/x5WhAMEKcEkJRmlwHjR1/edQ33
	fAf7IDxIvremHdIT27Fzc8WTGnr3BmWXxTkn4u7RHTDvhSksxWbhQTX7Elr21DjfNkBZ6Uk2gkr
	D9TKKsOFGAK2eQK/tkN0aAxbMAnjaW4IJQUsdhBTQtb/j+LOOC9D5qETf5WBQnuEs/6WeRcM9DN
	BS5ed4aKCChv5HjYCYA3uG2KQytHWHGLT27Z2vxoMjSVhb5YVM7gLcGNBFaNbW0q7NMBz1EHKhd
	svGgzb+HS5Agr9ZShHLZpoO02zYheshV0+RhKg==
X-Received: by 2002:a17:907:9707:b0:b9d:f5fd:a783 with SMTP id
 a640c23a62f3a-b9df5fdb0e4mr35246866b.7.1776058977652; Sun, 12 Apr 2026
 22:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <698d6b7faa190_2e57100d3@dwillia2-mobl4.notmuch> <CAKmqyKPyR165rACXRMJXgyUOp6OUdQqSsym-gfYVFnKLZ4ednQ@mail.gmail.com>
In-Reply-To: <CAKmqyKPyR165rACXRMJXgyUOp6OUdQqSsym-gfYVFnKLZ4ednQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Apr 2026 15:42:30 +1000
X-Gm-Features: AQROBzDQwMVyFaPUY8I-CycOp1IR9F8ypWP8Im0wi8xPIs5LdfP2T-ajtC_R_oI
Message-ID: <CAKmqyKOU-chxmNfNV11Dx7_zmQQ+kqK2eFtT1unsVQy1dsW7rg@mail.gmail.com>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
To: djbw@kernel.org
Cc: bhelgaas@google.com, lukas@wunner.de, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, linux-pci@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 1:39=E2=80=AFPM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Thu, Feb 12, 2026 at 3:56=E2=80=AFPM <dan.j.williams@intel.com> wrote:
> >
> > alistair23@ wrote:
> > > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Hi Alistair, quite a bit to digest here and details to dig into. Before
> > getting into that, I will say that at a broad strokes level, no immune
> > response to the core proposal of depending on a Rust SPDM library and
> > forgoing a C SPDM library.
> >
> > Most of that allergy relief comes from how this organizes the C to
> > Rust interactions. The core SPDM implementation calls out to C for the
> > presentation layer (Netlink) or is invoked by sysfs. That makes it
> > amenable for sharing those presentation mechanics.
> >
> > Specifically, my primary concern is integration and refactoring
> > opportunities with the PCI TSM implementation [1]. The PCI TSM case
> > should use the same uABI transport for requesting + conveying device
> > certificate chain, SPDM transcript, and device measurements as PCI CMA.
> > Note that in the TSM case the SPDM implementation is in platform
> > firmware and will bypass this library. The TSM SPDM session is mutually
> > exclusive with the CMA SPDM session.
> >
> > [1]: http://lore.kernel.org/69339e215b09f_1e0210057@dwillia2-mobl4.notm=
uch
> >
> > > Security Protocols and Data Models (SPDM) [1] is used for authenticat=
ion,
> > > attestation and key exchange. SPDM is generally used over a range of
> > > transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
> > >
> > > From the kernels perspective SPDM is used to authenticate and attest =
devices.
> > > In this threat model a device is considered untrusted until it can be=
 verified
> > > by the kernel and userspace using SPDM. As such SPDM data is untruste=
d data
> > > that can be mallicious.
> > >
> > > The SPDM specification is also complex, with the 1.2.1 spec being alm=
ost 200
> > > pages and the 1.3.0 spec being almost 250 pages long.
> > >
> > > As such we have the kernel parsing untrusted responses from a complex
> > > specification, which sounds like a possible exploit vector. This is t=
he type
> > > of place where Rust excels!
> > >
> > > This series implements a SPDM requester in Rust.
> > >
> > > This is very similar to Lukas' implementation [2]. This series includ=
es patches
> > > and files from Lukas' C SPDM implementation, which isn't in mainline.
> > >
> > > This is a standalone series and doesn't depend on Lukas' implementati=
on.
> >
> > So, I *am* allergic to how this series references Lukas' work by
> > pointing to random points in his personal git tree. I trust that was
> > done for RFC purposes, but it would have helped to call that out in the
> > changelog and set expectations about the ideal path to coordinate with
> > that work.
> >
> > > To help with maintaining compatibility it's designed in a way to matc=
h Lukas'
> > > design and the state struct stores the same information, although in =
a Rust
> > > struct instead of the original C one.
> > >
> > > This series exposes the data to userspace via netlink, with a single =
sysfs
> > > atrribute to allow reauthentication.
> > >
> > > All of the patches are included in the RFC, as it depends on some pat=
ches
> > > that aren't upstream yet.
> > >
> > > Now that Rust is no longer experimental I have picked this back up. I=
f the
> > > community is generally on board with a Rust implementation I can work=
 on
> > > sending a non-RFC version and push towards getting that merged.
> >
> > As long as this stays explicitly designed to minimize exposure to
> > "refactor across language boundary" events (as initially seems to be th=
e
> > case), then it seems workable.
> >
> > > The entire tree can be seen here: https://github.com/alistair23/linux=
/tree/alistair/spdm-rust
> > >
> > > I'm testing the netlink data by running the following
> > >
> > > ```shell
> > > cargo run -- --qemu-server response
> > >
> > > qemu-system-x86_64 \
> > >   -nic none \
> > >   -object rng-random,filename=3D/dev/urandom,id=3Drng0 \
> > >   -device virtio-rng-pci,rng=3Drng0 \
> > >   -drive file=3Ddeploy/images/qemux86-64/core-image-pcie-qemux86-64.r=
ootfs.ext4,if=3Dvirtio,format=3Draw \
> > >   -usb -device usb-tablet -usb -device usb-kbd \
> > >   -cpu Skylake-Client \
> > >   -machine q35,i8042=3Doff \
> > >   -smp 4 -m 2G \
> > >   -drive file=3Dblknvme,if=3Dnone,id=3Dmynvme,format=3Draw \
> > >   -device nvme,drive=3Dmynvme,serial=3Ddeadbeef,spdm_port=3D2323,spdm=
_trans=3Ddoe \
> > >   -snapshot \
> > >   -serial mon:stdio -serial null -nographic \
> > >   -kernel deploy/images/qemux86-64/bzImage \
> > >   -append 'root=3D/dev/vda rw  console=3DttyS0 console=3DttyS1 oprofi=
le.timer=3D1 tsc=3Dreliable no_timer_check rcupdate.rcu_expedited=3D1 swiot=
lb=3D0 '
> > >
> > > spdm_utils identify &
> > > sleep 1
> > > echo re > /sys/devices/pci0000:00/0000:00:03.0/authenticated
> >
> > So this is where it will collide with TSM that also emits an
> > authenticated attribute. See Documentation/ABI/testing/sysfs-bus-pci.
> >
> > The rough plan Lukas and I worked out is that switching between TSM and
> > CMA based authentication would use sysfs visibility to coordinate. I.e.
> > TSM to CMA conversion hides the TSM "authenticated" attribute and
> > unhides the CMA attribute of the same name.
>
> That seems straightforward and is already documented upstream as well,
> so that's pretty easy.
>
> >
> > The most significant unsolved point of contention between TSM and CMA i=
s
> > the policy on when authentication is mandated and the driver probe
> > policy. The proposed model for enforcing device security for
> > Confidential Computing is make it completely amenable to userspace
> > policy. Draft details here [2] to be refreshed "soon" when I send out
> > the next version of that.
> >
> > [2]: http://lore.kernel.org/20250827035259.1356758-6-dan.j.williams@int=
el.com
>
> CMA will eventually need to support some sort of drive probe policy as
> well, but that can wait until later and isn't going to be dealt with
> in this series.
>
> >
> > To be clear I am ok if there is an incremental option to have auto_cma
> > and/or auto_tsm that arranges for authentication or link encryption to
> > happen without asking. I take issue with auto_cma being the only hard
> > coded option.
>
> I have been working through all of the comments and discussions and I
> think I have addressed everything, except for this one.
>
> To summerise, is the high level issue is how do we know if we should
> use CMA or TSM?
>
> Do you have any more thoughts on this?

+ Dan's Kernel.org email

Alistair
