Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C62D30F531
	for <linux-pci@vger.kernel.org>; Thu,  9 Apr 2026 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775705977; cv=pass; b=MktshLUOM+Z1ccE0A45K9DqF2Cx8VPGGX6kiYHfn4kuD7yxj34TXZQ58cTbKZRcP2KDIDupZB6j8CmG+4hBUEaFglqJLvzFh16jUGkuRqJOXJx/5xBYVVdunrX2udNZj3+4xMjFU4qI2qkyZoLx+xzHUF6dYDz62eioaDRks7bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775705977; c=relaxed/simple;
	bh=ipzqqbtUTjTUXelIrvbr406hnlHtjj80FJssP+iGieM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfagSLsnreKS7wao918xvIqiXwqelwzSaxZRbx6zJ0x5jKdRXn1I+qKE5n2fWfTmY2gWGjrJjMBv2s78dDscFolI+9rkBQDJHr8DQ5iXDrda86Dmdpeb/Hj1I60V/2NMnU2JGPqh3PuOaflNCvKltgPu4iyuXfcD8pilDK/HwuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/m5kjUA; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/m5kjUA"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66bf6aa4858so669961a12.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Apr 2026 20:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775705974; cv=none;
        d=google.com; s=arc-20240605;
        b=eRXSVz4qZxkrslNcDYKU3SveiC+VgsjOMNIOEc52JQv8BA/jZaJ7lLwUhyMeCH/eJT
         ZDRbZ1DBjep7w6yrb2U7w+YSNNft9LIOm0cFa0fRJ7cOsdV6KRWU8rdRBfgcZsI3K9lg
         mzxno7guJOg6si77236i8KWne769786/F5yDggCBGDFEkVZ2KvTf0+t96XZ/EFcp00gX
         vrsNMpOGYScAAhvdYTBnxxNT7jVcb+cVmz1y3+M2mQ00Tgmqo8xH8xqkv9r6nJmOqXxg
         g/rwCTsi70CSLmz/JuZJi2QemPM8lhGaU0aBcb8JDdO/tGZ7JjEXeSG5jfUG4jjELy2t
         y/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3nK2rPjTD2J2hcTM4BMrIGnDtvubzv9T1WI+OHmAy3g=;
        fh=/ce8A07YVbLrLu1fh0268iEtReRrOTYEfLXqpv735GQ=;
        b=GcmQwxectwqwQFuhIPm9AwLV01Ud8iONZb7S50pahnIG5Eu8k/Dvvnxuw3Bc9ZbEBx
         4MT0eo25WN3kBJ+eOAC5NSV1ON5jtbTap6CLLDUc2io7pzi9JEPaIIvGC2GXQEFTHM/o
         BdtSgcRpCki8n6tZxzbsrJMRNN+jLwj3cnnlIeXIPHOCwzUjJW7mMNr3Bkp8y8XU/Hpi
         VJIZYL4E/2pv+xjU3deFC/B2U64vTXECmBYB42MBzVfm31+Df/C3eYmsJ95voWjXMmZC
         Ty+u2pxJA6rjW/aU69AfBxYGWUaKqgpWGwP16Yfktm6l3HFL1eShvpTZdVKlZ2p/qG6t
         lGBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775705974; x=1776310774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nK2rPjTD2J2hcTM4BMrIGnDtvubzv9T1WI+OHmAy3g=;
        b=r/m5kjUASiqAbHtDa6Rpw4MiO3QxDjcYQrkoPIxQhSEt8OhFq432UurTa9db+6rMR4
         1tSQCN+pH0oShWSsQVEBe9gNS7A1a72NTkMqJ4XsEL4nolY/THohvyHZDQq5+J6r+sLO
         ywxKgQCCbqxcz4+QvY5yjPpFGuPwnT1/eYwLK3sS2cTQeOatR7eEdiAtOs2rXSH4gv55
         IN6sjFfEPANe5sF+KDe3aLe02/t7JIy1StdLK//FbvorQO6UnLneZpVovVWgAcf4sCgx
         ADvPKCPKt7HTGaj6dBjZggXk92GosIxJgGEh7UiH02CTbg7ugtYXohith8SrwDnpryzs
         ggNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775705974; x=1776310774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3nK2rPjTD2J2hcTM4BMrIGnDtvubzv9T1WI+OHmAy3g=;
        b=QGzz3SfvHWALDomh9uPYhkQIAbs4MuTsdFqg35RCPvmqnEIojbWJ47xPGSV5KZdESk
         qMUHUazzEVM0DSU4zx11fgNaKtC65bVpW4oDLNSAxA+3+pRAk/H5saogqbbcoFYTs7KW
         yrR3VFngmcBHxvIZAKE8AiT5BUUVBuL1Xvjv00zZPXgjDN9vvsnyAp7c8+sKfcmIZK40
         xHRzmbKOg3yc+9Ho1BMRP4eb9U4qyv1MKmlFkCUsZBMzM/GNDBUn7A3l+xx2aSqOcpHB
         Idgc6LJSHdx5MzxZkFDqpEz47iFvpbzPfCwqooeuM+5LhYnvPQ/P45nTroZaSc6nxopp
         4dYw==
