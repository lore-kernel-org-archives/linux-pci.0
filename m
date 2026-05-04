Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4381E3E3C53
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915457; cv=pass; b=rilUH+eWLWFMevfLHbO/GyVjgdicd3AMhkmBT7DU1In1JeoXmNoBgv8Y+F0HJ6yyjVPYVIkDVsK635vzczhx/zCZAOEBx3EbRyXeJMH1WvDX/hDFQd1Ah79UYpzHSo7QhYqCepugubyZdHzMn3SB+0CH6qd/4rHhCkk4hYLLIhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915457; c=relaxed/simple;
	bh=GyTv8qCOVeKZc1v9heh9q2u8oTrZt8SPcXhTl05cfUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMg6WYfSKNEprm7okvmcsjKb6IgiuvTFg/Wq3kA/oQ9v3vcqRPeZdoonXCZj580aqzp8FUvsWxRNCxxuqrhNE08PWwMeNGdiWMqnjt1LoyoZHL82SqcWmpwvb9RgthtA35a7ZMDV2awzR1SQhBcgM1h2JjS1CR480R/PVIgLedE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E1+T0jvX; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1+T0jvX"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12713e56abdso3028568c88.1
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2026 10:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777915455; cv=none;
        d=google.com; s=arc-20240605;
        b=NE+0lVL84HOlmVKbK7dUVPepL3k2jXc6NcCSeCJHn6Zjeunb4a1oYL/6/sFfOm5/q6
         5wsMYUBwpv1grQA1sMRFU7VzV9Jl/9FvdoWITfwgRvzXY8E+VcmC/zJ2BX9G0UQ7yJyX
         3SD9a1uLhu5h0BKPbeE8eCnd/HFbVwodr/JuqfgMZ7jZVz7+s3yldxu9RI7wl8uaGe98
         cEp7UZ33YkIQCh8RYG5qqspwHt6+wYTKeZHbFUtixdx95kmNHvnHNKkfMDgiP1dfAF+W
         bkDOxts6aYvVMfL27KMakHqIgkK1JueoPW9UKR3qw9opW6xQS0q6XVOmG7SMyVEKW823
         i85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8DRIGBANyTxbRVKczgT9uBMklmvWRVuW0duqUNmLE+k=;
        fh=G+9vKX84hvpoAFI1MZ8XwDelPTzjdfF97MrorYnrAnA=;
        b=Wla9N5M62V6hyGWnTP5rKPHSPSBTzy5kglrC1BR4P6wDiQrc4Ye6jrl06F93rIGwSU
         3h4n0ahfeRXN5FplVA/b44kt1QPrh88XHRXYwQttwl6vDZz+PQfsLq1uj+tVD4M3UiKw
         eIhRmdExQwAT7XzRY1VgIVOIta2+0YEVrBczSeDVwHi589C/osmh+ws7y8HmP/+NrCxI
         Z6Eg0GA+vKHZGK4di4dYUlgyhxtud/GSywN1CydnMEqdEhGhFk1a0rJ3ZeLyInzHg7h+
         2B7HsVw4pqvl5mYxVez/B13p/QnUpCMfsBLFqt9fs6lOM/6SlwbNVhrE9KbIA8ICA3IM
         JUNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777915455; x=1778520255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DRIGBANyTxbRVKczgT9uBMklmvWRVuW0duqUNmLE+k=;
        b=E1+T0jvX2+/WRy3DTsXnIl7CYn1i4mjob4uTOWQngmm2jkAzedB9fvq5SiLlpk9YLI
         bZTVRQFgJuYwGBPR82RVZfFPO25+1FIt05UZd9cFtskm1SQVjsyV/0C2ZhxOcuJapdO6
         sSR0oQ4nG1NPmAUe6gn0jN41odnGBr1w0NN22nBznpYUeRbfTijXL5i0B876nBIZxt5u
         iDX0pp+DdWzKUqsEE3Aib3x5L3StwYYjxhWAvRLu4BXkc2PHlfzX/zgALCfei5l3syyI
         QsPqnN7kAXsb5zfRCwVuPRAZ1qnbCA617AxEa9T8/80/XBJtJTO7LDTju3E41ulOkh3o
         kM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777915455; x=1778520255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8DRIGBANyTxbRVKczgT9uBMklmvWRVuW0duqUNmLE+k=;
        b=N504KkeG7NODGOWHn9qy9BAjMYsMwFvbCqaqOt6lAWQGyG4a3HEmYEe5JBedWRQ9am
         cIfEuiArmecRYd33dz2xvLP5lTj/Cr8aXIkIxrpvnw/havn6uXXJCNChDCh9kDRV5fuL
         lCpkXNQcNGK2jAXGO1rIDeoIfZ1WcIyad2GRs+mNCWgmcP83z/izVWgcLL6MbnXgV6EN
         rHSAaEC6SD5FHfuErMRSrTuYgeYP8aTigrVuJyfsQCV2DSxlAWykEjVOsRcJ0gliZpVZ
         jdLxNn/Of1AmwkKZwYba2V96OqxlFSX9nQVAYkIFeuA7FcVHf0/uy+LCq1x1MmzVoqqn
         yjxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ckFNaq8N0+H9oXXhlLXyS3zXnZ8h05EDkHcqBvSU+3kdti2HvwjDqUP68faB7YusR/HEatVq5M7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9bLrAzKDmkbju0ouja4cK7OLMuwUaO4dVGvVOh55hGLWgNVBi
	3qJHZGtPstcW6SSbxozZUCZQauKcvboOBzW2VyzSlX8NBeyYmMCBlWogWyMXk6tjjYcWR6HLHuP
	5IlN36Sb2NuO+WNsw3W7ewdZ1fxngy+lQF2b7PUQy
