Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909259;
	b=VvakPerwDJRLi1cBNP5/pCiU9c1MKLY9PUej5h/l2U1Ew8mjdOHKKhxLzfgmSs70yeWI
	 0euGfHBd2bw+OG4+wJtGyOuz5PShXMD+3cn62mr56+cqWj7rHjAfyUXVC0idfeQgw9jUd
	 O8uYfqOC1B9bUKZGdLXHvn9N8i8SXT6rrLGI7fH91UilswUHg0ZyP8o0VRIpXgLV4WWpw
	 jIhA9XOOfcOMXPzR/qhfDObWE7jqz6RQEmvYXKbImavbWDltgVn5cO8OrKtRYOkRgKvW/
	 yV1VsiLSSz4FSVZjTGSlpqAUfF4ErwpC36QyjMrKErt//yTFHXxUcJgKUdBhOJClfaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=z52AWMMx/NPlxXG7BPdw5LHgxa12llcgL1Kha+Q5UfY=;
	b=mVbZ2sldWIQqXTfXiMraoVdvr2BtHBfBzl2gY7W0g1rSOtHjnQt7Sruki/cWKhz7Xaax
	 /MiXyEXiQ/Qny3OXW13vGt5I4REBBDUNrqItAS1kiiSLaMwGkGfrqDcQSuHXi9vrL/Uh7
	 /MFf7Diri+lBlOcQyE06y6djCWbCq3CEml7IBXVFBFjvPzvYFUYPEUzjXN4e8BdYlRI/l
	 knPBsMh0NvXsXYrAY5mu5eC47Us9ojuNHAfjZlQOBFXqnmvUeKf4A5Mnu3t9PK2FsDE/i
	 uxNZnhYpy5wXft+bLPcX8cMd6kep2xrXs64T1BnorRzsroHP90UzPnxGxBPIfzBHDcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=pWAcW2zD;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B993A6082BCF
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 20:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B993A6082BCF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=pWAcW2zD
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eafb65e163so1567792e0c.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 12:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793909257; x=1794514057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z52AWMMx/NPlxXG7BPdw5LHgxa12llcgL1Kha+Q5UfY=;
        b=pWAcW2zD/63HAANui/KgQteFGf23DIFTBPKN5TS2f+lZtRer2UXQWE5nmZ7E6+0NmL
         NOOCXte1XvmkZBJozDZeonddr7WOhKYwoxG0t/prTXufgqXucApuu46Sd4uUJbmVTObR
         7fBoftmI0x8C5OBoveyYTeiR5CzcpDKIDS2NqP2Zi4JYmMvse+F1UJ+tD5iRjIQbUeMi
         N0hs7feA4M3cPYsGIWBxIU+8M+cR5rQpjj7DVMZCRulJVbB4tHdrN+Gqsr/Umk190Esz
         gMQTgholi5MoO2YuumyOWyN+Vz/Zl26KLlq1hDXbDxh17QeLxWCQNp/kJGIw8NnG5ysp
         ISqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909257; x=1794514057;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z52AWMMx/NPlxXG7BPdw5LHgxa12llcgL1Kha+Q5UfY=;
        b=cv5U0CECA1OYfiPXQrI9aY4I8YgfohgI0KUjzZcGNpGags7CoEaLgo8Tk+hyKoORJn
         mo+aope1/Lbmkydw11blA8gV8MzwAp8Jg1JRtbVZCkWFc79tVevD2+6X3pgMbVIPTLPQ
         Q5HegSIzmEx6T2KcS8XEyLMu97+mFp1ntpux2Av3Zh8iGUZHVFSkhOuEAtoPJRJtDzdx
         capyzxwR/hpbH0dsUeANLpLZ08+X3UzpqL4ABM6y9cD+nf3YtyRVdDHaFLv7B7VrgsZH
         Gty7dCC2MP+z7TZuCkTEmiHAvExNjKQNX99DfwQd7oL+VIElPcrmvu21D7Yt52fkQQoU
         zWXA==
X-Forwarded-Encrypted: i=1; AKwUvBwDNPhDlWppNegiSaL3LiBUuLl6oenyhx6iwMeuVdSFV0rI9D+iDdYenE6jG0NXC5jWRKoZRPWBsDY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9edt67jSAhLIEEJ5QPjc2PdvOrJ3AqtKZ+uIK+wSZGpQtfcl2D
	inYvDsITlJnM27mbM0ULh7hKYzaRIX9unYjQOEoUocJrd18ptJRy+C6uQS/TZPVF6vQ=
