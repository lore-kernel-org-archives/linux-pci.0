Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1163AF666
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780954505; cv=none; b=PAt8RHiggZFZk18frJX3djYtFjtOGkvjVyrcgYh0ZrXVQc4S0HNVHfi17ECxklgbT24xpnjZ2bJRkK1EOUfrtDrVYXr4MWcHWiIlPFlJvX6hevUYR9dVrsxSo7vXrsL5n2XC4n0PW2BVOTltW8ifXlpujLjPAmeuaEQUU0ZYEMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780954505; c=relaxed/simple;
	bh=FADgUrimHtN+qEZsfk3vUT/NgVunEpha4jpRBuiDoYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fi48KU/CSjIUzRE03B6sCNcJn/wQsolwwVsXni7nIvlJEUUcupPdBfKbeCAwtRkPOTdiboaQLZtCoF+zm6SkOcZVWiOCdgNxJdaFGoqx4b3jz8pvNMx+xI0MtRoPXCSeBUZw/1mhagVIMmhGMViQDGI7gccJXlJsJesmEvJyP/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UMmsSExK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMmsSExK"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf0ddaf50fso32698395ad.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 14:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780954502; x=1781559302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mok13K1oI/5oKqM9t1zh4zoQDrWvB1QlqYCZOP0VV4Q=;
        b=UMmsSExKC3kF0ZY5LwxiZigzkAd+jd+HWct3x0m677Cb+Lpe6HCQv1i7z5609q2GiT
         KcXo2w52baFgfzRNg9utPHtxWpMMV+8qgOaLnpw/B1nTjVcUnN60IpSELPhRixEhv0A4
         r0WLjSiETe4fTU2pwXEAbL6j1H+2IyQKlSKw+d650lTc0HoYIJP4/akpmG/e77ejvtwA
         +6ycFzQv3sawUifNXsNiCgT7wIklej49jg9JMBqc20+XcAUyDLlxKmE14SINvxGHRd6Q
         YlfAUcY/HmYYrbu01PK5QTj3zR5KI2qXHQianz0dwR73PUs1oo6Y6+6c+K2tjA4bXo/F
         /wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780954502; x=1781559302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mok13K1oI/5oKqM9t1zh4zoQDrWvB1QlqYCZOP0VV4Q=;
        b=cPPW23Di9nFfwng9DAbgkwEI2vnfFr9TY0m4x0OKYNJTkHc24boUh2IOUs4y0+GBKz
         Aaa3g6WVPzxPiGMbhh3PVBNBWOPzrqubcw7AsxgiJlJO1pw/AQc8KTgtOIfTmF/dZsiZ
         1auIqIZjkG1d8d077xGKPzEASPSPs5hhFH0W0va/jvoEqlSCJPHn2VkJG2LQaKqm1kkD
         Qp+2qU0Iy7byFS2koSmojnoAT2NCyjQmZ88bHIqKiXOUR/63BVMm359qF+y/EZD4WrT3
         JdlfrC0FpAPPL4IJ/i+i5xR+8eUDM/WStx0kuJpSqJ6k9vDBOiWUwvigq5W5a+K7qgAm
         Yg3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9mF327g9cWcddZOH6RYnzpQ6ZepqJpBjSM1LcsV4pK+OJMt6KbmbwB9LB2IgO25pjgzKtVyuBmnaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHV4SVpHeclJ5zpwuf6Z1jxdEqTjYs5m5fGA1qJGedlt1askMV
	Sk/SKYkAfVpRx3YT4TVLOsLH3tGm6RrJjwU4AbyDrYOpFc+/0dMharGulSkPHTWjug==
X-Gm-Gg: Acq92OFWP9gCHDLI4YEGGwFrZbx2vvTHhfbQw5ZidQsiGi82nHu7IxZjzsKCmiZ+/MG
	qwTLMbispqNul2fuk/kYksTZ3eryWkfY5yocmqlUBjQ5WRjBXWCsy0PxkxvgHK64s83YfShr5VG
	sKZJOq9qV1SUuM3eaOp+hhSToLmKsPZqohnfM2rYd7fk7n1XFK/3PsHkAn7DQhJuwO+SVPsq9xR
	WbBY7cqe00imm5dq/RzFsoLhFjfZ5dGQCJcQQglSQ2TBNwPDYQD5cR+OSnag3hRKu15RpTToGS1
	FN653SVdtxkMjyceQ/LfWEFCWTkPROz87DOlsbQv4kw4j1IgNHa38iF8Z8CNd/rbHZpyNKHdJPB
	JIotw0uzm+IGJG6stjlnLEtQQyl5vb+U/s7Wzdb7rrDuw0lPAJrgyAdP3BpnH4C9Ww65lhW1oQI
	oWYICUS+Pfb4/DutAuYSAkj8ygMUIUeKKTfQTu5+3fWcgxRbiMtbT102oLvU/U4HHMxnZhHBEG
X-Received: by 2002:a17:903:2451:b0:2c0:d99a:2fc with SMTP id d9443c01a7336-2c1e78e4e7fmr195316255ad.2.1780954501183;
        Mon, 08 Jun 2026 14:35:01 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e05fsm197449205ad.54.2026.06.08.14.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:35:00 -0700 (PDT)
