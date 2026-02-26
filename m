Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD92BEFED
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 00:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772067139; cv=pass; b=DDbZ8yL6tRHzXWTYvZV7bb70gNDQiE0gSTOlOhDkhHlglIhWK4+PbrSbomqKWLZOZj+PAZWK7a1xeBenTmgYIEZO//hK440e0o2axjiBZKCDnb9Y541RsSH3diRPuN+XnKQgFf0atUfNP/UpU0/C6elvBVbKstj/13fRAUbtgaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772067139; c=relaxed/simple;
	bh=5UM3OPrEzy38BQ/z8lTr67s9jTiNGfLCQhFUKKuIZuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ne8t0KZphlUtf2bX56nEN0Khvkp3SLwctyWJSqMISbd+DpMH2rlLr6kUMNYoYCI30HTFAPCFvh2wFQmZL4Xtej4sL8u2qyk1PEEQ4F0VxZ5SOL+GYeLzQJFz2JwihfrO5neCNFXrYZu4N2TtXz8pp0Jh7iuNwf7bQUnPFltzTyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Isym9Zp4; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Isym9Zp4"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5637886c92aso236816e0c.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 16:52:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772067137; cv=none;
        d=google.com; s=arc-20240605;
        b=dbcR/WAI/uH/MDhSJczQe/58AVf2VxYuNI1ZYEAGUOgwgHCOzMcGzVW8+FCSRTAeru
         veWCY7gbYWAyHJ3zCjRse4UUoRYdDEhXK0fKRa+sQPQeGVeEh9IxQ8Kh/RxFkH0dpsr7
         U3bUp3my2mTaOuL6bPWLAR0jttWItAHXS+uc6bS1AFk54nZnRCv6c/19yWCMeZuBnTGB
         oflTl+9kk4IM55aS7zA3cNp23sqL5JU8iT19f77ubbCHblDO8OOG9z0rk4PQNmK3RHeB
         OQkOyvCNLfYC/xk9cweKvw2z/MufF9rtahfikRVrEBbFngvzpQOIU43bmorOJVld/f2f
         cnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tit/ZfajxqvE3xISUpVUeXJRv5DgJC6ZdqyR1I2SKAc=;
        fh=P7Nbdj1/dWIA5coTHMkkFuSsoYH3fO3k4kkCZksSlwU=;
        b=XtEbjKBLX9EcrFCethedoCN/xOCun7BWtw6S83Ck6+zI/AB/z0hU/fhoazImUcw5ip
         WnLR5jUhq2rzY1Ovvh97dFaiPhJHLEx9YvdhVVb0zNu8EMWWzWVgAxWX8BPNMU+0vvne
         mB5iLZna8GIA6ljjU6M/wB7Sq3lba1FjO3TwJBCRpJxjNIhBfi0t9fM8dSXQTBUFEdy7
         G15g4mrvPniOvlp5VsGl2AvhWLu1Yxxfzc9/5ahMeaTUeaRy9xzn2r6jVSuFE2W/fPm/
         vV0p9kt7ELQ6FZLi4bF69ttC61MFaI6h73ij8hHQ3f6JTjqNi/kn86tNXiwnqxIRNg84
         E0DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772067137; x=1772671937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tit/ZfajxqvE3xISUpVUeXJRv5DgJC6ZdqyR1I2SKAc=;
        b=Isym9Zp4jjzR+PC3c/BniSDPSxJbrLU8884r+rart9fG1ueJm/2EFzUZ54EEDwayeH
         4TElbvJ6sEuwu2Q91jPlhwmiNC15kR69yqOPhVJPvW2wHKUiI3ZQuEvDaubPPR5D993m
         Hnp/o4nbcJCA4D1/8p1P4oraDX5owxN0FTeHHx1eObgCadot88UiLgxyonvldRh4c++g
         zxEIpMNtWGmkw4Kjsp4F1Pk6APFcQZ8azzng1d+4eZdwvQfMelhgLDii/TcG/monS+0f
         1Zte2TRT8ls6qpt0pJKTAa4dnhta0PRjvHW754pcnzj+v1EdXGsgPbefOu4Ncl8P2vbY
         cZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772067137; x=1772671937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tit/ZfajxqvE3xISUpVUeXJRv5DgJC6ZdqyR1I2SKAc=;
        b=ulih1bFX9TG0IiKB5jy05q1s+M7wUr19fzCMTbaytT5plt1eLTjIIWQxqEQ9lsopjz
         k8BuPpa1ZtY1feV4AYS+5Gb6rgA1W8EclesLsTKblJtGELp996iXTNth9PgOXMhynkAh
         YcFLBtm+8AKgSdp+zxzqkGqSPQMvzC9BV9Ci6/R31PQWePJWKKxQxOeDBm2BHEGb7khp
         5/LuDYizU753fJ1at0n60nBdg7EnaWWTHsQOzmfgZlvyFVbxhG1THTLhpn9zufI1pIq0
         gf4NCIGto7vbYEO4b1WVAsU7AUPnv6wwsSlKx0xrzlKZDpuFB2igDsj3R28b9H3m5u90
         DBuA==