X-Gm-Gg: AYBFou1yz9BLjC1UmfYIskD2WfD7yZy2ykGuvrsFWS/9om6SVrJ2i+hgY6jFUa6njIr
	z9VPVn1CPWJkNWmNo3vtZFqUm2t7AwrtlG0A5jzIee/BO1Rde24pD7oEnmlIY9EFGjbwHNbpaDM
	5zzKcq6AP79ZhqJ1jWcBXP6tveCe3sCP4FM/n2SXyjaXc192p/rYIWJKEEC1KeQVo3FwwbjW6Rf
	jJrL7s3VBCooRSoP+qg6DpEt2ItwM2ViINkq/697VBxxZ7tiPogSdcXt/w5AXvmgFpHL4xP3aaA
	YBMSWY0ivULOTyn6db3+YbOdB9BZ179cYecgUWFUKb9fuYe3QCICEPoIXUkBFPnuROK5HNr8O5G
	fMnoTGyY34CXJnPJ8F/wt2P2Ba2f2wJvoNfjbmUWQlMaQi6fI0jKc3dunqk1rIzu6DtTrQKBd7q
	7jCttWKhap0LmO7/XLqzdP1yQ94VTigDbWR+ViwqETnMoB3J/sTb4OxUN5LJvlc7PMUOJL55RwH
	Pb+AronYCKlkSVxKaGnIYuBWpMfNZXKyuPZ4dNU5cRSSh/6J9bE2eYqkoifbgE6UPDMNr0iYO8w
	hyU4pypOFK3Ed6k2N018bWprmyreiP1uDxfekImEIIs3H8TgwwqVg1UtBdj+ZHW0fhYGnzW9cOq
	Jv99xAdWXNg==
X-Received: by 2002:a05:6102:390f:b0:7c3:99a3:314a with SMTP id ada2fe7eead31-7d2a1509e88mr658597137.9.1793909257584;
        Thu, 05 Nov 2026 12:07:37 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecb6d79d9fsm2610604e0c.7.2026.11.05.12.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:07:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP3kF-00000003dYX-3Q5c;
	Thu, 05 Nov 2026 16:07:35 -0400
Date: Thu, 5 Nov 2026 16:07:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v8 13/15] iommufd/viommu: Allow vIOMMUs without a parent
 HWPT
Message-ID: <20261105200735.GF663069@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-14-aneesh.kumar@kernel.org>
 <auuBjRjQwXl7UvvO@nvidia.com>
 <20261104193139.GB3889730@ziepe.ca>
 <yq5afqxf97a1.fsf@kernel.org>
 <auzAivzpzSUHjEQj@nvidia.com>
 <20261105182106.GD663069@ziepe.ca>
 <auzNkAGFLH6da8fq@nvidia.com>
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
In-Reply-To: <auzNkAGFLH6da8fq@nvidia.com>

On Thu, Nov 05, 2026 at 10:40:16AM -0800, Nicolin Chen wrote:
> On Thu, Nov 05, 2026 at 02:21:06PM -0400, Jason Gunthorpe wrote:
> > On Thu, Nov 05, 2026 at 09:44:42AM -0800, Nicolin Chen wrote:
> > > On Thu, Nov 05, 2026 at 10:58:06AM +0530, Aneesh Kumar K.V wrote:
> > > > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > > > > On Wed, Nov 04, 2026 at 11:03:41AM -0800, Nicolin Chen wrote:
> > > > >> By dropping the nesting parent from VIOMMU, it just simplifies the
> > > > >> attachment to an S1 paging hwpt, right?
> > > > >
> > > > > Yes.
> > > > >
> > > > > The VMM must always maintain a S1 paging attachment that is the
> > > > > identity map of the VM on all devices, same action as when there is no
> > > > > viommu.
> > > > >
> > > > 
> > > > I am currently creating an S2 paging attachment. This results in a
> > > > configuration with S1 disabled and S2 enabled, which is used by all
> > > > untrusted devices.
> > > 
> > > For validation, that would work. Yet "no viommu" should would be S1
> > > paging, i.e. hwpt allocated without IOMMU_HWPT_ALLOC_NEST_PARENT.
> > 
> > It doesn't matter, consistently using a single S2 for everything is
> > probably better..
> 
> Hmm, I am confused: if we use a nesting parent, why do we need to
> allow a viommu without a parent HWPT here?

It is because it doesn't *use* it. It is a confusing to pass in a hwpt
that is never used for anything.

Jason
