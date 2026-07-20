Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033F2D739B
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584852; cv=pass; b=RspiP3PCVV5WNUfw7C9EoVRRXz3CFwKWQHMGGIYLeqlRWoZHOSSgvYaj/crEchIDsUxWroD7A4TPJmPwosxrubf8VeP4fwlSpf+6cazTizkSNljZ/D40r9WK1xgLQiTGMWnJiE1w+Dm0jCi+Q5x+d6xlkxZmdCJSiHfGALNFZWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584852; c=relaxed/simple;
	bh=qeXXYXXoXBC9W4dpH975rfhTdv1IzKjF3KbKsLbRmhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eB/ZXp79Pn9VghQoPEcaxzL8TC4yhIIPQV/jjncDvqm/7jeAcRymg++lNthaFwnieJIxN6pgvni6dK26+2w2GaJ8QAtjfgbM8ECjns1YSKBXWc/gQQFvTJ6X4LWD5DDmJNAz2RWd/OV0eHQ5j8V98Nd3l0Irrj+6f75LGPMS2DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q3bgXtky; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3bgXtky"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso8294999a91.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 15:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784584849; cv=none;
        d=google.com; s=arc-20260327;
        b=XVhPiDapC43Xij4xSPV4SYfEfovE/43VXDxQxqAyc36+jwzFQwt01ffKwxvhUGYmMv
         06uEgY46VJNSkxShEr4e+QLj4n7Km6hB82QOp77+N69LZNG8kTszNOGfd/CnyPz9zdlC
         RrxJ5Ihr5JUhMF2MagUFtWleno8s1ep0dTblvXqZmQ9Q2uJfGYtCiJMc9oG6b3yMZFtG
         x7mRi24T/O2CFN6MNl7rG4a7aPNS7BicvwJFlXmgTpg6gdI+q6XZKozlGckthm/AwX8J
         7+o+8LLFffOTSy392xEVYVtfwkkd0YgttUYiCkHQloExie/yTA5i06H3zc3vKkztj6W6
         cw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gj82UvWIC9kB06K4+/XSzH6MrQ6ehsQ00zZOFqHM1MQ=;
        fh=s2yzvzsHRNI2rYHZcComlAf26mhIiE2fgh9jzLdb+oM=;
        b=OWWY+mPcqfvvRz2hGqxEGxIJ0h645F8dK6RQhstpD1zUJY0H9gYZHCyHSVAVK7KFf6
         wd11Wgfiu2GliPZRwbhbFZTntpkazus2kLth1Uf86P0nn3u9p5ArQ8aE5s2RdDxMCCT+
         e1d5qY8eCEQ78dTmSvMkGPPCs5dO714rJw8U5UsY8nKOg8KoFnktEggykHgvzeZ5jnQ5
         C9nCt0ALPzhKzbL7//wYKrpoJz2gpUJVvXlE2FnwjKewr99z+4ioupA22jCNGrhkTOdv
         IkmRJ1ahYOMkKg3xN3B5jzp/Td85s9Ap+13zvK0JdHMA/mzWx5Iwts2H0QQwppQhg4AY
         c9jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784584849; x=1785189649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gj82UvWIC9kB06K4+/XSzH6MrQ6ehsQ00zZOFqHM1MQ=;
        b=Q3bgXtkyzflaUSwFiUtY6GhqD8Pgb9NCzdLPnbs6mdWr7CPzFcNFwi0rTnvbn6PGLy
         sMuhWZoxHQEuBRAQfYe2+Ba6J2lcwlSDIZUDY6SJwako+hSXlC5Umcpwj3bJkaSstKIo
         HOgQNnxXcj0sp73aSCT43pxrvcNybpKVGVs80gzosfwyyWGFLhAf+uvKEkdhNGR+iJSb
         aRFKRavFsdZCrk8gMc5WXlhZJksddF/Lbwu9ZB6v8ERwar/WevMtbOddQav1bAtxx0cG
         Xps0R+7o5qi3UKpq4IWG0Cgu+3o+KejGI8typMDidiK8XCpy/YnYp9YqD1zqMyPtjfXs
         UJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784584849; x=1785189649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gj82UvWIC9kB06K4+/XSzH6MrQ6ehsQ00zZOFqHM1MQ=;
        b=VFDbUX+XTJQrOf984AR5aEl+XTKnD+3FrRd9P99CYZlW0ptBkAzRSLzD2mUqbqrtcN
         8WYIhO3DbIhv11Vo024ehCSm7VN0XE14RKHDv2KTZ3BE1vEp0jduqi66mhbrftJSR1dz
         7HgcOnyhK4dReLWnHakvNgNXl6BiQOtyLsxu+x82CqeUMzSiArZFGnCTLWQnd8u5nYBu
         KSBYE4TPdahywKRc0DXH2XYTrnsnlXZ4cd1w6V2jZ+cT3p/4qAuM/CfCQ/sgGDF3IwaY
         ssovoQjL9HpUFVmZmsEkRm/2KimXYvggRPGvqBsOswat1ZKNg0TM1FDgoEmEH1HPk6ZK
         IJew==
