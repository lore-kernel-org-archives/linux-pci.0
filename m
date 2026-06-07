Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994E432B114
	for <linux-pci@vger.kernel.org>; Sun,  7 Jun 2026 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780864678; cv=none; b=SHdoUOj0IWblSTrGIv792UYd9cjTU5kiaDFNieudR333pcu65dSps1WW7yDpEko4asR3jK6U7Ma4/8j4qzz4sSU9RAMUWVXwZUuXgeWHJCtTr15OjYypQjrokagOjbfpqKISMpqFv9H7yvFXnvJMs9Ipl/CG6GYBH+RGmNYmyAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780864678; c=relaxed/simple;
	bh=Kz0XEIVs2B4+UTHQmu6Y86Ku+I6D2eYakWtDHsOXm9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axS3IAMa1cCCOZ6tJBY7419PkvZedBUJz20GITt/Yd9ycyShsnkYVaR1PglKMlgxUuBMNlfwr80lEz+DtZiXJyuYxPNXsunksHtnDWm5AzPCW/r4ot7aUXq+cWwv8ZmYxmv4IYXTFTHIHecKQ76XhwyUQ3BnRC6WJ2rZVGZgNQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QlN/6d76; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QlN/6d76"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1336742714fso24454c88.1
        for <linux-pci@vger.kernel.org>; Sun, 07 Jun 2026 13:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780864677; x=1781469477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oir9rCALH4eHYpJVikC6mAKB9V6wqMG19r6g7e/slSE=;
        b=QlN/6d76TcjLhL7wCB8tFMgesQip4JCKw5rAGi6wty1JQDp3mNWqydW44dB5pcbPuS
         z4Ei5UMM3NFQRxOWFtetVQt1tIl7elloCR6o1IPb4w692YFPZVOujgRPzkaN2W7JWVlb
         De+EtJej8lhRP91y4pygaIVffkJ4XEfpFxz+8BydRlNukFR9nPQrWKU1KQFj58pR7PYj
         +HZ+MhlXfWX8HTVyW+yG/jrrDm/HeY0zvoLh/ttUvglOV2eDYkCHFjttXWLOxknoz4PC
         ZWbFNjB1QiAeA2MJ7/g6nmb1pk4I3uQTt4AtEkuRS3Qlc4J7cThckX86nxbq03leX4lp
         T0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780864677; x=1781469477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oir9rCALH4eHYpJVikC6mAKB9V6wqMG19r6g7e/slSE=;
        b=Og1Dl0PoWl+Pt1fSVtXTG91TVnbkseXf3F1BeveU2t7sVBCvXBCBY3hLpY70p9eXLz
         nIRYRHxTylbi2conU+qlyqPjinkRuvk60P8nGyHF0pAkk+VJ7b9Vpqctqaev8nYapNLH
         milN7NmdPoaiLgmBHEFzjjkQ3KWH3O34fUElBGZF9IHms4EV+Htv9DC3qYYjVV2Yt1Qf
         pouoXmaZZU3RDoYMmOxg54bID9PqlLPdKCLQE33+eWHt7ibDLzAvtkcskNF+4OpB8Qmo
         Db7B/TwHKyCF/W8itHUQRnxubviJf1SKZSVDj95HEkhYYdZjETFXSJ0trO5ejUWp5Ii4
         MBQg==
X-Forwarded-Encrypted: i=1; AFNElJ+buqKAiZbMY2oeP7/AXIGDiH/d/mIWSorIOxGsnzv5NEKlFj/vkr3uEeqtevkK1AKBtKTKSZwBED0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFEQBnGoxAT+TiA1G1gg0qmV9/SY0IozxKGMwbDZU3jjPN6J/z
	4ZeD0tmrmQMnGEofVXeo14M/8H/0Mw3Jg7ZhfI/jP1k107IWctkqOY2K0zgNlB6/8Q==
