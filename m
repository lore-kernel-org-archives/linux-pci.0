Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C382345741
	for <linux-pci@vger.kernel.org>; Mon,  6 Apr 2026 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491608; cv=pass; b=aulMekya+jRQtFp2kyxlnipph5HRwqI8zixkrGwEWHJ+ORuCCdX0e9dfo2u/RlRWANT0CrnoJRhP4X8EnfH3579M+XP3YtNTOxc0h/VOJ4GQzSTPzapp9wnNvqhnmBCIyj+LdYQtVNsvo9HgpcYED+160+338FmxlsDNUw31igA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491608; c=relaxed/simple;
	bh=0mfv2q13bWahVT0s2waY/ovs1AueK0bCMf6E6tJ8ke4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3UnyPr/uj49TePZBTPemnTUhNjB7a/Q4dXkesofx/wFTG1HvC0TfBx+gdaSkkTGd4JeweDVNEV+AGpO/Ml57rgKcLJ8pwunBePi8datEJ/UO5zAeMUFCAmNAdWAm/Ab0PygiwVvAkElt0AEQ7G2sZRvW9NG2jKknWaI1LITRQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IwnwHUVD; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IwnwHUVD"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38ce0ab821cso29698811fa.0
        for <linux-pci@vger.kernel.org>; Mon, 06 Apr 2026 09:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775491605; cv=none;
        d=google.com; s=arc-20240605;
        b=dpHlFy4aUgsIBYh6JPUtlFgnk1oMhoAm68jMdJ3FEonUme0rq8lLkeNfkRvKk1uWF8
         QDmQxM+zAnS1yh79N9EMXTwHqrQiTA6asmWDiFQq4kN6GdvrBKJywsZzvXTADKFEVc1C
         BhtQfdbvs3Ai+4kvuClhHAe9Eg+MruPuqhF9lkDiVqtXMXvGoqkUZ8Y+fOmKP1GdTK5z
         P+WXV6HJc2EjpF72FX+nrRZwAjvLL9py2V1bMHRlHiLH5g6id5ppKJgtSpcAZT1iPVee
         jkJleqp6eWZmly87eAxiTuqauS0/0azUVh81bE2oVJdSkW5oUxMiwbZx7dto7thIjDeT
         Yn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cOKcd1E+kh/rgDmBatc+5AEkevvJqYiqh34IKuXZ368=;
        fh=pUGjvtmlSoCk2NZLgH8ftKAvy8UHx43iBNUVhLtgqvM=;
        b=jH4h6Cf5dzklTPPx4qaBpK5Jco7mfDEUq2JBCnKMHjll2URkIMQcDLFAwayKekxk1C
         aW6sRL3jp91+Bn5pb/5UbemozmMJ9lPYoiNZAa6NS/2kr5W8C0+UgmXJdQCThkG892zK
         ac+1LL1RHPRviVlH8dxS4u5cDiqT+7A3ftr5tnhUUVHngCxDwx3SfFh7DNuokvuBxZPI
         Jxf/OE9+wABG4IV1WR4B0xXK00uLTy+GsBW47MF2lE5sN6qz1arU/jsyrTNKrLvp6pvq
         lymtseo5NzR4N7oCskCuFFqp4MMPColHAY6RqGBCSTIE/zeRVIT5CpoXyCIsxyNVJBf3
         ACrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775491605; x=1776096405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOKcd1E+kh/rgDmBatc+5AEkevvJqYiqh34IKuXZ368=;
        b=IwnwHUVD2T4Xb+Dd46BueA+Str+szIapn/Y+fyFgQSwlj6mjzlptehM1Sg6sFr/dwP
         3/Y1pkp2MwvbGzpNJKsRRCMnPF4yISFdb1OZv23yZ7I7QZgSWRjtI+UkYbPLzAUNkXhw
         k7dgJGyqBsf48qQdKVz/KPE7CvG1T4JyZDRV/4/3numJsXFFE8ATg28Ku7sq8l9Ns5wR
         aMXQgJT++ZZAj6Jq4q53P43tlh1BPBlIupFJOFOkGTTdquFzsj4NJtEubzYunEHrbwr4
         Pj6Q5vptSf57UeMe8W+fBnqjBlh5WRfD7UwDgIrJ0Szmz1FrYU0sZzEQocx3URM+s4uc
         RSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491605; x=1776096405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cOKcd1E+kh/rgDmBatc+5AEkevvJqYiqh34IKuXZ368=;
        b=rKuvujOFrAyPWA9KUcM65suJqyMYefgH7SgwSRfmSHqIeddDFX/v2YEWWWOPv6xofZ
         lOBfNectQavg4glW7Db2OSeJ1cpSJHwBTWBn52TPF9VZSGmYj9IcXEdxKKJ4NxsoMmfe
         Eab25qBHnTlDDjSN+c5XIZ9tMrop2E68tJwlAO1B+ioYUvZNfVOLSLgazpq/y1nh0fbz
         LwHZSK/xhWKyl5Q5YKRYr4JrNsnkyt9WUdWI17XUl4Esr6HsOr6RpHdRjtGOaW5bADSd
         Vmki5lFjc67pgbWszBU3692x+ZjiE/ybfdm0+pUeZ5Y2Z9zmlhqz/j4+ddYeY0KSxg8K
         kPwA==
