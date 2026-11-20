Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187855;
	b=JIpGv0oawuCO+oqOkTtRCQtl72grSnKGT70Yg8pMg3PJBg/3FlGOvb7is4LJNoSjcQUm
	 3riPJuQ8LtrXUGenSFVVeQSNgfqFwbjd28zJNC3oAC/dtbrbvlFfZxfEAXpxO1FHabbf0
	 3Ual1cVauSU5fc1okP5BaVAGEN/o6ZQxhjDlX6qtB3Tdh5UPrpLB0CFQZ0xwt0WbwjNxT
	 Pngp3ngFo2BAYYkNj2EPbsbGL2efObqwNVXKKQb0ysuwjlkQ8SfEvIGj37t8IQjXoDD8o
	 PC8FNe7OsByo4Qi97Wes38i+BDb1j7CueMmCwmIrqIfLFXTUATSlzuPPAgDJW2PwVxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=qAjYne+BgcE8DA63sQsMZ990H8S9yK78zgr2NZdv76Y=;
	b=rSXrLRhMTHVRJaD5IyxNZWrQdKq9qEkLOX+nNjZsVDBVRiV5advwNJannEdeKtsiW/wx
	 MpXeh4T4voSKWuGv9DGT2p/WIl2lH/O3XIoU5BquJ/oRtc+Yzi5Yp91hcEBY5HHWQDLQ6
	 v7c8/HRcWU3iePgMmW5ZgX/sQ0ymcydVGm6YnNKY9cF7tL0RvG7WPi3P5RhN6ctQ7mLEs
	 FbQf7Y/4IROpd0ZT4RjsxptMwl7zhv0aRPgSTcd3ZCt5RUjyH6X7ohE6AD4vxAtEGYVEf
	 GT2Iq+ApJxzXdwMVdytXYuUJuXZg0UWEY1VD1wIT1nbCyuV24ObJdgSWy9Px/8NLZKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZsBZbY9r;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D95606A331
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 15:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5D95606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZsBZbY9r
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-150ef97e790so7390c88.1
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 07:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795187854; x=1795792654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qAjYne+BgcE8DA63sQsMZ990H8S9yK78zgr2NZdv76Y=;
        b=ZsBZbY9rhrhfiMH0sIHuSlkXAHu76ZIvXMLxoLYKzwh8PjT4CLxStoojunbuP0/iA/
         W90zitn5Ubkfby50lAuwhDOazB2L6R/imqoZQrr5T2qH6KWT0/Oi7Sz1JcBbXdE3dDzw
         snDvkyJlfwkEk6pXFI3AHJmDTiQdkJuRleFOmaN5NVQG5880pyvAK9iBugmfOftYOo+v
         rAaNCKf4p5tV+po35L3klIxGqj+ugGAu/Ok0TpBPaFpfLMMtzEpqE3GuXOGoxX3Z2t7c
         lxFQfro0U36zTDNKHVXh5rBMyIfmzQRVpydIrZoC6Q6+KZ0L8XzhdBsO2aJGCJ6u6OzM
         9oDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795187854; x=1795792654;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qAjYne+BgcE8DA63sQsMZ990H8S9yK78zgr2NZdv76Y=;
        b=Qb/nCaybiB3mfF365XljGL5RM5KWZY2BeaTqa1lj6vewQtzTHmAKYlopaF9vv8CwOv
         sXijU5rnVaYeWvP5XOs6qs87j/lXB/ICYdgvjYxbUwB14XIKM/XxCoPdCHwHr69DzgSG
         ZymIFttANBKk2URZ7OBZmhFhFyHQ0THhTEyYibOeXiPUgjltfOA8NZq1k0QqpUaLBRyP
         ExKN98HUOgf/fPu+lhX+pryHC7cvqGjwahrIkX7p4mRSlbMEkvQ5Xk4dh5SwKRurX1SH
         qOWwn6MI23E47RQ9+IWyCbYgOZnemwKNeueYvliEsK0JGyCxZLLsvRleXSw9PH45Q7U2
         Teig==
X-Forwarded-Encrypted: i=1; AL+hErF2vyGWPtpyc6TLPF2PgRCYF9CU7Dc2hEsuNnsK/y6HLI8aJJOvKFrt67Fm+sesUYMaJ5Lc9pkvSqY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kVVGB+tWJ0wnlSO7tvzST1ctilKUw5MzpPCvXok+RqYBjAxPW
	TR5dGHBo8q9y0/MKLORgL7Tc0aQVZ6Ove+Gb9F33XLvFsRSKi+6Aoahn8Pp4mc+BBg==
