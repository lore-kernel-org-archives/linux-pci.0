Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDCC271464
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915782; cv=none; b=sTCIFZud+upu3ZhFhD9oy50JAOtHiUcaPjFMWGCEvZtDFLmBRk0dMJe6EMK8UTC7GwCtAidYtG/QCO3oJIkE8zBOUAx11SbnBByrsr5Rsf3O6EKCKsm2eibaZZ4Q7nXnb/5Ai/jPu+CWsbvAcb6FMCBTVQewzr+u1lkaVI89Q88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915782; c=relaxed/simple;
	bh=eed3wx8kSh9cvFIuH8h1g7Va9HBHOdti091cZ6XjzuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0v2noZbTFjYXdB9KKgl0OmYSIDcqW4r4y9n9eHamTzozapwx3YCmnu1N5a+pYmsb0IWxX/RxOSbyiz2z4eYcK9CLSzOw86504naOYVAbodR9+zixQ/YbS6y/L7v+GxHOnGW/6s4SBy7cqEocwLrBxcltVIqkj4E+MuNUG6JazY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJ/SVItb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJ/SVItb"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf22c18ad3so368955ad.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 03:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780915779; x=1781520579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fmn+PdTc6vMvIeP/V6J1RAe1SscwIO8ISTB8QBGG6KU=;
        b=qJ/SVItbRXNSBHiLcnfG5JzHGRMU1n5wfZeE8A7lXjQ4jVVQplBI+OPWx9CH2Tpp7C
         F9u34LLm5QyTlSg8/cuQdVrEeL4dVGo7RPvXJA+CLbuX9bYQ4Qrl0wD6AjmE4mGeWrCG
         R6fH5Qo15fVB5GS5+ZSlpcDVWLvh4qTSeNWnJM70kTUw7b2dH7Bhes7W4ZXGCvJ3fu+P
         DINne3vj25nMCEa5LwQ9jWOtKnoWsMR5+G5wV4MMuwBcGMwptxVP/qYNpsCyvvj4lrGM
         Eyb3Ro0YNBnWYZeCLh+9fUyDsym8wceWipCz06QbSVpCRqkWcW/W/a+VqIB5KcyNSpsY
         j+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915779; x=1781520579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmn+PdTc6vMvIeP/V6J1RAe1SscwIO8ISTB8QBGG6KU=;
        b=fQp9z/99AkPJYnJ8oUYRTIylsMrQQuDBSehjC88/G8c9DrwACnfcS8SfAiAKm4GVwb
         TUJGlyoavg4sp5XIh/fWfsh5AEvTnK2QOLt0tj+hQKgKHd5gtcgWkOu9Cftj5viT7/nh
         mcgTE8D7djO7y1CxfAenL2myNYdhaDV7jOszjPEAVI334YIDjDoYKPeRg3tFvVs3+P8Z
         8TbBxVAeJw6lRGQinYQ5H3GgGbqTHqKWGTwL2IIehKuyyKdnyJkYuRfwR9ChP6pp28cU
         6tivBKR/X97879Fq+c4jmsbo0u+4N1n3hUGOEZWjB+8abHicnjtreX0kL3gNzFIE7yDw
         SZOQ==
X-Forwarded-Encrypted: i=1; AFNElJ9e1B5AGC3H7OMUsHcYXfqCtd+jzUwsxb0qywgyBpA+WSQkVLBa4aaCsk87UOgvpUOOv05x+inFwSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ijQXdYOCGJtHO7Z2+Die5lR/BqlClDnJ6JsLLOUykuD+DMCN
	PDmxUaZJxXMPqNxcHt/gIAmF4h/OHV7/r7WshhIkp9EEiOGO5FwYHIuhLsfoyXwzQA==
