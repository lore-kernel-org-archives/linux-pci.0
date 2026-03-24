Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FADA38C2D0
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370023; cv=pass; b=TDhAI/pSriL+ADZ0lvKeO5EobbKl7ygVYj62EkZqJh8WJQXPUqKX3QSobSaXjtPyC0STVfhcgwRjnGUKqdX5IdWW26wEbBOOlY9k4ngZYr8j3UxgqZ1ED4nTgFFo0FhIIsnTuJ1zjg0U6mxar8Zk9aNLJKFAlF6BGICkHZ9E6fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370023; c=relaxed/simple;
	bh=KyZccWfRZPRCXyH3JPYtLHqoTnA1c/Yv1X7rEaPg17A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQCCIvDVPdeWLH6msh+SGnsHMDsVYI8l+mXpzVSUC4Q4lN3NbWrvkqCdBZxgZdnLeArj+MhS/TyObl+nV5B2zRvhuQSC/cdlNQEx6pvDWWQ/C5Yv5MuU2y7qxv/4K1WUaMWF5ZlQAvLXp3sF/2454mHn3WA0HJxKFPeqnQyBl0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HW6Q9NWL; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HW6Q9NWL"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a126c8aab9so4759657e87.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 09:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774370021; cv=none;
        d=google.com; s=arc-20240605;
        b=Cb2XpSEjpHNkZeHTjrpwWDUGk39RqCntNWiX5vjbO79NBKuw66JdX1mEOcmT3BzS92
         WefbIICMQBZlpTfXNgDfYCTX7J9WsBu0bMQ5KrVHKpttuHGDandlX6uDHEmhhL6hw2IV
         slC8pYNCtusZt97gFDTfoASerOCkbGfHF32WMOZEy7pJb4vkgiX0+SlXoFwrzfSFgZji
         C43Y+OPnB0SXn6qXhE12M9mf6kgvqnN4s8G/IeNmVUOU3NgtmDwV5hwm3Bu70rKyq2bt
         0qelCqP8+l9pV4s3kqjLTVFbokALfOeHGfsO9NSrkiCDpDz2N5IZeNB+uY+IyZb9sXNK
         aE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f++PU3wwkpbB0N6cii11zfED2xylkHlgqhKc/U2ncVo=;
        fh=sSKuJy/gnBDriCY/G3FH15zqvTYDvHPO4H/SHXP1g4s=;
        b=TUu1QXhDXfg2KlHaIm2u5kH6oAYMr5gMarkJYTG2ztrlLg06NEktH2Ghia6kTBw4l7
         w4n9y+JgJn9VfqxW4LJpKl5FpvqFJPL10VeOrEiN0bG1zzCaFsVWLF3y2LC9Y1FYatmT
         VyBKD3f3Fi00HjBZOhO1ULfoBQdX8vwphGaDDA1BAuUuABlUNXuT5QoydYEKnJzEipFF
         +jUWvuCZd8mjSQprE2XaAWUwQOMuM/UnCR3eraiw6TJ+kG8Vc0IAZDTBROEm1AqWo7i3
         ZK7fq7kDXSOTsx1UM7PXuaivNjgAqZ7tO7rl/UZh/tEfvnPdJh+r1fIiXGpZe9sIBOHe
         ue8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774370021; x=1774974821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f++PU3wwkpbB0N6cii11zfED2xylkHlgqhKc/U2ncVo=;
        b=HW6Q9NWLycxYs8C8OOQKDxwRZAuJuQI9wdKwP6+z6AcgPywU01ml6PpY55p34Zdi1z
         xwwbe9uS568Mz3uM+ZUTpdl4x8sIZV3+5Xq0wiiZtI5mlflMpQLOP4d7CtoB6BPuukiU
         fZxn4j+WFmsZRFNUGas7J47gd9YQNXgYlZ97JH6kk3lVfdGiEiH4CygTGrkkB/ngLfRH
         q7muSWLsaGO2EqKJDYVHsVSl52GjCMhUbRNY2Xbd1qDKLL8/vESy4wESEkqSxtf5oL3w
         ibHgdDgJWGH8NY7mxCGKFzII/YX2lS3BAQFV/j9ZoJKuXTnRttyweZrCBuf7uekiLjUm
         FIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774370021; x=1774974821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f++PU3wwkpbB0N6cii11zfED2xylkHlgqhKc/U2ncVo=;
        b=c3TEKyNsiS4qB4oms8RHeww1pcGaFhAv6/anlyA3F0W0WDiF6agO7l6TGW7pqZrvhk
         Wb4pI7hS0OK49LCggTOkXzlcwyAX8A8jO38DlCOI2ETs5kHqqmJ9iBfkYNTSVysAG+ZS
         8Ly/NSKGDe5LesurTXX2t/VlyniPVSQJPYV/vIZZAJ8wT+Np8QkSFP45az6n3j7UFtK2
         GaJFAFfCJ+WW/kRE7vis+wZsggk7LOEp9NNdhsrQ7gWSXJE7yqo63bABBRyTkKarOXUy
         eaViHFP9y6eqeyqfnTK4pqK3/ZL7qxcQRdpgVpvtPMUYqBVMlcKp7c9mYMQJZB+uLWif
         2G2A==
