Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D2410D17
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212803; cv=pass; b=MSVkFw0FHWLIYpLnX+jAxAMJnEzyYouOIXX5FC90larw1vT8XBCI2orHrv382PkzsSfiU/D+7gMFB6M54PuwHZ3QySTmzi15mmzOt9Kpm90HS4e9HHGY4H7fE1xaGKFcIezVfnidGNatvnnz18xHd8j/2E2kI+umiIBbyd7+d1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212803; c=relaxed/simple;
	bh=SSENmwLLmfNwcsRg3YsbfFMJCVOVJDpYAbDWxLRiUJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNjBG7GAiUCWlPkxPG3PoY/SydWRvjQLOcHmuLLcRZFbaSwkGhLdJvQcfveyP1gr6ZYbpma4W9m26fEsb/Phhr8IJouek/8t++V9bJhh8gAev1FsDebvdOtqtyfMj+UZmsD8UXM4HgeMswWeQwOIo/nypie2vDVf53jrXBlAN1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HHFpTT3c; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHFpTT3c"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3870778358aso1192721fa.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 09:20:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772212798; cv=none;
        d=google.com; s=arc-20240605;
        b=iutH19sALm+5RIRCqjWC3NKQyakB9DdsUXf/2m0RstobQLuUjn6T92HWgJ1+61B98F
         8p2y9bzK6mZLwxRoQj46FPzFiccf10sUErqcYZLQ9IunV2zDKxF98mzT98zU6L3vIIyp
         zwvy8yzsVTOCeLszB8YYNtMk6NOD41AZrffTQdekzQjGPjUvGMSv0YGBpbiDyBFyr0ai
         EqW+aFdv6Gv4+hZGPscb9qAHq8wR0+VmIf1LpLOIAaWIpNZyB77SvOzFjI9IXIMyOak1
         zOTm0PNhAK05UykvJjdoON7wx+H76sYwYJ1ttw9RYAHd9y0jbmadO+LyAGppLs/EJG+X
         5cuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TlM+Kfuyp7z6KhXNl7/hdctuf7el0QWvoUeGk1mQs2Q=;
        fh=gNqKsuYtLlnYHxkuoSSGWkVyhFa1jsf6ei8zIJVTrx0=;
        b=IgtdGy5erXmS9sdkQcSLckiubFDSeA8nNpsTvP+zgDE5uvi1QCZ2SEWyhWi59H9Upr
         fvHgcRAiqykT8366Hwhvp7GzpFwO1K48JkY/ggyDgsuvsvIZ/K2XLoOG4Y+7/4H5NT6a
         jI7tiEOK+BOGQ8eXqbt8qMqDdgnpaX+YBOubPC2rr/LPO3Ne0HrJffhcO7uUjsF0kVLU
         h0DjBMorPRYrRG4B3+rCmUybfzs+pgDzYNkkBnTKgPMQbN5deF1JRHO6sV8LYlXsHp/x
         LO+LU9NeCyoZU8sUOTj6CqoVwFZ71ZkBj5w9Q4DEL6XcrhphMgCbMDqh9Qvhc2RuSoRh
         TbtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772212798; x=1772817598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlM+Kfuyp7z6KhXNl7/hdctuf7el0QWvoUeGk1mQs2Q=;
        b=HHFpTT3c9vcvzJ3vVCMKu7JawFYgDIREzI+Q/pn48bejMi8S305zspNJdAZhTcixqt
         ORuLPealSeMmf7TSqbFA+Y3jHgipjhOsfgImPNTkWoxuekKsmaBHFF7KJ7ROyAHHJs8x
         UqNFbkk4dBP54X3yDV1ktfH+gaoQ7dxdNmvVov/DrCkPw/orQrQ2SWpYWQwKbQY+h69c
         8swnMFVs7FafFJfAClz0HhRXDlerQjO4rLhG7QXIwcKFjsJEj9owe/5unM0+qOdZYBsJ
         RhNt8ZD6lCoXGlSkQRNf/GU3UQVOLxTzRh2AdkKAtgrtqLdgEVUkryPPbxSlU5tQIdBh
         A5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772212798; x=1772817598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TlM+Kfuyp7z6KhXNl7/hdctuf7el0QWvoUeGk1mQs2Q=;
        b=mUSxCl6Ia1cCkIGAARRSB2STTVt+ri4oVgPZ01uBmY7ia/UwI31LIDjIfZRNKrOM3f
         tpUgc9ucIM1QxizuytjeySy+uQ60sReRc5GWhTPEivZH4Ty4CYGXaLq2OkfIdX/taoD3
         xLivJ9U2g3doVPOW1crFs2y/acmL0qzDsDlmDT3wZBVFeOMXESiDxF/DdQ7+9abm9mH0
         s4qmN/2zi2IsB0Ao5ME83sN/qzv3LmYE/jWM/MShYdTq1mZBqI8WryjQyHAiqHBjYlmm
         OIfFFNLNyN9LEyL55/fdSe++feQQ3EUj5XPFGixT+wj+lZfCkSis8XDOM+vCJdqRpQhJ
         jALA==