X-Gm-Gg: Acq92OGHgYbsQ0TsjoRejqDAPpZhPssQsiHrgPKJKJxfPaBp4s0gt6IgN2Ao1qddobq
	STS5ysVj15Lao9sx3LtOJvRmlMRF2O9PKiHW/DEvEuhqrruiUsXwS9NOc3X7furgSoWN9elfIUh
	pLZd64PuX0choyV+wlmzxaINor0qKU+BK0X/9XWcRMxqh6uPdK4aYBxHSc2IFtm7AbheY73UviY
	h9qHf8HaMTUWuNgaEpCMWBc/gpwnc22tgMjGAC8fCtjBQSbUdFDI2rrHHCrD2D95qeZMXcyo55v
	xkjLT6ALAsP/XqVocHaTEnY6rhBK/x5A7FBFkz0xuh8SbitZigUiP4ailE9sYDDCOEPsKx354tJ
	Spse7WNonRcU/vyarNJuuNJ8fpHsHgdYoTkmDEh/JANYUgKXhTbVuWASL0FQTdiuqxM/n2OgTHr
	g7hvCWY49ewTYBsP3SQzfa0y8KNh2jT3MK517f4Ok8JB9u04y6UmtWoZ5pegV7RFO7xM8aBc0=
X-Received: by 2002:a17:903:1986:b0:2c1:ee6e:4e50 with SMTP id d9443c01a7336-2c1ee6e51d9mr4607285ad.33.1780915778977;
        Mon, 08 Jun 2026 03:49:38 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649c302sm173906215ad.73.2026.06.08.03.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:49:38 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:49:29 +0000
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
Subject: Re: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
Message-ID: <aiaeOVomxQZhoM3K@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiXWmR-ettxin4LC@google.com>

On Sun, Jun 07, 2026 at 08:37:45PM +0000, Pranjal Shrivastava wrote:
> On Fri, May 22, 2026 at 08:24:06PM +0000, David Matlack wrote:
> > Inherit Access Control Services (ACS) flags on all incoming preserved
> > devices (endpoints and upstream bridges) during a Live Update.
> > 
> > Inheriting ACS flags avoids changing routing rules while memory
> > transactions are in flight from preserved devices. This is also strictly
> > necessary to ensure that IOMMU group assignments do not change across
> > a Live Update for preserved devices, as changing ACS configurations can
> > split or merge IOMMU groups.
> > 
> > Cache the inherited ACS controls established by the previous kernel in
> > struct pci_dev so that ACS controls do not change after a reset
> > (pci_restore_state() calls pci_enable_acs()).
> > 
> > To simplify ACS inheritance, reject preserving any devices that require
> > quirks to enable ACS as those quirks would also have to take Live Update
> > into account.
> > 
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  drivers/pci/liveupdate.c       | 68 ++++++++++++++++++++++++++++++++++
> >  drivers/pci/liveupdate.h       | 11 ++++++
> >  drivers/pci/pci.c              |  5 +++
> >  drivers/pci/pci.h              |  5 +++
> >  drivers/pci/quirks.c           |  7 ++++
> >  include/linux/pci_liveupdate.h |  6 +++
> >  6 files changed, 102 insertions(+)
> > 
> 
> [...]
> 
> >  
> > +void pci_liveupdate_init_acs(struct pci_dev *dev)
> > +{
> > +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> > +
> > +	if (!dev->acs_cap || !dev->liveupdate.incoming)
> > +		return;
> > +
> > +	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->liveupdate.acs_ctrl);
> 
> I might be thinking out loud here, but as an attacker, this motivates me
> to somehow hack the EP FW to mis-report the PCI_ACS_CTRL register across
> a liveupdate to fool the incoming kernel. If the FW feeds a 0, it silently
> strips ACS protections.

Minor note here: I used "0" as an example value, I'm aware that'll
effectively disable ACS and kernel will enforce more security.

My point was that a FW exploit can meddle with the bitfields of the
ACS_CTRL to spoof and mis-report the ACS flags.

Additionally, we might give rise to use-cases that start depending on
this, for e.g. if someone wants to change ACS policies in the
new kernel, the FW may silently update these flags across a kexec.

> 
> Should we also serialize ACS state in ser somehow to ensure we aren't 
> fooled by something like this?
> 

Thanks,
Praan
