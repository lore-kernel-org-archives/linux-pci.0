Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287A036C59A
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919912; cv=none; b=nfGsWTP/TKQMNOMdonHqCKDi1O5dUJtINKSxaKU6PC1UrrnB+JQfdeMuf2wm4fA4Y8fOs8MDbVohrK5HtbtIs6W5iqmLSllxeHYUz3jPh7u68rfWDC+1trSQpsmI7CLtZL/Ej5acuoQsCOi5g7I4C+IkgyhDdV6SLTGSBRet4Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919912; c=relaxed/simple;
	bh=lRADBLgkLa3yPDCBWXAV1K5xrYWvA85f/dwiJB5B0jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK9uoFMlJg+NLCFO1zXL+OF3WHSumoRVTLxNqlvvaP7qliileJ+IEAzNY1rtvZsbE3DMAE9Om5kJPon3pFtD715OAOCfhlGjmeWesUiXDlI2Vsut529AKvDerzWgqj948iNq81CzT+wuHNKkedDt4jYLBlrL5LZKP8jG/6LzvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSxhHpFZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSxhHpFZ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf22c18ad3so373825ad.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 04:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780919910; x=1781524710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8CB2k4eqEZ/J9Iam1QvalqCdyib5VuBIoGU6FvxH5X0=;
        b=bSxhHpFZsVgn9x8ibm2PwJlVAoyYbkqJl073AizUP+8WcOD4/OMYfrnSyMNm3oZrx6
         F7ueLeJX02jewkcw8yGBRjWBChNfDTutokXjnPYsgVpQr0IT/yFgZyLUNMabegc4gBKU
         8M8ajpSewCYI1BuRNlGM3TJ+FQhbbOISAaUwl0zY8KzJ9NyGeoY5WsXRKU+6II76E/Iz
         5W2dEHqdmm+d72lzWs2pVqXu7MxHYosWp4Tw7kLzOARSlgWXMHsIMYraMoOQRF5KvcV7
         JJfa4ZZj0cmZjKtzfuOytS0yA+k/o1+2kacpLGzVQQu3BXxz+8fdqZ29hOfAzP8gRNdu
         oxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780919910; x=1781524710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CB2k4eqEZ/J9Iam1QvalqCdyib5VuBIoGU6FvxH5X0=;
        b=KYKsSh3ZBjWe7KYmBX0g9/ebD13K8EQooiwKPQTjG7K83FMGtX4LTq+axPQlpOMe6v
         KFwj+jhWx038HBXiBAePbs0kxPeEmPH+jMWbCT75GnSkKvvXFCbvdOoUAQOTo8q+/7Rb
         hQyqkp7oAMpV+myM9lDOB1ahB0/uhYgRMjqvaX9xlC49PPuSEjeE/xNItc4fRm6DD5q9
         fOpUt2DAPSlFUxl26ZnFFoW4WzxrHPO02ENrDU/Ixc/lRSy4BjcRPQ3vg17Exubzkr9R
         6wBTlPG0Ip7KK/ydCjZe7BmgnkD+54IeDl2ni0IZdXGMKK1JOR6A6Zcx9t5Q5cYETfWG
         Xfhw==
X-Forwarded-Encrypted: i=1; AFNElJ8OIus47Qypa14XiOHPWXfWbNJ2Z3xAxW6ehzKsYSvwTrowLQ8FPOWbG58LS+6VyIN1Z9pTBkJMC8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmo3sZxtlIppWzBLGYk+wBxbbHWKsPK7Pad/Cey4HGWZavHH6n
	zdszXV2Z6CJ8eOkVNouA3phkipVXBq3J0MMEJeJ+TJgUPIl4idf5mE1o0/yVs+ZMIQ==
