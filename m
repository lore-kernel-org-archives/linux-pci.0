Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32F8370D4B
	for <linux-pci@vger.kernel.org>; Fri,  3 Apr 2026 21:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253527; cv=pass; b=f5P0NYnoIKqx5skLbbd5wlfa7mJxIc35DbWIQXPl5HBmtkQ41c1hMdbANiy35rgyUcRvUNR0mmrp9YRi8pGFsT0q57u8Pn0wUrTO/TvicmO7F5pZq+5+QR3t6WMHKhBzEUN8HVJ8mDQjY9MrjDjrRusk1459a/gcJYxU0hCqBpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253527; c=relaxed/simple;
	bh=oCK+sZb08S6huM/V/s1J1l900Tg/cNM1yA6PbfEXFH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGn7pTxc49B2dsEH3FJTeQaeLt51PcAihXqRHKLInMIEQSgNtnm37/L2LB0YfjvpSEtfJAuEFo3XWBSw8xCxCmT5JhKoU4RBNCO1j7bUghDORh8cZArcVBNlOPRskfGg+zrBHLqAtcCEMeFBptt88FiZOxIZSvQ8kwbFCEbBEg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sfVInFU0; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfVInFU0"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a2b5ea59a1so2661281e87.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Apr 2026 14:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775253522; cv=none;
        d=google.com; s=arc-20240605;
        b=HaS5HfXz5FhYtFGXxttFx30XyLp3wACrptgUpfE0PI1sWb+Nrj49zXI61gkmpz3tqY
         6Jbc18Xm8iqKyC/gX+rXZW6njwwfXFdc2szmJ6eeT0e3d8hxknNFBO6uoF3TFaeBMazT
         +ke2ZCm1tt+mRWNXefuR23eIkON5Q8R63BKXmylhmtC9zU2o9JeNP+LZNX2Yd/W/yf9V
         kbn4xNjm/aKlOn8SyiyvS7j1CNuUpkuxAoZ5UnBxTR76V9WB9c2hObC8coz05AXMgSv0
         nG5wOT8xR/KZoslJmN4an403BCKLzV3EYhvqd1xGxUvj7Q/eAh/yqx8RB2cF9MJM4olh
         yTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n1x++2kh/JMrnSacQAY2WWd8oQD4emJiO8jgrYOFWkM=;
        fh=PNkqFaqTXdtSAaP3AiXzgbyB2qYqs7nNBASvbBnm5H0=;
        b=XtGhEiJNPo70Mh+Aq9n4Ugct9O/AVjKZmIgIMBSqQ/rZCDXeABQP05+ChtuJ4jShmm
         Q7uCOYCXz8rMcNPCgYMMck6hUlYU7vMksRwInHyJIZlL9Y+tvG43CzA7nyGzLYM8Q44b
         l/dmJ7KRCgoggfr2P8niPOmebGU6okzq9c/4cS6feIav8fKmoPWGYOTRyGWgv98xVsjm
         HpK4GZKgoaSvowg5qToWC2riL46roClQPpDRQTCI4D0gNhCRJ+dG5j2tlH59XhXje1qR
         UvVxnk1he3focSrjZ4stut6qmdEevHH+Vc3GSiH8vatuTDP3/3BdKzzuxA+2rKP5nCb6
         nMWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775253522; x=1775858322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1x++2kh/JMrnSacQAY2WWd8oQD4emJiO8jgrYOFWkM=;
        b=sfVInFU01E+LC/YL08p0ZrKy5EpCdGKddjzFyepyUv4or1nGuchn8jkj/IwiXItUrW
         nFN6Eqf/js+yJG1Nuou/6OciQugdHpyDNCfbBaFQNxFv2mul2ZMJg3kGYxTEsEuiBjnZ
         0SAwrWBs8MdwUdwpZOmdRLodQPwWfwrBrfXsRmNbctLQj/AXgQ38BzeZx2GBZR2SNT4f
         RVq3gSCdWgwT73tc6U18cP9lvNsuFCc0H4Y5jo5lATYkVEybeYCOJueCv7GxvQJg39zi
         vouHBiahkBZQ1l3DMVQsRBTbyEwZeOLhEH73PMkQmpcboD2alHYcF0E0Rml6mGYxEvWO
         qoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775253522; x=1775858322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1x++2kh/JMrnSacQAY2WWd8oQD4emJiO8jgrYOFWkM=;
        b=ZMccNcHOGpGmteunswjz9CxY4kPg8SI51t5vbaQ2iu6leNe7VmTGVre7J2BiIDgFbo
         a1VKA4gw+pWVE4Tz0ZJ3jgNQ/P2S3biKmXBA3rZq3/vLn6ob0z+2NrUl/tec9CZiKqN5
         ESuglQ123Gf70W5HgmnFwuD9j4PVxCuzcCoQeXtaXtOOttEOtZUapxFjt1CMgDF00i8L
         34KbnRI2C3/qkF+T/eQo8x17JpHpn6pvquw6EO1d9v5ihN3gkB4+Qjcs+CD1G8eR1GXu
         XbSvtuujD2UrGi1edmALomb1ZfMyr81yJLsRu/+qr9Q61C1FesMbGcff2YYmEaRN9UM5
         x+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXYODOeiN15uG3XX2jnrDfbiGL+Pel9I0WF/tYcH9q3LVfOVFxS5DiV3RIrdXLVdbLeSsSOwbB7Yco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0PHNvjln5BUGeIaqWyU11+Ow7naEx1J/J9DCPtRSHcnZQH5Pc
	qQcjG6evhDCkMYXJcG6jQVaNZo/X6XWnmE8z4vDk6uNLrC+evEEgbblokJwxgWO4puUCoYJ3sCj
	H3hBYSSw3dokzC9cIf4S8Nkyc6vbQo3MF4ahWTVRj
