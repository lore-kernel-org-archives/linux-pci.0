Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20F94A9D6F
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 23:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789688665; cv=none; b=cQicMHw473NoUvcaMTLOpsWHqHnFd38qrAI3iWBP37R9JB6Canuinyl9MP7XC7vDjaXgAkEKGwC6970GpPBkCcXxxnYuw9EWRNi9gtEUFV5lL2oSejNGXFpd/0tJG1kBPqDWtQcSc+l3B7TXABjqEFN6id6Dn+q3PWfR39MnCsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789688665; c=relaxed/simple;
	bh=0qb5BN4Fj2nv+sgYAPZ46br5D4GO5PoKovsuRwRkY1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZz4aDVh4KppJkp7c2Cl42p7To5bMS4DZTY575IzxgY4bLg+CyUc2xPWJYIm1yod4gXrf7ePTwZQckw3XTAEt//bEnY6oNXRqn0KMKxGI2Hg3mVthQZtmU4aEzUD6pv1RnXQMAHKDoFInZBaq3BOr8R6qLOSfhie+UT0oxg/uOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fIHOCuxa; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fIHOCuxa"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso187651a91.2
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 16:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789688663; x=1790293463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u0O1lZsSl6FgDJ9eTYr2jlFm3jSIkWmZkODdW+Q8s2I=;
        b=fIHOCuxar3V6N3nRyYwyOBcMx25y+NyZcqs0AY84mFT+xwFfPqJKwOGb1ksccBidBR
         d19yafntAo/US2zxt0jccsO1B9hLnulcO6//5cM+YtRTWok9yTdBcYc6Q9WTeJyxW7ON
         eI3t6eOD4nof6MnVagWJkU0eMMhvHyvq0uXy61hruFYTmmIRDzo1MQ7GMnj4hS670t08
         AfuE+GvbslBfgsg5/3Ox1ym/OaKTZ9Ni8/RVv2pVbG+FCGRONjilASp/y5djgrZJdAXT
         b2nLbmdDomUtH3chp9Kv/8DkXeW1P01VAyEgZlFwQog+TIqwsnMzIWibWRhVlBMcFroX
         v3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789688663; x=1790293463;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u0O1lZsSl6FgDJ9eTYr2jlFm3jSIkWmZkODdW+Q8s2I=;
        b=Pj4gL5WMcAy+WpVsM+vq6ljrh/f0eluIbqSE3Ftj2UACesydJryB2+FA7At6Aw8JhS
         iBmrale25VCZoPxLnlPev1o/vrvBn1zpmzOIiwtoM5PSs0ynu9d4nfteP4nsxADEqk55
         OP2Fcq8t0mDXyH0AS/uEceHorjXQiyuvNlztzpPSytT0+43LGFXLK7dOT0iO3vng0pWv
         n3GwatGQYyNDvmbDzLiSXn1ZO3INiKtr2r1dmag0TYpNwCzSBK2ijOx+HomcyyJiZHjC
         5i62XMShvcGMC5KoIcQobY9Tu5FBDAq5wQx6MygAHDNZ8bPxig2nBvbg9ziN6XWpPDzx
         APzw==
X-Forwarded-Encrypted: i=1; AKwUvBxoYci0EbKXeTDu5Gn7WvQYJeY4isTGEInlJCmBde65/ZzlRGN1PdVVaFLIama9pI/tLoH6rDm+pFI=@vger.kernel.org
X-Gm-Message-State: AFuF++nF3Fyx4TCe5IMtE23NuYg0qPdKacTQc1wNwRtcgefy07OB8TYP
	KlsYGlW/5HnP/RakFA7pYqKm5QonGKU9Zx6D5IppmaiziTHtYVxTLqOBd0FEd4NyAw==
