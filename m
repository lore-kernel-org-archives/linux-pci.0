Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA0B47AF73
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772230819; cv=pass; b=Igg331xAlFNMfGRlsAq7lzb0Ik1Pt2+CioDCBWeuU91TYOJ8RnIZsafBzzr8JC0OcAG0WbLJ7/MVIMue2UjXJ7E+8LGhd8cBDyo230JfSiKV/vCRXvUFVhkpzUBUlYExg1ONpYt6XYzy/e5NO0zUvcVzqpV44C8SG5PNKfMjRcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772230819; c=relaxed/simple;
	bh=GtsGyeZPiDudjfd8L49wF+hn5MDTTqKv6ZZkfauqv5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MamZ4CELlDqe6+2OTOFozcPfXn09D5PjlSm6GAtIjFK6m01yN8Ns5QGXcL20tkJwJW4IFFXp6qbbFONVOzdYUdWmmx5kCrzl+QoyUo4m60Dqg9rRxOEgfd34g17QI5xnPqpRXfPiIlGEEQOJRK//mn2EdNUhzPixqjYZ/36bu/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0MQQxTeH; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0MQQxTeH"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-386b553c70eso34228521fa.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 14:20:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772230815; cv=none;
        d=google.com; s=arc-20240605;
        b=A1+5gy2L+BksdKzaNR7qYcZLFdFTfc8o+qZWtCKQ0zeO9Js9S/siQ85Ke5KaxkyjGg
         M/WsdlpXepiszBfoj2+H1uYF6mCGW4WwD0b4TlxxH6duxfZY5GHdxoJY00RAIAQXuD3X
         2QWxzKSXpB8TUXYNMphGFXwYjgaMYaAhst5a+wBRganFFjEp2tE72A992HTtlZCGxxN6
         JNMKsWvoDdU6Z693NmQDmloWE9GHwQjOs22bHw63QhDSYjmcv0dmpz0+m17Ogb1UsYi3
         O3UGz/xuUpjoPBa2qqjHPyJ1cQ55KfohaJPzuipU0xyeiTVkC2X9eEPv82kddYaGTxAj
         7JNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WC3H5DEaZJ5Vspp5jAs+PxKz8E7K+Tp6LHW5IP31g2M=;
        fh=kBwKtmQlxg5s4UEIrlMkb2TpJByGZKILyTzlyttGAmE=;
        b=GveQHkMHHeWiDQqnTBJ569tONJPBL6G38lMDO0blaimGqW7V1LmeF5dEtv2v8+jWPJ
         +AnMRczGqp//Plca3rBeU6Cqjree1BxfnN4ztOq16sTyx1DZTzQq4VYsULQihygLF+uP
         0DWsl5RgQrV+oxlJV3h75Tv2D6DJ2RwsquF8XXUGKriQpFs+RExljZiQ4LOUrbowzzjW
         bCZxqxbClt/JANzW236uBiZV0lK+fQAmrXXR3Tza8/UT8Gc7Bh42xvgIYLkaEpbPI9rb
         u2uwkjz2ULRfJr3dj5gsuAeazYX+hhrQrK7u5C7oHv8FOupccCdSQBLYKRIxEdbzaJM5
         gFbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772230815; x=1772835615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WC3H5DEaZJ5Vspp5jAs+PxKz8E7K+Tp6LHW5IP31g2M=;
        b=0MQQxTeH4drNtPAxjqOERP30fqO8XGjxdB8a9Frg3KPY+t8k3Y0sxCohBY5MIxsuTV
         0SYevnvypqsMoj3K43Wvq1GOO30l/rBN1wyPGme/CTUWr1yUJ2QCoLtzogotQH3yg2O6
         d0rVcxDdYsnPoREkiLxgsIbopf84baaXx5kguZVoSSaXIyOBQaPlUuQJR7yqklfcEDzG
         y6+H9dCbQP+sX0YaMOwfQlp3JLknU8Sgfx4baCXMStTha/TdULiY2ks5COvznkqBzgHP
         G3WHoxY4XbgEXL/9dYBdBr78/vD3tKpWC9db+Q/AJSMI2Bswx2iLix5B6oYhW+txUhLK
         NwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772230815; x=1772835615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WC3H5DEaZJ5Vspp5jAs+PxKz8E7K+Tp6LHW5IP31g2M=;
        b=Ryi+zmEnrq4pSCHASjU+IC/gDr0sIoMHuk8XxDhKpd42mbpEswJ7QQtT6R/CG4HV19
         v3PRxP79aPmVq6DGG9cWOTd0eSYCzxVlVq8a9k3w+c3fSXVMq63dhpepC3lUFOI7rAG3
         v7abfep1U/Byc8VoEIZJY5YV+pPTr8dbXj/WjYJV7IGKZlyQNRSMlorTgtYmAQlkGid5
         vUqRrh5M3+IsTJG+KoOc649Q5NigXV1YXpDR6/xBEfDP2dtMgY9OLjwaqVVpP/hdvTYy
         YiqAZuBxwx2Po371meJi955yw2EN7hkYfT35bAkdCrdgQoBl4QqVquUsH/Hiiy2/Nndp
         c7rw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ427DwxYWvdE6fnY2hiGgw8Y4vYq6OhT6dzbQYQq2sTwPBqKkbfQM2O/BwNSgSuScRUzMGykF8OU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+zVibzb1bBxNREMIo2dlxbdcvWKbnFfRCyVKvqa+47mbTGkpC
	/MC2rnNNC3yR0ZWmj1xQTWXs3Ixo3ZbEIgmSCZ6bNbA4siVWqC5K4j8hl0PJh2Fin0FmeW9szUO
	OsUYqqm8U7s1/XKd0T7QR0vF4YiR69BTZ14YEBRNb
