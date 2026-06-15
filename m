Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA33AE1A5
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781554841; cv=none; b=JHxzidIQ18KEBoGhwfkbwNAC8E/wZ10rVQeEJJREi7Gw8ZrktX+ybBHUzEfBJEWKNkecWnFWkiTy0bIyYVUQEV+X+FpNBtA2kiaO+qAV4u0rJfK33JQkK9w5m5vWsVoN+M4dj3YJREqgNMlnQ+/HDC9ifIXKe7Z8FbeCkRLF5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781554841; c=relaxed/simple;
	bh=TB32LhnDXfTJUQ0KhV0DDq8feI4v0a+HUW9AsVhyJdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA5h6oJAV6kvdQ+KGdW707+hfY2CMjipckO1DLlAfZ7WRvxK46NmPObE+8hVEnAlqJBezj+aaXhCJPM/f6vESEUuS+U83lf2s7GLJ3tM+SPTuSqXQTdoAdUkBM9CDZryGlP6kn9trgiU3K7b2317tWmT7bSTC+gRxUuxa3zJyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vNTveM76; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vNTveM76"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36bd175fdbaso2289250a91.0
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781554839; x=1782159639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ynJ3evPKTv+CHJxYf+R9sPicm7rQMH20Hi7EX5GWIM=;
        b=vNTveM76TEMCSRUshuxZaW48EjNLGh6Ln6suviRcRPJzFhgEiE6DDrImXx6rhXWqZq
         lKvF2dtcX0RKpWaeiz9imfVLoXkQGrTKi9prUWq/BA5LKtXQ6qbTStp1pzQSUO7j1fBa
         KJxMKYuFDY4HjLXt2CIiNFEDq+2uFiEWnmo02HGo/tpoAdXLdh6iSkSZ4AItvGKSb8Mu
         kVBCrLsyuip0I+yj5E2Bfz2Iqz0bSYXreDG48D09IJ3iSWT1MARgtsRBdGPgqb3O7Jfn
         ags4vSnZ+4bY+Mty/ELtGHTYWPYx/096SbHXH22qItXvmqQq7g/2IDcip+x8k9zciPXi
         suOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781554839; x=1782159639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ynJ3evPKTv+CHJxYf+R9sPicm7rQMH20Hi7EX5GWIM=;
        b=WwxhueqMcP1koSSW1vkC/0weklhtH/wrnIivygVHqcxJdU4nAvx51ixmXhJEyjyfhz
         o0jCO3ScILg8VknbrF85RedCMyz+j9JpX72osFNplZv5A3ahnt6maxAKB6t+WkMHKd0/
         6pAhleEKQ1RLH4LwhtTyjIzZbDlkvuznIyuKMXwv4Ht9EPA+VhltC46MqLZOb7wuQaZv
         SoWx3BRFRsEcgIOZP4/g4reCrfq7LNRmIDAEiZy4+Vlm7oBi1/w1iQmDyxQ1OS7+61wv
         ZX15g+2ZtwXr+re3IhEKtyOsK1S0dQhaWchzooHfX8JYE71uLWc7QmI1oab9ck4+U8vT
         Qmmw==
X-Forwarded-Encrypted: i=1; AFNElJ8U83zmzZpRfz4+vEVET/XDt1Rd7X3MtxL2B7FHHFOP3y4m6kDV3DtynZgmGTn5tF6gR3ChaogGOuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz30nEOiP8xPKrqP9SrFDCSzOUkfKBLDc0IKGKZ4hZZN4dWKts/
	KXZPGDQaprZjxiLrucnP5a4Z8jcGr2tiPMUTGXblkVCDqIuOC1Oo9Nl3dSKZK9/oQg==
X-Gm-Gg: Acq92OGQjz8Zcaw6iy2kYhfT9vQNpSEQGkQ/6yWuVl8PnIgQl1UMrOG3bSQXcze6sBG
	4vGaBKKqRJ0itD+7Lv9UZVZDpvG0EnsqfYaN4vJ0X05cLDiATEQwLM/AdCMwKU61Vu3wYnwxJpc
	Yk84N5iIgIAB5dEl3x2Phi+U+Ksnfx14jl/rGumXurbjxcuiRaFRvBLgPSiAOA9CEhL0mpSgob3
	Hlv716yB9tdzrlsk9JKk6KMZ/IKcjwjwXplO3KHWn6sRo/HWz3zH3J2MctTCHvh5M4Iu5XkxpjC
	9HwtSpwjXKsjZ3jmSgrghkaFhe1O7WOjlOFmFe404GEuTD4sIHlV9BYly9gX7MteuRXQpa4eZ9e
	hFeYAmKYfSBsfuY36psA6WgkUFnxucd4FSlrYvodm2DgXmsXO0CfIvqVTKcywCEIBiN2jBYp7bj
	UYvMnOYz6+5OHXxf2/gb3esUAne2eij0c2iYDz7FWxsVCev0t7Y9fVR+DlypGfHQ==
X-Received: by 2002:a17:90b:2f05:b0:368:6998:b4a9 with SMTP id 98e67ed59e1d1-37c2bc7c378mr12049662a91.11.1781554838812;
        Mon, 15 Jun 2026 13:20:38 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521d96ddsm470060a91.6.2026.06.15.13.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 13:20:38 -0700 (PDT)
Date: Mon, 15 Jun 2026 20:20:34 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
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
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 05/12] PCI: liveupdate: Keep bus numbers constant
 during Live Update
Message-ID: <ajBektwaDID-NqQk@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-6-dmatlack@google.com>
 <178144546090.1266136.8524338598480624580.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178144546090.1266136.8524338598480624580.b4-review@b4>

On 2026-06-14 01:57 PM, Pasha Tatashin wrote:
> On Fri, 22 May 2026 20:24:03 +0000, David Matlack <dmatlack@google.com> wrote:
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index 4f2ec6ffdd16..2421bc218916 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> > @@ -103,7 +118,7 @@
> >  /**
> >   * struct pci_liveupdate_global - Global state for PCI Live Update support
> >   * @rwsem: Reader/writer semaphore used to protect the incoming and outgoing
> > - *         FLBs, and the references to them in struct pci_dev.
> > + *         FLBs and references to them in struct pci_dev.
> 
> This change does not belong to this patch.

Yes, will fix.

> 
> > @@ -396,6 +411,72 @@ static void pci_liveupdate_flb_put_incoming(void)
> >  	liveupdate_flb_put_incoming(&pci_liveupdate_flb);
> >  }
> >  
> > +bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_dev *dev,
> > +				      int pass)
> 
> This function requires a header comment; it is public and not self-descriptive.

It is private to the PCI core, but I can still add a comment in v7.

> 
> -- 
> Pasha Tatashin <pasha.tatashin@soleen.com>