X-Gm-Gg: AYBFou0WBkBgrFk5Zj1bPzO4mAKLcNJdJcP3fmBcaNXO2NxKvUmoszwJrrmCbo3DNMF
	Kh3PRQOOWyRYi23anWdtFueEs7sgVbyYT15zTjOcM94cAF/QWYXbbiWy+/wUktTRYXG6xLJhjNt
	PWajmxwq/DHbSRvL3U6cupbRrMN8Qofmk4Jrwg6+o/nRdGN8vtfhvmB5I3Tvfhs7jhVs19adGDO
	GIa8uLnsub2cszhrWfD/Z4j6r3VzlFjMiQZC6ZayaOCWrO4T+Yt1GyjBQ7/2SYzVwOrtV0tHDRL
	0dHBbeGU/lCzLRp7DYbRcE7hf9Gsw8pTBHT+3NnaoYsvJL9WKULnyLMp8COjxbai6RdU6lTX54d
	jEfxl9l6cFqupT1ILT5VZvY1PIQQwsE0OGxuNcAX/Vtbjt3LXyOGDG4k6de5DxTgu19ZeDT1f0M
	vXb3F43rbnpgbSM6B72wxKR2k4twIRujFC5riMZVWTwuIlwXOQf2V1nAlq4S9JOVQdAyBuwhCMT
	6ra/CPxeUHG3kaJ6WjWo8b+MOK0B2VH6Ly4ml5uLp33T5hODqA=
X-Received: by 2002:a17:90b:2ecb:b0:39e:4c81:6c9a with SMTP id 98e67ed59e1d1-39e54fafb06mr1575707a91.32.1789688662542;
        Thu, 17 Sep 2026 16:44:22 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e535f0421sm443246a91.1.2026.09.17.16.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:44:21 -0700 (PDT)
Date: Thu, 17 Sep 2026 23:44:17 +0000
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 06/12] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
Message-ID: <aqx7USJxZrk9GIWm@google.com>
References: <20260728221007.2098560-7-dmatlack@google.com>
 <20260917000723.GA992337@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917000723.GA992337@bhelgaas>

On 2026-09-16 07:07 PM, Bjorn Helgaas wrote:
> On Tue, Jul 28, 2026 at 10:10:00PM +0000, David Matlack wrote:
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
> > ...
> 
> > +static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
> > +					    struct pci_dev *dev)
> >  {
> >  	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
> >  
> >  	if (!dev_ser) {
> >  		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
> > -		return;
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!dev_ser->refcount) {
> > +		pci_WARN(dev, 1, "Preserved device has a 0 refcount!\n");
> > +		return -EINVAL;
> >  	}
> >  
> > +	if (--dev_ser->refcount)
> > +		return 0;
> 
> I guess this is a nit: I was looking for a dev_ser->refcount++ in this
> patch to correspond with this decrement.  I *guess* the
> "dev_ser->refcount = 1" in pci_liveupdate_preserve_device() starts
> that, and the "dev->liveupdate.outgoing->refcount++" there is an
> increment of the same refcount?  The connections there don't seem
> quite obvious to me.
> 
> But I guess "dev_ser->refcount = 1" was added by a different patch, so
> probably *not* the same?

As mentioned in the other reply I can combine refcount=1 and refcount++
into a single refcount++ to make this simpler.

The refcount=1 is for when a device is first preserved. refcount++ is
for when a device is preserved a subsequent time. Bridges are the only
devices that can have a refcount > 1 so that's why this patch introduces
the refcount++.

> 
> >  	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
> >  	outgoing->ser->nr_devices--;
> >  	memset(dev_ser, 0, sizeof(*dev_ser));
> >  	dev->liveupdate.outgoing = NULL;
> > +	return 0;
> > +}
> 
> > @@ -385,13 +418,23 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
> >  	}
> >  
> >  	if (dev->liveupdate.outgoing) {
> > -		pci_warn(dev, "Device is already preserved\n");
> > -		return -EBUSY;
> > -	}
> > +		if (!dev->liveupdate.outgoing->refcount) {
> > +			pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
> > +			return -EINVAL;
> > +		}
> >  
> > -	if (!pci_is_root_bus(dev->bus)) {
> > -		pci_warn(dev, "Cannot preserve devices behind bridges\n");
> > -		return -EINVAL;
> > +		/*
> > +		 * Endpoint devices should not be preserved more than once.
> > +		 * Bridges are preserved once for every downstream device that
> > +		 * is preserved.
> > +		 */
> > +		if (!dev->subordinate) {
> > +			pci_warn(dev, "Device is already preserved\n");
> > +			return -EBUSY;
> > +		}
> > +
> > +		dev->liveupdate.outgoing->refcount++;
> > +		return 0;
> >  	}
> >  
> >  	dev_ser = pci_flb_alloc_dev_ser(outgoing);
