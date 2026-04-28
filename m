Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025DF26FD9B
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777410764; cv=pass; b=ScpkCbdm3XooWM7FVjDFn6KuZNA/rA3A76g5eadXA9FV4SaNvTvc+Z0QbbTob4lBekuEmCuMiq4bWUprYfSClLh0b6HfYW38RuyZL36MtcTYtDjunDHladUmgQZhVqkHXuwR8v2LHn/1DwSxZRAgRb5/u7CM6mh8lrdOYJplJV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777410764; c=relaxed/simple;
	bh=+RPGe3HPwueWHOYhTgYMgmvZA/eWqyQvbZ6YEmo7TUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0yMNgNmiT7Hyy6wDOtF1NXkHp+bKC3YL96pRXXPZ8SHWah4MJj6BFPMIC23NaaaSlb90DmOuCzhECBMSOcKiTg67tmBMdmbBaKiZzy3TiEMtqPlaKMRp12yXl3Aa0tkfBcMCVZEMtrRdMP/y1JYVzN8e/peY3pG/mIXfWiLsSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ua5RxdY+; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ua5RxdY+"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38dd575bca3so2573681fa.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 14:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777410761; cv=none;
        d=google.com; s=arc-20240605;
        b=H/On5hnXvn06ytPjfPGV6GAx7JIh/RaBVhoAKTatRMXPlCKTQEzaagWrYg8At3eo2+
         /Bndw3hGj5h389R/UL4v/p7DE40MapMfVcaDMlIoSMVABHsFEIxB6AQKNw/c75zwN6vX
         oAvPn9Dz/uUqqbKirYvZEF3vdS7NptTHmcQAyXVqHvDmgy9zdPckcj0sbU5xzoNjY3ZG
         EfoCN/bIrrCCYwzXTI/24euEyS/auLoWdF1r+GevxpkZWfu1HeXH2G3nVgcVTQH3eNGo
         vNMl4HGk5W73HdsudGISpNZ/wlyKVaoj8DBM+MxrcCuM15Z08AZYROJ00tCLK1od+BVX
         D7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y1c0hsfQ1G9nhDHLSFuAkEDbfJtF8fRH5TAPVGQIJWY=;
        fh=Op6PVWmARA3j+tfR/qoN3+YyE3OngxuSFcvQBnIGnn4=;
        b=SUp/LXDsjchN6WcrKNjJiToMDtckc9JuSZMRj4XrVcbgalAVkiBNseAp3izZMQU7ZT
         wVFwPJRAuIR9tTZV3+sJwRLDRnGPdhsEh4AN3mGHpIhP/lvN7sHnqKnC5F5MUq0H3VyZ
         nZrSRktc11Pslascj4MnaN9LyqT8h3HxrepyxKG/WSwLs3TmmGC6dQ9INDYFytB/5VFo
         teSUqyqNExnfNmQXxNmNmBd0eiDEXJoY8hgMo3nQuIti5iTzj4M50pOG94MObIx/VX0B
         YNn3NONnfgy8bl0YZ1Zb6Y9WQ0JIJInQQclgYpIUdG+Oqexni/F7luSfDP8gqcAwYiAg
         3Jkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777410761; x=1778015561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1c0hsfQ1G9nhDHLSFuAkEDbfJtF8fRH5TAPVGQIJWY=;
        b=Ua5RxdY+nWnHy6DlxMX5GM1Hoqlf+orxmHpa+o5sNDijwNLu8PayPAZp4LPvcykOct
         qHoMqoUGOsz/GOTzthgTmeP9Gb6hxnTrlKDeESTEzGsnCDvwcVlR/ni2kLX0j0sIJMOo
         lBYUjwXVT8ELdD1K5cBIFRyhVF3yDKX5tNddB0JQ7bsjVZs4B0g4+ZYde9VfvoyZpnUd
         3Lu4G81O76e0QbNYzLOL2IWmbrwR33AGqRIYG/wbaOJQFRYXGwuoLzXuNIWr5RAMXhIy
         dr0WwMWYyH40PHEwOq/+k97m/+BICIjkZeRtbV+eC1dVrz0mcKU78OhZJCfiZgKRmZUY
         DuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777410761; x=1778015561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y1c0hsfQ1G9nhDHLSFuAkEDbfJtF8fRH5TAPVGQIJWY=;
        b=LNRmNO0doecY0aF8q8/YG+nGgeYFtKwGdXhi3J72rsscBx7b0J+JyZtRuLvNjBrTWN
         Vf+Lk+1svPD5ClEp1sopPJIcmjGRVk/oxBdbTM3IrB8F5DX4RTls/mXw5ejwbFkMd9fL
         8ijLoPW5RLCSVrZPIV7ZQCnTWiWYbDyr6LtRMF+IiVSYe2+ni9f5e617vEceCUbexYex
         Bbca9dhlaFOIwn512aOxm6W3xcPSVRvLEoNIxziVvPJfx8GSx41qlHv69rvu4gPLI42U
         bBhZF1ZyEBJi82sVZpUGUZ2Pva/tzybhvNWcQBw4jld8sIlIG3JHG2wKbNvMTpGFGhkR
         tQ+A==
