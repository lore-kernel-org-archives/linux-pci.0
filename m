Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD0483811
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397969; cv=none; b=GwixvfiHj5iGa3tg///t4ib84PIW8LdIKEoTZCCX1luSpFTLRTy+NUCzd7zSWtTn7mnFn2F9RFzR9EDc7Vux2Hz2jEz353KrMPEDds+VNN4VbhpgQFMrsdd9pCKomLnvgZRm4IiIRM0AKlfGGx66IW5iOn+jo0BmuP+zg3KQF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397969; c=relaxed/simple;
	bh=4YdSqPMQ3AqrylMN6xPYkljWBceL/O9a6xta9YhYWKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzvCsUlKOQnORaVsr0NpPsCQuLSOjB8VSqp+0ZkguwWhatjUuNoeb3UB1BjAwNpoiM1ff+Ou2GMtu63ri9OOMC7jd9swSNkr/lgodE8brpjoryqYQFs0KJxw2Q9zRFgP/gFf3uNKPTgRNMH6wju2fopZy7oGXOvofba627slHkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WmWhpOwj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WmWhpOwj"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2db33db4de9so68295ad.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 01:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792397967; x=1793002767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RJdZXHdbMv74njH384nYFNZ44vSOhnp4TPEILn84FiQ=;
        b=WmWhpOwjZwLjD1vfa/Xb4qyIEpr7fh357BIo4+rbQODsHyNx7odlRz1iVRqFdikmUW
         /ERoF5s0VlQkD2NyF/L8yYUPuHxbtFO+KLtfNBH2sgJmq/sfr9fQlfiBR+QVFXS+dZWg
         rHfzoEiQmY+ne9K592yEpu3z5DK8zqOoGDlkbXYL5TxO9bDOPN1K6xqNYvIgR3L9kXvA
         eunTFFUHbOaqxxWnl4geEF3LOVubsHWmt9W/DNTs4naLsCV1PIDWGXEBdiOdvgd+RiK7
         U5kCnmvAeOYXP5BEe674+N/JGNZkDaau3+2EMH5KFXZO1/T9oE/SaeW7hMOCjowLyB7Q
         ebrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792397967; x=1793002767;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RJdZXHdbMv74njH384nYFNZ44vSOhnp4TPEILn84FiQ=;
        b=qNwX6kGVr7RQxpc3gPt5UXkRE+5OZjr6YwQlBDSqCtY5qYgZAt9tcYdOrTtQk3KraD
         Hiv6P3eppofIJUDBTWHOzlOELTSEFqbIT4hzfVNtbzGPkgIHAudsGl3fcdN/2hEyCQRI
         dZQHooPdstnIGpQluta9TCh7FygRPJrfv9jexzUzcdZozKA1+1jdBOWFFd78VVKl+uA2
         z84+SFieBgntLzVFJp7vaGzRzjfhZzyEn1Egu4TdnI77bf8vIX6DWXsYj9EYiTRJ8vvN
         a6qCB7/3gN3IEv339wyUEZyZwN+2MNjrIKquu7zVf69Yg38W8AgNTAYKC8LCqs5tsJfZ
         KrEg==
X-Forwarded-Encrypted: i=1; AKwUvBxH/Zvdnujyzn9Fv8GjMHZreenZk6SFYlgE/yehcZnnQqgeLnZXUegCMNDvMKNiUD4cBTvOkogMKRk=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5Dd1OrnZWZLz61/IOQkD4vfJg3xaoMPzcImRuFN77RuAr90Gu
	geFCe0hhmcBWqmcq5h4SftnSiDNbZjfrCy4X8AN92wQVnADqwsrOYLI8M6Iw85t2VA==