Date: Mon, 8 Jun 2026 21:34:57 +0000
From: David Matlack <dmatlack@google.com>
To: Pranjal Shrivastava <praan@google.com>
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
Subject: Re: [PATCH v6 06/12] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
Message-ID: <aic1gdmisIT4sqEN@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-7-dmatlack@google.com>
 <aiSb85Ec6jW4xPaE@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiSb85Ec6jW4xPaE@google.com>

On 2026-06-06 10:15 PM, Pranjal Shrivastava wrote:
> On Fri, May 22, 2026 at 08:24:04PM +0000, David Matlack wrote:
> > When a PCI device is preserved across a Live Update, all of its upstream
> > bridges up to the root port must also be preserved. This enables the PCI
> > core and any drivers bound to the bridges to manage bridges correctly
> > across a Live Update.
> > 
> > Notably, this will be used in subsequent commits to ensure that
> > preserved devices can continue performing memory transactions without a
> > disruption or change in routing.
> > 
> > To preserve bridges, the PCI core tracks the number of downstream
> > devices preserved under each bridge using a reference count in struct
> > pci_dev_ser. This allows a bridge to remain preserved until all its
> > downstream preserved devices are unpreserved or finish their
> > participation in the Live Update.
> > 
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  drivers/pci/liveupdate.c    | 136 +++++++++++++++++++++++++++++++-----
> >  include/linux/kho/abi/pci.h |   5 +-
> >  2 files changed, 122 insertions(+), 19 deletions(-)
> > 
> 
> [...]
> 
> > +
> > +#define for_each_pci_dev_in_path(_d, _start, _end) \
> > +	for ((_d) = (_start); (_d) != (_end); (_d) = (_d)->bus->self)
> > +
> > +static void __pci_liveupdate_unpreserve_path(struct pci_ser *ser,
> > +					     struct pci_dev *start,
> > +					     struct pci_dev *end)
> > +{
> > +	struct pci_dev *dev;
> > +
> > +	for_each_pci_dev_in_path(dev, start, end) {
> > +		if (pci_liveupdate_unpreserve_device(ser, dev))
> 
> I might be reading this wrong but are we leaking some upstream devs if 
> an intermediate node fails?
> 
> 			  EP0
> 			/
> Assume we have: RC -> B1 -> B2 
> 				\
> 				 EP1
> 
> and EP0 & EP1 were preserved successfully.
> 
> And then we try unpreserving EP1, we follow:
> 
> unpreserve EP1 -> unpreserve B2 failed due to a corruption.
> 
> This aborts the loop, skipping B1 and RC completely?
> Their refcounts remain elevated, effectively leaking them as preserved 
> state permanently? (i.e. if we unpreserve EP0 after this, B1 & RC will
> still get preserved).

Yes, but that would only happen if there is some sort of kernel bug or
silent data corruption. I guess we could proceed with trying to
unpreserve the bridges upstream. But I opted to log a big warning and
bail immediately.

pci_liveupdate_finish_path() has the same behavior BTW.

> 
> > +			return;
> > +	}
> > +}
> > +
> > +static void pci_liveupdate_unpreserve_path(struct pci_ser *ser,
> > +					   struct pci_dev *start)
> > +{
> > +	__pci_liveupdate_unpreserve_path(ser, start, /*end=*/NULL);
> > +}
> > +
> > +static int pci_liveupdate_preserve_path(struct pci_ser *ser,
> > +					struct pci_dev *start)
> > +{
> > +	struct pci_dev *dev;
> > +	int ret;
> > +
> > +	for_each_pci_dev_in_path(dev, start, NULL) {
> > +		ret = pci_liveupdate_preserve_device(ser, dev);
> > +		if (ret) {
> > +			__pci_liveupdate_unpreserve_path(ser, start, dev);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * pci_liveupdate_preserve() - Preserve a PCI device across Live Update
> >   * @dev: The PCI device to preserve.
> > @@ -321,6 +403,9 @@ static int pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev *d
> >   * pci_liveupdate_preserve() from their struct liveupdate_file_handler
> >   * preserve() callback to ensure the outgoing struct pci_ser is already set up.
> >   *
> > + * pci_liveupdate_preserve() automatically preserves all bridges upstream of
> > + * @dev.
> > + *
> >   * Returns: 0 on success, <0 on failure.
> >   */
> >  int pci_liveupdate_preserve(struct pci_dev *dev)
> > @@ -336,7 +421,7 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
> >  	if (IS_ERR(ser))
> >  		return PTR_ERR(ser);
> >  
> > -	return pci_liveupdate_preserve_device(ser, dev);
> > +	return pci_liveupdate_preserve_path(ser, dev);
> 
> Minor nit: I might be too nitpicky here (and it's NOT a strong opinion)
> but naming it pci_liveupdate_preserve_path_for_dev() reads better to me.

Noted :). I'll keep the current name for now since that is pretty long,
but if anyone else votes for it I'm happy to be overridden.

> >  }
> >  EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
> >  
> 
> [...]
> 
> Thanks,
> Praan