X-Forwarded-Encrypted: i=1; AHgh+Rp9vaoHwtwvrByfGeEIbhJLEFXaeVk7t2W8XNp7fBlmB3Z+jbmG+KiSKIOoLLcrWOrBlj1eJmivt+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG6OBrQMa/VA6q72V0oFosOIStTBRzrfbINi9U2AuZ5W1oi1VW
	MqQb/rGxTYkFuQtFoTELZysjX/b19lD5TnkHZUAr2teN/fqyVuq829Dc2JxqnrN/dRGfiqttHpE
	3tNVh9x/rseq0bv6iJT8UFq9Mtt7o42Hu3xGZ4pJw
X-Gm-Gg: AR+sD13vZf+PxK2x7ZekDSHqgCSGxHcgvXaTSfDf/hXe8CQDqzNT+a9QLYwSdi0coh9
	zRg037vO+gYWGsJszReh1i8OobcqrA6iJSa+1qKD5rTns+gtX6XllGNQgvoo0LeppZicIzQA3mU
	+a8ZGsZeb6uy0QpKVTfVXg3tyLvRMyFi6J3KlA7c++75YKy943in6yN1MT0W78hgMDWoazcQMKn
	b6iigTLhz0WiOhY1/IbS/fHMc6Px4OFG27RihC1g6o4jSJYzGX5a4EOzgZ/ng==
X-Received: by 2002:a17:90b:1dca:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-38e4b454d1cmr17323817a91.10.1784584848356; Mon, 20 Jul 2026
 15:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-4-dmatlack@google.com>
 <20260717163820.6bc8c13b@shazbot.org>
In-Reply-To: <20260717163820.6bc8c13b@shazbot.org>
From: David Matlack <dmatlack@google.com>
Date: Mon, 20 Jul 2026 15:00:21 -0700
X-Gm-Features: AUfX_mzNR0w-MD4Mb6dfdU632NpNdotxFCmghB3mJDm5NOOEi_E54XencSYW9rk
Message-ID: <CALzav=eQ-0rbxh6Eekbt4zUoNGNZc_THmSCvVWVwE3om1BPtdw@mail.gmail.com>
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Alex Williamson <alex@shazbot.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
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

On Fri, Jul 17, 2026 at 3:38=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> On Fri, 10 Jul 2026 21:26:06 +0000
> David Matlack <dmatlack@google.com> wrote:
>
> > @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev=
)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
> >
> > +static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
> > +{
> > +     struct pci_flb_incoming *incoming =3D NULL;
> > +     int ret;
> > +
> > +     ret =3D liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **=
)&incoming);
> > +
> > +     /* Live Update is not enabled. */
> > +     if (ret =3D=3D -EOPNOTSUPP)
> > +             return NULL;
> > +
> > +     /* Live Update is enabled, but there is no incoming FLB data. */
> > +     if (ret =3D=3D -ENODATA)
> > +             return NULL;
> > +
> > +     /*
> > +      * Live Update is enabled and there is incoming FLB data, but non=
e of it
> > +      * matches pci_liveupdate_flb.compatible.
> > +      *
> > +      * This could mean that no PCI FLB data was passed by the previou=
s
> > +      * kernel, but it could also mean the previous kernel used a diff=
erent
> > +      * compatibility string (i.e. a different ABI).
> > +      */
> > +     if (ret =3D=3D -ENOENT) {
> > +             pr_info_once("No incoming FLB matched %s\n", pci_liveupda=
te_flb.compatible);
> > +             return NULL;
> > +     }
> > +
> > +     /*
> > +      * There is incoming FLB data that matches pci_liveupdate_flb.com=
patible
> > +      * but it cannot be retrieved.
> > +      */
> > +     if (ret)
> > +             panic("Failed to retrieve incoming FLB data (%d)\n", ret)=
;
> > +
> > +     return incoming;
> > +}
>
> I'm having trouble following the error escalation here.  What's
> fundamentally the difference between FLB data being provided and not
> compatible (subtle log message) versus FLB data being provided and
> compatible but we cannot access it (panic!)?

There is no fundamental difference IMO and I think we should handle
them the same way (panic). The problem is the PCI core cannot actually
distinguish between "PCI FLB provided and not compatible" (should
panic) and "no PCI FLB provided" (should log). I would like to propose
changes to LUO so that the FLB handlers can detect the former
situation but that requires some non-trivial work that I didn't want
to block on.

For now, I guess you could say it is up to the user to not perform
Live Update between incompatible versions. I can update the
documentation.

>
> Don't both suggest devices are running but we can't get their FLB data
> to continue letting them run?
>
> The errno interpretation is also slightly different than the comment
> above liveupdate_flb_get_incoming():
>
>  * Return: 0 on success, or a negative errno on failure. -ENODATA means n=
o
>  * incoming FLB data, -ENOENT means specific flb not found in the incomin=
g
>  * data, -ENODEV if the FLB's module is unloading, and -EOPNOTSUPP when
>  * live update is disabled or not configured.

I think the only disagreement is the lack of specific -ENODEV
handling. Is that what you are referring to?

>
> Thanks,
> Alex
