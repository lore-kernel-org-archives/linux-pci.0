Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC52175A9D
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225174; cv=none; b=Xyjh+sj6TVRQpXb5SC1wucvwJaxG11aWjFJoDLKNXSoWpIkhXgQ8dHFqla9iZ5sjejaxyFt6/37akH71ahNk2sUSpHxb0jqFm0antSoAKW70OM/lQwO71nlmilnG4Gj5H74hqQgnOwp4LAi2dta8H3xRmZk+ts3x/Hig+oqiWnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225174; c=relaxed/simple;
	bh=7ux0Lhtez84UEZLgPd0cB2gsvx8mSzbdmS4PsNfNucg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0ZNC/jpWV0uvl1q1qMHgdlbgbR094dDY4D1mew7RmEJ8QGbi49iObe811BPrHm4tAEPUlkWtsLOwziQCyIJdKOn0bU3D9t85+KZbYB1FmPxevbORyKAy2uw7uvCBULlWvjB/jud5d5/SqLuAaVZxr6Ap9JEPFvA0p2tuzhH9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhNJRBh8; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhNJRBh8"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69690062350so5589171a12.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782225172; x=1782829972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FHS7wdFy0blB17IMPzCciGeqlqmt5gtvVsIa9T7SO2I=;
        b=GhNJRBh8dKvw87U9wM6rTXmGlir9g+m0LHVuv9HrdiGR4CZ62kbWZ4JGWWNvwHuZ67
         EzzjqiCRhvJiN1KpDyZsEO3hjR6VGDicDRSO71e5nuyVlrANijTIkfBTSIQ//5rvxJdf
         eoSmct9Dr2TRMlG7vYqKATK+hN2ZwaFIy7dC7uKPzixJV0WqMNB6UZLYPEHCJCpMv87D
         /fTZlgbR/FFazagdeM9mXKL9OdOxCrkFBpPGk0ZwCn4VIaJI7G+HfSclitemRS/ky1Rt
         oh111FNPGT6USb90vuHEzKiY7JCuHoxGJbsRexg9kQ2sXuw7eQw9EeTwcCTozTrPUaig
         jwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782225172; x=1782829972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHS7wdFy0blB17IMPzCciGeqlqmt5gtvVsIa9T7SO2I=;
        b=l7U1Lwi2KmVczkmA+VRnSZ9m3dls+pXYs6zMGpDgTEKwl1cXS+4I196xgwl32+c1U3
         nUwhuTPwUXswQaqDySPXImggXDypVgpbwq53MGgV/TXG62lNv+VUm6OejTRsVMmIszbT
         3hdyYYB2oGCflpThCIND6l4lH5M8IV0nDDnYY2A7mPk9Eex7Stafo8duULf6vxQSTVbx
         /0g0jrCO9n0INAv4p7LvQza5KFDZtw//m0RVe/6wrB9kE0JOR4PNew1Ex81bAHfHAyqN
         MD57t8m5Qu9RC/fKpVIW+JZW149fnldBmYOx5Qa7/m+6uvIoklCq/fUi4YoEkMWQj8mX
         cRMA==
X-Forwarded-Encrypted: i=1; AFNElJ9dqH9TN+oRsYd4FX1tMCyfZgXfLZCmI+aoN8YPuWQeoCYOAUDbkv9TPmTcv1duTXvPc2WpgyKJcIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo7WJseROpT4KyB6Any0gmx62dDTWygro1JHaCcU+QyYtqYJWD
	QRhg+MlrGIKp4euRpRBi9MWUUb7BFjO6Wp/whd7C7QKCYh5lFqSFEr24
