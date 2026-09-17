Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC4F495043
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 23:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789688319; cv=none; b=blGC+P/D/DSDVpXYQlqRAZygLoZWpEvu70ZycRTkv4UkmOeA7stxf2SCRmQ7xEeOQIFuNPPqsaaPjUEQoT2vB216NIAxIU+0B8XP1pv1efHz0aBE0AXEfYgj8Lc8VnO1SMoM3hRo8tl/BKfl03HJ65z1aHkmfJkJxDhsv8h18cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789688319; c=relaxed/simple;
	bh=7bzgXoqpa7S2qe+MUbsTcZthmstF/MKOSx4x05mGxz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liwfj2Ewl0KSBRhBqdbTqRepOA2M5CldCJGgiV9rAlHMhATrxTGWWXq+3MT+gzBtQxLhtibcz+ynyo9Kia9IxFcPXPcU2X/Va8xZCICZyYqhNVe0vmIls7JYhB3pbF2EhaOIuJ/dwdtL781b9SMEPyjxaweDX/1uvZeI8V3kyOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ktGe8xOV; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ktGe8xOV"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d93ff61046so1453295ad.3
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 16:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789688317; x=1790293117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7fnbLCpb26KXPMnHq1G3sv+CyiTND7rvG+kHXBaTg0g=;
        b=ktGe8xOVCsSa29P+CG4ctREEBJZ722UXhdWOZC8PDH6F9DEWL+5Wxi8M92U0hjH65O
         WUX6bT1LbWMbL10S+Oj6Pw/srhUj1LF/A6YUdlT1XSRM12k481QD4TKSyhh1rWkL75jb
         6Seulrei+8zqTFDVd9FNTGGS8+e0aKAagImmEoJ9mw7fOSOZOR0QzfWE+NRa6tYdBqnW
         3yUuBPKkwOKXtCYEr5WZFTmLGu2tdEQ3mHFe0alsONHKpXmhO532V6GSVwVM1hNfUE0L
         ue/9IQn8GLepiIiR+f4Yuf4mm9Xfrvu+RjkcNjdi61qj4CdCj/r5BpQ2TVnC0FyixqQO
         lSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789688317; x=1790293117;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7fnbLCpb26KXPMnHq1G3sv+CyiTND7rvG+kHXBaTg0g=;
        b=FJfLH56thwF+otY4DuPezADLq7JqdKEMFlWPZUOiYlso5fnKj7PPA7IohLWlQIG9ft
         iNjn0xTa2720BrJngkq3n/sq137uF0eb4Nvy3b/eCwr2cG12RtjGQkgYvFWK5EGFU9TZ
         PjwOenDX5U9ViXF3tcX5WkVnEDPsVROu8jqzZLTUcf4+Bq38zO5yf8r/SuDhI07YIy6S
         woMcP1rrvQ75k+NZcA1DsyEo+FgmDGqVBLmFdmztTFdKeXjBNkYmQPBAyO5PxRUBwG+j
         TQtwvxHlpcMLRbDT4JP25T2XV1ESkz1vhZvgzwdZXuTURfpQvi0qD3PLsg07jlE7xFpL
         5//g==
X-Forwarded-Encrypted: i=1; AKwUvBwO2ZWK9j1ZBsaFI1/390qeMCn3rWXJYjn+g3Jb/9IzwTqovVRqHPWKcsyx1HQ8xO+tHKbJXBlPH4Y=@vger.kernel.org
X-Gm-Message-State: AFuF++meemDBEEWC3PJb2NQhJxmSE5S1odhyq0j95NG3rUs7tYfsPgf9
	T/qH7SPXrPHf5LqeYkXQm7l5xviyNvI7NDKPuZRlrKw806/6fb8ywq+ulo8AhLq1DA==