X-Gm-Gg: AeBDieuH4BIUcflZcN3ffWkFCz5GUyXScsENenmFHCbNDspIb6LOgaI3xFGdvektCmZ
	FBenz5Kd/RWuybQkzLwqESfk1wnc7PVy/kN02V1IdA4/rL8HKvTWEtOLj1NnpBmJtAuPd1jIhkG
	j6pH7v06GwOIzyZ8aBH1XbZ/kU4gko1By84N0WDdu2cYj7dXUOIJxc/rEN5/TZZtRxnKpLJ/7kQ
	QbFrPhZFQ3L85uous93autaRhE6WnSZMRihPT0IrJ+cd5ixfpXzawtt7ibFC1wdTguWClpkbRGe
	NJrdsESX5qdK7o5fvhvImhz37S4Pow==
X-Received: by 2002:a05:7022:497:b0:12d:de3e:86af with SMTP id
 a92af1059eb24-130a9fec67emr177647c88.18.1777915454575; Mon, 04 May 2026
 10:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-8-dmatlack@google.com>
In-Reply-To: <20260423212316.3431746-8-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 4 May 2026 10:23:48 -0700
X-Gm-Features: AVHnY4KOWy2Xw7Jao5yCErgbS2iXWpg2-ZhNYfKSnvLQBaJlNVGZseag5k_UOKw
Message-ID: <CALzav=cmZzNetCqWjQaG=VO+Fs=TTL3izU01vDUFd-=mRnDAuw@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 2:23=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> Inherit Access Control Services (ACS) flags on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
>
> Inheriting ACS flags avoids changing routing rules while memory
> transactions are in flight from preserved devices. This is also strictly
> necessary to ensure that IOMMU group assignments do not change across
> a Live Update for preserved devices, as changing ACS configurations can
> split or merge IOMMU groups.
>
> Signed-off-by: David Matlack <dmatlack@google.com>

> @@ -1017,6 +1017,15 @@ void pci_enable_acs(struct pci_dev *dev)
>         bool enable_acs =3D false;
>         int pos;
>
> +       /*
> +        * ACS flags must be inherited from the previous kernel during a =
Live
> +        * Update for preserved devices (which includes endpoints and any
> +        * upstream bridges) to avoid changing routing while memory trans=
actions
> +        * are in flight.
> +        */
> +       if (pci_liveupdate_incoming(dev))
> +               return;

Sashiko caught that pci_enable_acs() is also called from
pci_restore_state() so this patch needs a fix to ensure that ACS flags
do not change or get lost after a save+reset+restore.