X-Gm-Gg: AeBDietH0+Ln16OyjD4LZyXWqwLAQXLAnOSzk89IjcLeEyjw1XZdAhnBVR1B5c0p8t3
	YykjtONphrKHgLc3ehQ0s9z2bODxDmOcuAk9veINqUp2h6Uj6Ralk9CqruruS2me8Kk6yaAYNsj
	AdpjvN/DMkQBh2F0xy1zJJLHpw2LyL5LYlNU4ZMCkhP1TnOAwWlXoQQy72hyfXa1Q4x/WrVYxRY
	ErEDtC6F8uOMpmKJov4nYm1kDOH7bjbF+E++bxIeOLnzrYtcTPO65f0EsdXOjlgh7Mm3uYV62zQ
	HCNkbW4y
X-Received: by 2002:a05:6512:1310:b0:5a2:a5dc:6111 with SMTP id
 2adb3069b0e04-5a337563322mr1534908e87.18.1775253521414; Fri, 03 Apr 2026
 14:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-3-dmatlack@google.com>
 <e3fe7085-1297-47b8-bb17-a48196e8f37f@linux.dev>
In-Reply-To: <e3fe7085-1297-47b8-bb17-a48196e8f37f@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Fri, 3 Apr 2026 14:58:11 -0700
X-Gm-Features: AQROBzCufsJjSomX3fu7F7ptwK4HJAYNpi3kPBVsC_mFldZEseUJNvIFRhG6pcY
Message-ID: <CALzav=eyf4XRTi8MfE_GBNSm+tjmfX7=d0M8Aj5Hh0vJn7huew@mail.gmail.com>
Subject: Re: [PATCH v3 02/24] PCI: Add API to track PCI devices preserved
 across Live Update
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
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

On Thu, Apr 2, 2026 at 2:29=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.dev> wr=
ote:
> On 3/23/26 4:57 PM, David Matlack wrote:

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

I don't think it is possible for CONFIG_PCI_LIVEUPDATE to support 'm'.
pci_setup_device() (which is under CONFIG_PCI) needs to call
pci_liveupdate_setup_device(), and CONFIG_PCI cannot be built as a
module. This call is necessary so the PCI core knows whether a device
being enumerated was preserved across a previous Live Update.
