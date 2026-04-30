Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCDA39A7E5
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583771; cv=none; b=GwQ4W5Sfh7mdeTBgsWc3bL+S8zJEOOh7xF0JDykdokPzjZzbBnSWu0c3QiNmRUXNJP8RNJ5bYO5irQsbPh8ODLnX25FwouVrkG3qw5FkMQJ7ozJ6WLzhiVMBp1P3b+4Hey9syZUfmdcRa1mOyicN7pXINHUBui5R00IoghA2Gs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583771; c=relaxed/simple;
	bh=p74IfHhIob98pzABSKbeddeDIJ3TxaKYlP05kGBMvAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q85nZFvACEDAvBeaRex6n3gj+Ftgvzcl5C52lE12jD4JdVDaI+1gdZ5BGSC3xr0JepMt4+kcA3Stj2zft50Xeg/vQkvtYIRL1RYIKr6soN3p8ZDTA19NAFG7DhTRwJAkxscxvGXcRN+9L++vraPYe6yY/W56jcL0MQ2VuUqe460=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iobmpRok; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iobmpRok"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b9705613ddso8667805ad.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777583768; x=1778188568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qKjNRn2md89MeJaRqxCLA5wY9NhKNsbLMVT1tb1aOVs=;
        b=iobmpRokjeWaAmiUZ9Yustwkb240NMj+cqkmA/OGo/PhrcvcJUoWSSjnj168wxhMWs
         yMf0ODt0bScdnzLDNMfrTTpBrZV7DSIxcllc7QaqK0YS/DfxZH4fD7a5b6S3JSzJ4AdW
         LeOKYfrphvMgSsm2T0PPVsdtGkyJWlxE4LQrd8xAHnIx4wE2X3wTcZRSu0QRGjUrUzzG
         3d6fZMBkaHjELXiD9Y0CXEIGmPQQndBj/bYPCMD4+oNEnyQF4rfhxFBrN6lsKQN8BrQj
         ZW4/hJmaSp7ZQoukN80ND5YvQQLiqdyycmiqvEVuXUJxOrv4/beDbbGjlsPYVBhs9kIr
         KG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777583768; x=1778188568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKjNRn2md89MeJaRqxCLA5wY9NhKNsbLMVT1tb1aOVs=;
        b=kXfyVKZRmJuJxKJQS2pHHVK5WJD/spSzWWelCJL5on79tx/V7mQOgNYvI1N0A+tpDT
         0+N0kqya8/uwjjwKW6RNmA6R6H3iT0YiMqf9yVrHH0IpPkpwZ7nLWa4WwzIS9SqG0geX
         UPVZb5hbr6wWZ1OONseLPbMhhYecTdR3ovCOCSQcpo4HaL+mtaZ0Nq1xcn+u/lEK9chB
         GSQUNJlEFz46r2jZ9Z9UOxV54NNUcAaFhfmG87JzjNWt93OqBKg5h7nHDJJveTkl2BIt
         ecbdGF3Wv0Zk0zLE03V/Hfxsk6FIbbsfnnh9ZB4r16Og0+KN8gHvE6ecMab663bsWf+f
         z/5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9505kxVqUKHv3aaoA9f3BhFnaYFYHhurKGiQrmOg+RHXmd/VvAnJGDUimMmU4bnlZqY+Hsi5neybk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGjRIJXmvzjwQMxLeCudWG8m4alOXrRigRwLvHTN4ObJUL2Guo
	+quJwc1yF+BsUtNBieX2XtT28z/+KtssFwM6CFxvNGqOaNg0cdetilXXCS8/r1s9kw==
X-Gm-Gg: AeBDies+4tf7dZTiBs383FGlyAETWIoIN2N+4FIr/eT6RkcIsG9F9C1SirOl+DPBAij
	by0KAzAJukA8KCTR/96cz8OtgB3Mo0wKvwbO0BTqjsP2ID1cn6O98QkyVDxwXmyLpYAqpYuSu8a
	8rcaxMSbQHCbYyPrTrY/v2uOelyuCNWqju5euZSc5ZueeAv2rGolc8SzRsJgxWehOT/76MOKovG
	aOw5qTVaz91Mwi6wBaeHgnXVoGGLrLxy1SXiUmZdaXYEvvmeGsPmkdIzF9kp42U5cwQrlhERxx7
	4H7sGqyM0S2Md/3xutBeQ15KBVgeBTlm1YfvG2bBp7qLXw5hbZjL42M92KHgcUpe6crVF/dtpAm
	aiyHdZGHwYhGnIv6IV4dXmUkYdmxUHTsYcpejvA0Evhy1FPF4MTXERK5golWWcTb6dONGsLeX/z
	XxG1WXGsJS7Ok25IPToPwOT1r+GUg6qip2duI+peTd4YE94EBBkAi0KWp5q4DC5Rhz+GcIOSG1n
	F5leA==
X-Received: by 2002:a17:903:22c8:b0:2b9:9086:da9c with SMTP id d9443c01a7336-2b9a234e736mr49645755ad.17.1777583767972;
        Thu, 30 Apr 2026 14:16:07 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae67196sm5018815ad.79.2026.04.30.14.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:16:07 -0700 (PDT)
Date: Thu, 30 Apr 2026 21:16:03 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <afPGkxjCdPCL8MLG@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <afDqs6oqWlhoVqMN@google.com>
 <afDvVhkp8tQpsVlt@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afDvVhkp8tQpsVlt@google.com>

On 2026-04-28 05:35 PM, Samiullah Khawaja wrote:
> On Tue, Apr 28, 2026 at 05:24:53PM +0000, Samiullah Khawaja wrote:
> > On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > > Add APIs to allow drivers to notify the PCI core of which devices are
> > > being preserved across a Live Update for the next kernel, i.e.
> > > "outgoing" devices.
> > > 
> > > Drivers must notify the PCI core when devices are preserved so that the
> > > PCI core can update its FLB data (struct pci_ser) and track the list of
> > > outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
> > > device must be preserved across Live Update. pci_liveupdate_unpreserve()
> > > reverses this (cancels the preservation of the device).
> > > 
> > > This tracking ensures the PCI core is fully aware of which devices may
> > > need special handling during shutdown and kexec, and so that it can be
> > > handed off to the next kernel.
> > > 
> > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > ---
> > > drivers/pci/liveupdate.c    | 101 ++++++++++++++++++++++++++++++++++++
> > > include/linux/kho/abi/pci.h |   7 +--
> > > include/linux/pci.h         |  26 ++++++++++
> > > 3 files changed, 131 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> > > index 5c0e92588c00..5b4c8d9e462c 100644
> > > --- a/include/linux/kho/abi/pci.h
> > > +++ b/include/linux/kho/abi/pci.h
> > > @@ -23,19 +23,20 @@
> > > * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
> > > */
> > > 
> > > -#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
> > > +#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
> > > 
> > > /**
> > > * struct pci_dev_ser - Serialized state about a single PCI device.
> > > *
> > > * @domain: The device's PCI domain number (segment).
> > > * @bdf: The device's PCI bus, device, and function number.
> > > - * @reserved: Reserved (to naturally align struct pci_dev_ser).
> > > + * @refcount: Reference count used by the PCI core to keep track of whether it
> > > + *            is done using a device's struct pci_dev_ser.
> 
> nit: I was wondering why is this named refcount and why it is needed. It
> seems you are using it to track the preservation dependency between
> parent devices and leaf. Maybe add a comment to clarify that.

Ack, I will clarify that more in the kerneldoc in v5, thanks.
