Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABC34248A0
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584520; cv=pass; b=MZrBL3Hy9AO2WjCrhoiVUROylsBk4rMWMa+08B1qk8l43e4/RNsUVrVWBvAqsrNzGPJz8/WmSdIxxjoZjYYAQw1iYcZMHTFXJRco/YswCm61xj/+ky59EDalqYwN4mmBBXX8dX2C0jzFWadbd630dtbwgWSD6TQbigGIL2akW5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584520; c=relaxed/simple;
	bh=D/j1C6kmseQgrsCTCw4oe5cpvUdlEQPiJRprWhYCNGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKWsQ8ZIFQ07sXK+V4AWsNCX0Tg37dB70EpZZeK26PmlRa5sCioSD80Ics4YIo33QIC1ycRdpSZVj99FQO45/xjcxlIJbxKG+eItpNvmYPH4fj/MT6rIcwGZESx6hhKG/Vy6xD2LxyVp2ELUUQZ3tES1r+CvWOsflwLFKa7jHMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HyBpl3yM; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HyBpl3yM"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso3369198a91.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 14:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784584518; cv=none;
        d=google.com; s=arc-20260327;
        b=EtBqIzCdE0I3C0lHmjjfVF+B0GvZOQhn+qmSWBcYQZG8yVUACLDzMDsfaQVbSM1co+
         V3UrfZmijsbI8CIw/3jWnPmXj2SNnd2qWRf9jMRh3I2Tnj6j2LTlO+mBO5pi7UYaqOBe
         xk8LsEhWRi2cN8WYbEMPb0ezjh3CE3ABMLQMnJhSskxjkb3hKT/ZygjspuIDAZWDRn/K
         rEDNdDPllmdfumorDvc5r0OG5tMnSEnFpgAXbNykJG/3czsOF5dlP4bCLHB4r6slVsQH
         nIt9YdW2bqjw2G9MB6g9yFMEXGA/XR7VWYTm0PevtSkx8OhTZDZwhkJQnSnDNihUNAC7
         2yxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9mE0sfVA6cta9/M5CvPkkpA0kKt/DbFANSsjRo5aapo=;
        fh=NCgIJubrFuv+EwvHIXLkRKrmBgXfYLtiRQXT+R4SY70=;
        b=RcX0n5u9BPysIvSVSzn4jhQIHCGWoDEnPXJWDYwo9lkFvjMkxprmkcOMghCI/e/Ips
         MAQ6wbGTFE1Horb9paaccw3fvJ8500CwdvH4ZwqWGNqplBpCRHGb/Ok5xNuzTXwHI/Ls
         YCy8dCZSAo3MhP7AKif0Mohp5BGkqJSWoxezVe8FLNJPvkqPvrG3hQDxj3tD1UNxUEwp
         JrdeqmxVUN23dAjCV6+DKB48PNOL9Auut4OFMjVS28XQ5/BB5Uzn3q/9OcGEHUF/mxUs
         wVN82cUJ2t0VMc3h/ThYabYO2Mfa/o1Qw+VvAqlOyDvov4zgLoLFbRoHAnjTJ+TQKWYd
         2noA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784584518; x=1785189318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9mE0sfVA6cta9/M5CvPkkpA0kKt/DbFANSsjRo5aapo=;
        b=HyBpl3yM61QnFkKtCw8LP2AtzFWYKLyLtX9iwY0cdcwHN//wXoZ9CFrKQ3CKsW7Mch
         UQDLFShbpbST00elNCg296D7gtwMkWqlykU5tYPomdU7qTcuDFI05E2JBpLPqd36imMF
         v2zbuWKwwsy49/ccoiBayIDxSYL+ps76X+RQrCf5GpZ63gav80UswM9opZ5bJPuj2k0L
         uO4jbgVf3lpLrkgtaO2TzmUPIPDXFcTPHcCkuu745ItUXVh1+ExuYy9lWyLZ+b486nMc
         aDeu5sk60qg7hVSFaRMm9pZAGvBSGCdvOTbAwNce3VD6aOCLf27KjKMETSpnsc7QYqyb
         J8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784584518; x=1785189318;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9mE0sfVA6cta9/M5CvPkkpA0kKt/DbFANSsjRo5aapo=;
        b=lzWS32Uyj7CeydylkGVzNayu0F+DmoJHEDRRJtdf69fnE5bapMP+u7b64bzKyaW1c0
         zfsYp+ji4p/sCQKZ8sIe+tZQqtvvWEHVFGdeNEDtcAT57UiqUwCtCszAZI1qSt86wWS4
         +vEp5NUaDgY9britFYOwcQa7BV9EfQeb2BwXJXfrU+mD3QK2049f+xM396wEVNlrIIad
         hKeqo/Atfv6jga2BDHMPqBOfE7lMHKyDtFup0xUYM6EKtCPgH8fY9n0G37lXaNkY3QgO
         dGC1vKPdki7kA6zsbnb9aY/WPub/6rwMoKR9nUaC0MDZwMnxSK9W21SNPeaVtXl6cOad
         xnyw==
