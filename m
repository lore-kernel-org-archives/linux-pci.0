Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE255292B4B
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 21:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930081; cv=pass; b=RmKLK5kRd7/Lo9r2nt2ZwO8L0MCBvdBL/kd4G1GYalqiz3PdDhMV2CwkNG7n0LUbVNNMATj0CxtbhdFWJMHokEjFdBl7iM9PLJIQrCMiIe8c9qerdG3HMQAraO1YuKi90PvjMLvqlaYG0vZDC8LhfD+wc28PFQDxOPHtSA8jAa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930081; c=relaxed/simple;
	bh=hxJm0/mYjdYZeSe/3mr1gzaZCNknObJa6noZfD0Qc50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4iPVOue1O3OyOjn4N/D0LW+jkeTR63KIz8eezkgWMtsPQ/MMLJETslOI+c0id7THIavtibfir4W9Z2utyUOFugPOUl69byjSYlIQgDqcTdBsPWSkw6PDMVKK80YI0hEOshd4IVrPuX5riE9SxuCRMxJy7KZ6Ws2ReaHr2tXV5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ocg9pKWX; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ocg9pKWX"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so915558a91.3
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 14:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784930079; cv=none;
        d=google.com; s=arc-20260327;
        b=VGPoZgkwT8XHvq3OGZssuUraS1FjHCWhLfq6hV22qktvVrG+Bq3VFrDk3v6EIKsKwI
         w8CfSZ5uVqnTN99DiPKXJ0g8pveEpuznrmBonNbGRDPtcksKiDIHy138nXlNUdWY4Jz+
         hGffRrOaOo/rWtX/cBEbY2xR9p5ZNh3BPd0rpkKNn4SviZlZ/4065U+ChrMYbX0GkiXj
         aG8p+oZKzadCRVCCNB7JiW3NNNAwXzSWO5oBxOTJuHkTfcBA6UZwsIvP1ef50BPoyG8k
         Q8d+GAg7dD2QvFRyRmtdmwrnHSxj3Rkwa7PsoEuY8G/PIGqAAXze+eDyPPw4FqVDS3qg
         mTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/VuhMIt3y5/j6Le1Z4BNgwX3UBNQKNT5cbNU5pubERw=;
        fh=vevrsBXZIT9M7By9o1WA4QuY+/oC0JL3sL9/XWl/ES0=;
        b=UJw10UE9WK0eSY4AW5ONHyCAUA4x/E2KmafhHndXwxzqOYURah4a3Ouu6u/IlQmjlb
         Zqa252nQ8ZKkocknIdmgPSoqgCJj1DvIcHCS3RRKLv6RMZjPrrGfMNptwGjMQnCGx64s
         K3KjA4bVghWa5W+DlO/KSiaXPxtzifywqzC4jRagCvNAYnWmm1q5QIwls71czctNuDmc
         AS3PC7W8DG1hw30IW4DiUcmJT75pG9s9doWFPAQV9olNeMCIutgT4ACcMr3IGxSM5plC
         45miRvj9TJGRL6zplZzTissdpv/ZmxejCw6A/FnAZtw3uXltJJagBpOGvCLVH3QI2r4f
         xo2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784930079; x=1785534879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/VuhMIt3y5/j6Le1Z4BNgwX3UBNQKNT5cbNU5pubERw=;
        b=ocg9pKWXVMQHAbsSAA2HkdWmKgc8nzy3z1lceBWhsxnQEdjpwcFAWCXoUoonedX6Vt
         YBUrqMGb7uT0MOl8WJzKM5q+NS1kYPKu6ktrcHgNjQvYBd4RYBFsY8h+0MRcV1TAfsmF
         GLKGVU2IxMmzpkRNQ95I32ORauKa2VWl0L5rdhEwDzidYfxn9TEzv14jZnFkWS02N/bi
         P4IGlnthP6oLChgELfMG9lHKILhSk7TTM4at7PyL7/Pisjp7euOksLWIXqqIXCmMsAli
         4CncAvCgyVHMWeQ0dgn08FuNrGbUdFRTl++h/BgWvxoxuGNKoHWTtnTD8nJlHuDD6xLc
         Nkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784930079; x=1785534879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/VuhMIt3y5/j6Le1Z4BNgwX3UBNQKNT5cbNU5pubERw=;
        b=qVZ4GC/0pg7VmatGWlq+XT6UOYCH+Qherp7fa2U4+b2WP9nkcsa5EUcPKIAWQD+O2l
         MJfYgdGJZw6r52e1HXqS+/pOyKEnp6hkxQDylocUuRnuaXWXbSZfdh8lsiCVQ2+PrueG
         PFQO0DMKlQWK8Uc4rDcj09VVzdt7o9QnVJR+OiqH65fKQikSoOGD4WUTqY3FBpcGoNwW
         m/oYURcFXoXIqc3lKAYv36QSghH41sBoVzHGeVZUco89hAzPAaVmj8/6nEEo8PoW5BYO
         zfnGdRocyNau7j5ZNm3dkza0ULupY5P+nOHdWmh530P85u6SUUsVhxdkT332RqlJ/hpN
         Vtsg==