X-Gm-Gg: AYBFou2DrZD+3uCw3J6fBgwxdBm73kwdWr1IzPhV/q7CCliGeZmEKKXcm4kpsejR00+
	X209DVM7V2NwzfVDe7Xw8W2Vf5zYatLgPXU8//rYFUFwz/6W6nb9hEkHPMSbbi+UFNdYG1WxNvs
	7ZAlj50Z4SkKDWYhMr/GfnhZamOM8nKdNXO6B2c+0W6W3l+SBt3FJ6NxpXteeEzS80Frwx8JNjB
	zbJe5uziiqH1lD+Z6dV22oLGcNUyVVntHW41sL5K+cMwCKtcasyXnc7IizwbQS5qz8mPGAHxnka
	JiLeEwWT4Xh6h0ZJROol7AJ+egM4aEXuz2wMC5+wpmCfQivRq+EK31JbfexkQ8mYZ3oYDzssVer
	ggEkiWzFqCH2V4U15eKGsAu8Us/LqZQwkJHjCTmcHft6QyiaP9sGspwnzBOk4a//vp9pdOb1Jo5
	xZGEJxJeGCqH+Mmg/h4McLPdd/j1K//W7n2IK5H5U8MuBJfSBZ7ySzWUrR04LqEBZKQGF44JAnJ
	Tz9Jegche7jVq+/1+wasw1SUTUiKQFhXnq7
X-Received: by 2002:a17:902:d2d0:b0:2e6:12af:5b04 with SMTP id d9443c01a7336-2e9ae497cc4mr6838265ad.0.1792397966463;
        Mon, 19 Oct 2026 01:19:26 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad48dc2f1bsm865449a91.4.2026.10.19.01.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:19:26 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:19:18 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	sashiko-bot@kernel.org
Subject: Re: [PATCH v11 08/16] genirq/msi: Provide
 msi_device_domain_restore_msi_msgs()
Message-ID: <atXShi9ReURhBmdB@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-9-praan@google.com>
 <8733u8eygy.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8733u8eygy.ffs@fw13>

On Wed, Oct 14, 2026 at 11:58:21PM +0200, Thomas Gleixner wrote:
> On Tue, Sep 29 2026 at 03:45, Pranjal Shrivastava wrote:
> > +void msi_device_domain_restore_msi_msgs(struct device *dev, unsigned int domid)
> > +{
> > +	if (!dev->msi.data)
> > +		return;
> > +
> > +	guard(msi_descs_lock)(dev);
> > +	struct irq_domain *domain = msi_get_device_domain(dev, domid);
> > +
> > +	if (!domain || !irq_domain_is_msi_device(domain))
> > +		return;
> > +
> > +	struct xarray *xa = &dev->msi.data->__domains[domid].store;
> > +	struct msi_domain_info *info = domain->host_data;
> > +	struct msi_desc *msi_desc;
> > +	unsigned long idx;
> > +
> > +	xa_for_each_range(xa, idx, msi_desc, 0, info->hwsize - 1) {
> > +		/* Only handle MSI entries which have an interrupt associated */
> > +		if (!msi_desc_match(msi_desc, MSI_DESC_ASSOCIATED))
> > +			continue;
> > +
> > +		scoped_irqdesc_get_and_buslock(msi_desc->irq, 0) {
> > +			struct irq_data *data = irq_desc_get_irq_data(scoped_irqdesc);
> > +			struct msi_msg msg = msi_desc->msg;
> > +
> > +			if (data->chip)
> > +				irq_chip_write_msi_msg(data, &msg);
> > +		}
> > +	}
> 
> In this case sashiko is wrong:
> 
> > [Severity: Critical]
> > Will this result in a NULL pointer dereference in hierarchical IRQ domains?
> > 
> > Since irq_desc_get_irq_data() retrieves the top-level irq_data, data->chip
> > points to the top-level irq_chip. In hierarchical IRQ domains, the top-level
> > irq_chip typically does not implement the irq_write_msi_msg callback.
> > 
> > When this top-level irq_data is passed to irq_chip_write_msi_msg(), it will
> > dereference a NULL function pointer:
> 
> All MSI top level (device) domains implement the irq_write_msi_msg()
> callback. That's the whole point of the top level MSI domain as that's
> the one which has access to the device and the associated message store.
> 

Ack, I can try folding this into a comment to avoid sashiko reporting
this multiple time in the v12.

Thanks,
Praan