X-Forwarded-Encrypted: i=1; AHgh+RoJpviFiX8vHAuy++z3e9Pf8N0lv3lteg/r+h4DNQWIBJJ4KTNgnuzLKN3jCbG3uGyWtzTrgJpEDfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHiKSWtNjK5xkjkW5B0pjHYtCnhlBqoMVyTSVXx80PDE9i376Z
	DxD9vvIFRxUsJcUmW0phC27x3UbPakQupGJcukCG920QBrvmw/Hy7h3QbjrFFFR1ORVXCJEQntt
	FsOAXKcY2eaANFX4u+53On+olgAlWIjac7BzfyXyb
X-Gm-Gg: AR+sD12Aph+o2n/N/GLDH/IVoBsgVv6UXzNgqo1WV3J0GQwkRAdEqtFdU5D1X3JNUO8
	fvJ+xpAGN679IWRlwWZ/WVw0+cXroDHjw27ocEeUOsvDIHh6GQAWNHvelqC2TjR7kZScIU+bLwn
	IvsJcjeipuc+W7/WHZusgju10dTLqvmFvV4z5XUjpBjrGARJUXqpaRxrwNXtEhnXWMl2uABzFt+
	yuaTbJgrn3UaRSHFx4tj4x4PUV0YcAVO7DMku3jI9Q0kb+iPtQf9aGTYDWmEuvVKT7x659m
X-Received: by 2002:a17:90b:1d01:b0:380:8bb9:aba9 with SMTP id
 98e67ed59e1d1-38e3d13426cmr20701271a91.3.1784584518042; Mon, 20 Jul 2026
 14:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-4-dmatlack@google.com>
 <178432481253.189683.3297727348836286619.b4-review@b4>
In-Reply-To: <178432481253.189683.3297727348836286619.b4-review@b4>
From: David Matlack <dmatlack@google.com>
Date: Mon, 20 Jul 2026 14:54:51 -0700
X-Gm-Features: AUfX_mzVY7YuVDoFqhrPV6EULV5udJxArm79VLoT9W377bOVTdCDKuzAWRnUCOk
Message-ID: <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 2:47=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Fri, 10 Jul 2026 21:26:06 +0000, David Matlack <dmatlack@google.com> w=
rote:
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index 03075ce06ac9..df6a02240aa4 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> > @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev=
)
> > [ ... skip 76 lines ... ]
> > +     /*
> > +      * Hold the ref on the incoming FLB until pci_liveupdate_finish()=
 so
> > +      * that dev->liveupdate.incoming cannot get freed while the PCI c=
ore
> > +      * has a pointer to it. It's better to leak the incoming FLB than=
 do a
> > +      * use-after-free if driver does not call pci_liveupdate_finish()=
.
> > +      */
>
> I am confused by this. Each preserved PCI device must have an associated
> FD preserved with it via LUO. I.e., vfiofd would need to be preserved. If
> the vfiofd was not reclaimed, and finish is not possible, that vfiofd
> would still be owned by LUO, and therefore PCI FLB refcount would stay
> positive.
>
> However, if finish is possible, and this is the last vfiofd that is
> finished, FLB will be freed as soon as the reference count reaches zero,
> which I would think is the expected behavior.
>
> What is the point of holding a reference here, instead of only for the
> duration of FLB access, i.e. to make sure we are accessing a valid data?

The duration of the access is from here until pci_liveupdate_finish()
because that it when the pointer (dev->liveupdate.incoming) is
cleared. So that is why the PCI core holds the reference from here
until pci_liveupdate_finish().

We could avoid this by deleteing dev->liveupdate.incoming and,
instead, fetching the incoming FLB and doing the xarray lookup every
atime the PCI core needs to access the device's incoming ser struct,
but that would be inefficient.