X-Forwarded-Encrypted: i=1; AJvYcCWDeXoNc7FCfqZMwlY31NfZP7drQyP2DbsUxQybDu2PpEZ0b2R6ZDRvrp4u1w6yzDdVRoxpCmhf22g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP12UL7VAuZNxicNX1l4mdBQtpOjAr/PBk4u4fQPDiYrJBOkiz
	Nx8Rs85sn0PfNTJziOOw0fPqmKK24i/BWJ7gJu2KfBazdXTLw4+Kh0nqEp/53o8X28cL8W3fxXQ
	2ksw606HbgGb7SoXdXRMuDc7NW5zxVRzB+NBl48N8
X-Gm-Gg: ATEYQzzA7kVUD8Y6JMsFLxTzykbROKpn+bDCB+eIzPMyJvVAo/+Yb/iEPrFCbj6v2KQ
	Eazgxh3fhqjcagtrwe3Qy8KINyup6YH7Jadm5QeHlu9mE9iIgWAq+kr5M0I0PnyfYQIWo+Zq2kD
	zixoF5/IBUDXWcIs0Vu/RwQo4Ln/O9VNX6JqQXmXXH5qutGaw/DwqvSBlN+ATf6XmvffdWw6kBA
	iUMK3bH8yRouTSbKA9ArBpNhYHocvLFWMhB3udAZjQlRZKB9khH2SExp4EYl8DPPyWfuedTw7fx
	U5ZIhe47
X-Received: by 2002:a05:6512:3044:b0:5a1:1899:a0cb with SMTP id
 2adb3069b0e04-5a29b9a1efbmr55664e87.34.1774370018671; Tue, 24 Mar 2026
 09:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-7-dmatlack@google.com>
 <0d2eedec-01c1-41c9-bc74-0133ae6ebb04@intel.com>
In-Reply-To: <0d2eedec-01c1-41c9-bc74-0133ae6ebb04@intel.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 24 Mar 2026 09:33:10 -0700
X-Gm-Features: AaiRm530aoKtDDdSXYb9CaNnVHDZa0HeKfsko4zWVykFU0w66CUzojlEOk9szPI
Message-ID: <CALzav=d65Z1Va14rmoRcx5WrK1GfRvuHmrqK16wJJeTiq28eCA@mail.gmail.com>
Subject: Re: [PATCH v3 06/24] vfio/pci: Register a file handler with Live
 Update Orchestrator
To: Yi Liu <yi.l.liu@intel.com>
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
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 6:00=E2=80=AFAM Yi Liu <yi.l.liu@intel.com> wrote:
> On 3/24/26 07:57, David Matlack wrote:

> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -170,6 +170,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, con=
st struct pci_device_id *id)
> >       ret =3D vfio_pci_core_register_device(vdev);
> >       if (ret)
> >               goto out_put_vdev;
> > +
>
> a meaningless line here.

Will fix in v4, thanks.

> > --- /dev/null
> > +++ b/include/linux/kho/abi/vfio_pci.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Copyright (c) 2025, Google LLC.
>
> would be nice to update 2025 to 2026 now. :)

Oops, missed this one, thanks. Will fix in v4.
