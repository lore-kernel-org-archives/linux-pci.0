Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01051372EE3
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777322465; cv=none; b=HTW5KIfu7VHfjYAXdCI1SCTbfjAlHyfWGeQyjQUIxfG7U48nrk0StggA17fX7Fbqgr0+8idgrLHQD8AEDo219lyBiB6BTnIeUeMYuICz6CyewHnUoxm9TqgdWLbYnwa32xTPGsEQtDe8StsFIJ5UwFZyzIfl64xHyOqvUuasK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777322465; c=relaxed/simple;
	bh=VtybxAi8wqTRTXeCEm16Hr4v3bL40QteE/s5Hrb0gmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1RdriQV72deDw3nphXpbzLCq8/hDrMAbYVf/cqYCEEB5dGn3yPtb6zVpLaWWb7DhvyMP5jQOi2Gonda6JbsLNJvI9wg+NicFgkgrklrhTlybKbYujCzQ7jutLFzPdIl9f7nkaswvhr460cB6b+hXNsh30ryd5o2HFqTkappCRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l+74P8y5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+74P8y5"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35da8d037a5so5051138a91.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777322463; x=1777927263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wM+QOtZ9yfNrPXhT14ztNpzNE+UB64YzKseERpnZeo=;
        b=l+74P8y5IvcIyLCJhWfduUcJY6PExFFYPz7uwWtbcQhdHNz+n3ynRYHkqzW7G+vjGm
         fuaW8tW8lVe6yUmC13/ZSNz1n6C1Ml1F0I144uxlRL2b0YspkmehWAZK1X0LolD68Rm4
         j2G6tb7gaeV7op3zWdAlUQQepJ2oHb3jxYMbW1a7nQfKa/Tj5TUcCNtF9m4iRYCIGK+r
         bbqH2ou7D+xISbfUIeRJl8moQ6zWgopeljKQ9nwGYV+J/zwB1M3oDwoc9agR5lrd3bYq
         Jdr5a7dfzTp5lyy7V8wqooLMB8P5J+pRbEbVkJzDS5ZmXDi1FkswzutNpTATkTRgnElg
         tx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777322463; x=1777927263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wM+QOtZ9yfNrPXhT14ztNpzNE+UB64YzKseERpnZeo=;
        b=GSZCt97zRxRqEoQS8vgI1aU40Avgqmx+1l4W9S7d/gqgN7idx9HHticPEHlaKdR0DG
         U1/mbSbuVQFzqWVQStOtQ8uiTBI0+tt9WC7iZKt3Pm7tO4Zk1fyZzztgjDZuPUAgr7SU
         GiHyEIAWz+KHSN9/kUPY8ayI0gPYKtGTJp5I6pr1ZdeAILq11hRv6H9HWihVmOB+27hU
         EPycwojOlrrp3UBA+h3aMUDjT1g2tTqdpsJgYXEvQg461SPE+c5ytwB8KN0RWY0PcSws
         XqmkEtyT2RbcleBAuFwN72XY+V7d5vOowm3QvNiUeDoukDjxue9hPKxbvigICS/R6Zhe
         07+w==
X-Forwarded-Encrypted: i=1; AFNElJ8zoCMd3S48e+cG/aK8fT4U8MjkD58PMTkldHzxVGJcEsUyg5RFOSYbIufI/3uICVRbtBAEn0d73mA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz88edrZUclRIcWz6XuJwcZ4VQw+WqRg5MCDy4q/Of323ZWE15H
	tB5xPTSJTSN7Mr8BVdR+lUNU3lTrBmgZ/n/IehjwMfoIwzrGffPBzKUb+54XIYnf/A==
X-Gm-Gg: AeBDies6pBaZypIRPbZ+lgo8JlZCyaQGUGyxTumkHvUcGxRJRLbJ9eiXu1Kjy5YOBPy
	v95Wh8MEheKuqyXfnypF9Indt5c8yRGQP6VMLYVkkfvCjQ4OZ8BLrzy2/wctkVTDyv1smQp9SIy
	X9sdfnjoI8F00vyEi1caf0qrP9QVdBiXZ9PA968zxFYu8kKdIE8M//jTnYRb9bQwfnPx8/2kgKC
	lak4R7Ghrk6CeF+6JVld21p2QE1BaWoiJwGindPxR6xqw5h0AZV6QLMiws0e3+d5HlZ+b/PGnCH
	vmL9RG9PNXf+2Rk8iMWyxhaFozVhCyKbPIiBzDpIWXc2eGHzShAJWgdtSJX6ISra9/GDjU5UYsg
	st2vDEtkOj30oOE2K5jkhpZ9ZUuHT9QO3nyagMCypxyXWSqhk63BjQssAXlTHvbrh+D287TCslq
	1X/wQQLuoXrkZyYpzM4gt2tMJQ+lelnDh7rbKducb03yDzuCdyVY9V+oZh7rndlMzMahlZ4fI1c
	mZ0Q9QzJN4z1MID