X-Gm-Gg: Acq92OEktKRppHFSkmCoY89/17G/NPmGZtscOSAiLP1Xs4ayq0Onn6Hj9kd44amh3Ar
	AYfHClPDIHWy4vDiKDTXlkym2ORftIYGLlyWzUtOguvPeZbBuK0/1rNfvcJW/OHG5I0FJC5ZQGS
	kzC4DY+XjC9xza2EeqtbYQsKe+1ulMDRJRX8QQ/DwvT67Uz2ByN48q/E/rIqf5AdFDLSdF11vKr
	r8sYTGusf6T3+JjQKREgfXYpeLUjF0Gj0rhVGh7kxH5dIq70AqjoZjbmFN7KitgVEPn1tRKfgLh
	AcJWKwMFBqnq+9DEymCudoa/FE0pKEALGlqsrXhYJF8EqBxyXPnQ8T8SelM9g/VO4DUHeUUfr5t
	Mcj8LGTaECR+ebB5HwVUTHUqfpYogeHCyyeky7FQx43gFn4vVjH5McIDykoQvPgMeGEvvSA/U7g
	jgEHCfAAaamNVwd12eSstQNX0b/V1HSy1oMEgKot0/Io41b29mjp53kWEhXuuBVjFZNQdN7ao=
X-Received: by 2002:a05:7022:504:b0:134:fc89:410b with SMTP id a92af1059eb24-13807c7c2e5mr279135c88.15.1780864674937;
        Sun, 07 Jun 2026 13:37:54 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1381495bb00sm4230734c88.3.2026.06.07.13.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 13:37:54 -0700 (PDT)
Date: Sun, 7 Jun 2026 20:37:45 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
Message-ID: <aiXWmR-ettxin4LC@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-9-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-9-dmatlack@google.com>

On Fri, May 22, 2026 at 08:24:06PM +0000, David Matlack wrote:
> Inherit Access Control Services (ACS) flags on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
> 
> Inheriting ACS flags avoids changing routing rules while memory
> transactions are in flight from preserved devices. This is also strictly
> necessary to ensure that IOMMU group assignments do not change across
> a Live Update for preserved devices, as changing ACS configurations can
> split or merge IOMMU groups.
> 
> Cache the inherited ACS controls established by the previous kernel in
> struct pci_dev so that ACS controls do not change after a reset
> (pci_restore_state() calls pci_enable_acs()).
> 
> To simplify ACS inheritance, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c       | 68 ++++++++++++++++++++++++++++++++++
>  drivers/pci/liveupdate.h       | 11 ++++++
>  drivers/pci/pci.c              |  5 +++
>  drivers/pci/pci.h              |  5 +++
>  drivers/pci/quirks.c           |  7 ++++
>  include/linux/pci_liveupdate.h |  6 +++
>  6 files changed, 102 insertions(+)
> 

[...]

>  
> +void pci_liveupdate_init_acs(struct pci_dev *dev)
> +{
> +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> +
> +	if (!dev->acs_cap || !dev->liveupdate.incoming)
> +		return;
> +
> +	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->liveupdate.acs_ctrl);

I might be thinking out loud here, but as an attacker, this motivates me
to somehow hack the EP FW to mis-report the PCI_ACS_CTRL register across
a liveupdate to fool the incoming kernel. If the FW feeds a 0, it silently
strips ACS protections.

Should we also serialize ACS state in ser somehow to ensure we aren't 
fooled by something like this?

> +}
> +
> +int pci_liveupdate_enable_acs(struct pci_dev *dev)
> +{
> +	u16 acs_ctrl = dev->liveupdate.acs_ctrl;
> +	u16 acs_cap = dev->acs_cap;
> +
> +	/*
> +	 * Use liveupdate.was_preserved instead of liveupdate.incoming since the
> +	 * device's ACS controls should not change even after the device is
> +	 * finished participating in the Live Update.
> +	 */
> +	if (!dev->liveupdate.was_preserved)
> +		return -EINVAL;
> +
> +	/*
> +	 * The previous kernel should not have preserved any devices that
> +	 * require device-specific quirks to enable ACS, but if such a device is
> +	 * detected, log a big warning and fall back to the normal enable ACS
> +	 * path.
> +	 */

Nit: It might be worth adding a note here that this can also happen if a
new device-specific ACS quirk is introduced in the incoming kernel for a
device that was preserved by the old kernel (which didn't have the quirk).
In such cases, the two kernels are essentially non-LUO-compatible..

> +	if (pci_need_dev_specific_enable_acs(dev)) {
> +		pci_warn(dev, "Device-specific quirk required to enable ACS!\n");
> +		WARN_ON_ONCE(true);
> +		return -EINVAL;
> +	}
> +
> +	if (acs_cap)
> +		pci_write_config_word(dev, acs_cap + PCI_ACS_CTRL, acs_ctrl);
> +
> +	return 0;
> +}
> +
>  /**
>   * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
>   * @dev: The PCI device to check

[...]

Thanks,
Praan
