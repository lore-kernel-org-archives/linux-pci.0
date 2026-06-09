Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758793644A6
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025628; cv=none; b=ndNHBxz5O5ztrsbkrfG3Yhvp7WZE2xiarJOupKPLJkZh5OHWqR05IFncjFfsK7234Ljljv+V+mogJ3Y8/jPQvE9w5BL7mawA3gxc6MW8TZ7wC+vMzrz7wKvllJqpP7zGg9Q8HeheW7U8pvkj2W+/Zj8gi5+HOXiXhKUvKTbSz4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025628; c=relaxed/simple;
	bh=TK2+t/up9BNHR7cWnWPkUKbCONbG+0KU9N82d806Hmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4cfGS/SMQW/giccXjOmtOxFHd5XscbZJZlPVYhMP9/IISdfVUErRxWSn4jo7IrCBsk+pbWLg/Pihd6RVdyLZ4hODEX8NL4nBncI0S2OD/ZSyi8KXn5CXmJnYj4f83/zJo9XgLTp4xr0ctpm6KfdkSEy/D0oC+FNAiOwJ/5lqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LAtm0tOB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAtm0tOB"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf2911f93cso461945ad.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 10:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781025625; x=1781630425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01u/8EAi6NGn4gFgEAFXoW9+VQRDowjxcP1j39dvRbk=;
        b=LAtm0tOBO31AXYeLi+UB/W5ChfPBv3oU+N91irOeaQv2UaSvc4ibQqfOhFM2llBMnq
         9c+zb+lQb1MJoHIvMgh5a2fef7nDaqbOF/tV7o412PzQUtKoHlqpD81ryv0GWb6TtyNU
         KxiGVOXcdiwTR1UK/SoPG9h9psrI4i3uoRBXBL3hTf1kSwY21797gp4coe3iLLzL9JB6
         QXRhFmgnggvxP05kngC+5yWNlQuPldM81OBlBnScOp3j8gm9eVcmeiLnEM8SruNTfe9h
         e82pHa1gA7J6PxbVTQr9HwTAPTe7v1x0eLnFc+SDiR7R/GoPIBE9+qO0CLvRTWg5ZYpy
         LIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025625; x=1781630425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01u/8EAi6NGn4gFgEAFXoW9+VQRDowjxcP1j39dvRbk=;
        b=gDCeedbCTb7wmaxBz3UCjyNSjkiarKDPfo4IV4LtDPmi0TYNRT944bFH3DZfMLOojV
         uaEVAAP+FeUzSjUzeyZRJ72vm3ym/JV0U6K+GctgUT877Av6AqzD95mcubYqFBrqG0G9
         eSLJyrIpeVzBRuvCEf7+E1dem87zjUfIOep0NIkOSn7IdezVbKoMJ696hA1bCcxeA2p8
         +MEg6KwidGLua372zVEKSOnmKbJj1259hB7TSiSSmVPNmFFSaW6eR62ABK/T0yyncoki
         6t0v4OS6wYyi7V1XESjFetNVLRrVbjkuuRlV+k/Rj6FDoLq1XWpQo5fFEV7cK13Yawwu
         RUoA==
X-Forwarded-Encrypted: i=1; AFNElJ9DpOvqDw76zLdc701wonRu0+lBuq2gHlH974kC5H5rx03t1BeBx/ABlEGJxPE88WFWGr1QgTrMMGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy38ZFJQqW1aZFj4wbv3Eod/YfAeXzDNFBnyL4lXbr1QeNONmQO
	DF4cNgTLzgWBGVvHxnHSZOm9RVVi/UOr4emMy7L8GpEAUpvQc2S7GQPqxnMke9ulR9dYjbCR3dU
	3/KJBLCKJ