X-Gm-Gg: AYBFou1d4I7g9wBc13dK6DTzNKwaE8Rmo9mg/Txu72ZCKGaKPiFG0ZsiATHD5ruGPdj
	hgg4QUNhQ7GxRbf04LQoEVTDZX1EHk6ra85FCm+BtdLspV0L3hJUWDinU1V7UeOpvC3hwqLeAHq
	D0xaUVy6vjp/S4Hr4/tvQNfHjTkS64ynO064SnWQqSzrb57YIXkp5sT7g7gH9nJ7ZaM3nSsnV3y
	e6SIZ5p1FMNui6AY4r+3uwle+V01Ge4XAbx563neRIsM3+5uEQ9+UY43FLiL3EHpVCQzjZQZIlv
	MTfVhePKq0/+YEdMxst6i/N5RK27WLy1xaak8XzSp6pcVJwvIva8/6m4VYgdovvlvobO2qaKwv2
	/VildGEkZpcplmxWfDHq5hsS3AI+19X8CR6ngdAboyRSF+K+twb/S9rKt/aX8avMtUyTV4DsLOx
	dJnjIQHnQziNnLJ5mc2xllN2Cn5Xi34j+/HsPLuG+1pWfuRIB8HTpu9vrLC4CnjfKM2V4hCKgb8
	vRYVaq51nHmgTVNOdLvxU1xfYUcOAP0//ONnRC6UsZYt1ICazs=
X-Received: by 2002:a17:902:c944:b0:2d6:ffa1:429b with SMTP id d9443c01a7336-2ddb1adf381mr15539635ad.7.1789688316616;
        Thu, 17 Sep 2026 16:38:36 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89e96cccsm32897375ad.22.2026.09.17.16.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:38:35 -0700 (PDT)
Date: Thu, 17 Sep 2026 23:38:32 +0000
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
Subject: Re: [PATCH v8 10/12] PCI: liveupdate: Freeze preservation status
 during shutdown
Message-ID: <aqx5-KH_GcSvsvqs@google.com>
References: <20260728221007.2098560-11-dmatlack@google.com>
 <20260917201737.GA1047708@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917201737.GA1047708@bhelgaas>

On 2026-09-17 03:17 PM, Bjorn Helgaas wrote:
> On Tue, Jul 28, 2026 at 10:10:04PM +0000, David Matlack wrote:
> > Freeze a device's outgoing preservation status (preserved or not
> > preserved) during shutdown. This enables the PCI core and drivers to
> > safely make decisions based on the device's preservation status during
> > shutdown.
> > 
> > Note that pci_liveupdate_freeze() is triggered by the PCI core rather
> > than from drivers participating in Live Update so that all devices can
> > have their status frozen (i.e. prevent non-preserved devices from
> > getting preserved late).
> 
> This calls pci_liveupdate_freeze() from pci_device_shutdown(), the
> pci_bus_type .shutdown() method, which I think is only called from
> device_shutdown() in the kexec or restart paths.
> 
> Since there's no error exit after we get as far as device_shutdown(),
> and this applies to all devices and dev->liveupdate.frozen is never
> set to false (at least at this point in the series), is there benefit
> to tracking this per-device?

I think this could be global. But I don't see any obvious place to add
that hook and keeping it per device is one less global variable to
worry about.

> > Reviewed-by: Pranjal Shrivastava <praan@google.com>
> > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Signed-off-by: David Matlack <dmatlack@google.com>
> 
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> > ---
> >  drivers/pci/liveupdate.c       | 16 ++++++++++++++++
> >  drivers/pci/liveupdate.h       |  4 ++++
> >  drivers/pci/pci-driver.c       |  2 ++
> >  include/linux/pci_liveupdate.h |  3 +++
> >  4 files changed, 25 insertions(+)
> > 
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index 744513ee11ed..65bcecb1b64e 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> > @@ -394,6 +394,11 @@ static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
> >  {
> >  	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
> >  
> > +	if (dev->liveupdate.frozen) {
> > +		pci_warn(dev, "Cannot unpreserve device after it is frozen!\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	if (!dev_ser) {
> >  		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
> >  		return -EINVAL;
> > @@ -447,6 +452,11 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
> >  		return -EINVAL;
> >  	}
> >  
> > +	if (dev->liveupdate.frozen) {
> > +		pci_warn(dev, "Cannot preserve device after it is frozen!\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	if (dev->liveupdate.outgoing) {
> >  		if (!dev->liveupdate.outgoing->refcount) {
> >  			pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
> > @@ -718,6 +728,12 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
> >  		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
> >  }
> >  
> > +void pci_liveupdate_freeze(struct pci_dev *dev)
> > +{
> > +	guard(rwsem_write)(&pci_liveupdate.rwsem);
> > +	dev->liveupdate.frozen = 1;
> 
> Nit, the series assigns "true" to other booleans
> (preserve_bus_numbers, was_preserved).

Ack, will fix.
