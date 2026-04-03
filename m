Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4835D3C3441
	for <linux-pci@vger.kernel.org>; Fri,  3 Apr 2026 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775237087; cv=none; b=rHA5A50uAd9g8oriQR9lbCoEwvdSu5kDs15t46vfgioGytkJNpaBv1USlwlgFwQX7ykCtu/mnOxtcMj9mG1xf3ZtjwABkr6flXk+1aJ5eSJsuyqgcHYvxccIQ2vnPJcJLUcF9zzU5+WgVNpeDXKJ+z17FD+tvquvVI4Napu7N5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775237087; c=relaxed/simple;
	bh=E1bzUypaVS7w28CbARApxGc+uxb6NjOyzaisp3si/6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bp85Q0NVvoyfR1YLM4LLH3psjJAMta1mIZZUawxIxrlFlA4HX99rAgd6/5rx8Ba4qfu4SkSfkZnIe4oc9xVPXeO2tVhKE92p7/oGvbW8k0qSy6DeIyzbbf+0uILMk+AlDVpBsZ1apixteQ1lbQOWKmbnwhxc4eo3TJwG9dXBgBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ri162ENa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ri162ENa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EEEC2BCB9
	for <linux-pci@vger.kernel.org>; Fri,  3 Apr 2026 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775237087;
	bh=E1bzUypaVS7w28CbARApxGc+uxb6NjOyzaisp3si/6g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ri162ENaaXiSRPqBTShI8ahm36fA0yxapnpusRTreYOdDDMZ+niMHjj7xqXvZwXxR
	 W4688wQ9cGxnGe+4MGiHfTAaMtuD2Con4gYFbAMxcYjgjIt93lCPasclWTi7ojO9Zc
	 cazVdgRwAtkk89yPiJTWnIHMEFFN8LHV8glDBn0X8QcC5UvdP0JZaLMOMJXUx/iVXU
	 J6GWfBEZdlJkOBVUvtov+m1djxfdByrpUr0rmKXjb+/NqCjkj+Qy2GYzHPm2Fr+5nb
	 8/vPh720vR6+uCmdKhX7HYao8p87jfXTXfxJbR1k47IxMwREqsFF2kj0iRdD6uwC5X
	 E/5FWDXI51lcQ==
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ef161129bso1800163d50.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Apr 2026 10:24:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPUmr2/TWFeFAe7h7yaZOn6eMZ/4YHjMXWm8nFrRCL9H6wJPrlAx7EohKaqUjelyH7I3brjGQGdgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeMxDEcsaZzAgWjcv1fgbZm6Zsxypz2R0tfrd3dFKuxnAvxste
	kU0THHKFTnvuDcI9KuRe28EYLn1f0hidb+iDtV/qVog2eYhNrIWVHrlQFJ45giwJ3IhFrtTWlEE
	jgrxGvMYJyk5FR7ATyIhg47vdABt6CRnCE8v+89uXqw==
X-Received: by 2002:a05:690e:d41:b0:64e:a765:ef82 with SMTP id
 956f58d0204a3-6504870ea48mr3180067d50.24.1775237086162; Fri, 03 Apr 2026
 10:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-3-dmatlack@google.com>
 <e3fe7085-1297-47b8-bb17-a48196e8f37f@linux.dev>
In-Reply-To: <e3fe7085-1297-47b8-bb17-a48196e8f37f@linux.dev>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 3 Apr 2026 10:24:35 -0700
X-Gmail-Original-Message-ID: <CACePvbWrHCSzYmiKz0EuXE48MNk26+4j0njSP+1Vy83RMvvVrQ@mail.gmail.com>
X-Gm-Features: AQROBzDLi9Fnv8_mDDwmklVKEby5KKVysrnsYTweXxYMFegWZQjyvtyGp9AI6Cw
Message-ID: <CACePvbWrHCSzYmiKz0EuXE48MNk26+4j0njSP+1Vy83RMvvVrQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/24] PCI: Add API to track PCI devices preserved
 across Live Update
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
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

On Thu, Apr 2, 2026 at 2:29=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.dev> wr=
ote:
> > +config PCI_LIVEUPDATE
> > +     bool "PCI Live Update Support (EXPERIMENTAL)"
> > +     depends on PCI && LIVEUPDATE
> > +     help
> > +       Support for preserving PCI devices across a Live Update. This o=
ption
> > +       should only be enabled by developers working on implementing th=
is
> > +       support. Once enough support as landed in the kernel, this opti=
on
> > +       will no longer be marked EXPERIMENTAL.
> > +
> > +       If unsure, say N.
>
> Currently, it only supports 'n' or 'y'. Is it possible to add 'm'
> (modular support)?
>
> This would allow the feature to be built as a kernel module. For
> development
>
> purposes, modularization means we only need to recompile a single module
>
> for testing, rather than rebuilding the entire kernel. Compiling a
> module should
>
> be significantly faster than a full kernel build.

Building as a module has extra complexity to handle, e.g. the callback
can happen when the module hasn't been loaded. Then the user space can
take an arbitrarily long time to load the module.

It needs more infrastructure to support the liveupdate as a module.

Chris