X-Forwarded-Encrypted: i=1; AJvYcCWUA15nN0GjTa8abI7/2iTtO6Fi2DRbUeXQAJXfnpmxBSYpNkwNiV54vilbjlNNwmzYqCh+X+Zv1Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBFzBRt7tPmT2N/C9XkCrJOalm5DU0jAYNaFXNWnGi3S/uQgz3
	4ORbw0Iar/9knfMLP9umtkBkb+T1zeiEpsyyW14XBfbv752Hm1t5nrisZwDX720rWthIIFi470V
	tUO1FqFjer5Zh72zFv6qg9l3Z4k9Z7ayQx93cZKnw
X-Gm-Gg: ATEYQzweqCI5uwvzA1t2I8bMIugHiPlclx6m9lnVaHKUh+QaCRWy5Tt7BJtB4QeyZfd
	uxdzskefuJCd4ouaX7Tmq205SltG9Yc8D+ZE7eZhaY+yCweqMYlAaSkcVMN6y7p1l9OMFef6GJS
	xVOmv8igPp2bqAUcZx7yv03bqm6SJXwHz+XJckU/1CoL2ZS3WWPVfwnhDI8CD5ZLuiMBprcRbqb
	8O+N+1xziQ1iAlrruQzz28XwoQ7G24vbOae2nlBz4zLJHKCxUEmk6wuVRQn0OJTQzUL5pydNuVB
	Tq7YHME=
X-Received: by 2002:a05:6102:3f0d:b0:5ed:f13:e58a with SMTP id
 ada2fe7eead31-5ff1419f7b6mr1037473137.37.1772067136513; Wed, 25 Feb 2026
 16:52:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-10-dmatlack@google.com>
 <aZ606sDJxtfNF6qW@google.com>
In-Reply-To: <aZ606sDJxtfNF6qW@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 25 Feb 2026 16:51:47 -0800
X-Gm-Features: AaiRm51I1tTdJRO5CbbBFYwdOmR4S6VSPvkujC59eyupuwvOv4iLZLnGYRmW3DQ
Message-ID: <CALzav=cH0-qqQJTOjDD7pHzsFeZOir5DoC3f1hhDg=jqK7vdgw@mail.gmail.com>
Subject: Re: [PATCH v2 09/22] vfio/pci: Store incoming Live Update state in
 struct vfio_pci_core_device
To: Pranjal Shrivastava <praan@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
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
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 12:38=E2=80=AFAM Pranjal Shrivastava <praan@google.=
com> wrote:
> On Thu, Jan 29, 2026 at 09:24:56PM +0000, David Matlack wrote:

> >  static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_a=
rgs *args)
> >  {
> > -     return args->retrieved;
> > +     struct vfio_pci_core_device *vdev;
> > +     struct vfio_device *device;
> > +
> > +     if (!args->retrieved)
> > +             return false;
> > +
> > +     device =3D vfio_device_from_file(args->file);
> > +     vdev =3D container_of(device, struct vfio_pci_core_device, vdev);
> > +
> > +     /* Check that vdev->liveupdate_incoming_state is no longer in use=
. */
> > +     guard(mutex)(&device->dev_set->lock);
> > +     return !vdev->liveupdate_incoming_state;
>
> Since we set this to NULL in the success path of vfio_pci_core_enable()
> I'm wondering if a failure in vfio_pci_core_enable could cause a
> resource leak? Because vfio_pci_liveupdate_can_finish() returns false
> as long as that pointer is valid, a single device failure will
> perpetually block the LIVEUPDATE_SESSION_FINISH IOCTL for the entire
> session preventing the LUO from reclaiming KHO memory.
>
> Shall we also set vdev->liveupdate_incoming_state =3D NULL on the error
> paths of vfio_pci_core_enable() ?

LIVEUPDATE_SESSION_FINISH will also perpetually fail if userspace
never calls ioctl(VFIO_DEVICE_BIND_IOMMUFD) (which is what triggers
vfio_pci_core_enable()). Or if that ioctl fails before it gets to
vfio_pci_core_enable().

It's not a great situation to be in, but this is why can_finish()
exists as a callback. Userspace must properly and correctly restore
all of the state in the session before the session can be cleaned up.
And the kernel is not going to handle every possible edge case (some
files in a session are restored but some are not), at least not
initially. If userspace gets stuck and cannot recover a resource then
userspace will have to reboot the host to get back to a healthy state.