X-Forwarded-Encrypted: i=1; AJvYcCUswhCRCnH59eMJJLtEkEPhWne9gtLp0WGagQUFiA+QTf2w3Ox0m4bA17DFxdja4okVuxQa2cSAVg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD/+GiTw+UZ1NcrDYgL5Wsu7v6RQYC1XyC0z5gG1oVdYjEyjVh
	5BbClXNsHvO8j2SYeMt59y4qbJuFsa6sLBy7AXdeHIRsL25cvKjA5ZOwdIa+mSn9UujHl21BiOQ
	Z8jzNawvB6kbY/rOe7QptMwQEgqATM/dJHZAAysnG
X-Gm-Gg: ATEYQzzuPCRDSb5T6xcClN8Ogw6DnhRA/wCpRe6Y/4OhEEfOKu5kgI9SyoLGRZlODHr
	7PDPr8u5jWVviRlTBsPx5qSGxvBXM+UZCLg1yFCZTMh0vkCAdS47v5zdhGtFLk6WiLicr08szgh
	qI59RT6F2JA7alcRB/McuozYLWX7P14EZbUujI7IApwf9vZdakmMPEyE5hl30B/T+vxtz8YsQYw
	pUWRZdjFUmkmeoCoJbuu+zcmcT+J9Etw0GlQ6W3mTeijlWcnTzKUJOVR7JFbH/TrdVfv+xh4ont
	iNIUDDY=
X-Received: by 2002:a05:651c:f17:b0:385:d0b6:6c44 with SMTP id
 38308e7fff4ca-389ff14567amr23252321fa.18.1772212798094; Fri, 27 Feb 2026
 09:19:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-3-dmatlack@google.com> <20260225224651.GA3711085@bhelgaas>
 <aZ-TrC8P0tLYhxXO@google.com> <20260227093233.45891424@shazbot.org>
In-Reply-To: <20260227093233.45891424@shazbot.org>
From: David Matlack <dmatlack@google.com>
Date: Fri, 27 Feb 2026 09:19:28 -0800
X-Gm-Features: AaiRm514TJvedInAnynD285P6RuOXX1FfRIbxiQr5Hc2znqJUuMLjDSPlZjM6yI
Message-ID: <CALzav=dxthSXYo13rOjY710uNbu=6UjzD-OJKm-Xt=wR7oc0mg@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
To: Alex Williamson <alex@shazbot.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 8:32=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> On Thu, 26 Feb 2026 00:28:28 +0000
> David Matlack <dmatlack@google.com> wrote:
> > > > +static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> > > > +{
> > > > + struct pci_dev *dev =3D NULL;
> > > > + int max_nr_devices =3D 0;
> > > > + struct pci_ser *ser;
> > > > + unsigned long size;
> > > > +
> > > > + for_each_pci_dev(dev)
> > > > +         max_nr_devices++;
> > >
> > > How is this protected against hotplug?
> >
> > Pranjal raised this as well. Here was my reply:
> >
> > .  Yes, it's possible to run out space to preserve devices if devices a=
re
> > .  hot-plugged and then preserved. But I think it's better to defer
> > .  handling such a use-case exists (unless you see an obvious simple
> > .  solution). So far I am not seeing preserving hot-plugged devices
> > .  across Live Update as a high priority use-case to support.
> >
> > I am going to add a comment here in the next revision to clarify that.
> > I will also add a comment clarifying why this code doesn't bother to
> > account for VFs created after this call (preserving VFs are explicitly
> > disallowed to be preserved in this patch since they require additional
> > support).
>
> TBH, without SR-IOV support and some examples of in-kernel PF
> preservation in support of vfio-pci VFs, it seems like this only
> supports a very niche use case.

The intent is to start by supporting a simple use-case and expand to
more complex scenarios over time, including preserving VFs. Full GPU
passthrough is common at cloud providers so even non-VF preservation
support is valuable.

> I expect the majority of vfio-pci
> devices are VFs and I don't think we want to present a solution where
> the requirement is to move the PF driver to userspace.

JasonG recommended the upstream support for VF preservation be limited
to cases where the PF is also bound to VFIO:

  https://lore.kernel.org/lkml/20251003120358.GL3195829@ziepe.ca/

Within Google we have a way to support in-kernel PF drivers but we are
trying to focus on simpler use-cases first upstream.

> It's not clear,
> for example, how we can have vfio-pci variant drivers relying on
> in-kernel channels to PF drivers to support migration in this model.

Agree this still needs to be fleshed out and designed. I think the
roadmap will be something like:

 1. Get non-VF preservation working end-to-end (device fully preserved
and doing DMA continuously during Live Update).
 2. Extend to support VF preservation where the PF is also bound to vfio-pc=
i.
 3. (Maybe) Extend to support in-kernel PF drivers.

This series is the first step of #1. I have line of sight to how #2
could work since it's all VFIO.
