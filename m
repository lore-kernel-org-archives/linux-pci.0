Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C9427A904
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584181; cv=pass; b=kAs3Lgg+e8uAvzEv5266+cptPWzXm+yzDtxVCs8IbGtigun3DKZxQtY2tHPZnktTnZIU5VCBg2ns7GqrvF7+bLNwL6GkSjMi2yguShLkoalQJJvIHJjeDAHXBaWbjCKoS3VvwR3vqRsZrALv6mVnzGMW9/RRHbLBfW+Ie0+yliw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584181; c=relaxed/simple;
	bh=M3mVujZnSbDcky4ImjiZHpQ7MdR18QqNyQGKAVOs0Hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3KszDxp8O0rSBc+UTs051AbQkgI44MSeeiFJziy8TlhbajxcyMpEpha4pTXF8Nx3kP/s9XBW7NUYa3Z4Kx53aCd4A5y+F65AwCFJlUKM/dCLoB40dX/1QkohavIcKuOOcmK9mJeymLiP77rjQmvQsADPoyg38nV815b0Y2Y1xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H4yBkh4+; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H4yBkh4+"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-610aadb2d9fso460262137.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 14:22:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777584179; cv=none;
        d=google.com; s=arc-20240605;
        b=Aj9A1iRoIS71ThPoRV0t5QlP+hjjeHHiGiy268QSjb1mAYSYPRjiibZ/NQPaKvApaP
         2O4ATuZyNn6cpXFPNuHvDf/LCoK1/duYbZ9OYfuPxDqBxpHGwoq9U9ISSuL1pNzfFl9F
         k8L2XvoYj89ua6o8g11afS7ErJcw+cN+PYtc6Iszc7Dq+MbbaTjF0we52PGbaLIYB5eM
         ATIrbdwXzEoxSjC64NvseWsTpwmT182l7UjbXqxsdvVlj4kj8ZICCKofXLqHPwR6dGqZ
         7N4WTUTcvCn0/4Cp9EY/1Ytvvogu8kWhogsfPcWY5mAIjwfZr4joDncRdZrohrqgCjKU
         E46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VDdDBeOth/GyO4S6LG5C4tIpCfmXMPVkXYvoyOVLmpc=;
        fh=0CwitysbmaxXRYCEJlivB80p51oomkj7WgcN2ahMzBg=;
        b=OG7ei/43LgBge/87HSqobHIEYgkAJlLdai0QiEaznT/uuXV17NEsZOhlFTPkek0Hvl
         gvn+b4hsYt1EubyvfWhp3fx/ICAUZ4dFOV52rl9i3zYSof3ox6qp2g6sahmEGL1iy3LU
         i9oz/hzRuWsSQrHJavKm7zEUHybQjO+TaknILYtnJqrmmzKKc9QSrWRdK9LKry2sS1RF
         hE/SUHN3dFSMQCT7T8QzbEP3lnmJcSb8JRh9t3cQ6a9dyt9KOL00/0YRCUvWWnJfdYLy
         R2PvScP6BteMctBkNcM7Fp6HdG9bcxc5fkjR1zd4QT6Lq+owAQu0BJzkT07bjYHuoHO5
         L7ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777584179; x=1778188979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDdDBeOth/GyO4S6LG5C4tIpCfmXMPVkXYvoyOVLmpc=;
        b=H4yBkh4+BAYyAGuckmnPx6xuGsf4yyYrGetfI4FJsnhTSELM3EMJpKYEPTp3h0e+4N
         ZjjBod8JdKCA2drHnl1Ks6jJUp1vhixNgH6nMZs+Oijf9OBOPU5cH5Xqn+aDvzbRh619
         OlQfa32S2RpAhYC2/lEEo09u90+JBedJ6Vl452vVeRxtzjKQ2x33HlMtHsnsvsfyuOrU
         s/5bwAtoTVuF87HVpHblBMHqXcspL4kyOU1cflNJQ/NiH/4qQZiSTT8yJkW4AonttLWS
         R+Irjc55IPVsaIcL1fHvr6/2F7poILOJOFjwk8WBYOhJDMNAoOrH9ErUO9vsc66MwDj/
         BK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584179; x=1778188979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VDdDBeOth/GyO4S6LG5C4tIpCfmXMPVkXYvoyOVLmpc=;
        b=RYYHAbHZsnhqOvAk4Hnbsel9lfFLbldTJXGjJ7g2lHuuNmHDOp6gdgTBaHgHkONhsP
         j3cxrfZWpwp26wMHEgBKtlk67bNAn0ujC9B0hTDpdUylKtuOREy/bSdYsnxATOMwkXBe
         9WBqGIR9llIERk7nDoZRa5SMwAkcuQi1t9RkOexddmWDWWTpCJr318HcAnEXzQnNo4Fp
         /7kA8+tZAd+0BezGk5XwoVH6A+Tm2VxoX5l12gZfufaYho9uPK2U1om2N8ysbH9YDO2p
         NeV1khoHcJymoAipAAj/Lws0dFZBpAcWIebOavwKFwYlJaMjpJLXL2hrXR98QoX4/Nql
         YnAA==
