Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505212;
	b=klzpBeYthwTf55fUc1xMG6Hf+Qin4ts+1Aj3GVS8eJfgh8JVJ+2j19jPUFqEVYLszpnx
	 aRQiKikvt6tS/+h6lY0oxgWnpA2DMB88Ju5SihqXPM8TF2nJ3jLuYto0MPskoYNwLrtzQ
	 e3qscUF35dFqihloh/s5O7ooC0G182D+pfv34o8M8JoHur761oMbNO/BFDxCe6m67jmgT
	 ZEFdszpWJ2uireaPJySRtwJwy+E7GjNfQv3fS5HEKsQz6DOCs7CPMEig2W4u2YVQLfIJc
	 uR5jcz5d9uuLsJC14xsEAz5f9icNdHhKnpxK3nwSIWKmjviKLVzSvPSBh7NHgVA/fDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GMK7MSqRNNJITd9VKn9EN01v+V/w/ND04vZqm17dQrA=;
	b=eIALEcKSq8NibJaF9zCqMk9c5XesLwsykDOY1xrTTqQcOXTkGyNM9ukZHPlGN3HCHaQG
	 YjD4+8Yaqr2Pd0XZFe8S/TtbyLvVRHfcrfnyg+27he96rLesciTt07I93JGDKIBtk5S8M
	 RjOVZmEPBdSL7rCNIrfOYvMuwwumFTCXb/V82wcqzdIAlpYcG5321Z2PaP2dqT1DKt6mS
	 FGVeXMr6/+4oRX/HXJYLTw14TqVP/4fAIZV1Lopq9hcSiCm2YJa5578TTaxBrw5jAQbNw
	 hbiZmMI12j539ecYB2iuDS4iesCZgw01czTmKAXECKhmGSN1MO01FLufoWGWYKeK2ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=E7m+7oWT;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1627606C348
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 17:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1627606C348
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=E7m+7oWT
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53397554beaso42712301cf.3
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 09:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794505211; x=1795110011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GMK7MSqRNNJITd9VKn9EN01v+V/w/ND04vZqm17dQrA=;
        b=E7m+7oWT5vnwPeCygHD6YEjh7jOWPEC+ZDjeuPdczK1vYBKrloATpEDBVihXvtG9m1
         oi1WkqSgA2COI/tL0rIYwv4W397NzbGvplbxnoPs3COp53kkX/jdv8cbobRJAd8QOxjw
         SNF4IJ69TrBKYjc7paHmPNKvqMzmje7Wlk5KplK3lm03LceoOPQMDRpFo1Z/+zVyEiZe
         cqGu0Or2btrBpahALI8LEKNKbF+yWWsBWtj2Wo3iwDjvCiVEfw0hGu0rLNrZiM3ldNX3
         3TsHxI16od7ea4V61ESiHMCGExqr3qn22Hh6C2DtYSQdOCTdsfdQZMKCCJswEIr5YG7/
         5Vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794505211; x=1795110011;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GMK7MSqRNNJITd9VKn9EN01v+V/w/ND04vZqm17dQrA=;
        b=1pc2A3YKLHUOdhJC/uTaCt1dCZ+p/QKN6T6aofZ+CiGosrKZQaBzmmsOiB24LkKa3v
         KGPpJC6I03x5NPzQkCgOU2XtLWPE+oYwaIHABiAMWb+eKiIDQ8hh0SoL3NBTPmjIjM67
         lAqkRAb5NNs3gZBfY+RLdGV6gcLrTH1wJ7r6iKgGostoqb5QQWl10zL/20UKsUwt1NfZ
         zz8YFqPPlIVgUrp7l3sf0pNQNZQKVWz3kV3wVh9xwSAA/4pkZZ0y4WBV7bqNkDlPfOm8
         pRlPN0LVkdKSptoiOD6kqVeptHrJn6P2+tIpmUfWvZ6avrcoUIuGr1CnQUiuJITTFDJE
         4KKg==
