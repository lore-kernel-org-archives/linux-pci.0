Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246B4207A
	for <linux-pci@vger.kernel.org>; Sun,  7 Jun 2026 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780858898; cv=none; b=FwsniDVMSeiw552tyk+EAukcOuuhnwXwAXWFDpxsjyuj42iJV3SrO+b0uUt4/Wdls1Bx3LtyQev8Cjy8hNgJEqZahde55cJlmBDQvWGgHTuP9t/c3xEACWzpJTU6sj9X67FgS3LvYNdcIuCef0QgU+kpnQYqS1Thc6k+LuOHkj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780858898; c=relaxed/simple;
	bh=8TXfEMMV2uWnmskY16B5og0NVW5Rz797jmeczmEHw4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dkzz6Egc/3qxIwF5OBvGmcLL5haqjFBNXxJirT25aXL+0jaAZPtY1xla3d3a8a/7ntXAcAJrzE+IEWtLxTZK91u7jD5TGDShuwlpU690PBa6yIzvG+sa8M0t9Kccbld5AqxluwA8jM5asLIIJrmBVsjxOPYR+wP5HlyqOv9LoFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pgRydl7/; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pgRydl7/"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1380104f31eso19926c88.0
        for <linux-pci@vger.kernel.org>; Sun, 07 Jun 2026 12:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780858897; x=1781463697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7bxnEjA/C3zuxdR051u14W5wOLjOO10IAKaN4C2htfQ=;
        b=pgRydl7/v6qxi4kfAI8pxM8jtQMkltAiCed1YgfNGv5z3zqCKVVezTcwFJasClqhFZ
         8SgYwMwaszwJ/Ef+zfADWDwRw7HsKqjHXwbN53uisDybAJFZ4YE/glzBOqj0yZ61DbFd
         ypIXfiFAogGl6i8PiLet9Ij5NGwK7q6D0rxupldOrqbYtNsFChFydkCq2XARxM+kiZnT
         8vvGdx5XlRh/Npilx+iVocF4cf97R9kUoSyYAvOXJrIopREX0JCq/SWk/qZFa5hbbCoe
         FkX8ThHU+FaIOqALNzYvHAaeOp030QdN8H+D5GuxEHsq0mtyOQxvYpoi6pNFTGnSWxbv
         mERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780858897; x=1781463697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bxnEjA/C3zuxdR051u14W5wOLjOO10IAKaN4C2htfQ=;
        b=gCizswiXU+Oo9ezw8XJy8X+B/NG+0J3llRjSN8s9zP9TUq7tgd2MmUgA/KPrwUtHBe
         82hl9RuCjzsOA/mLZ92RABfBmJmIJSWBocW4nwq4atB8zTjDQJNLAgr/XcMVS94bSY43
         ntql14b5R0bxRwisk7B3bWnq2tJb/PVauNkjTTt+WuX68a0k/wf8R6kAkPfJNe9tRoX6
         AWKGb1zkYaPega8OKhBd5VIGH6Hm7I0g28UMUT/YaAUOj4vWwmTIpLw7xfTWttGTiATy
         hgncQSN6axiMjm1cDbQUXDxJHSW8qt86AqrFZver4k8s++48dmUDPkEcYDW2Fmogfls2
         FWEA==
X-Forwarded-Encrypted: i=1; AFNElJ+rXF+99nh+PQv+cdEDVOzCQFx4b6VkA6wFku+GMbi4xVcgA156SiW77zlyoAaOE7+699DYBQSEXig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyldlZvCeFpDDS8VC7LQvAgOKXq0Q9Dyab7FnQu13x6OT/ZBixO
	vkI5+lRggLkiyKvVTwitEFOg2ojjajlcvM8NvwvYk+v4IlH29K2PM4reXXBmAMh3hQ==
X-Gm-Gg: Acq92OHTmzO/l97lQBE+AXRUa9yIvN5XmGcROg2+Pms8ObwcXJ43ZDd60cVh9p+T+w2
	1hMNIuFUfG6KqDzYpgUTl+f3z/mdgNYz0OcQtHL9u2457O6p1lCoRSTi6MSWzrg/hDZbzaRgC0R
	1dNOCA1VjT4lwZyQrtxuNelt41LuRMvFOVRcWJvpl34sc97ChiKq+HuytCuRQ4BfwXfF1MLLszI
	4SoxEEf6qB9dXJi1OL4u2LlobE+eklhlLoVmiM/CdR/hqR3KlJ6cpa97TFdwkHu53R3JOnaPm50
	23Q39XUMzHMFuVHlwl5LH6VyCbZJmEZ9Jt2iT0o0yvhdIpMxVoPrC4u7xH+Al191wYeI+3gqG59
	D6srLZ+nCehu5W7Y5pk/i1Z+NdTM/L25ifC5tO6zcJWg8JeHteP8VPVRnzkkfT+2YJr0prk33D5
	oAKEmG/cFxdpDnK4Lgf+OWNGqyGyGBpS+MG0atC6oGV+O3fQ7DfTTrSdDsqICKlPcfyZS9X9c=
X-Received: by 2002:a05:7022:23a2:b0:138:888:32de with SMTP id a92af1059eb24-13808883386mr174298c88.30.1780858894965;
        Sun, 07 Jun 2026 12:01:34 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8e76sm13773740eec.18.2026.06.07.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 12:01:34 -0700 (PDT)
Date: Sun, 7 Jun 2026 19:01:25 +0000
From: Pranjal Shrivastava <praan@google.com>
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
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 07/12] PCI: Refactor matching logic for pci_dev_acs_ops
Message-ID: <aiW_M7y0fFwLN84G@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-8-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-8-dmatlack@google.com>

On Fri, May 22, 2026 at 08:24:05PM +0000, David Matlack wrote:
> Refactor the logic to match devices to pci_dev_acs_ops by factoring out
> the loop and device matching into its own routine. This eliminates some
> duplicate code between pci_dev_specific_enable_acs() and
> pci_dev_specific_disable_acs_redir(), and will also be used in a
> subsequent commit to check if a device requires device-specific
> enable_acs() during a Live Update.
> 
> No functional change intended.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/quirks.c | 50 ++++++++++++++++++--------------------------
>  1 file changed, 20 insertions(+), 30 deletions(-)
> 

[...]

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
> @@ -5481,33 +5475,29 @@ int pci_dev_specific_enable_acs(struct pci_dev *dev)
>  		     p->vendor == (u16)PCI_ANY_ID) &&
>  		    (p->device == dev->device ||
>  		     p->device == (u16)PCI_ANY_ID) &&
> -		    p->enable_acs) {
> -			ret = p->enable_acs(dev);
> -			if (ret >= 0)
> -				return ret;
> -		}
> +		    p->match(dev))
> +			return p;

Nit:
Should we check if (p->match != NULL) like we check for p->enable_acs &
p->disable_acs_redir(). 

Otherwise, it seems like we're mandating the existence of a match op in
the pci_dev_acs_ops here? Today, we just have two Intel entries in that
array, both of which need the match op. However, AFAICT, it shouldn't be
mandatory for future SoCs that might only need a simple vid + devid match

[...]

with that nit:
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