X-Forwarded-Encrypted: i=1; AJvYcCW2QMW2D9vHhGvO0tnobeXw9ifOFfLmRWrfQUaTqswHOd86G4AmkKZlIaWOIrl4ZFsXLW4jjwFQbaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUT2a9kYofNgptCWCez8UJsVnADOw0EKTtBJ4l46gLnzIWvx8q
	5HZi51xjiIuD/N6av/wXLQl+vvyJ1rFzN3FPJRKwUS6Dhgka5qTufceAgB4xRh+ApHLWRHgjh0k
	CczOaOP9E0LGOf+wYGwNb3LJb1Gq7/2aIkKCpNsjr
X-Gm-Gg: AeBDieuq14jRWKy/GUwp1Cr/hO7GEL2r/E9qxUu29NxNLd/3Mv9XzaGpcj0QWPiW8Ta
	rrSYhulrNQldvXUsGlyP5ljeHM8jmDHzrBz9eTN7B1J2ve+8t+yFsmPnvyC6cEKBxmMuBsR84Mv
	odrLlECLaS4P7c1KU+pCm8Ja/H1Hv64chtUmfU6larzJ7uSh2ImEcEAmvbJI4kpcYlT4LS8KCOg
	gUpGrwCUB8LaCNjwdYL/vJ37Yx3qTh7IK16Pe3j8XyVmAiT3fh+agp8R5heLTY4dh8ZX4hxNqVd
	Cc6mXHbB
X-Received: by 2002:a05:6512:33cd:b0:5a3:d2ef:2f93 with SMTP id
 2adb3069b0e04-5a3d2ef2ff2mr3364086e87.30.1775491604807; Mon, 06 Apr 2026
 09:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-3-dmatlack@google.com>
 <e3fe7085-1297-47b8-bb17-a48196e8f37f@linux.dev> <CALzav=eyf4XRTi8MfE_GBNSm+tjmfX7=d0M8Aj5Hh0vJn7huew@mail.gmail.com>
 <c4138f66-edf2-4689-b5fe-16dc4839e9c3@linux.dev>
In-Reply-To: <c4138f66-edf2-4689-b5fe-16dc4839e9c3@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Mon, 6 Apr 2026 09:06:15 -0700
X-Gm-Features: AQROBzBbHlG2eO4NjewlbX-rvy8OZhgqlWaRP6spr5d6_KAEWYAdDGH-j6HkrWs
Message-ID: <CALzav=ei_xSfM0MTdPFhGDjNwe3EQ0vHPiEk=vszFX-Xi_KjQw@mail.gmail.com>
Subject: Re: [PATCH v3 02/24] PCI: Add API to track PCI devices preserved
 across Live Update
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Rientjes <rientjes@google.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Li RongQing <lirongqing@baidu.com>, 
	Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 5, 2026 at 9:56=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> wr=
ote:
> =E5=9C=A8 2026/4/3 14:58, David Matlack =E5=86=99=E9=81=93:
> > On Thu, Apr 2, 2026 at 2:29=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.dev=
> wrote:
> >> On 3/23/26 4:57 PM, David Matlack wrote:
> >>> +config PCI_LIVEUPDATE
> >>> +     bool "PCI Live Update Support (EXPERIMENTAL)"
> >>> +     depends on PCI && LIVEUPDATE
> >>> +     help
> >>> +       Support for preserving PCI devices across a Live Update. This=
 option
> >>> +       should only be enabled by developers working on implementing =
this
> >>> +       support. Once enough support as landed in the kernel, this op=
tion
> >>> +       will no longer be marked EXPERIMENTAL.
> >>> +
> >>> +       If unsure, say N.
> >> Currently, it only supports 'n' or 'y'. Is it possible to add 'm'
> >> (modular support)?
> >>
> >> This would allow the feature to be built as a kernel module. For
> >> development
> >>
> >> purposes, modularization means we only need to recompile a single modu=
le
> >>
> >> for testing, rather than rebuilding the entire kernel. Compiling a
> >> module should
> >>
> >> be significantly faster than a full kernel build.
> > I don't think it is possible for CONFIG_PCI_LIVEUPDATE to support 'm'.
> > pci_setup_device() (which is under CONFIG_PCI) needs to call
> > pci_liveupdate_setup_device(), and CONFIG_PCI cannot be built as a
> > module. This call is necessary so the PCI core knows whether a device
> > being enumerated was preserved across a previous Live Update.
>
> After the following changes, the liveupdate.ko can be generated
> successfully.

Sure but you've broken the feature. Now devices can be probed before
liveupdate.ko is loaded and the PCI core will have an incorrect view
of which devices were preserved by the previous kernel.