X-Gm-Gg: AYBFou2XxQ6wtH1bbxrYzQLjFMGCFw8G01omH7sWkR/kbQ9KsBB84Hix6vyE85OUwS6
	O6aO4Vx8HXNolI1peAm46O5AcnKg3nDFsHPkHRPVSfFjLyFXL4kfl3deSdzAY9HGUYGUE2uehzt
	SqgaEuTb7YdWJ31apHR/jDpPu7qEd0HDRNa0hi1MwmZ9Stk2e5NQgetVZFRUgq4KXdvuOvzMPAB
	lpU7u5Br5ucRRro77B1DQyvmNbcGzKIRao+IfRlamkaWyGMZ6SLhLaVSABnxPpysND5nuUwVDWM
	aF8to642U7knW4vzP0CYeo8NXSQTZENZQiaVTVkIOae8J4icyk/rSdxyZfPQS8RSeJ2PSMqO360
	+ueUW6/377FK1fmQKAADsPbUcMePLqO9slwWT08oumHCjqo4Sa9RbURGiRutYqLGV8nx7bSXSIJ
	neAxDJx0/8qM1xe3PiHTvLNeCFZ6gdl490ag4gRCwd7PBLk66BTOGqjVwH3y3PDmrEGhUw6wD06
	sxiVJinpS0MiVnZoCbUtQZiHccXQ1ozuHkyI5QYnG2OqH8ke8b4wDFietvHIPekj9+T4uZbZH9m
	764NEts1IvR/EuXfczzZW5+GQstQhU7mGtMbTL/1pQPH6rby20D49uqhau4HTI2FKNxuy/v6VZd
	V1W62wkUcqZn5
X-Received: by 2002:a05:701b:4516:20b0:1b3:c4ba:8e0b with SMTP id a92af1059eb24-1b557b69270mr1215594c88.2.1795187852837;
        Fri, 20 Nov 2026 07:17:32 -0800 (PST)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567e2bd1sm7441365c88.3.2026.11.20.07.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:17:32 -0800 (PST)
Date: Fri, 20 Nov 2026 15:17:23 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Alex Williamson <alex.williamson@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v11 09/13] PCI: liveupdate: Adopt ACS controls in
 incoming preserved devices
Message-ID: <awBkg0ODE436CZy0@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-10-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118223704.3286085-10-dmatlack@google.com>

On Wed, Nov 18, 2026 at 10:37:00PM +0000, David Matlack wrote:
> Adopt Access Control Services (ACS) controls on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
> 
> Adopting ACS controls avoids changing routing rules while memory
> transactions are in flight from preserved devices. It also keeps IOMMU
> groups from changing during or after Live Update.
> 
> The adopted controls are recorded by the pci_save_state() call in
> pci_bus_add_device(), which runs before drivers bind, so they are
> reapplied by pci_restore_state() if the device is reset. Allocate the
> ACS save buffer for incoming preserved devices even if they match a
> device-specific ACS quirk, since their adopted controls live in the ACS
> capability, and panic if it could not be allocated.
> 
> To simplify ACS adoption, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account. If such a quirk matches an incoming preserved device
> anyway, e.g. because it was added in the new kernel, log a warning and
> adopt the device's ACS controls regardless, rather than reprogram a
> device in the path of a preserved device's memory transactions.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c | 75 ++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/liveupdate.h | 16 +++++++++
>  drivers/pci/pci.c        | 13 +++++--
>  3 files changed, 102 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 00d6fa5236e9..b99a88c2c199 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -123,6 +123,9 @@
>   *
>   *  * The device cannot be a Virtual Function (VF).
>   *
> + *  * The device cannot require device-specific quirks to enable Access
> + *    Control Services (ACS).
> + * 

[...]

> +#include "liveupdate.h"
>  #include "pci.h"
>  
>  DEFINE_MUTEX(pci_slot_mutex);
> @@ -1071,9 +1073,13 @@ static void pci_allocate_acs_save_buffer(struct pci_dev *dev)
>  	/*
>  	 * Devices that rely on device-specific quirks to enable an ACS
>  	 * equivalent keep that configuration outside of the ACS Control
> -	 * register, so they are configured from scratch on restore.
> +	 * register, so they are configured from scratch on restore. The
> +	 * exception is devices preserved across a Live Update, which always
> +	 * adopt the ACS controls established by the previous kernel and need
> +	 * the buffer to keep them across resets.
>  	 */
> -	if (pci_need_dev_specific_enable_acs(dev))
> +	if (pci_need_dev_specific_enable_acs(dev) &&
> +	    !pci_liveupdate_was_incoming(dev))
>  		return;
>  

The ACS save buffer is forced for incoming devices that match an
enable_acs quirk, but neither existing quirk keeps its controls where
the generic code saves them (Intel PCH Root Ports have no ACS cap, 
SPT/UPT has the Control register at +8, not +6). Is the intent that 
such devices just lose their adopted controls if they ever lose config
state later? (e.g. a Root Port D3 cycle after pci_liveupdate_finish())
If so, maybe worth calling it out in a comment?

Apart from that:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
