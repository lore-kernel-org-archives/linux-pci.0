Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50444D022
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397759; cv=none; b=s0XuxCcC3S+6rGyxhDXLpb2emcTgsn/rdRPfAIs5KOQzCUOTW7xGB4LVblztOijN3CZrOdWDAsOJDDfQZdWJkYuz+B/YTUPQMPhzGzlysPDjPM/zEclMHGKSoSZZu9E1JrghS3rZXl3CHmgWGlZXHcT8VSxPbEiYKNqYZsjY5mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397759; c=relaxed/simple;
	bh=6BOFmV1sfaExkGiH3CUmno76chlBrIHAsLEqmzM/9QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdGCgf2KCYG8SOIrKa1h5SHppiJ5SLeL72KNXMgcAIFGQzdJrbzWXfNly+a7EtNHcsLLOhawAwl7mZt5cu/st5BTBejCkiNnZwuaUj64aGSnTikrgj9R+P6HBFLxuRVGywiOkNAaGV9B+sT/lGesAW1S6ZtbdBKR7UJ8WiQQMhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nMvrIq/y; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMvrIq/y"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso24365ad.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 10:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777397757; x=1778002557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ncltMbqb0oRbMvugQb2r0egpAWKoVDCs8cMwwYz9oEg=;
        b=nMvrIq/yZ/KS2OxUDqe41xLYPVOAeWQZYLfttPxfHzJ7EwMylXburbqgyNw0SwYior
         BbWInMYE42B7q/EI9/VvFci/H3RtwRbro+awc+w123iFybR8S1sNtn4iaQD4FdvQaFXl
         oEnG/UeuRSSqtBs2BSuGvEQ7O1xqayH4NEa+TLNBIK4quPNlwfwqMRGqzdSJtAt8fVB8
         QYafZhT/ZTH5+ThNqGLRF5H8srmZ42KO/SydZLNe7rntBjLAyK2U8TYxya/uHP3hzsGK
         x5vJeuSMg7tzQ0AAFMRNe2XcDDGhLFvABojZ/WfonlaWXwoRpqZSwdsXNvKoEGfV6YyG
         PlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777397757; x=1778002557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncltMbqb0oRbMvugQb2r0egpAWKoVDCs8cMwwYz9oEg=;
        b=kwmxrD/HbNIuW+lYCOVGvi/yF1Ez75I8On1WAfxDQDtPfgOV0jukLGa6URZ/KYhWs+
         WoTg1MMk/u6o5a/vKFlDaysZLVQOmNVODrCAqoKuobHkIG1hrKs8JG4TAZ3pbf/pm/HO
         2VEOOUevoLfsTIqrbcPXRAOlqwjmkchvyPmh9L20ymA3487/Z7lHQF6f00avkfaqL3D/
         Dm6Lzg90SmuEOdxuXPlgu+OarXpfvjzqoab8Hd4wD9NfTbdryd7xDMCHZxAWO2AnMQYv
         seEjiFg8ACEgzESB4htPi/IhROY+mAoavDLa4l/ZhNY3j7lC3hL3zrpFi2O4tZrk8Zd8
         xl6w==
X-Forwarded-Encrypted: i=1; AFNElJ8nMFT/+DaUUCs5QmHStXInMHU2J6IDueSSHORNm/FHJvEsjZpcvxuzL45xnKQgR3OJQy9jOAlAqo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/n26mM+4A808zXJ4/DadrtoIAWVHsy7k4L8aBoO5js27tLG5d
	ej9Job8AU7ojpp+rR9wZy2j1AHlTg/uS28sk1s0DG9g4AZU9FNh+0Kq/Ly9GNWuanA==
