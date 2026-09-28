Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D8E378822
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619463; cv=none; b=KELaRg3ExBXFi+gl2RWave5ILpTswKxL7uKFnDkRiaod2QWeLaJEC3CLohtm0B5qTlX1R+hxCJl870Lxt0S9MerOPfx5ZtNeMfbBTStl0w1y/rq9iTxsuL3MAzuHunIUwAUU90MLXV+efPG0S20C3ncAtIFFkupxfb4/vfOOV7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619463; c=relaxed/simple;
	bh=t7wnAbQo9fhp75YDIZ8Di2uLMxtaqNgTQQQgRgB2y7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvZBWFzpZVOFJhKRlkBfyqux3QS+IKYG9exZXCBx9ZADiYtRMLkGBxka+z3kw5OnylHIAltwqLwx1FJNkfoE/ntXGZBmPMXra3hzMHhE0liUH5+kHZgX7I2dCGuEJBPOCSqfPj391RTwOsnnG5V7f6/wDsG9a+UDygZsKx2qveY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbLERrcq; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbLERrcq"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d391aso25041405e9.2
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 11:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790619460; x=1791224260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7P4n65OS1muIcpC3FLPM1Cf6wgXMdF30weAgyrooSwc=;
        b=cbLERrcqKD/iOx0zNL9szerynmLpYRmAEg0WAk2cgUSNgqaSYG4iE/hkL5Meo8zWZk
         l6AuMPOzBoTZTosFX6LNrPtQ372ff3ATLSqxr+Udv2PeFJmRoyS+4en3Zhc/A7pIT3CQ
         +BOV9ypIyujKFzljQPwviI3CYGPJ7BoBNv/JdhDizZVBzyT5ib6P4vEw/SVDAKm2zyl7
         LEWs66oHgK4DVjGIbuVbWkJO34NM42NXS/sTrQevGaqXILZFAMKhydVefE/UycrGgftZ
         VA+lhwc7CIjNrmIL9Jjpx5Sy9yTqxzMci/bTEFzFKFmxz29IKm0Wn6lh9QMFrnlUT1R3
         lBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619460; x=1791224260;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7P4n65OS1muIcpC3FLPM1Cf6wgXMdF30weAgyrooSwc=;
        b=es7HDTzjowDGtpR4GmG0MNBssO1jcEwUEtlMWWEgXrTHBoPLtQSld1KHOAk8AcxyMj
         lFa39+nVf6nHY8wMI0NtUUVJE+atV34oJ6CcpdA6gyPAV9H+M8tbJrHNNsD0GBxH1jMa
         NA+ryVyyxgZSV8uQJueFEqdVEziHcrXgYefCI9MKSc/9MK5qyd7viWRsLvUWhVQgg0VP
         W62MppWSHEOkAKUqRYL1P4KjMGN60T1G/mh6UpCDJAAzqR+6T4t7tDtuvAZC+e6wGLYO
         5iFj/i/h/QRRKyNx4slh0jWxbabwgDcLOKfx5ehxFR2Cn3IVuJwUS/81tCpQEm6ULsqI
         L9ow==
X-Forwarded-Encrypted: i=1; AKwUvBziYa0idbxKeFmGAohDaicpLaBHXeJ1AwUHr5pzD83lWS0YIKsopTxhqGO3gIYwKJ4Ph7rE2Yc/TXI=@vger.kernel.org
X-Gm-Message-State: AFuF++kwZ39bU2WYe/eWLSWWC+G5SwlotWIY1+9koOlJIGt0jxybkDno
	BXz0JhKEXEnRlTWmuCNfB5j/SuJmv0lFZMWBB/VkOT2NlVTazwwDUSHo
