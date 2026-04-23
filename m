Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABFA1E5724
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776982287; cv=pass; b=s6eHayHut6rPn2IvmqOSSFHymNf9h5bZy62JRiR4udbIZm0NgI2tluDmkfCpCcjdcxmWhz5/CEADEYA2qEu37ZUKkcOx0wLVhsCBl9oa+JA8PlyF2eh2iggs95UcfdoujjiOjjka3LDTzJkpf4+Lh6OJ8qriUl4TG1loSGZ+rjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776982287; c=relaxed/simple;
	bh=1LE8KttVtGM+9CpiUlwllHY6AYyzUrNOnEbtRD51iDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7lGIAl3O16E4QaSD4ePRdfk/sIj7DohnkXu2cw165JiWmX2UuLfEmupw8B7dCjgbsrf6yklp1v8Jqe9zA/ZEA9kbZIikdgvIZUhNCWDjWOuEiLyFR3avgPF9zAq0NwDNOyiBqASAa/fpojuP32bOqQsJCS2BAFSQLv1LDawLCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RCSNOXLc; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RCSNOXLc"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38be5e86918so82596121fa.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 15:11:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776982284; cv=none;
        d=google.com; s=arc-20240605;
        b=H4phw1oYfdFfg9IcSlz3CJmjaer8UN4do2mUXcOHlm523ctz0lKg+vJtm4xzjusyPs
         so2fYIzB1r9xtBlhcpEqvbrsoienr99R4QraUwi9nQ7PyX/NhgOGY+L2P0CcH0curu4B
         5A+y90RreRKM7lP/TeWUsTF7dFBoWJ/0rrLz9VqamKnWF1KlrgT8t45frpVgBKthb2qQ
         Bjo5KzxQL9dUvvN4pSO82oEoh20Ik0wX9qTjymCQH5GwO+3j/EGelrI3u/SGEECgsvSs
         BM/MlZ5epVYsFdIkvPft/c/4L654QmbIKfssCq/WLGcrqfTcveTvjX62q4ZcCrPcs4yg
         yL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1LE8KttVtGM+9CpiUlwllHY6AYyzUrNOnEbtRD51iDc=;
        fh=Xes6DeTKMFbJzVeq4kaGFSzw0PxLC93maqFzZtbiabc=;
        b=YllcFiSpgHco864if4ttalN7ygIQu7oHjt20ldaneCn4SEzIYikWNM24fYqyKVncPm
         6Kt6M7S0uZeUILdVFDHA17Fec+pUipo5KP2RIxDrxbY+bZIRK1G/4u9rqlLY98EUbqel
         eEBPjYs/8UkyXCS8/X4V24bdGSNSvSGrFXmEwPgY8n/zvifc/GXTlzB1VD8+4xGrZWPa
         JLiT4dylMySJady4xazkPt4nvKNLfVeEcxeRSdTUbJII8p5mlmuJWtX64O42uOOUKirv
         05WJ88Gw8wU4Ep4S4pWG8Ee6IzlEO2pI2dhTLvdkOjj4fE/p2XrLjaosyelEYGhGITLE
         DiUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776982284; x=1777587084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LE8KttVtGM+9CpiUlwllHY6AYyzUrNOnEbtRD51iDc=;
        b=RCSNOXLc2RDedMpLLcSB07VXN1TcWxVckcnL+0r0qTQkGkuKmxa6Pe/0LfyQgxCWVW
         vNQBZwvY1uaaYFeB+fSgwtmyj4ienMzkRenCQenC8idV3GjbKmOk6mSXSimI7SRzo3cz
         T3Ho028BCBb2k1zqzwpXLqDiD+uZMONBNm23qJHHN+l4bgy26AOFaoY4EH/sCzcckY8e
         xmM9z4bNMDGKuvioRZPyI2fAe2qtEHbzZndIcKFq2Iw9MrWPdKIRaTWgMZfJmgN27EGa
         5clB2hQ2DN2VDdmcrWBwe6EqpiPV3YUSOgWd4waYbjZH/B/pKgVxIwJz6cS8ttLniK94
         6JbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776982284; x=1777587084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1LE8KttVtGM+9CpiUlwllHY6AYyzUrNOnEbtRD51iDc=;
        b=RTfzNUEHbl8S9HUS/DJDYi9/zqMpdxT/SFoIfy7tmTLjACittmZEAVoih+BGj7cur8
         ETUxkWQh6HQFofl4g2z0238f87t0qo2aDfWOJIVTZwLP0H0ARDPl9mt+7JJ7vBFsWQ1q
         ieTU2UobyX4r5cTC0k9ssQr4oFUTrGRHvZa3frsjSMszWmh0O9RCEGlTAnXUhIVF3iDF
         c0ncFyzZV6epw/6UZwC4/iUwmhpvVayIgYMoka9E5usxmpy3DVS4hRXiEFQCIHdVqwtq
         CEFxaBHlBpbJvdwkAv8jFSeYhsEX/BOvjF1uvN5nOP2pqse/v7+dPRHO/XiXGwHh5clL
         +7KQ==