X-Forwarded-Encrypted: i=1; AFNElJ8QJQ6SuXLgyxVp89CS9nbOzjSz94aETpB2JQYz5USTEFI2MEStquO+qJNpApHr5CVIKV5VFyhM+y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1NoZFWvBwJct/yU87JDbaSdwkq2MD9li3k3G85+t3CGjMpmdh
	tZoJp/Pu7DU+iGo194ZSfwZtWppKOGKU0HNreiNUAMhII6Rx6uFtuYiRKfe12xdtfU9/ZUY5HOE
	kilW+SdTpLSM0+cDnPRpTA6vw3JAELaic7rCTvxi0
X-Gm-Gg: AeBDieuuEtyHblEQ5DSiBoKa7/4uFcFsVp6a8520D+R7AyQauJVWh9+nEo/PuZDxM52
	zn0Dgy6WwODS2oC+xi1me4XaMEmi94HgmV5j4z2yQHq4GzmAPxXGBUoNV8JdgA4HI+TZ+Og6qXO
	o5KhiP6GLHiXT4SzXTV2uz76JP8rhcu6jSLUtgfwmH71dnL2hE4NOxJONFUDqqgZW5idlBZElph
	9enGTEE4DQyKfMVQ5lLjbVp3R0Eg9NIy6tjCWO22pXbuGQWVygv72lJKKv30CDtU+03ZkYTkn9r
	C3tasrWuTeE6BTRxachiWoOo4e3HZg==
X-Received: by 2002:a05:6512:1390:b0:5a3:4692:61ce with SMTP id
 2adb3069b0e04-5a74a32f180mr148152e87.1.1777410760874; Tue, 28 Apr 2026
 14:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-3-dmatlack@google.com>
 <20260428201231.GA3885809.vipinsh@google.com>
In-Reply-To: <20260428201231.GA3885809.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 28 Apr 2026 14:12:13 -0700
X-Gm-Features: AVHnY4K7jpha36hMRH-mQGhZech3LSC3uUxVbVP_4PPgBDawCFAtuaz99Nxadcw
Message-ID: <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>
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

On Tue, Apr 28, 2026 at 1:20=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > +{
> > +     struct pci_ser *ser;
> > +     int i, ret;
> > +
> > +     guard(mutex)(&pci_flb_outgoing_lock);
> > +
> > +     ret =3D liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **=
)&ser);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (!ser)
> > +             return -ENOENT;
> > +
> > +     if (dev->is_virtfn)
> > +             return -EINVAL;
> > +
> > +     if (dev->liveupdate_outgoing)
> > +             return -EBUSY;
> > +
> > +     if (ser->nr_devices =3D=3D ser->max_nr_devices)
> > +             return -ENOSPC;
> > +
> > +     for (i =3D 0; i < ser->max_nr_devices; i++) {
> > +             /*
> > +              * Start searching at index ser->nr_devices. This should =
result
> > +              * in a constant time search under expected conditions (d=
evices
> > +              * are not getting unpreserved).
> > +              */
> > +             int index =3D (ser->nr_devices + i) % ser->max_nr_devices=
;
> > +             struct pci_dev_ser *dev_ser =3D &ser->devices[index];
> > +
> > +             if (dev_ser->refcount)
> > +                     continue;
> > +
> > +             pci_info(dev, "Device will be preserved across next Live =
Update\n");
> > +             ser->nr_devices++;
> > +
> > +             dev_ser->domain =3D pci_domain_nr(dev->bus);
> > +             dev_ser->bdf =3D pci_dev_id(dev);
> > +             dev_ser->refcount =3D 1;
> > +
> > +             dev->liveupdate_outgoing =3D dev_ser;
> > +             return 0;
> > +     }
> > +
> > +     return -ENOSPC;
>
> Since it is executing under a mutex, and we already failed
> 'if (ser->nr_devices =3D=3D ser->max_nr_devices) check above, will we eve=
r reach
> here and return -ENOSPC?

Yeah I wouldn't expect to ever reach here.

> > diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> > index 5c0e92588c00..5b4c8d9e462c 100644
> > --- a/include/linux/kho/abi/pci.h
> > +++ b/include/linux/kho/abi/pci.h
> > @@ -23,19 +23,20 @@
> >   * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE strin=
g.
> >   */
> >
> > -#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
> > +#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
>
> Just curious, why did we change the version here?

Because a field in struct pci_dev_ser changed.

> It's not like just
> previous patch is working enough to perform a live update. As the config
> is experimental, can't we just keep it PCI-v1 for the whole series?

What is the benefit of keeping "pci-v1"?

I think it makes sense to follow the rule we set which is to update
the compatibility string in any commit that changes the ABI.
