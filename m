Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC584ACC9D
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151427; cv=none; b=gwKXZ2pJfZ5mGysUNSnvwP4bHeubLgIC0tiLpKn6h3NnG/dtILdaYNvdSZHaGWkwTKGxxSc+/+/or4tFoVwx5eOM33XgTiQ3iZ1ME3PHeaiw3uR1LvW170zEYNKQeJoBEWZce0/Wv5mCu0tLOfzuaMO6N7/NOdSkB00khv+4pRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151427; c=relaxed/simple;
	bh=TVE3JVWlJlOZPRS1ruijM+QLYraeNqQKuJubo8lPiII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbnW6es/1WZLKOMRwfwxUaNifDUvyMRdgZV5MRcpH2cUoNLE1c63kPcKhUbXJ8oPtpKV3ym9vxbsSSQsIuf+Z8Sei5x3pB+oI0YLhwoYHjv/yiPxKLhgGcqMmmWMgrxuLyUU5g1dex0Hx3sTJEtlOmID1IyMg/Yp4DSgktlzBdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n/A4sIKD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n/A4sIKD"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso17373865ad.2
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 11:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789151425; x=1789756225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wNS06P8dgAVGWElToa1LxbVILkDrDt7tgcn+fOWtX1k=;
        b=n/A4sIKD35qfXbjSPtoC59egLyEW+bJK7TPxI4HOq56gjXcceK0OAgT8hX83TnZw71
         FgkkWOgPn8vqN1XTuP1Q290BhPKFbq1lo699/fPN2C84REmmP86xlV8d7qDqC68q7TGy
         wc2LWlKrafJy3d0f3yuHb+FRF5EkgTqdCtsY85lOrtMxlQDBCG2obYOrxXHNP0bZMlX2
         VcWqT8/FWwa+Nyj45eymCS1PZ9vd4UB+1Zcz/MxxPSW4wHF9ozBTV+RcI23BGMztvruU
         26sOw/8rvy71BswwqOZj2DNwZJEd+vQep7FCyqOC+p9MbjbZhTzv5z4HThSAcSIy7hgC
         y3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789151425; x=1789756225;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNS06P8dgAVGWElToa1LxbVILkDrDt7tgcn+fOWtX1k=;
        b=fPvMzWuVZwLPSKLkf8xhu3Y+kk7HnaJkViVXMwDOWMBM86J6thWA5luUvKFlSB85Hi
         kE7erw77lNCv+mjmms0TiIFdaqSEYn6r/FatDUmwznwQvvkf6mM+iZJcQmHDAlL4HJbj
         oX7gy7tgCmRZ4mN7aPB2LJgYW2s6ujEOVZhYX0xOOqS1379z2lCuWPSOF+VjaWItE/xa
         lS7DT76yn7EVBZt7sRFXnw6oK2BGZHEyLWL+UrZMD0VGyJB2DtzJ2kkx/Mk7UhDXNBGK
         MalhArENl27I1M4x/5l82r3T4KaMTmIw6I+ZHhm6Hu+8Wh2YkwjIW5HxL9ddYzHPyk8Z
         Ua4g==
X-Forwarded-Encrypted: i=1; AKwUvBwiZ6OSIS8AeW43PcfB5PL/EjmoyirkqC+4FWaI6ejM8dc0q59gLVgsbK21pOJzHVSpwd5lKfM1Vlg=@vger.kernel.org
X-Gm-Message-State: AFuF++kJMbpbBJGrwyy95FHyaaALGqXOl7pjeqhR8Y6mfCCGPqIwhORz
	2KHkLiG5hbrVXt7q073YNGsk5PH3FODuLnfrVmO6eZ9KoMktk6SxXl21bGFtMpGcIw==
X-Gm-Gg: AYBFou3SGz/I86q0Q4Xa8kWDF8KRfipV3V2aoEDVxpD7TMNsY/DUVkVN0puNjnnJZCs
	TsUJVesvLMvIq50JKKnWKvAAuoj94szt1rb27hwUEXIKK0lkpSyDSlRBcM7WAUFK3/C0GcXgckb
	gF4StKs/Iixe2zUPQXtoakjiRzRwR+g+L2iqh1dBdxKYAdPQPeWL03x+lHvzgzIaNQcJuUj2ih4
	s2Qi7rM/T3OmNj7oBmM4WRNJYL+48Uhj6zJDJfOwLuxelGdav09XIN69SEkIYhM/wpxBLVVYM34
	fviWgKr3uF651zOxBgL/FHOrR6ynkjxjG/GyP3G+rtHcLAe1QUJ1tBtEw0SXeaGc59pMRM0zkqo
	7kzSaNEHJLUYFjRgXerOEd50WhTfGckNiZ8WwS6uL14FHqbHUPmg7hY9LflRSlG3EdtNYpsLpgc
	lsEwoCBpqDbJ0AJp0vS73eR3782+xyQvyuTgFR0p8TE1hdFuSulPJeEtyQHbdm08DTdxgqDfrq1
	Zaz7CAyIMwTRODRgGm4pcajQJtR/T/h1AHV9Usu