X-Forwarded-Encrypted: i=1; AJvYcCVgNmwnK8RMHL/o10xlxWt4I9hsYxWNibVu4yXbPPXZn7mez0hfhNyRMFpGndibZumxjgEGOJp5nCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmB6BzsMSIF3Y5+qMP5ns8Mz7+eoSLlneZWo8h/GD1Pkp5Q319
	6XaJfwRh8evfFkjZJCUMaveE1g9Bg57gVjIBMHxpBFM5CPEYKNU3iT1ZuAHzAj1dCugCzGcZnEp
	gBf3IJnjandM9gVOUGeR0P5NcK3aHrgw=
X-Gm-Gg: AeBDieue0VcDKAdwGZasOWK53xkIurD1Bxeed8I/Aeo7rCSo5xBCI/JtlmEnCuQMi0F
	TAojBrjMCveSkk1vjQjqQV5g3P/TBsY2WkdkOyWwHIWB5dl9j0iS0aRL0Ypx4rKcp31XGl2nBk4
	0B0/vtUU5ihAYtLq5ygK8mto9IQZ4PMOLhZFqp6Off++OMjSadYQCW6oR+LO8nftXTZKRhQ5FZx
	GrLYZ6t6s1XTE6BS6ntavxurnr63WJlXreMyopfknK6Z15sBHCotl5AIqMcb32dz/e9JXyUU6Aw
	SobAA1lFy/vxW/zHkhSkfeqIx06/JTnl0mTcDg==
X-Received: by 2002:a17:907:96ac:b0:b97:d126:c007 with SMTP id
 a640c23a62f3a-b9d4766357cmr74156066b.30.1775705973292; Wed, 08 Apr 2026
 20:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com> <698d6b7faa190_2e57100d3@dwillia2-mobl4.notmuch>
In-Reply-To: <698d6b7faa190_2e57100d3@dwillia2-mobl4.notmuch>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Apr 2026 13:39:06 +1000
X-Gm-Features: AQROBzBMdVWviJ7UQPVJiSjzXhX3MyVPNdI2Nycp2rCssuJJohwu6SX0ICGXpZw
Message-ID: <CAKmqyKPyR165rACXRMJXgyUOp6OUdQqSsym-gfYVFnKLZ4ednQ@mail.gmail.com>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
To: dan.j.williams@intel.com
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

On Thu, Feb 12, 2026 at 3:56=E2=80=AFPM <dan.j.williams@intel.com> wrote:
>
> alistair23@ wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
>
> Hi Alistair, quite a bit to digest here and details to dig into. Before
> getting into that, I will say that at a broad strokes level, no immune
> response to the core proposal of depending on a Rust SPDM library and
> forgoing a C SPDM library.
>
> Most of that allergy relief comes from how this organizes the C to
> Rust interactions. The core SPDM implementation calls out to C for the
> presentation layer (Netlink) or is invoked by sysfs. That makes it
> amenable for sharing those presentation mechanics.
>
> Specifically, my primary concern is integration and refactoring
> opportunities with the PCI TSM implementation [1]. The PCI TSM case
> should use the same uABI transport for requesting + conveying device
> certificate chain, SPDM transcript, and device measurements as PCI CMA.
> Note that in the TSM case the SPDM implementation is in platform
> firmware and will bypass this library. The TSM SPDM session is mutually
> exclusive with the CMA SPDM session.
>
> [1]: http://lore.kernel.org/69339e215b09f_1e0210057@dwillia2-mobl4.notmuc=
h
>
> > Security Protocols and Data Models (SPDM) [1] is used for authenticatio=
n,
> > attestation and key exchange. SPDM is generally used over a range of
> > transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
> >
> > From the kernels perspective SPDM is used to authenticate and attest de=
vices.
> > In this threat model a device is considered untrusted until it can be v=
erified
> > by the kernel and userspace using SPDM. As such SPDM data is untrusted =
data
> > that can be mallicious.
> >
> > The SPDM specification is also complex, with the 1.2.1 spec being almos=
t 200
> > pages and the 1.3.0 spec being almost 250 pages long.
> >
> > As such we have the kernel parsing untrusted responses from a complex
> > specification, which sounds like a possible exploit vector. This is the=
 type
