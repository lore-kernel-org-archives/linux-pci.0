Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37C31E825
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777407633; cv=none; b=GPakG6+sc1E4QWoVN3PJDxyoM+IaV6V9FlaHexCvxkGT6hDtm0grQjk9DUuCPsvpWueQHJRiR/R2JpLYo8w1Q/EaZKxTOTWog7gM6ffKivItcVuWEnXGstjA9w1EtoUe6/T+/1Nh5Hp15ChnY5+iRoG0h7bB+7a4fE//WNRCOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777407633; c=relaxed/simple;
	bh=+4M4htXEh/xXtFiCFXN/m9StERkAgWTPW4y6jMSwAUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZ2+4lQMDvEWrJHqq/ewgCt/oFRKRnvvgIZFf6jWA+LfNz3e5ho3jImar/YwuGfyW6okrXBpet+QL83Z6drHCwI/cSnJMGS1yGtlUAc7gkWPpQXfmUTnQTUxZYYoJqDPAvGXhQRS4g/xg5v0uNBZr7uZVN1xBBkJSXD6Nzsk7R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iYVy2Uj0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYVy2Uj0"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b243198058so14025ad.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777407631; x=1778012431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MaR4AuPDQzq9MeZ+Bqr1j2DtvJljfw3TYQa7ZG83Cs8=;
        b=iYVy2Uj0BtzEejJ7IqaqqUnbOAY0YCT1Om7DU3z9uppgtOQ1SZBLAx8N8l1faTfVEv
         JuyohZ08iYpz3bQmwBz6QQse9KDISeeQmVTUEbkHwKUTnyktewMWqHHLXUl66DN7mfGQ
         ILouXOFMbZ4RAWx6V1DdKo7gQRybjKxZ/diDphlgyyp3eNxnuwbjCwGjYz07NQU2kGTo
         CzXWf7SRSo3lEulYolcEhq1zA4+kRziMBWaWV/4oX8hd4G0EIXGPAwuTSeveRUbbdWCj
         tsxeLKT4Ghu3s0itr5/mj6B1TJAkJnt8PK74FhuOgPuAtHan/j+hYps8HKP92us/ReGc
         gXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777407631; x=1778012431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaR4AuPDQzq9MeZ+Bqr1j2DtvJljfw3TYQa7ZG83Cs8=;
        b=AWY8lpyWMQO9pSkjStV6nR4h69BIgCkxobTXyuNYCDHOevAmU5d1mEc1HNRYq0D7sd
         gopkUckI951hIM7SUF79IjRwkP/ouPqnVL0wQqLxPbZlBE5q2JD6l2H/XueCJZXu4vip
         /t503orMuVMAByjXfeW6WGBT8vCt3Ru3J89nYstHZes2dpfehKq3dF1RmgHVOaa8csm0
         aZffvJN+wgOZJUZkf7ORSMZhBW05mfJCkUG+1LYQEHKjbhVMvmNZA5BC7rYJIhJTbIxg
         urXxI+mdUgM0IR5pM/TGNEfhFQyURRD+lbX6XIRj6yA/0bVwJyLg2A6cZ0I1yWLTVfXk
         uUCA==
X-Forwarded-Encrypted: i=1; AFNElJ943b4zs6SY3PoACJd20RbSFqtWijPjT0xngwDyd51AAVA+9fNjPsWXKe2xdKgXVhCJw+3ZHk5SB+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3dP3sWwlU5rT/iAt8VMehfSDEuxkQdFqWfIeXInDP5zM5JrZG
	wOCkhgZlxCTT9Bsa5MYpLT+OzlMZ6E8Zpkm76lT4o+MWpU3z/+nCTS/VnWjV+rbcRw==
X-Gm-Gg: AeBDietpCys0mssPvw9+vv3I1BwXOjEFyzareS1fI+k7/Jpex343fR7klmt74WdxzHB
	SUx4scBviz9OWat6nkeuea7quK5NrKxdxlgl7/7QTFuCj9v/ZaKL2me2pU8SstTlyW1zGBOge++
	zifOWLAWdqnFQ0l05fhwRTu9MbnmjUpwKJNbXLEevJ52Af6qGK6Ta3bpyceZn+/B/5jTH8MxtJq
	OsmCBmwirp4HhVH1So0kMGEQoeP3uCN9Y5oWxlBw2jSIs0fZvfXbYcrT8jxXrLmzVlaJw1Qf/g7
	p81FhDXESb/lQCt9/SABynPxdyE6h9AkdXltrlPKfOXSaXpN5A1Ni1FZJq8+6RRtx1ttV6EAsED
	dv3e5lojjs0l8tI9PjsZcGJm0aO7qiXeiWfta/aKO4IYeNCNv7N1zuqavqBKN5XgJipDcBon0Yn
	YkFq5Fe6wrqHt1uBFrgDBLNK3Sfpfkf00CrSwxCLDS0DwopVQoEy1y8g3oJ80chcEulCiJrDx1u
	awh47k=
X-Received: by 2002:a17:902:db0e:b0:2b4:60e6:44bc with SMTP id d9443c01a7336-2b988e32430mr88155ad.13.1777407630352;
        Tue, 28 Apr 2026 13:20:30 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834dae00d13sm3520508b3a.8.2026.04.28.13.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 13:20:29 -0700 (PDT)
Date: Tue, 28 Apr 2026 13:20:25 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <20260428201231.GA3885809.vipinsh@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423212316.3431746-3-dmatlack@google.com>

On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> +int pci_liveupdate_preserve(struct pci_dev *dev)
> +{
> +	struct pci_ser *ser;
> +	int i, ret;
> +
> +	guard(mutex)(&pci_flb_outgoing_lock);
> +
> +	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
> +	if (ret)
> +		return ret;
> +
> +	if (!ser)
> +		return -ENOENT;
> +
> +	if (dev->is_virtfn)
> +		return -EINVAL;
> +
> +	if (dev->liveupdate_outgoing)
> +		return -EBUSY;
> +
> +	if (ser->nr_devices == ser->max_nr_devices)
> +		return -ENOSPC;
> +
> +	for (i = 0; i < ser->max_nr_devices; i++) {
> +		/*
> +		 * Start searching at index ser->nr_devices. This should result
> +		 * in a constant time search under expected conditions (devices
> +		 * are not getting unpreserved).
> +		 */
> +		int index = (ser->nr_devices + i) % ser->max_nr_devices;
> +		struct pci_dev_ser *dev_ser = &ser->devices[index];
> +
> +		if (dev_ser->refcount)
> +			continue;
> +
> +		pci_info(dev, "Device will be preserved across next Live Update\n");
> +		ser->nr_devices++;
> +
> +		dev_ser->domain = pci_domain_nr(dev->bus);
> +		dev_ser->bdf = pci_dev_id(dev);
> +		dev_ser->refcount = 1;
> +
> +		dev->liveupdate_outgoing = dev_ser;
> +		return 0;
> +	}
> +
> +	return -ENOSPC;

Since it is executing under a mutex, and we already failed
'if (ser->nr_devices == ser->max_nr_devices) check above, will we ever reach
here and return -ENOSPC?

> diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> index 5c0e92588c00..5b4c8d9e462c 100644
> --- a/include/linux/kho/abi/pci.h
> +++ b/include/linux/kho/abi/pci.h
> @@ -23,19 +23,20 @@
>   * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
>   */
>  
> -#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
> +#define PCI_LUO_FLB_COMPATIBLE "pci-v2"

Just curious, why did we change the version here? It's not like just
previous patch is working enough to perform a live update. As the config
is experimental, can't we just keep it PCI-v1 for the whole series?

> 