X-Gm-Gg: AfdE7ckl3g6xjkcJKr9urMfOV/Dn72QjNAiPNIUt9AeVnpzr8hM5eiAu9hkLYWb65xy
	oLEoEkeI7RPjqpfv+IB+uj6RL0SSGIMvHlYtcaSOF9hu20DCY/QNAHJYK4R57tHBMnlWiihsC+m
	zBDv9Zz5Ae1WBTIzYEYgI2B2aLsCcy1l1wEIxzIcKfMk9YkJXDdCu4yqt8mdUABAyE+IFm0aru8
	2C4Tjs0BmyAh6nd4FT20mimaROO16sHWJbNNj3Ok66a4bS8R6ocm37vRX3oYb5acPsfbOlneBxr
	8fOzu60Kaq3Kwo1rutx3WNKjVtrn4zqPrYC2TyiWTvqbGCbkSdrKcaonNx4neBd8Bcn74gFuq2N
	V8h6NJnuc233dqQuVuWTNGZXfC+D5rFHDK9fDNE/r2X03R7zlQRhFjCeO4IyS9C7dNstCZNC1MM
	S8/1joSPp8rfC2Hm6UmbJh8TM4OapA+bMMscucRqthIIiKByf8MnxwQkTroYdZli83i7JjBdIpE
	8GEYfWw
X-Received: by 2002:a05:6402:3221:b0:697:8f1e:e919 with SMTP id 4fb4d7f45d1cf-697dbaf6041mr1867063a12.1.1782225171581;
        Tue, 23 Jun 2026 07:32:51 -0700 (PDT)
Received: from localhost (dhcp-91-156.inf.ed.ac.uk. [129.215.91.156])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977b86de31sm4669848a12.12.2026.06.23.07.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:32:50 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:32:50 +0100
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: shivankg@amd.com, Stephen.Bates@amd.com,
	PradeepVineshReddy.Kodamati@amd.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: SDXI on AMD EPYC (in relation to =?utf-8?B?TmF0aGFu4oCZ?=
 =?utf-8?Q?s?= SDXI dmaengine patchset)
Message-ID: <20260623143250.xk3gzylxhcozgz7i@wrangler>
References: <20260623103204.qvmd5luse4vmhwl3@wrangler>
 <875x39ies3.fsf@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875x39ies3.fsf@amd.com>

On Tue, Jun 23, 2026 at 08:10:04AM -0500, Nathan Lynch wrote:
> Karim Manaouil <kmanaouil.dev@gmail.com> writes:
> >
> > I have a dual-socket AMD EPYC 9004 in the lab (I pasted /proc/cpuinfo at
> > the end) and I wanted to see if I can get the SDXI series from Nathan [2]
> > to work on them, as this will open the door for me to experiment more on
> > AMD hardware.
> >
> > I don't know if these CPUs are equipped with these accelerators or not.
> > lspci is showing these devices (four on each NUMA node):
> >
> > # lspci | grep SDXI
> > 06:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> > 21:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> > 41:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> > 64:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> > 81:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> > a3:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> > c1:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> > e1:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
> >
> > All of them have these PCI specs
> >
> > vendor=0x1022
> > device=0x14dc
> > class=0x088000
> > subsystem_vendor=0x1458
> > subsystem_device=0x1000
> > BARs= 	BAR0/1 512 KiB prefetchable
> > 	BAR2/3 512 KiB prefetchable
> >
> > Class 0x088000 is:
> > base class    0x08  System peripheral
> > subclass      0x80  Other system peripheral
> >
> > However, the PCI device class does not actually match the class from
> > Nathan's patchset [2]:
> >
> > +#define PCI_CLASS_ACCELERATOR_SDXI		0x120100
> >
> > +static const struct pci_device_id sdxi_id_table[] = {
> > +	{ PCI_DEVICE_CLASS(PCI_CLASS_ACCELERATOR_SDXI, 0xffffff) },
> > +	{ }
> > +};
> >
> > So these functions appear to be exposed as generic system peripherals
> > (base class 0x08, subclass 0x80) rather than as SDXI processing
> > accelerators (base class 0x12, subclass 0x01).
> >
> > Do you know whether these AMD 1022:14dc on this platform are actually
> > SDXI accelerators?
> 
> Afraid I don't have any information about these devices. The driver
> isn't intended to support them.

Thank you for the reply, Nathan!

Is it public information which family of AMD CPUs have these
accelerators? Could you potentially share the device's PCI ID?

-- 
~karim