X-Gm-Gg: Acq92OHZmN23kQaf/Ec31tmVAc7sElCax7H+ZFuym3S309tGztrYWm5DJkLdXzuGFpH
	bqnuF9G7Cy337QaXf7nhFaepNhg9rQaczl+AKbYsix1/QBIBN2zwEaQVCPDEG78OJUMesi66KDb
	+l6x5S6EH75Q7+basAZMsJral4rlF5yPd7Cd8VjWVnf4H+UGdgEEhlZ8+VDD+Mf3EDyZhRInAbF
	nH3VfaH+BtfX+1kwghbNaU3DypHhfGjyAe8dNNgEOwX+a+FOsD+oOUQnqqx3wKSbXjhOYUsBpr+
	mCh3W6VqZpM1v7EN+1oBQxwJty+OUYeipRret80ClimTcpOUJHs2ECglroTeMy6dD9zvw2kiT40
	tCAHfzmzNGyIUzwvsK3BAepxloDYADea4giIkf9ZhjukgbuiCvlbopCgOfN/rUYZdGJkfqSpOxd
	vkU7gj9c/kb/1mdslm2KTcZlv7jnqKkYdqy+61gTFJPGuVjp2x9VADUIkCJBQpFNKADyE74Ug=
X-Received: by 2002:a17:902:f787:b0:2b2:70ba:305c with SMTP id d9443c01a7336-2c1eafbd48cmr5222305ad.8.1780919910000;
        Mon, 08 Jun 2026 04:58:30 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b56c5sm15740485a12.27.2026.06.08.04.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:58:29 -0700 (PDT)
Date: Mon, 8 Jun 2026 11:58:20 +0000
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
Subject: Re: [PATCH v6 11/12] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
Message-ID: <aiauXATym3w2QX9N@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-12-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-12-dmatlack@google.com>

On Fri, May 22, 2026 at 08:24:09PM +0000, David Matlack wrote:
> Do not disable bus mastering on outgoing preserved devices during
> pci_device_shutdown() for kexec.
> 
> Preserved devices must be allowed to perform memory transactions during
> a Live Update to ensure continuous operation.  Clearing the bus
> mastering bit would prevent these devices from issuing any memory
> requests while the new kernel boots.
> 
> Because bridges upstream of preserved endpoint devices are also
> automatically preserved, this change also avoids clearing bus mastering
> on them. This is critical because clearing bus mastering on an upstream
> bridge prevents the bridge from forwarding memory requests upstream (i.e.
> it would prevent the endpoint device from accessing system RAM and doing
> peer-to-peer transactions with devices not downstream of the bridge).
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c | 11 +++++++++++
>  drivers/pci/liveupdate.h |  6 ++++++
>  drivers/pci/pci-driver.c |  7 +++++--
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index d404e64a4e55..a6f2790bc1bf 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -132,6 +132,10 @@
>   *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
>   *    preserved devices to ensure that all preserved devices on the bridge's
>   *    secondary bus are addressable after the Live Update.
> + *
> + *  * The PCI core does not disable bus mastering on outgoing preserved devices
> + *    during kexec. This allows preserved devices to issue memory transactions
> + *    throughout the Live Update.
>   */
>  
>  #define pr_fmt(fmt) "PCI: liveupdate: " fmt
> @@ -790,6 +794,13 @@ int pci_liveupdate_configure_ari(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +bool pci_liveupdate_is_outgoing(struct pci_dev *dev)
> +{
> +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> +	pci_WARN_ONCE(dev, !dev->liveupdate.frozen, "Preservation status is unstable!\n");
> +	return dev->liveupdate.outgoing;
> +}
> +

[...]

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f7a5e65a7c75..0b1f8d01d7a5 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -546,11 +546,14 @@ static void pci_device_shutdown(struct device *dev)
>  	/*
>  	 * If this is a kexec reboot, turn off Bus Master bit on the
>  	 * device to tell it to not continue to do DMA. Don't touch
> -	 * devices in D3cold or unknown states.
> +	 * devices being preserved for Live Update or in D3cold or
> +	 * unknown states.
> +	 *
>  	 * If it is not a kexec reboot, firmware will hit the PCI
>  	 * devices with big hammer and stop their DMA any way.
>  	 */
> -	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
> +	if (kexec_in_progress && !pci_liveupdate_is_outgoing(pci_dev) &&
> +	    pci_dev->current_state <= PCI_D3hot)
>  		pci_clear_master(pci_dev);
>  }

Looks good. 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