X-Received: by 2002:a17:90b:53d0:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-39d9bc1b0demr8040768a91.1.1789151424426;
        Fri, 11 Sep 2026 11:30:24 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b16sm6613109a91.14.2026.09.11.11.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:30:23 -0700 (PDT)
Date: Fri, 11 Sep 2026 18:30:19 +0000
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
Subject: Re: [PATCH v8 05/12] PCI: liveupdate: Preserve bus numbers during
 Live Update
Message-ID: <aqRIJs1SdJwoV_cf@google.com>
References: <20260728221007.2098560-6-dmatlack@google.com>
 <20260910235104.GA367522@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910235104.GA367522@bhelgaas>

On 2026-09-10 06:51 PM, Bjorn Helgaas wrote:
> On Tue, Jul 28, 2026 at 10:09:59PM +0000, David Matlack wrote:
> > During a Live Update, preserved devices must be allowed to continue
> > performing memory transactions so the kernel cannot change the fabric
> > topology, including bus numbers, since that would require disabling and
> > flushing any memory transactions first.
> > 
> > To keep bus numbers constant, always preserve the secondary and
> > subordinate bus numbers assigned to bridges during scanning, instead of
> > assigning new ones, if any PCI devices were preserved. Note that the
> > kernel preserves bus numbers even on bridges without any downstream
> > endpoints that were preserved. This avoids accidentally assigning a
> > bridge a new window that overlaps with a preserved device that is
> > downstream of a different bridge.
> 
> > +bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus, struct pci_dev *dev)
> > +{
> > +	struct pci_dev *parent = bus->self;
> > +
> > +	if (dev->liveupdate.preserve_bus_numbers)
> > +		return true;
> > +
> > +	if (parent && parent->liveupdate.preserve_bus_numbers) {
> > +		/*
> > +		 * Preserve bus numbers if the parent bridge is required to
> > +		 * preserve bus numbers. Otherwise the PCI core could expand
> > +		 * this bridge's reservation beyond its parent (which cannot
> > +		 * expand).
> > +		 */
> > +		dev->liveupdate.preserve_bus_numbers = true;
> > +	} else {
> > +		/*
> > +		 * Otherwise preserve bus numbers if there are any incoming
> > +		 * preserved devices. This ensures that the PCI core does not
> > +		 * allocate a bus number to a non-preserved device that
> > +		 * conflicts with the bus number already assigned to a preserved
> > +		 * device.
> > +		 *
> > +		 * This is slightly more restrictive than it needs to be. For
> > +		 * example, each host bridges have their own range of bus
> > +		 * numbers that won't conflict with other host bridges. But the
> > +		 * previous kernel should have assigned a sane bus topology and
> > +		 * it is simpler to just adopt that entire topology.
> 
> s/each ... bridges have their/each ... bridge has its/
> 
> It's true there should be no bus number conflicts between host
> bridges, but it does require the domain as well.
> 
> > +		 */
> > +		dev->liveupdate.preserve_bus_numbers =
> > +			pci_has_incoming_preserved_devices();
> > +	}
> > +
> > +	return dev->liveupdate.preserve_bus_numbers;
> 
> I'm not sure why you don't just return
> pci_has_incoming_preserved_devices() in all cases, which is what the
> commit log suggests this patch does.  What's gained by all the logic
> here?  It's not like devices will be hot-added during the kexec.

To protect against pci_has_incoming_preserved_devices() flipping from
true to false while the PCI core is in the middle of a scan. It is not
likely to ever happen given most host bridge scanning should happen
during early boot, but theoretically possible with the way the PCI core
code is structured. I did not see way to structurally ensure these 2
things cannot race. A lot of the host bridge scanning happens without
taking the rescan lock, for example.