X-Gm-Gg: ATEYQzxPGMFRUxNk4VNlCP7MWsK8CDwGKTFOm2tLzjtQcFqmBSWSbcz/wpxK4nqWgXn
	Z2ynmcbe0CT2edZxO4io9Tb/XWTomXWSu8FWhvzz01Dl0fT2tEpxvv+WsqkAniDxLXyeFTZeB/M
	dgv5LZU0rweA1pgqAs+fvlq7W2UcXwYu1c+Kp+Nvv5JcooBRA3iyQPoPRKZVXhMqX5FCflCeBX5
	Tx0sx8VbYyWw/ku6wN4Z3N87j5ePrNJWzK7JWA8TJfmfuDuYNPp1i+itq8AnSFAsx4+wB3zPklE
	u78Y70jbs8Rbftql8g==
X-Received: by 2002:a2e:be9b:0:b0:389:fcc6:4923 with SMTP id
 38308e7fff4ca-389ff36c676mr32953561fa.36.1772230814172; Fri, 27 Feb 2026
 14:20:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-3-dmatlack@google.com> <20260225224651.GA3711085@bhelgaas>
 <aZ-TrC8P0tLYhxXO@google.com> <20260227093233.45891424@shazbot.org>
 <CALzav=dxthSXYo13rOjY710uNbu=6UjzD-OJKm-Xt=wR7oc0mg@mail.gmail.com> <20260227112501.465e2a86@shazbot.org>
In-Reply-To: <20260227112501.465e2a86@shazbot.org>
From: David Matlack <dmatlack@google.com>
Date: Fri, 27 Feb 2026 14:19:45 -0800
X-Gm-Features: AaiRm50CpBktJDVkdNswfpkBixm1XqIc04gAiSgoLOF5-QNcfKrgPA3B04Dkoqw
Message-ID: <CALzav=egQgG-eHjrjpznGnyf-gpdErSUU_L8y82rbp5u=rQ83A@mail.gmail.com>
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