X-Forwarded-Encrypted: i=1; AHgh+RqH4uUJkWNoXXDGH74263PLcO2GUJpf7slJNFOYQrdNQGx9yDWZpbOFjpMKXyT5CobdPj0+yMUhbrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdzUqDL0I0MCusKDqAVh/K8gFZjPc4pofRiaC2L0VJ/QI6IJeM
	PktED9R3VkOMbNmcje7U4U4KRGrZuy50ESb/J7qWLv3MQodkQOFI4jp5s/XqBGGAV6RrP1jhzMb
	aJmJ6veNh/t3pkeAGu2Vf46BOhJvQ9Kv83S7EOltU
X-Gm-Gg: AR+sD10bqmFGfqp3zkizUx/KxxiwdIdPI3m0JcGY2dpWm8m9BprdClTB40MtuQk8EzL
	ol7YL1dhMfe5Db/LRYX7bnTAtGRjz7rRY4EVP1fCYM/q7vIem2alsCNU8jau2wwAGdaZYdLUL4M
	RXYGnMGLGA/VHmXKm2+fZAiYc0ivFqYPeiye9Ks91wAbWhbhgoo/XySdVX+RFBjHB/uxkMswv04
	7RZYbGlTDcljWVI8oKm7Unm3EnTw0PAsY688ee5sH2b9NGW73UZnBzMvR5dYQ==
X-Received: by 2002:a17:90b:3f0c:b0:387:e0bb:57f1 with SMTP id
 98e67ed59e1d1-38f2975d581mr178977a91.34.1784930078557; Fri, 24 Jul 2026
 14:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710212616.1351130-7-dmatlack@google.com> <20260724205506.GA1012423@bhelgaas>
In-Reply-To: <20260724205506.GA1012423@bhelgaas>
From: David Matlack <dmatlack@google.com>
Date: Fri, 24 Jul 2026 14:54:11 -0700
X-Gm-Features: AUfX_myY_bxyw4-P1Rbrabgs4s-tLloBKDJhDTUU1nvReA0LfPMvmIQUGRTYqPg
Message-ID: <CALzav=c8amq1hTRCwHbQOZvhNKtissagzzXX+RGeRgUiKPOcbw@mail.gmail.com>
Subject: Re: [PATCH v7 06/12] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 1:55=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Jul 10, 2026 at 09:26:09PM +0000, David Matlack wrote:

> > -static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *out=
going, struct pci_dev *dev)
> > +static int pci_liveupdate_preserve_device_again(struct pci_dev *dev)
>
> Could pci_liveupdate_preserve_device_again() be folded into
> pci_liveupdate_preserve_device()?  That's the only caller, and having
> so many *liveupdate_preserve*() functions gets to be a bit of a maze
> of small functions:
>
>   __pci_liveupdate_preserve_device
>   pci_liveupdate_preserve_device_again
>   pci_liveupdate_preserve_device
>   pci_liveupdate_preserve_path
>   pci_liveupdate_preserve
>
> Maybe even more could be squashed; pci_liveupdate_preserve() is the
> only caller of pci_liveupdate_preserve_path(), which is itself the
> only caller of pci_liveupdate_preserve_device().
>
> As a reader, I think there's some advantage in collecting the whole
> "preserve" flow in one place, but maybe nesting depth would be an
> issue, especially for the unpreserve cleanup in the failure path.
> Maybe a "goto" error path could mitigate part of that.
>
> If there's any squashing, I guess the place to start would be in
> earlier patches, e.g., "PCI: liveupdate: Track outgoing preserved PCI
> devices" and "PCI: liveupdate: Track incoming preserved PCI devices".

I'll see what I can do in v8 to avoid splitting the
preserve/unpreserve logic across so many functions. I suspect it can
go from 5 to 2-3 while still having a reasonable amount of nesting.

> > +#define for_each_pci_dev_in_path(_d, _start, _end) \
> > +     for ((_d) =3D (_start); (_d) !=3D (_end); (_d) =3D (_d)->bus->sel=
f)
>
> I think you might want pci_upstream_bridge() instead of (_d)->bus->self;
> see https://git.kernel.org/linus/c6bde215acfd ("PCI: Add
> pci_upstream_bridge()").  I think VFs are currently out of scope, but
> no harm in making this future-proof.

Yes in fact I noticed pci_upstream_bridge() while working on other
changes in v8 and already swapped to it :). It also makes the code
more readable.

> Other than "_end", this looks fairly generic and might be a candidate
> for putting in include/linux/pci.h.  I think there might be other
> potential users, e.g., calc_map_type_and_dist(),
> pci_enable_atomic_ops_to_root(), pcie_bandwidth_available(),
> get_upstream_port(), pcie_find_root_port(),
> pci_is_thunderbolt_attached().
>
> The "_end" termination case could perhaps be done in the body instead
> of the macro since it depends on the use case and several of the other
> loops that iterate over the path already include terminations in the
> body.

Sounds good. I'll move it to include/linux/pci.h and and handle _end
in the loop bodies. Then once this series lands I can send a follow up
to convert those users to use the new iterator.
