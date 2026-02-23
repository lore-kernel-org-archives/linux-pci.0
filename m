Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7A537D134
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888131; cv=pass; b=TmS1vpV2hdsjLhK1elDNiGBY0LOjwx1eXzy2NrYN0Tn9cHF+X41aiE+0MSQ0DwV7wAad17to8yFg1UcdKKhVKAWaRrDHUpsDSuDn9wC22fw8NbD/G9gKF4BCDE/tv5o6A65E2QEMfPtBx/i4Dahb6lxUNd9EmPVX7p7QZPe79Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888131; c=relaxed/simple;
	bh=Ydbc6rbyk4KLWrkHSXSI7j05eAvfIq7SG6ROABriCE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hi39ymakq1Id0BdCsgpU5HzTjILqUjki1vMVrSsmnUQF+LoSsK/JIVOanb44Jmr+EBYBoqxhn7awY3qzoQIoG08NYiO9Gz5QOPWVgXhwMvpMrlMsKSx/J8dVjYzj0DH9N+x/PzUUsCD/c0Rk7XECMkorNz09hbmqozdGlwgKfkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d2jOm9V3; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d2jOm9V3"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59de8155501so4894594e87.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 15:08:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771888128; cv=none;
        d=google.com; s=arc-20240605;
        b=IhUMgM9XLgRj1PJt1t989tIR1r/JXeEnM5Yh4kiyJyPrprIjt+iQjUzcrfJUx/s1UN
         b00g6q35UNEaZpAjz/Mp/kmVr0gkrfeAPJmfWjFLY4V3OUbhxRWPxnKy2KZxYfRcl4Kx
         q7n4+NEE/WkzfPS9/PlumAO1AweGOB7P0+FL285auest2Wykt6rdfMj8O/L/Qj4TMH2u
         JQUTIKhKFyYPxI53GYwghLaaSFrzitNSwSkFCRr+ZIb2++VxpWw6Ark8sfFF/6DNDGUe
         EPmEFoMRYp8WcSzkkTCkNk3GQzMEBqZZIajlvz1FgeDXzzjc1o1J4XSm70Vz4gB8KSOH
         KP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c4ne1Ls/uKmuDNTWcMVVG01PBoi2SfFbs/naiop9R80=;
        fh=dSSRyNSIxZuN/g+ge8+dQxKjKLgS5X/dRY1grldx3qw=;
        b=RA52mFvb0fba6dNfMrLY0ZCej4TgBMvyYr75GTVUHYpP6uY2/QroYpOj3jKC1niMvu
         s7M8vfZfwk7N+RSRz2Lf0uVMBi4snozeV3jXUZuieOLeBGhO3xml9urC72fazkmam81a
         pw6hsABBHVwEblB7zlYQV3h9w/AXzpH28or1wm003HcVgTD10WMUGv3SiCERAYv9ki/R
         n8JHWO1O9kCAgq/2Jbv0r0GXA0Lzjo23MrnytI/j4vyQR3waWY+sN7U7i5uW+wYRWxnE
         8yHd2G5wRSMxnoXYeuFrwoc+hfEdrnuySRO/Ux4r9j/satJLs1VXv7KCotos8Qb97MbF
         NWIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771888128; x=1772492928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4ne1Ls/uKmuDNTWcMVVG01PBoi2SfFbs/naiop9R80=;
        b=d2jOm9V3cdZfFgFgtcOR6roP0zV6o54zg6vrHNIGDgRJKHwNbJiF1oKLByePDLu+RZ
         RvMt3et4QhS2OXYEZLCppfk879ITR1XE3hdUPE0ThGM4C5mKeUT1c6Dnw3A0lQECdVkl
         MLoG2wBeARg8OaPUQOIlRAOfeFOFaPvyTTni1e89jNXDRH3Y9eV5MY26WNXGwo94WMnt
         BXxRYZWJ2B8+cz37pMBIO8DoV8yI9noiFuHZhCyj7m7o3+hGADuNCMWgfkYrPxRDSG8F
         BiW+Yp8TW7QxilchJG8UantylCuotfQo/2+FVQfg77AktnxQ2HvZ5eoU2Dy5tsafT9wJ
         KNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771888128; x=1772492928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c4ne1Ls/uKmuDNTWcMVVG01PBoi2SfFbs/naiop9R80=;
        b=hnYlbI4RxL05F7U7bjQepELAtz6+Wfffcxvdgr/SyeQA35OhsswlGbiCQmQnpQuoe6
         RY3WeueI79+zgCrPTKfLKKEW86Jv3ZYQAQybGkso1EgBUXDRgUIUhqTjFouC6IY5GIIL
         dijkmnJLMjwAK2zEAlnWmBnYvQEAXan225kK732UATfMvW6j/8vXjUxV9uT1tRbQVid1
         MfQI8FJfRmogFvTjNRwBakCrF9pbsu86PbDim9L/i8rhb0K0zCk204uSEaCAXBviE970
         WF5O1ka/XaYqhbQJCoxtuphUCfk1n2UaytWhVaDKE3gxFxqxHFPE1/O/AYo84KmZFqoY
         nMLg==