X-Forwarded-Encrypted: i=1; AFNElJ9E0J4io6UBCRmgFcJ2NLxRu8n2NsX3Kx8b30jHFwsImaKAcRk01CCsvD//7EZNR+rDKUkj7JQm4IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXEPSiMLvList46aKTWoJN42QmGt7klx4THRErmXL5S3vh/Q3
	n77Dz2t530rhSLQpNISk9iyPrUbNvNBzbtYbtHnQgvzoomP7WhigKpGmKk2opFoycWzzD74NrMf
	hlqquXMjL0agsgWRfRh2tlL8M3lFe660JgNgAnSwt
X-Gm-Gg: AeBDiev4P9L9h0fFzobsVNz1dyGLtmoyAaaqhohsizbp2+OCJgPt3PF4PsJKehNp71B
	LPI+K7AVVR6v0Q5gIifHHNBcgIkESfd2KCU8uC74SUMqSjikBOSJUIdYHGfhqbZ1AP1FfN0pgIa
	2kkfE35jH67lWHINGhInZl+9lP8Zuaf9qh2cbmcXPwzFRzlAp9lbAvNpnBkCyjSBE5v/GIRrXe7
	QKhr6/yTRpBKXL0vyoWT20jYRnx8blzwEXDzggIrYsFXGUg4uCHMLK/TSv22lRhfCekkd1gY6ho
	c4rWLQxYbbMa37qA/JeBajP8HicGCg==
X-Received: by 2002:a2e:bc83:0:b0:38c:6b7:ad39 with SMTP id
 38308e7fff4ca-38ec7818193mr99821181fa.13.1776982283419; Thu, 23 Apr 2026
 15:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-9-dmatlack@google.com>
In-Reply-To: <20260423212316.3431746-9-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 23 Apr 2026 15:10:55 -0700
X-Gm-Features: AQROBzCzQHNRAyujF9tGZltx4kVtGjkMoj2uVw4QUXf8lLhcB6v0kyr5BiRYiDc
Message-ID: <CALzav=dGpHEnEjyp8qc50iZrGeKJ47vjLvwtvkLCyNzOMJhozw@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] PCI: liveupdate: Require preserved devices are
 in immutable singleton IOMMU groups
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
> Restrict support for preserving PCI devices across Live Update to
> devices in immutable singleton IOMMU groups. A device's group is
> considered immutable if all bridges upstream from the device up to the
> root port have the required ACS features enabled.
>
> Since ACS flags are inherited across a Live Update for preserved devices
> and all the way up to the root port, the preserved device should be in a
> singleton IOMMU group after kexec in the new kernel.
>
> This change should still permit all the current use-cases for PCI device
> preservation across Live Update, since it is intended to be used in
> Cloud enviroments which should have the required ACS features enabled
> for virtualization purposes.
>
> If a device is part of a multi-device IOMMU group, preserving it will
> now fail with an error. This restriction may be lifted in the future if
> support for preserving multi-device groups is desired.
>
> Signed-off-by: David Matlack <dmatlack@google.com>

Jason, do you think requiring singleton iommu groups is still
necessary/useful now that this series preserves ACS flags on preserved
devices and upstream bridges?
