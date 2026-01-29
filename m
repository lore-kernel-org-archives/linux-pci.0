Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAF2364020
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769726002; cv=none; b=CCemYILz3A6pYehnB+38y2EB4osZmkbDmUZY+j5w8zywM11sDZXH2zmxZDx23pvkY6KIV6yrCahW/kZoyPvE9XiVaLxQLOteC2Xl8351kjGQL9g2IfxTAT08O17IWnZ6XQkFy7lM70KIRtrRrRnDpX2wC0HFFCBoHpankJxEVAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769726002; c=relaxed/simple;
	bh=v63/Q89R1FZp3eIace6yEluQWPmCvUnvUR/7uDkLuXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASTEl6m6ZuRswvv195LtduE8dsoKKpWkjsyVRKjON50bjkcsrRqK603h5NzrgGBNVsxUeqzMUVU5RRbNtX52BIR5y1sWhoBmH8vsALmwVYY9VTFiXLzLt6oFPOMgvGVJgtdBkaCQdMIAs0sQ/aWrX3CDbwAgdZU/YKcycSy32IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ByDLftJw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ByDLftJw"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81f47610542so876051b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 14:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769726000; x=1770330800; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dBZ3PFz9KqTT7KdM5e4cMtXwD446xZIZixlzxugjwak=;
        b=ByDLftJwm+ggKAtpqCU9sPZffMWsEUrPGlXYxLmcxXvEW2byFmmvqfi2d01fyEQEMb
         MwhFVh3cp4Y5o0bKokJMPdnGLYqEXcrActt5hjA6Zte2xnVh0jf/E3MPQ2Z6fRih8t1m
         lxR4LUyDfzoBoC5OH0lWEf6RuUHQpGHPtiHoOiZpgaWlOfdFQZ3hiJoXZ0VsorP7VNwt
         zbXj9JvDROjUvSKfSMLwr9R0sIDSR1JipmmZRm5xbVwZnNbvyQYg9vZt4NRHkezN3bEs
         qm9OC7jqRQeTcAdtpZgNSTOUzwAwWzJgmACaT4toFUT5eFZrRiThC4MtKcUDKYWSt7we
         VK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769726000; x=1770330800;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBZ3PFz9KqTT7KdM5e4cMtXwD446xZIZixlzxugjwak=;
        b=GWex1MxgrulP/o3CDmyZakYHvIlkv4BL5WyVTrFuDxaza83CTeIPynxbsb/rG/6ykk
         fWvuar8t0xFE353gtCWEey5eApPtYvlENIXniY1773T+VcmAb3LUfLlN7UQxosiYHVFY
         gF2sVtIV1IuJTf2psKLvJTC4xubOL6z+DoZfWR59XBucR+e5r22ul0+qycpjzRQZomcd
         0K3aMqOJFWAZrm4JpWksX0/BY0lvOcjDNYWzFLVBRK2j6q9h8Wd+PthuOBJejsPQLx13
         LkwpFc/P5IzUMrnxDkf5/Y2kwkzfYJN78nFqzXchuy4eW/Ky6gn5gU5DmJ2Q234x/c4h
         jJPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXu0bOnbvgKVgXSgjYLuHWOe/BAZTAxEMsMWn/Y+CCPnEaiesHvs6MNfJn3fcj1UKXYB/Tr71U440=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfGc3k+rTAHI9XwrEhlAl+oFsGq2XaFcp7drnfdJ86e2WcG7La
	+dmhFJuFt+gkn1Uj5HEyKksL+c7+GWNvf2Nic4HQAAu6Iej8HBbDezLApMgnxUC1MQ==
X-Gm-Gg: AZuq6aLIrWYGz6dUDnjUBKbKv46exRcEWDnvSD9P815WBy2IqM+JoSuYt4SDNwKpboG
	F5dZ5gS5tIdTgp6XBAbU4WgN0TtmGw44ws3TK1d52FfZ7/Ch/XXdMqLrXW6t5YqputnXCZSZbBl
	h3P+Y1t7F9jnZH889ikpa73LuDRU4Rtxt8gHNp8QLt6E0s+WSaUb7Y8KqpzAmO+6OdY9V8gdVe8
	Gqh2oi2fRsi0t01fQbMftD9M0iUViYbyGfcQX3a27ejlMOdp18bvalM2OoUkN2VxagQANrPMBOd
	rLgHaJluAkKqJIEkmJRA7w8Cx7ozbeTN63v+WNf/jSrpqNrtDA8QrVaM7TQs+q6iZ97stvinW5b
	vT9aXs21iIwW0WNah9IoWKGNztortwPp518RCURZMyHCrx8lsAeTj+ekPJwcOnhLc+aR65aEmv9
	9D3DqLS1Zx7X2r8HqcgY2UY/hjx753dJEYShRY8djXci6QhNbYEQ==
X-Received: by 2002:a05:6a00:1f0d:b0:81f:5ec1:8bcd with SMTP id d2e1a72fcca58-823ab684bffmr621422b3a.20.1769726000049;
        Thu, 29 Jan 2026 14:33:20 -0800 (PST)
Received: from google.com (79.217.168.34.bc.googleusercontent.com. [34.168.217.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfd797sm6165100b3a.43.2026.01.29.14.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 14:33:17 -0800 (PST)
Date: Thu, 29 Jan 2026 22:33:13 +0000
From: David Matlack <dmatlack@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <aXvgKRrbfymW5NKb@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-11-dmatlack@google.com>
 <20260129142158.00004cdc@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129142158.00004cdc@linux.microsoft.com>

On 2026-01-29 02:21 PM, Jacob Pan wrote:
> On Thu, 29 Jan 2026 21:24:57 +0000 David Matlack <dmatlack@google.com> wrote:

> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c index b01b94d81e28..c9f73f597797
> > 100644 --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -515,12 +515,24 @@ int vfio_pci_core_enable(struct
> > vfio_pci_core_device *vdev) if (ret)
> >  		goto out_power;
> >  
> > -	/* If reset fails because of the device lock, fail this path
> > entirely */
> > -	ret = pci_try_reset_function(pdev);
> > -	if (ret == -EAGAIN)
> > -		goto out_disable_device;
> > +	if (vdev->liveupdate_incoming_state) {
> > +		/*
> > +		 * This device was preserved by the previous kernel
> > across a
> > +		 * Live Update, so it does not need to be reset.
> > +		 */
> > +		vdev->reset_works =
> > vdev->liveupdate_incoming_state->reset_works;
>
> Just wondering what happened to skipping the bus master clearing. I
> understand this version does not preserve the device itself yet; I’m
> just curious whether there were specific difficulties that led to
> dropping the earlier patch which skipped clearing bus master.

Hi Jacob,

There's several places where bus master gets cleared that we need to
eventually eliminate to fully preserve the device.

 1. vfio_pci_liveupdate_freeze() clears it during shutdown when it
    restores vdev->pci_saved_state.
 2. pci_device_shutdown() clears it during shutdown.
 3. vfio_pci_core_enable() clears it when the preserved device file
    is bound to an iommufd after the Live Update (in
    vfio_pci_core_enable()).

I think it would be safe to skip (3) in this series, since that's very
similar to how this series skips resets during vfio_pci_core_enable()
for preserved devices.

But I don't think it would be safe to skip (1) or (2) until the attached
iommufd is fully preserved.

If you are just asking about (3) then I agree it could be skipped and I
can include that in the next version.