X-Gm-Gg: AYBFou0r9VSIaGJlgI5HiwOp3a+NsP8zcFwL9PbNxAf2LbaZuuDjwCO+Yl4h9yoiyg6
	JA8QZOXwfR+yNfAeNvjz7S0xIfQ9S5BQ3Zl6jmFBbginQ3prnxPIXHohqSMaI1YYnYvvE1sYLfE
	rr7dA+QpZeRVRmhXZPs4ZjeGVzu+5duMAB87KFLdsb5b1sTA6ObxYOium+crEF7d6teWTmgH2es
	aD8PtB1sFA3UYDi5wHXv1PrzLVRXbO9zM7TWCeqjSdbKQV00rzqLczebAOO1kLgwHzZgcm2/JBP
	MNp4kBeqHLqMwpNkZEmNxLdTDO7Z5IPxH2K0q3rsQopLCb1wB26VQj30k23lnnWsm4qC0Fd9LkY
	OML2X/dKq87tRbawAh7VXNmrrZGcf84HNQ2PrClRFThJAJhhQnAaQteuSTsloZcgY+zw3QziBsr
	nP+gFKoqbk2ANeWrzgyiN0qCTnPaVAqR4djzchdj5XjSl9a8HIfA0yd6zEZ3z+xh98c3NDWoBxJ
	hxjNMsgyt0FbnVUXgmL7OTAG7JJUjwyOmM=
X-Received: by 2002:a05:600c:3511:b0:49d:17d4:d6ad with SMTP id 5b1f17b1804b1-49fe66fca74mr225174635e9.23.1790619459558;
        Mon, 28 Sep 2026 11:17:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9b72fsm14819315e9.9.2026.09.28.11.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:17:39 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:17:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] PCI: sysfs: Reject unaligned resource I/O port
 accesses
Message-ID: <20260928191737.20c8a985@pumpkin>
In-Reply-To: <fd1753ec-020b-b90d-ec1a-9d21ab2fa9a4@linux.intel.com>
References: <20260928123036.7902-1-kartikey406@gmail.com>
	<fd1753ec-020b-b90d-ec1a-9d21ab2fa9a4@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Sep 2026 15:57:23 +0300 (EEST)
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Mon, 28 Sep 2026, Deepanshu Kartikey wrote:
>=20
> > pci_resource_io() validates that the requested port lies within the
> > BAR but never checks that it is aligned to the access size. A
> > pwrite64()/pread64() on a resourceN file with an odd offset and
> > count=3D2 or count=3D4 reaches outw()/outl() with a misaligned address.
> > On arm64 this becomes a store/load to a Device-memory mapping
> > (PCI_IOBASE + port), which architecturally requires natural
> > alignment, causing an alignment fault and kernel oops.
> >=20
> > Reject misaligned 2- and 4-byte accesses before they reach the
> > low-level accessor. With natural alignment enforced, an access that
> > starts inside the BAR cannot extend past its end, so drop the
> > port + count - 1 range check.
> >=20
> > Reported-by: syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D7134530b25073b4ef373
> > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > ---
> > v2: Check alignment per access size in the case 2/case 4 branches
> >     instead of using IS_ALIGNED() with a user-controlled count, and
> >     drop the now-redundant port + count - 1 range check.
> >     (Bjorn, David, sashiko)
> > ---
> >  drivers/pci/pci-sysfs.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 1f21856aac8a..8118cc6b3a61 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1209,9 +1209,6 @@ static ssize_t pci_resource_io(struct file *filp,=
 struct kobject *kobj,
> >  	if (port > pci_resource_end(pdev, bar))
> >  		return 0;
> > =20
> > -	if (port + count - 1 > pci_resource_end(pdev, bar))
> > -		return -EINVAL;
> > -
> >  	switch (count) {
> >  	case 1:
> >  		if (write)
> > @@ -1220,12 +1217,16 @@ static ssize_t pci_resource_io(struct file *fil=
p, struct kobject *kobj,
> >  			*(u8 *)buf =3D inb(port);
> >  		return 1;
> >  	case 2:
> > +		if (port & 1)
> > +			return -EINVAL;
> >  		if (write)
> >  			outw(*(u16 *)buf, port);
> >  		else
> >  			*(u16 *)buf =3D inw(port);
> >  		return 2;
> >  	case 4:
> > +		if (port & 3) =20
>=20
> Why fon't these use !IS_ALIGNED() anymore? You can use e.g. sizeof() to=20
> connect it to the natural alignment of the type so you don't have to use=
=20
> literals at all.

That just obfuscates what is going on....

David

>=20
> > +			return -EINVAL;
> >  		if (write)
> >  			outl(*(u32 *)buf, port);
> >  		else
> >  =20
>=20