X-Forwarded-Encrypted: i=1; AL+hErHLfI+/LT1wFl3ilxOQy+DzSq91raYlY3hG4vjqCG656KMjPHtqiL24iUhRXvISY2rFHyS8u/+G3oI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+z7G35QBP9fE+hdCk8nfyDSmYON6SFPShC06kTh9sy0Xu2Qj77
	VmtEkjJK0iyZpkXqhZ6ScZaINu5Z1cyRP209ABw7LX3Gd6NOEmxIMrUDdIJSs7kj77o=
X-Gm-Gg: AYBFou0VBXo5WF62bbIJ9NvTYMT/d3cB/gyRB8Aa67N82sf04EoHSX6C7xOgvllrc/9
	NdWxAlO/yNl6h6HD/+/T0D8LyrTRVB6XwCfO1tr0fhSl0twOXrhDyqAq854sxb6TF0pCgRiVQib
	6tkoWQW3kokkTPhrA2xvoPidn1Q4qnURVHwSAlMY4qeiWiu6QdQ/h+2Z5eN85h5uQY5kAaTvwRx
	2WLLGGCeLAZWNG113PNuyajzOb3D7cEQQSGOMlph2CMjH4x6Ao++uv1ZP4zgaQ5v1myPbWn+yh/
	gQXYqh6nOi4d3P0bEeYRE77v1ikNhusEdIE57OOQoQU/9UjO919EHzikBoHwGISnHoIeF+pOTwd
	6+ilOwtUCwzd+hINTFDKZu0xIQmDuJ1k5+3lNbDTngiFk/6Fg5IhoNpBAySVHR0abV7I6DSbQD3
	dcVr22ueAH3Oukn1To1wsWWQ721VcsQVVBydqDsvfxvIddXlzGzj1EQiNtD2O1a55N+45b/NzHp
	Ttg4hk1znhiUoWpkf+yVErFFHKSBM9OEbHxGABVssqW6gmmEwrkc8lGDD1bWzw/BmfMkNdbm2+N
	PNg4ew==
X-Received: by 2002:ac8:5fcb:0:b0:533:8e6b:260e with SMTP id d75a77b69052e-55ac78597d2mr1668441cf.31.1794505210728;
        Thu, 12 Nov 2026 09:40:10 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d70489sm890336d6.21.2026.11.12.09.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:40:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xRYmP-0000000FjX1-1XQV;
	Thu, 12 Nov 2026 13:40:09 -0400
Date: Thu, 12 Nov 2026 13:40:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v8 06/15] iommufd/device: Hold a KVM file reference for
 the device lifetime
Message-ID: <20261112174009.GB2532299@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-7-aneesh.kumar@kernel.org>
 <CO1PR11MB4835982DE81AFE060EEE01B88C762@CO1PR11MB4835.namprd11.prod.outlook.com>
 <97053bb6-c221-4ae0-972c-603b194ec25a@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97053bb6-c221-4ae0-972c-603b194ec25a@amd.com>

On Thu, Nov 12, 2026 at 11:25:46PM +1100, Alexey Kardashevskiy wrote:
> > > Once the remaining KVM file references are released, a later ioctl on
> > > the still-open iommufd can access the stale pointer:
> > > 
> > >    iommufd_fops_ioctl()
> > >      iommufd_viommu_alloc_ioctl()
> > >        iommufd_get_device()         /* finds the surviving device ID */
> > >        get_file(idev->kvm_file)     /* accesses the freed KVM file */
> > > 
> > > Take a KVM file reference when binding the device and release it when
> > > the iommufd_device is actually destroyed. Release it before the igroup
> > > check in the destructor so that bind failure cleanup is covered too.
> > > Document the ownership in the bind API and device structure.
> > 
> > I don't think this needs to be fixed. There is already a WARN_ON()
> > in iommufd_object_destroy_user() and many bad things could
> > happen afterwards...

Yeah, it shouldn't be fixed like this.

Either we need to rethink that warn_on path for some way to actually
wait forever or we leave it.

AFAIK nothing here is going to make that warn on trigger.

> > If we really think an ioctl could take more than 60s in sane scenarios,
> 
> It is quite possible when some TSM operation involves (in)validation
> of hundreds GBs of MMIO.

That won't be under these locks though.

Jason