X-Forwarded-Encrypted: i=1; AJvYcCVOI1sStAbJg6g5Jx6jlIcbon9dpGtNCZMIbIEyCMMGfgtGTwMXuaYzWIhMJ+JvdmVvx3yUjOP4MEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YykyH3+wZ13gXn/cP56276SeV96BwuNhyx1o7A3xoOqHF56jdPp
	6dncPRSz1KIzVR23NXkOl6ni7c0hHrHKjLevkSYIbev6u+ZRzh8P2LzHMUEzivY4Yal6lBgpbVF
	sncjPxywEy6AtfTZJF5A4T6s8/q/9SX+Vu9So3Tat
X-Gm-Gg: ATEYQzx6F7wH5Ju5jf1BixQ8sDQX1Vl09OJ+JKV87z4Mp2nHoFjOzvdpIY0tpPDTgmC
	YhlYY12j3ZQyDJdKIwKT0ssHAHV1LGt4xiy0zMxfMS6sAS+8Fd+3XJ3cCNlpp3P7P0/jzdaDppI
	G+DzdzICnkKZr+sxbmQFghiO5iTQ4DmJ/UcHf4RgVg2m6s9koHsx2029D0gxKupqqsmvb8cQwye
	UBg6m+9NJfUJgHyCDux5fcBLPR2bRMOLAdMFh6hznsWhnbUgfkzh4Ab5KW1kuxph+NBYQGB2cPR
	REGRN84=
X-Received: by 2002:a05:6512:3b9c:b0:59f:8546:1899 with SMTP id
 2adb3069b0e04-5a0ed87de41mr2986457e87.11.1771888127316; Mon, 23 Feb 2026
 15:08:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-3-dmatlack@google.com>
 <4mbhcmimhin2ulz57mbzpe5p5dkhfziiyep5k3vgls4zmom3sb@g6jlouyvmpuz>
In-Reply-To: <4mbhcmimhin2ulz57mbzpe5p5dkhfziiyep5k3vgls4zmom3sb@g6jlouyvmpuz>
From: David Matlack <dmatlack@google.com>
Date: Mon, 23 Feb 2026 15:08:19 -0800
X-Gm-Features: AaiRm50_OD8BarR0N1ju3iFQZFALazFmYS4w16LFHF58C19D7VPNrgpsKvMORCE
Message-ID: <CALzav=eXY=ZBshmpi9axt+_0SxaAm0Xbo7w==nCWJwKK3xcThw@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
To: Samiullah Khawaja <skhawaja@google.com>
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
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 2:04=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
> On Thu, Jan 29, 2026 at 09:24:49PM +0000, David Matlack wrote:

> >Drivers can notify the PCI subsystem whenever a device is preserved and
> >unpreserved with the following APIs:
> >
> >  pci_liveupdate_outgoing_preserve(pci_dev)
> >  pci_liveupdate_outgoing_unpreserve(pci_dev)
>
> nit: Preserve and Unpreserve can only be done from outgoing kernel, maybe
> remove the "outgoing" from the function name.

That's reasonable, I can make that change in v3.

> >+static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> >+{
> >+      struct pci_dev *dev =3D NULL;
> >+      int max_nr_devices =3D 0;
> >+      struct pci_ser *ser;
> >+      unsigned long size;
> >+
> >+      for_each_pci_dev(dev)
> >+              max_nr_devices++;
>
> This will not work for SRIOV as new devices will be registered when
> sriov is enabled and the max will increase. As we are not handling VFs
> with this patch series, this can be fine?

That's right. Since this series does not support VFs
(pci_liveupdate_outgoing_preserve(VF) will return -EINVAL), I dropped
the logic from v1 that included the maximum possible number of VFs in
max_nr_devices.

Once we add support for preserving VFs, we can update this logic.

Another way that pci_liveupdate_outgoing_preserve() could fail due to
running out of room is if hot-plugged devices are preserved. But I
don't think that's an important problem to solve right now.