X-Gm-Gg: AeBDietY1ZKZzriM/sinwOc3VEhlL3MWVT7xooKnnFXk4uSWxEM6at+In9aGlxB4Vm8
	dGcTR9isWVJa/X6VVFCGE2fQ/5FFoSwW+6hMKe/n7hGSic181l9DjZ5wZPdFcq7ah5RprFivxWG
	PyWE36rp74Kqyf4BF6lnDgG+FEHoqPIVw9mc+xvngh8vSCcYr9nIKMLv1lJugQq1SfrPhVCRIOG
	FdIwPJ/yInS/Ufzp/HBCvoFzznSP3BYrNgrAVizm8n/v9AbmxsEb8ohd5U2HDNR7hWC2CPD02k/
	WOEIGamQfFTIONjWRrmmWdItkeA7+1uhPmaFl8JYuv3/d2ovDvq+RyRZow38AHWRL0PMO3jhoNd
	az9TmBzWOT3ObZBJB3kE+DaQ/jYIoWpgFRh4y5MGx3Vf8DuafeiEqSbQc3Hn4tjZ5ZBH9pMkLYk
	oYJFjsa5WnnYuP5EjaTpV7bKi6xPTbN4QA/vM+ta9Zli5XEZ6bfitI2QYNfv2NQi3OpDhLX2v58
	OuDvv+32rs=
X-Received: by 2002:a17:902:cec2:b0:2b7:b03d:9dce with SMTP id d9443c01a7336-2b987ed382bmr144705ad.18.1777397756522;
        Tue, 28 Apr 2026 10:35:56 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf7f43bsm3432664b3a.58.2026.04.28.10.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:35:56 -0700 (PDT)
Date: Tue, 28 Apr 2026 17:35:52 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <afDvVhkp8tQpsVlt@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <afDqs6oqWlhoVqMN@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <afDqs6oqWlhoVqMN@google.com>

On Tue, Apr 28, 2026 at 05:24:53PM +0000, Samiullah Khawaja wrote:
>On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
>>Add APIs to allow drivers to notify the PCI core of which devices are
>>being preserved across a Live Update for the next kernel, i.e.
>>"outgoing" devices.
>>
>>Drivers must notify the PCI core when devices are preserved so that the
>>PCI core can update its FLB data (struct pci_ser) and track the list of
>>outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
>>device must be preserved across Live Update. pci_liveupdate_unpreserve()
>>reverses this (cancels the preservation of the device).
>>
>>This tracking ensures the PCI core is fully aware of which devices may
>>need special handling during shutdown and kexec, and so that it can be
>>handed off to the next kernel.
>>
>>Signed-off-by: David Matlack <dmatlack@google.com>
>>---
>>drivers/pci/liveupdate.c    | 101 ++++++++++++++++++++++++++++++++++++
>>include/linux/kho/abi/pci.h |   7 +--
>>include/linux/pci.h         |  26 ++++++++++
>>3 files changed, 131 insertions(+), 3 deletions(-)
>>
>>diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
>>index 5c0e92588c00..5b4c8d9e462c 100644
>>--- a/include/linux/kho/abi/pci.h
>>+++ b/include/linux/kho/abi/pci.h
>>@@ -23,19 +23,20 @@
>> * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
>> */
>>
>>-#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
>>+#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
>>
>>/**
>> * struct pci_dev_ser - Serialized state about a single PCI device.
>> *
>> * @domain: The device's PCI domain number (segment).
>> * @bdf: The device's PCI bus, device, and function number.
>>- * @reserved: Reserved (to naturally align struct pci_dev_ser).
>>+ * @refcount: Reference count used by the PCI core to keep track of whether it
>>+ *            is done using a device's struct pci_dev_ser.

nit: I was wondering why is this named refcount and why it is needed. It
seems you are using it to track the preservation dependency between
parent devices and leaf. Maybe add a comment to clarify that.
>> */
>>struct pci_dev_ser {
>>	u32 domain;
>>	u16 bdf;
>>-	u16 reserved;
>>+	u16 refcount;
>>} __packed;
>>
>>/**

Sami