X-Gm-Gg: Acq92OEYpqo67eNl3PCU30iXLmKIol5/EZTwVxJQO5yCJweWwKwToKRaFt4vF50MRon
	8MYYCs3kzotasoHJ06bqPkdGgKu5mDBr0dw91lyxtlZG11J2ullGZOJQQh4BrnmKXnKGnaq2O6R
	UYqC/SicrmnZ3N1XzuCqJXN6FA1aodQ4rBlnYHCXkJf/mzuRmyIQzgnr8MeYobvL5rciYOpn8zj
	bWhZDmPKWiDOdqbDa8qpHeHd0L6uEdrwaSeLHlxa56zMS3wE6pgrv3i4GmI16R56u/lZtRKekte
	ViKTMMB8t1FfpRUu6fj57HlI/0YIAqEr6X2/evEMpTtZH+TSD1TsH5JmPLC7u5a8L9hU25oZkg1
	nj5fRC9nNJ/SGd0b2+mCAaKYfMddSR70Ja5zgxY9mnznNCxkCe2DIIfoMmE4tLvRKIGZYiCoCOB
	Pqx9ZrMfN+f48WzgzZCmJw8+QqluOSz+Qs7zz4hPpJa4ITcr9i2YbWOJDZ8bhwkXzT8qJXZx4YA
	AgodQLdTA==
X-Received: by 2002:a17:902:e744:b0:2bd:907:2ce5 with SMTP id d9443c01a7336-2c1eafbcbdamr9084545ad.7.1781025624007;
        Tue, 09 Jun 2026 10:20:24 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827e6sm25059778a91.1.2026.06.09.10.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:20:23 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:20:14 +0000
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
Message-ID: <aihLTgs1Y49OXQaV@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com>
 <aic6mdiZ0qUJpFca@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aic6mdiZ0qUJpFca@google.com>

On Mon, Jun 08, 2026 at 09:56:41PM +0000, David Matlack wrote:
> On 2026-06-07 08:37 PM, Pranjal Shrivastava wrote:
> > On Fri, May 22, 2026 at 08:24:06PM +0000, David Matlack wrote:
> > > Inherit Access Control Services (ACS) flags on all incoming preserved
> > > devices (endpoints and upstream bridges) during a Live Update.
> > > 
> > > Inheriting ACS flags avoids changing routing rules while memory
> > > transactions are in flight from preserved devices. This is also strictly
> > > necessary to ensure that IOMMU group assignments do not change across
> > > a Live Update for preserved devices, as changing ACS configurations can
> > > split or merge IOMMU groups.
> > > 
> > > Cache the inherited ACS controls established by the previous kernel in
> > > struct pci_dev so that ACS controls do not change after a reset
> > > (pci_restore_state() calls pci_enable_acs()).
> > > 
> > > To simplify ACS inheritance, reject preserving any devices that require
> > > quirks to enable ACS as those quirks would also have to take Live Update
> > > into account.
> > > 
> > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > ---
> > >  drivers/pci/liveupdate.c       | 68 ++++++++++++++++++++++++++++++++++
> > >  drivers/pci/liveupdate.h       | 11 ++++++
> > >  drivers/pci/pci.c              |  5 +++
> > >  drivers/pci/pci.h              |  5 +++
> > >  drivers/pci/quirks.c           |  7 ++++
> > >  include/linux/pci_liveupdate.h |  6 +++
> > >  6 files changed, 102 insertions(+)
> > > 
> > 
> > [...]
> > 
> > >  
> > > +void pci_liveupdate_init_acs(struct pci_dev *dev)
> > > +{
> > > +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> > > +
> > > +	if (!dev->acs_cap || !dev->liveupdate.incoming)
> > > +		return;
> > > +
> > > +	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->liveupdate.acs_ctrl);
> > 
> > I might be thinking out loud here, but as an attacker, this motivates me
> > to somehow hack the EP FW to mis-report the PCI_ACS_CTRL register across
> > a liveupdate to fool the incoming kernel. If the FW feeds a 0, it silently
> > strips ACS protections.
> > 
> > Should we also serialize ACS state in ser somehow to ensure we aren't 
> > fooled by something like this?
> 
> What does "EP FW" mean?

I was referring to the Endpoint Firmware (basically any SW running on
a downstream device)

> 
> Does such an attacker even need Live Update to attack the system? It
> seems like such an attacker could route TLPs in whatever malicious way
> they want regardless of Live Update.
> 

I agree that compromised PCIe devices are a menace anyway. But I was
talking about the potential window opened up by Live Update here,
suppose we have Device A & B assigned to 2 different VMs (implying they
are in separate IOMMU groups because the switch set ACS_RR = 1).

Now, the attacker has an opportunity with Liveupdate, since the devices
are already assigned, if *somehow* it flips a bit like ACS_RR, the
incoming kernel might see both the devices in the same IOMMU group.
Who detects this case and what happens if this happens if the devices
are kept assigned to these VMs?

Thanks,
Praan
