Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55C48FF77
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397899; cv=none; b=RuQ0LR1JA/VeWMGoxLlLVGBnNM26rFxxq1UUsbXHbd2L7HGsBmewba/BO9wfRyGbsIoOXBh7CKPTThCRKb48nv0etKJazdCrONtd8C7CmQ85P9MeQdh6t/EV69nZkyQrQe8YGX30nnx+ydH/WLCTYQZEZQFXP00pvCxoN/mpSwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397899; c=relaxed/simple;
	bh=zJbXzUjdtRbnDRMSD0ZFUF3Ql50Yc48q8DhOcPiIqao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWmE2s8nxD8rQaxfFaDw8sJRLk2x+dO8wMQBI+ZKZ1xXg2mEuG15dcXTz2xbXfpJ47AQ5uwTHKtfiK1Yz6WpDLXnJxaHrIFz9hYcW5eIJyMMR/xSvfDqP9gf9ZkucQpGH4za2V8kcIz1lg8FKaWc0MHTOxkvZpOFs+IA4W8fISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDfo8YTQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDfo8YTQ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e8623790f8so67195ad.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 01:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792397898; x=1793002698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wjpKNxbRFa0QN2xvZXyNEaUJwKZqQxqRu5XGn6mWryk=;
        b=tDfo8YTQ2aUtaSaFGdWyQTSlnuka752MbLgydVdf+DN/pqkCY2Hvm4fgqCOMr3tarJ
         IZC7K5TdBOh4M679M2EsT/QJL8A8xVAZaUj/tUPguzd9HBX70ew3CU69CEHajsvJQ/Gm
         5Dx9sdRmh2Ssk8Q+MTOmk7KI3Gcvq4FS7MgVmciSSQYYo+ukFo1YfN2TvaPea12IfKRh
         ybOE3c2tf2y83nnG1Gz1+LgzcHXnidRfPxnrBh2+cWkLOu4HL/gAnFTVXdVoDp4K/D2R
         YM3t9xkV+1rcXehX+Qn/3MB/5AFia+aiWCDXIcIraUwQFe21tHtLATXzfNrepWHdA3q5
         RSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792397898; x=1793002698;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wjpKNxbRFa0QN2xvZXyNEaUJwKZqQxqRu5XGn6mWryk=;
        b=GdBMDDvbxqnbOdfCitVIyXgK8LzcYIj5wTVyKAVqZd5JH2IcH6zZvqOAYJuMwdvC4l
         QXWfEbpRAMqJ6dSkINp5sJrZtyp6wKc/VEaMWeV/X6qZo0TzhH1QkS4+YT607H+B5YwN
         Bj4FW7ggI3S8D7GPTSYMoH00WvUIOe2ZTmGwwz8WPJO7XlVvYbxZ4NNz5vSE0NN2RaC7
         X8TE7pfzL/tEDM28H95OrJ+UfwJiAjzQ76JI0mG70AZFiYc5B5LgIz/AD5Df+uLeZvMs
         cO0cjkzlZW0T5FomATOcpiOABKOR9izs5KQflGm5gFfBj4+oMKs2Alphl8EtEl1q8Wwh
         leBQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcbmpoTl3lSersWvNZgDD0IYhQ28SV49ox+DUesdV7BzjGW1PEu7fpsV/KBNsRObDNv1qhMFW58KY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKawOV0GVOmpXgi86jk06gMQhU6Pa3pNcNWMdCqsAm1VTiDjao/
	vbxsmlrQhJiEpF4CxPWRYJGgQnD9BxVfUud+KvzvQ57DaU76UF9mL+Njx0Qs+UNWlg==
X-Gm-Gg: AYBFou1qx00/mmvvN0pVZ+1EkBnXLMvgi1wuLj7j+SLccqvpUx0BR60AOYG9uAxUO0/
	rf7GnPmmbR25rw9BHZ95A5YNdOV429Ex2oD+dSjaboPOcG0/zFXIh+fCb6oC61jRistWCKqRYXa
	DPwN85WWUAKAIAP434gpvVrqeeqlG3UGRV4Yey57g0IC0HSrQ4rQVeLhaeAfXcEQ7aCuC1PmLof
	iYaB8GBU4xkMrHIt8xN9tzk5qkz3MRkKinevi9aD20ArXYsrZWkbZJvhFSoOCrjDZ2RifHAuyzO
	JXAJeDeN+wAgrA1AEirnlsMrpqYDdjQpMvviNvXO40hlDQy5dZ+22w7trTkcNUpgOK4yf00/JZT
	c949ApbU0Dl9nm7H1DLltaNjMh5ptFubvpLdDPw+rDE6v4TlYk81j7GE53qAj29BSdlK3mrecHk
	8Xkfd+8oVJwyJK9Fagh035ZdhKSoP9OV6X/krl4W1PVCPFUzMZ5vpXgyYmTq9AmYQmCp8IYbekc
	kOoDWSk9pLFcwyCEuZAn8c1F2kdm0WcBtJe2Q==