X-Received: by 2002:a17:902:c412:b0:2ae:57e6:616c with SMTP id d9443c01a7336-2b97c3cba0cmr1478985ad.3.1777322462621;
        Mon, 27 Apr 2026 13:41:02 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97ac784c5sm3813795ad.45.2026.04.27.13.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 13:41:01 -0700 (PDT)
Date: Mon, 27 Apr 2026 20:40:58 +0000
From: David Matlack <dmatlack@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 05/11] PCI: liveupdate: Inherit bus numbers during
 Live Update
Message-ID: <ae_J2pRWFf5qjZXb@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-6-dmatlack@google.com>
 <20260427114745.00000656@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427114745.00000656@linux.microsoft.com>

On 2026-04-27 11:47 AM, Jacob Pan wrote:
> On Thu, 23 Apr 2026 21:23:09 +0000
> David Matlack <dmatlack@google.com> wrote:

> > To keep things simple, inherit the secondary and subordinate bus
> > numbers on all bridges if any PCI devices were preserved (i.e. even
> > bridges without any downstream endpoints that were preserved). This
> > avoids accidentally assigning a bridge a new window that overlaps
> > with a preserved device that is downstream of a different bridge.
> > 
> > If a bridge is enumerated with a broken topology or has no bus numbers
> > set during a Live Update, refuse to assign it new bus numbers and
> > refuse to enumerate devices below it. This is a safety measure to
> > prevent topology conflicts.
> > 
> > Require that CONFIG_CARDBUS is not enabled to enable
> > CONFIG_PCI_LIVEUPDATE since inheriting bus numbers on PCI-to-CardBus
> > bridges requires additional work but is not a priority at the moment.
> > 
> > Signed-off-by: David Matlack <dmatlack@google.com>

> > +	/*
> > +	 * During a Live Update, preserved devices are allowed to
> > continue
> > +	 * performing memory transactions. The kernel must not
> > change the fabric
> > +	 * topology, including bus numbers, since that would require
> > disabling
> > +	 * and flushing any memory transactions first.
> > +	 *
> > +	 * To keep things simple, inherit the secondary and
> > subordinate bus
> > +	 * numbers on _all_ bridges if _any_ PCI devices were
> > preserved (i.e.
> > +	 * even bridges without any downstream endpoints that were
> > preserved).
> > +	 * This avoids accidentally assigning a bridge a new window
> > that
> > +	 * overlaps with a preserved device that is downstream of a
> > different
> > +	 * bridge.
> > +	 */
> > +	dev->liveupdate_inherit_buses = true;
> > +
> This flag never gets cleared after the incoming kernel boot up, what if
> the user does a manual rescan via sysfs? i.e.
> # echo 1 > /sys/bus/pci/rescan
> pcibios_assign_all_busses() will never gets called for this device, and
> may hit this
> 	if (dev->liveupdate_inherit_buses) {
> 		pci_err(dev, "Cannot reconfigure bridge during
> 		Live Update!\n");
> 
> So, maybe clear it in pci_liveupdate_finish()?

I think we can allo wa rescan to assign new bus numbers once all devices
go through pci_liveupdate_finish() by clearing
dev->liveupdate_inherit_buses on all devices in pci_flb_finish(). We
would need to hold pci_rescan_remove_lock to avoid this racing with such
a rescan.

Now that you bring up /sys/bus/pci/rescan... I think we also need to
set dev->liveupdate_inherit_buses in the outgoing kernel, to avoid bus
numbers changing on outgoing preserved devices. pci_flb_preserve()
should take pci_rescan_remove_lock and set dev->liveupdate_inherit_buses
on all devices, and pci_flb_unpreserve() should do the opposite.

If we did all then then /sys/bus/pci/rescan can work like normal as long
as no devices are preserved (incoming or outgoing). If any devices are
preserved then dev->liveupdate_inherit_buses gets set to prevent bus
numbers from changing during a possible rescan.
