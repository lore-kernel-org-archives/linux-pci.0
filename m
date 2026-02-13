Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D97A35FF43
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2026 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991814; cv=none; b=DFNwETy1j4EEbmuyDmhuWZW+0aR1w81sqNGP+pUPLxK6DTkA0lsrv3TItYWY5YH2rHw6kgmaWo1/y1N0hqeP4PXH30LNDfsL4OfgJACSw0cNbBrBBmY/Q4NKC79Mfv8flpWb7vvpuTHYImuo1IJv5m+GO8MSyZdX9CROX0leQy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991814; c=relaxed/simple;
	bh=Jwda1XIXGoATYSn4IqggNMXVCMlXrGRQTrJCNdto0mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEszY32wW4TSgBgqC8mcI4k4ID0rpJlJpAQmK2Ju7AgJuHdKmc1j3rP+et9o8NHRKwcdTmu95hP5TfNcO84NWGF3TdXAJMh6MHO3srgfnBb7MbJiUf3g0WB8HGeNhcic+yH9u/thWafR69tUl7VLoXaqAxwEQN6tUUn37X7QcM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sy0SjX4V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sy0SjX4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71715C116C6;
	Fri, 13 Feb 2026 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770991813;
	bh=Jwda1XIXGoATYSn4IqggNMXVCMlXrGRQTrJCNdto0mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sy0SjX4VxcjocJYndrPSuOl4F3aw37Tr4FebsbvU2mpdI6zWN2HIfDMeVxarCke6u
	 Y/UvqRitFNxZ3vE9RBjlPM/ZFocHCqyDwdprPp2xeHYIyxfYShvxFyJyLVSgrFo3EM
	 JF4aCcL6fGJRcn9txOO+Y0Urrh0/IBzPwjcfvTEOxRcoWOen1vYdoXZFo9zSB5/4DG
	 04kOqORmO8ncV4kOvZfxQQDWEp3y8ws3EdPwwV7LwRzgxIMDuMdywLkkwhKfkbQjlS
	 w5tukuezLOuLoLVa0oMya2XoYwNaerAmU1QTI9Tc3vsQA+QtBkuR5/M7eyly1+G6Rf
	 +79iX+C69dUFg==
Date: Fri, 13 Feb 2026 07:10:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	helgaas@kernel.org, alex@shazbot.org, dan.j.williams@intel.com,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCHv4 2/3] pci: allow all bus devices to use the same slot
Message-ID: <aY8wwyH9BpFwzfxm@kbusch-mbp>
References: <20260212224112.1913980-1-kbusch@meta.com>
 <20260212224112.1913980-3-kbusch@meta.com>
 <da0a460b-2098-c9ce-a884-d4a8118638f9@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da0a460b-2098-c9ce-a884-d4a8118638f9@linux.intel.com>

On Fri, Feb 13, 2026 at 09:26:35AM +0200, Ilpo Järvinen wrote:
> On Thu, 12 Feb 2026, Keith Busch wrote:
> > @@ -42,6 +42,15 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
> >  				  pci_domain_nr(slot->bus),
> >  				  slot->bus->number);
> >  
> > +	/*
> > +	 * Preserve legacy ABI expectations that hotplug drivers that manage
> > +	 * multiple devices per slot emit 0 for the device number.
> > +	 */
> > +	if (slot->number == PCI_SLOT_ALL_DEVICES)
> > +		return sysfs_emit(buf, "%04x:%02x:00\n",
> > +				  pci_domain_nr(slot->bus),
> > +				  slot->bus->number);
> 
> This fits to two lines.
> 
> Add braces as it's a multi-line block.

These suggestions clash with the local contentions of this function.
These lines are exact copy/paste from directly above it, with a tiny
modification for the legacy behavior. Not that I'm advocating for this
particular coding style, but consistency is preferred.