> > of place where Rust excels!
> >
> > This series implements a SPDM requester in Rust.
> >
> > This is very similar to Lukas' implementation [2]. This series includes=
 patches
> > and files from Lukas' C SPDM implementation, which isn't in mainline.
> >
> > This is a standalone series and doesn't depend on Lukas' implementation=
.
>
> So, I *am* allergic to how this series references Lukas' work by
> pointing to random points in his personal git tree. I trust that was
> done for RFC purposes, but it would have helped to call that out in the
> changelog and set expectations about the ideal path to coordinate with
> that work.
>
> > To help with maintaining compatibility it's designed in a way to match =
Lukas'
> > design and the state struct stores the same information, although in a =
Rust
> > struct instead of the original C one.
> >
> > This series exposes the data to userspace via netlink, with a single sy=
sfs
> > atrribute to allow reauthentication.
> >
> > All of the patches are included in the RFC, as it depends on some patch=
es
> > that aren't upstream yet.
> >
> > Now that Rust is no longer experimental I have picked this back up. If =
the
> > community is generally on board with a Rust implementation I can work o=
n
> > sending a non-RFC version and push towards getting that merged.
>
> As long as this stays explicitly designed to minimize exposure to
> "refactor across language boundary" events (as initially seems to be the
> case), then it seems workable.
>
> > The entire tree can be seen here: https://github.com/alistair23/linux/t=
ree/alistair/spdm-rust
> >
> > I'm testing the netlink data by running the following
> >
> > ```shell
> > cargo run -- --qemu-server response
> >
> > qemu-system-x86_64 \
> >   -nic none \
> >   -object rng-random,filename=3D/dev/urandom,id=3Drng0 \
> >   -device virtio-rng-pci,rng=3Drng0 \
> >   -drive file=3Ddeploy/images/qemux86-64/core-image-pcie-qemux86-64.roo=
tfs.ext4,if=3Dvirtio,format=3Draw \
> >   -usb -device usb-tablet -usb -device usb-kbd \
> >   -cpu Skylake-Client \
> >   -machine q35,i8042=3Doff \
> >   -smp 4 -m 2G \
> >   -drive file=3Dblknvme,if=3Dnone,id=3Dmynvme,format=3Draw \
> >   -device nvme,drive=3Dmynvme,serial=3Ddeadbeef,spdm_port=3D2323,spdm_t=
rans=3Ddoe \
> >   -snapshot \
> >   -serial mon:stdio -serial null -nographic \
> >   -kernel deploy/images/qemux86-64/bzImage \
> >   -append 'root=3D/dev/vda rw  console=3DttyS0 console=3DttyS1 oprofile=
.timer=3D1 tsc=3Dreliable no_timer_check rcupdate.rcu_expedited=3D1 swiotlb=
=3D0 '
> >
> > spdm_utils identify &
> > sleep 1
> > echo re > /sys/devices/pci0000:00/0000:00:03.0/authenticated
>
> So this is where it will collide with TSM that also emits an
> authenticated attribute. See Documentation/ABI/testing/sysfs-bus-pci.
>
> The rough plan Lukas and I worked out is that switching between TSM and
> CMA based authentication would use sysfs visibility to coordinate. I.e.
> TSM to CMA conversion hides the TSM "authenticated" attribute and
> unhides the CMA attribute of the same name.

That seems straightforward and is already documented upstream as well,
so that's pretty easy.

>
> The most significant unsolved point of contention between TSM and CMA is
> the policy on when authentication is mandated and the driver probe
> policy. The proposed model for enforcing device security for
> Confidential Computing is make it completely amenable to userspace
> policy. Draft details here [2] to be refreshed "soon" when I send out
> the next version of that.
>
> [2]: http://lore.kernel.org/20250827035259.1356758-6-dan.j.williams@intel=
.com

CMA will eventually need to support some sort of drive probe policy as
well, but that can wait until later and isn't going to be dealt with
in this series.

>
> To be clear I am ok if there is an incremental option to have auto_cma
> and/or auto_tsm that arranges for authentication or link encryption to
> happen without asking. I take issue with auto_cma being the only hard
> coded option.

I have been working through all of the comments and discussions and I
think I have addressed everything, except for this one.

To summerise, is the high level issue is how do we know if we should
use CMA or TSM?

Do you have any more thoughts on this?

Alistair