X-Received: by 2002:a17:903:1967:b0:2d5:db38:8010 with SMTP id d9443c01a7336-2e9b332b4d8mr6634505ad.15.1792397897247;
        Mon, 19 Oct 2026 01:18:17 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f58017244sm3517077b3a.47.2026.10.19.01.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:18:16 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:18:08 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	sashiko-bot@kernel.org
Subject: Re: [PATCH v11 07/16] genirq/msi: Cache MSI message in
 irq_chip_write_msi_msg()
Message-ID: <atXSQFvKWo_xAw9l@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-8-praan@google.com>
 <875wz4eyqe.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875wz4eyqe.ffs@fw13>

On Wed, Oct 14, 2026 at 11:52:41PM +0200, Thomas Gleixner wrote:
> On Tue, Sep 29 2026 at 03:45, Pranjal Shrivastava wrote:
> > Currently, PCI MSI caches the composed MSI message into the MSI
> > descriptor inside __pci_write_msi_msg(), whereas platform MSI and other
> > device MSI domains do not cache the message in the core, forcing
> > individual drivers to manually copy the message into desc->msg if they
> > need to restore it across power transitions.
> >
> > Cache desc->msg in irq_chip_write_msi_msg() before invoking the chip
> > callback so all hierarchical MSI domains automatically record the
> > latest message. Document why the redundant assignment in
> > __pci_write_msi_msg() must remain for direct callers outside the
> > irq_chip hierarchy.
> >
> > Suggested-by: Thomas Gleixner <tglx@kernel.org>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/pci/msi/msi.c | 6 ++++++
> >  kernel/irq/msi.c      | 9 +++++++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > index 80a9db417dc8..f7bedc31d486 100644
> > --- a/drivers/pci/msi/msi.c
> > +++ b/drivers/pci/msi/msi.c
> > @@ -257,6 +257,12 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
> >  		pci_write_msg_msi(dev, entry, msg);
> >  	}
> >  
> > +	/*
> > +	 * Although irq_chip_write_msi_msg() already caches the message,
> > +	 * keep the assignment here for callers that invoke
> > +	 * __pci_write_msi_msg() or pci_write_msi_msg() directly outside
> > +	 * the irq_chip hierarchy.
> > +	 */
> >  	entry->msg = *msg;
> >  
> >  	if (entry->write_msi_msg)
> > diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> > index fb5f372215bf..df460a574d80 100644
> > --- a/kernel/irq/msi.c
> > +++ b/kernel/irq/msi.c
> > @@ -634,6 +634,15 @@ static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid
> >  static inline void irq_chip_write_msi_msg(struct irq_data *data,
> >  					  struct msi_msg *msg)
> >  {
> > +	struct msi_desc *desc = irq_data_get_msi_desc(data);
> > +
> > +	/*
> > +	 * PCI Multi-MSI shares a single descriptor across all vectors and
> > +	 * the device stores only the base message. Cache the message of the
> > +	 * first interrupt only, so that sub-vectors cannot overwrite it.
> > +	 */
> > +	if (desc->irq == data->irq)
> > +		desc->msg = *msg;
> >  	data->chip->irq_write_msi_msg(data, msg);
> >  }
> 
> Sashiko reported correctly:
> 
> > [Severity: Critical]
> > Does this code cause a NULL pointer dereference for domains without an
> > msi_desc object?
> 
> So this needs to be:
> 
> 	if (desc && desc->irq == data->irq)
> 		desc->msg = *msg;
> 
> Did not think about that, but that also means that this patch was not
> tested on any recent (less than 10 years old) Intel x86 platform or a
> x86 VM exposing HPET...
> 

Ack, I'll fix that, and yes, I've tested this on arm64 platforms only.
I'll pick up a recent Intel x86 platform as well, to test this.

> Thanks,
> 
>         tglx
> 
> 

Thanks,
Praan