X-Forwarded-Encrypted: i=1; AFNElJ8DmJq1z4qCBryF5kuP6SuI5AKhCopqkBHaECKoN28Q4j2lWOK+lNsCpY/dDCOz7tUh61T2VrtOBVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlhoBK4pyJN+Rk6ecq0XzVIuDPOgRMzloDEbk/AKU5b0d8Pj1K
	hOKwNH+PbYEkvEJ//KjVEAFYKkv9MHpeq/mVRj+ewO97fBmYUU3FnoP1r4ep+x4fQ8jvo1F6G1s
	hAqEAAhgnWYOoeEPYELQWKqHiKbFztzTYH0iVzVPt
X-Gm-Gg: AeBDietrb4EJo4ZQKgGzZKayvgqLqEScRIgdOCkLPU4L5Wr/L7nZDBOYjIcA2eWhrTZ
	DYakboV3zeacPp0rTV884HbE8d8rMZndofNwoYQE7TVa/GmfFWkEIYeceR8PB90l/ZdKvpZjF5i
	cZ0UvtlCe7FddRMX0VKsfjF23ZTljIFfvTSld9+kqXd5/3ve5lG8JdXmdyPGsQyS60ueAUUt1qG
	qW7mgs9LITBwdKWCvm0Mr8jQmj8oYEol5Ei2UE+7rjErrwLRxG7YFKuS64PNaKLRV/Gxow3pBHM
	Rd+cmqQPcTTV4Aeg9Xz4IRCbD1Xpjw==
X-Received: by 2002:a05:6102:808f:b0:60f:7499:9b6b with SMTP id
 ada2fe7eead31-62ad51bb6d4mr2567155137.29.1777584178374; Thu, 30 Apr 2026
 14:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-3-dmatlack@google.com>
 <20260428201231.GA3885809.vipinsh@google.com> <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>
 <20260430175916.GA13902.vipinsh@google.com> <afO9VOckgyiiokw8@google.com> <20260430204009.GB22297.vipinsh@google.com>
In-Reply-To: <20260430204009.GB22297.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 30 Apr 2026 14:22:25 -0700
X-Gm-Features: AVHnY4Ikcvel7QdyZYGumdrGxwhKO_qS6LiUUIjUSJt8Np0PybdhnEVt0dyw8U8
Message-ID: <CALzav=dsQ7fj3MJ8Fbv9LZMjeayOgM31c-PZZd5JVL2gov+3=Q@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI devices
To: Vipin Sharma <vipinsh@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 1:42=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Apr 30, 2026 at 08:36:36PM +0000, David Matlack wrote:
> > On 2026-04-30 11:25 AM, Vipin Sharma wrote:
> > > On Tue, Apr 28, 2026 at 02:12:13PM -0700, David Matlack wrote:
> > > > On Tue, Apr 28, 2026 at 1:20=E2=80=AFPM Vipin Sharma <vipinsh@googl=
e.com> wrote:
> > > > >
> > > > > On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > > > > > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > > > > > +{
> >
> > > > > > +     if (ser->nr_devices =3D=3D ser->max_nr_devices)
> > > > > > +             return -ENOSPC;
> > > > > > +
> > > > > > +     for (i =3D 0; i < ser->max_nr_devices; i++) {
> > > > > > +             /*
> > > > > > +              * Start searching at index ser->nr_devices. This=
 should result
> > > > > > +              * in a constant time search under expected condi=
tions (devices
> > > > > > +              * are not getting unpreserved).
> > > > > > +              */
> > > > > > +             int index =3D (ser->nr_devices + i) % ser->max_nr=
_devices;
> > > > > > +             struct pci_dev_ser *dev_ser =3D &ser->devices[ind=
ex];
> > > > > > +
> > > > > > +             if (dev_ser->refcount)
> > > > > > +                     continue;
> > > > > > +
> > > > > > +             pci_info(dev, "Device will be preserved across ne=
xt Live Update\n");
> > > > > > +             ser->nr_devices++;
> > > > > > +
> > > > > > +             dev_ser->domain =3D pci_domain_nr(dev->bus);
> > > > > > +             dev_ser->bdf =3D pci_dev_id(dev);
> > > > > > +             dev_ser->refcount =3D 1;
> > > > > > +
> > > > > > +             dev->liveupdate_outgoing =3D dev_ser;
> > > > > > +             return 0;
> > > > > > +     }
> > > > > > +
> > > > > > +     return -ENOSPC;
> > > > >
> > > > > Since it is executing under a mutex, and we already failed
> > > > > 'if (ser->nr_devices =3D=3D ser->max_nr_devices) check above, wil=
l we ever reach
> > > > > here and return -ENOSPC?
> > > >
> > > > Yeah I wouldn't expect to ever reach here.
> > >
> > > Will you be removing it or want to keep it just in case scenario?
> >
> > I'm not sure how I would remove it. The code doesn't not compile withou=
t
> > a return.
>
> Oh, I meant, inside loop a break and outside just return 0, that way it
> won't be a dead code.

That would hide bugs if the refcounts in the array got messed up. How about=
:

  /* This should never be reached. */
  return WARN_ON_ONCE(-ENOSPC);