On Fri, Feb 27, 2026 at 10:25=E2=80=AFAM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> On Fri, 27 Feb 2026 09:19:28 -0800
> David Matlack <dmatlack@google.com> wrote:
>
> > On Fri, Feb 27, 2026 at 8:32=E2=80=AFAM Alex Williamson <alex@shazbot.o=
rg> wrote:
> > >
> > > On Thu, 26 Feb 2026 00:28:28 +0000
> > > David Matlack <dmatlack@google.com> wrote:
> > > > > > +static int pci_flb_preserve(struct liveupdate_flb_op_args *arg=
s)
> > > > > > +{
> > > > > > + struct pci_dev *dev =3D NULL;
> > > > > > + int max_nr_devices =3D 0;
> > > > > > + struct pci_ser *ser;
> > > > > > + unsigned long size;
> > > > > > +
> > > > > > + for_each_pci_dev(dev)
> > > > > > +         max_nr_devices++;
> > > > >
> > > > > How is this protected against hotplug?
> > > >
> > > > Pranjal raised this as well. Here was my reply:
> > > >
> > > > .  Yes, it's possible to run out space to preserve devices if devic=
es are
> > > > .  hot-plugged and then preserved. But I think it's better to defer
> > > > .  handling such a use-case exists (unless you see an obvious simpl=
e
> > > > .  solution). So far I am not seeing preserving hot-plugged devices
> > > > .  across Live Update as a high priority use-case to support.
> > > >
> > > > I am going to add a comment here in the next revision to clarify th=
at.
> > > > I will also add a comment clarifying why this code doesn't bother t=
o
> > > > account for VFs created after this call (preserving VFs are explici=
tly
> > > > disallowed to be preserved in this patch since they require additio=
nal
> > > > support).
> > >
> > > TBH, without SR-IOV support and some examples of in-kernel PF
> > > preservation in support of vfio-pci VFs, it seems like this only
> > > supports a very niche use case.
> >
> > The intent is to start by supporting a simple use-case and expand to
> > more complex scenarios over time, including preserving VFs. Full GPU
> > passthrough is common at cloud providers so even non-VF preservation
> > support is valuable.
> >
> > > I expect the majority of vfio-pci
> > > devices are VFs and I don't think we want to present a solution where
> > > the requirement is to move the PF driver to userspace.
> >
> > JasonG recommended the upstream support for VF preservation be limited
> > to cases where the PF is also bound to VFIO:
> >
> >   https://lore.kernel.org/lkml/20251003120358.GL3195829@ziepe.ca/
> >
> > Within Google we have a way to support in-kernel PF drivers but we are
> > trying to focus on simpler use-cases first upstream.
> >
> > > It's not clear,
> > > for example, how we can have vfio-pci variant drivers relying on
> > > in-kernel channels to PF drivers to support migration in this model.
> >
> > Agree this still needs to be fleshed out and designed. I think the
> > roadmap will be something like:
> >
> >  1. Get non-VF preservation working end-to-end (device fully preserved
> > and doing DMA continuously during Live Update).
> >  2. Extend to support VF preservation where the PF is also bound to vfi=
o-pci.
> >  3. (Maybe) Extend to support in-kernel PF drivers.
> >
> > This series is the first step of #1. I have line of sight to how #2
> > could work since it's all VFIO.
>
> Without 3, does this become a mainstream feature?

I do think there will be enough demand for (3) that it will be worth
doing. But I also think ordering the steps this way makes sense from
an iterative development point of view.

> There's obviously a knee jerk reaction that moving PF drivers into
> userspace is a means to circumvent the GPL that was evident at LPC,
> even if the real reason is "in-kernel is hard".
>
> Related to that, there's also not much difference between a userspace
> driver and an out-of-tree driver when it comes to adding in-kernel code
> for their specific support requirements.  Therefore, unless migration is
> entirely accomplished via a shared dmabuf between PF and VF,
> orchestrated through userspace, I'm not sure how we get to migration,
> making KHO vs migration a binary choice.  I have trouble seeing how
> that's a viable intermediate step.  Thanks,

What do you mean by "migration" in this context?
