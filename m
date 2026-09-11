Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D8649B5AB
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145156; cv=none; b=MUDQJoQrfgMlYeLuGycmVCu1GcNoHRoV6EIVLdxjpTq5ui9CWLOQfVxd2zRAhY/NY4uXtZjWHDHiWddAKcE1ptFl2Vcst8ipMensM2cQO7mqykYwN5pqXQWCeVOKKsCySZLmPCoYbvnyek8zOkg5B6dMcIkuZpDUdiRa5pQQHok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145156; c=relaxed/simple;
	bh=jhZ8WhdxOZfx0MQfMBGA+WGi7i3w3FCXHl1lH7WqOE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfrYyKpdoXird2dX3fXg0S5S9R8S6gDzqn+asQoyXbsWRaKLd2jWjZB88mK6rsQbvCqDheWXCbSeyPn03zBR5baYYvI+HrmkiJMt8jSZ/+70GGqyhuahtONXXnqBMcd3PK998Prum7qgWDtuVg3MTtGkcr+PeAGJ7PGGvn92H4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rvo5AzN3; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rvo5AzN3"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b2e1d5so136728b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789145154; x=1789749954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=atdgksBYk103iq7faoi4jk9ATkMw9i3avFodOi108iA=;
        b=Rvo5AzN3CZ3SXe637+eGMHys9fYzjo5iJKHoTC7Pfh9vnbsiJMPWr2XNXMakwEMchn
         Mdg4uSWE8aqu5CUh3oZCMEgfc45idjaPiEHXYqLEXHNMbse+r7hoCIyFgoG6A7mftWAd
         AgPPvNWkBWcXUDP+Jm8L1m2sYydebkFHfCEt2OX3QaZ7tUEDO8WA3n6va0Ke67c3g80t
         6XgNUgIvigkfDwMiDnApfO7xPmMgPsqTFuB1xcb52Jc0cZN3FN/GbhbDLqf+VN4uSmHy
         nxFHbCgyeUZ1e6h1M7StIWzxQsNrtnlZEYxoFplaqXPxUKviLnQoDpDycw0JGhEhS/Jf
         NqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789145154; x=1789749954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=atdgksBYk103iq7faoi4jk9ATkMw9i3avFodOi108iA=;
        b=c3BkplxrzBCtn18BLwFUUKo+hLS4eudx8Pu7ft8KAOI9kbq38eYT68Aj4AvfCQWMjy
         SmMWdPeoamEuhr/AwBshZ74n42xCtQps0CRNCC9nXufobjfaqxnEZgz47awTFz4EuuFV
         JNklnKWaMT+lrVDn2mUeytdt6jRZf4Yx2QPVk1sxGOOGPQhMfHtcqhSa2FjrtuJgRKq1
         PN7VfbAW3He9+wTuBXR4/1IInofvCf8qSqmsOirjUtciL082nTebAs0o0Cd7pN7YHZNi
         O+FEs1aarqmHx7pHSwRIQFGo0HsnBWwa3yhQd1hlh7hsTnud/O7pH4HBzGiBR3cdyKTf
         TGiA==
X-Forwarded-Encrypted: i=1; AKwUvByFlAgY3oYgSwFfoYBHdGSR59R6hRElUF7K/Q3uy/aikIfm9N8NUCjvrOqaWjMzTafbObNLEDSU26E=@vger.kernel.org
X-Gm-Message-State: AFuF++kuueNzS5i00nVZAFmdci8LdcUnkXCvHFF9cczTomrvqC2uEHJN
	5cQUTXo3fE/RNaBV7I1ATARF7JjXmkLGNfVc3sdSGkjWGNOVpJI8zj5UDwHhBt2W0g==
X-Gm-Gg: AYBFou1Utu90gFN6WYUtMBuj+gNBwY30cWD2yApAlb2kbukzGuqhcP5MCj3zFqFLYPT
	7e9cDvvEnMZOz9txU0/CV4vRCzqY8Mrw/QWsFc+UbWEXyLy7pE9raVLfBmHiYodv6JIjBXSdC7W
	vQROu8/SQzWWs5j7O+NgUcfLgRwuAraafkda2SqxEOK2o36vBfH6CF2woFXPdqMeCWsW7w6ye4t
	jWKV9gr5v/DpNz7QeGUFoFuhrLTfbxZ9f+1SSse1g7jyby6+TPMDh42f7gIeIJ6rBnK1kAqTtGf
	FccHH5SKLl1HtL1fuHxrtwR5donnE/Rvt78FFJwS+dblJIjWazqrWQSxAqVDsodo4cdJOOCN/Vg
	22FlzfPndBWJCqz1P9tvGJS9r4UEcCOEdkqYOjVc4eX1QaDWc94zrdMfs2S4R+S146MzyMIA4ya
	n314N00TO2/co3yROIuoF5AEaaQFV6LA0MuT9YqDsLAXzzfcL/ozmh8ylmSsiKVmiisoqc6wNc7
	QiR0p2IEfx7veaekXTAXunCW5/vATkaEJdT36PU
X-Received: by 2002:a05:6a00:4c9b:b0:857:72ba:ff0e with SMTP id d2e1a72fcca58-86b347ebbe6mr9035236b3a.22.1789145153852;
        Fri, 11 Sep 2026 09:45:53 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b286c3f5asm1472296b3a.12.2026.09.11.09.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:45:52 -0700 (PDT)
Date: Fri, 11 Sep 2026 16:45:50 +0000
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
Subject: Re: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <aqQwPn4XOxC58vU3@google.com>
References: <20260728221007.2098560-4-dmatlack@google.com>
 <20260910234956.GA367108@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910234956.GA367108@bhelgaas>

On 2026-09-10 06:49 PM, Bjorn Helgaas wrote:
> On Tue, Jul 28, 2026 at 10:09:57PM +0000, David Matlack wrote:
> > During PCI enumeration, the previous kernel might have passed state about
> > devices that were preserved across kexec. The PCI core needs to fetch
> > this state to identify which devices are "incoming" and require special
> > handling.
> > 
> > Add pci_liveupdate_setup_device() which is called during device setup
> > to fetch the serialized state (struct pci_ser) from the Live Update
> > Orchestrator. The first time this happens, pci_flb_retrieve() will run
> > and convert the array of pci_dev_ser structs into an xarray so that it
> > can be looked up efficiently.
> 
> > + * The PCI core does not enforce any ordering of ``pci_liveupdate_finish()`` and
> > + * ``pci_liveupdate_preserve()``. i.e. A PCI device can be **outgoing**
> > + * (preserved for next kernel) and **incoming** (preserved by previous kernel)
> 
> Thinking about how this will be rendered in the formatted doc, I think
> "i.e." is really part of the sentence, so in U.S. usage this would be:
> 
>   ``pci_liveupdate_preserve()``, i.e., a PCI device can be ...
> 
> I understand British usage generally omits the comma after, so that's
> OK too, but IIUC the first part of the sentence shouldn't be
> terminated with a period, and the "A" shouldn't be capitalized as if
> it's a new sentence.
> 
> Similar issue in "PCI: liveupdate: Document driver binding
> responsibilities" later:
> 
>   bound to the correct driver. i.e. The PCI core does not protect ...

Ack I will fix up the use of "i.e." across the series.

> 
> > +static unsigned long pci_ser_xa_key(u32 domain, u16 bdf)
> > +{
> > +	return (unsigned long)domain << 16 | bdf;
> > +}
> 
> Add blank line.
> 
> >  static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> >  {
