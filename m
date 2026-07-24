Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34EC3264DF;
	Fri, 24 Jul 2026 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927038; cv=none; b=VlugDgqUokjDYM5rmR5XyS4KLvnlLq17s8qcmL2jsk1yv+ahiuLy7e0liFI4khFSAR7yRn9TTIJBuWF8KldqjZmFrTFLDmelS2pBgjmknrl2ODapgTS4+uPoBZhWAWxXWUniRHmpwHBMFMfClBNQosgTFKdw9ggNyO1fm3fB+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927038; c=relaxed/simple;
	bh=ofQYJLPJuLb56vsCfj1sPQnKlQXy/1WsBcI/GzEpXb4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EbHb3Ehr5atpRBEIUrulw4Jj3E0uG1WxTcAy+W+zTXiMQi1NU/SWXwHtBEChlqqiPssEhWS4+ztGleZ91gnNytIOkeD+CRmVfS049ozINX1ZS8Hpnmu31QwDV0mKH6Z0mYaaG0HIr0O409/9ojEC8D1vbmnjXiw1KHehntsrhRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awwG2N60; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awwG2N60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BC21F000E9;
	Fri, 24 Jul 2026 21:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784927036;
	bh=ORy7pD3J3tq2ffN0BYU78UX4I8xRQr5quYqmf8Dwz0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=awwG2N60+aaqJ3kLhq5nlZL6C/rx1WROQ4/ll5LuH3nXHs1kPA0zvlTOgoRhi17Aa
	 nOiqCGQjQ5jV1cHlp71EJ75x1kxOT1T9nd8meabJtXAtvHVmbrRFR6N1enDeGQ0evu
	 h4gdVbjRuzDNrq33cwbS5oOj2tyyiyh9iiWXqiiNRjG2563ghB9Nw6yktQJoNk7gwV
	 7XLxAtE+LhI63U7atmwMhC4ULTesDHuRr982v+q9UFF9CV0CKGJsEyOtAlM0Ud+Mlh
	 TS5RP/788u8V6/Qs+oE/IxHYboT5ocyv0tYA/CFjT/XIK5cpXO+fV/trhVrZMf24GK
	 yWcy1B6i6Nrcg==
Date: Fri, 24 Jul 2026 16:03:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
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
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 07/12] PCI: Refactor matching logic for pci_dev_acs_ops
Message-ID: <20260724210355.GA1052395@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710212616.1351130-8-dmatlack@google.com>

On Fri, Jul 10, 2026 at 09:26:10PM +0000, David Matlack wrote:
> Refactor the logic to match devices to pci_dev_acs_ops by factoring out
> the loop and device matching into its own routine. This eliminates some

Can you mention the name of the new routine here?  I guess it's
pci_dev_acs_ops_get()?

> duplicate code between pci_dev_specific_enable_acs() and
> pci_dev_specific_disable_acs_redir(), and will also be used in a
> subsequent commit to check if a device requires device-specific
> enable_acs() during a Live Update.
> 
> No functional change intended.
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/quirks.c | 51 ++++++++++++++++++--------------------------
>  1 file changed, 21 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846f..7ac39ec2843e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5374,9 +5374,6 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
>   */
>  static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
>  {
> -	if (!pci_quirk_intel_pch_acs_match(dev))
> -		return -ENOTTY;
> -
>  	if (pci_quirk_enable_intel_lpc_acs(dev)) {
>  		pci_warn(dev, "Failed to enable Intel PCH ACS quirk\n");
>  		return 0;
> @@ -5396,9 +5393,6 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
>  	int pos;
>  	u32 cap, ctrl;
>  
> -	if (!pci_quirk_intel_spt_pch_acs_match(dev))
> -		return -ENOTTY;
> -
>  	pos = dev->acs_cap;
>  	if (!pos)
>  		return -ENOTTY;
> @@ -5426,9 +5420,6 @@ static int pci_quirk_disable_intel_spt_pch_acs_redir(struct pci_dev *dev)
>  	int pos;
>  	u32 cap, ctrl;
>  
> -	if (!pci_quirk_intel_spt_pch_acs_match(dev))
> -		return -ENOTTY;
> -
>  	pos = dev->acs_cap;
>  	if (!pos)
>  		return -ENOTTY;
> @@ -5448,56 +5439,56 @@ static int pci_quirk_disable_intel_spt_pch_acs_redir(struct pci_dev *dev)
>  static const struct pci_dev_acs_ops {
>  	u16 vendor;
>  	u16 device;
> +	bool (*match)(struct pci_dev *dev);
>  	int (*enable_acs)(struct pci_dev *dev);
>  	int (*disable_acs_redir)(struct pci_dev *dev);
>  } pci_dev_acs_ops[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> +	    .match = pci_quirk_intel_pch_acs_match,
>  	    .enable_acs = pci_quirk_enable_intel_pch_acs,
>  	},
>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> +	    .match = pci_quirk_intel_spt_pch_acs_match,
>  	    .enable_acs = pci_quirk_enable_intel_spt_pch_acs,
>  	    .disable_acs_redir = pci_quirk_disable_intel_spt_pch_acs_redir,
>  	},
>  };
>  
> -int pci_dev_specific_enable_acs(struct pci_dev *dev)
> +static const struct pci_dev_acs_ops *pci_dev_acs_ops_get(struct pci_dev *dev)
>  {
>  	const struct pci_dev_acs_ops *p;
> -	int i, ret;
> +	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
>  		p = &pci_dev_acs_ops[i];
>  		if ((p->vendor == dev->vendor ||
>  		     p->vendor == (u16)PCI_ANY_ID) &&
>  		    (p->device == dev->device ||
> -		     p->device == (u16)PCI_ANY_ID) &&
> -		    p->enable_acs) {
> -			ret = p->enable_acs(dev);
> -			if (ret >= 0)
> -				return ret;
> +		     p->device == (u16)PCI_ANY_ID)) {
> +			if (!p->match || p->match(dev))
> +				return p;
>  		}
>  	}
>  
> +	return NULL;
> +}
> +
> +int pci_dev_specific_enable_acs(struct pci_dev *dev)
> +{
> +	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
> +
> +	if (p && p->enable_acs)
> +		return p->enable_acs(dev);
> +
>  	return -ENOTTY;
>  }
>  
>  int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
>  {
> -	const struct pci_dev_acs_ops *p;
> -	int i, ret;
> +	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
>  
> -	for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
> -		p = &pci_dev_acs_ops[i];
> -		if ((p->vendor == dev->vendor ||
> -		     p->vendor == (u16)PCI_ANY_ID) &&
> -		    (p->device == dev->device ||
> -		     p->device == (u16)PCI_ANY_ID) &&
> -		    p->disable_acs_redir) {
> -			ret = p->disable_acs_redir(dev);
> -			if (ret >= 0)
> -				return ret;
> -		}
> -	}
> +	if (p && p->disable_acs_redir)
> +		return p->disable_acs_redir(dev);
>  
>  	return -ENOTTY;
>  }
> -- 
> 2.55.0.795.g602f6c329a-goog
> 
