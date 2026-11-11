Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414289;
	b=LguS4L/C5WSxHQjcBqGo47W5NSmzeRI1P3BCgi3C2eeZ6iMmMeFo28eXou67k3GzSq9j
	 tmWFyvZDqg6scEI5wOVI6cahnP7NNxy8xz7AFg2C1FElLOnE+0xW7wBV2fbLW4BT4jpOz
	 QvEzbYIhdcddXctMi8zo6e8y81dWYb5/HorlZP90ilV3OapfgN6tPfy8g6ALATtkCurPF
	 amnz/YBg/BgCxyjeRKBdlVuV1zg1/YV8f5tLNJUbNcFXyutt0A2WZjgkM0RbE/fjXuO18
	 nEDNBOQhzTk3pOPjljQuTbnMNcRaHUrAriNkw1SqRBKvlk2kndz4xxGbaSDkC5VZwoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414289;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=OjsO/ys/ad/piKfPb2QV+3VHWakKPWNbmqHXdLgFmLM=;
	b=TAlS4BP/FKQP+gSjTm29iRsk7DiwNwl5D1+h9STkgob+ee9toFgU5LIB1knHw4PsPrMl
	 FiLeRcYVu++M+ymVz7dDdgET99m7+L1jhnc7WhSezh/Z5CUXVgWE5NRMF0QyMrlKT3hIG
	 biOdlgP2uKu7b2WyoYbUlnKh+RRzk4OT1rUT+xTMwyqRJMkpS53vaf7RnKO7A1O/iqpwd
	 dxq7KA4AN6ETKch/7NYaTBcvYcHTxtgzm/WLB+mWrXMGb8paX0U839xi63uaou/NjC1z9
	 c8Na9m93aFLKogZmlmTT03Nv8tvIyPblZPMLvTcYDWh3nsgXPs4oFzgcry77/mq7CbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9R3bt8I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B006606A324;
	Wed, 11 Nov 2026 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9R3bt8I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EF51F00A05;
	Wed, 11 Nov 2026 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414289;
	bh=OjsO/ys/ad/piKfPb2QV+3VHWakKPWNbmqHXdLgFmLM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=D9R3bt8IMlmKCvjpNgRgysgj8jSfI13uGBJNO/Gz7VeltIMkdQtWk7rTUbnL+hSKP
	 yw446sJdMUoV63jGJWmoLXrdm1ER/+eKiRPANmy8/oVLQQIHoxwQk4097d3gNv9RJN
	 kPGqM0dBGFUDQwamvB9bgVigbzfmgo2HAwhl9bStSXnCsJPMOT+eRSw3AJbBNyDXRc
	 8huwLIoPnXNi9b/6DowoNI3g+6A06OaWwxGcf8k5/7RxZl9Us0FcZzRZntTE+c9g0z
	 h2AVNfplmuc6dmcm7rJeSw5ylRkvChp9Qq2tOVm3kX5/SsTu3LunBg9pwpNtEIVykp
	 A7793R8G+sFfg==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: RE: [PATCH v8 10/15] PCI/TSM: Add vIOMMU-bound device contexts
In-Reply-To: <SA2PR11MB4844957D715CDA1CC614E8C38C762@SA2PR11MB4844.namprd11.prod.outlook.com>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-11-aneesh.kumar@kernel.org>
 <SA2PR11MB4844957D715CDA1CC614E8C38C762@SA2PR11MB4844.namprd11.prod.outlook.com>
Date: Wed, 11 Nov 2026 21:54:32 +0530
Message-ID: <yq5a4idntjy7.fsf@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Tian, Kevin" <kevin.tian@intel.com> writes:

>> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> Sent: Thursday, November 5, 2026 12:16 AM
>> 
>> An IOMMUFD vDEVICE represents a physical device within a virtual IOMMU
>> (vIOMMU) for a guest. It must use the same TEE Security Manager as its
>> vIOMMU. Pinning the vIOMMU backend keeps its tsm_dev registered, but
>> does not preserve the connection between the physical function 0 (PF0)
>> PCI device and that TSM.
>> 
>> Add a per-vDEVICE PCI TSM context. Verify that the PCI device and the
>> vIOMMU use the same tsm_dev, and account active contexts on PF0. Reject
>> disconnect with -EBUSY until all dependent vDEVICEs release their
>> contexts.
>
> We really don't need so many vIOMMU/vDEVICE notations here,
> especially in following code/comments. It's just about a tsm context
> which holds the pf0 from disconnected. Then let's describe/code it
> from that angle.
>
>> +struct pci_tsm_context *pci_tsm_context_get(struct pci_dev *pdev,
>> +					    struct tsm_dev *viommu_tsm_dev)
>
> could clarify that each get returns a new context even on a same device.
>
> s/viommu_tsm_dev/tsm_dev/. It's just a parameter to be matched against.
>
>>  {
>> -	struct pci_tsm_pf0 *tsm_pf0;
>> -	struct pci_tdi *tdi;
>> -
>> -	if (!kvm)
>> -		return -EINVAL;
>> +	struct pci_tsm_context *context;
>> +	struct pci_tsm_pf0 *pf0;
>> 
>>  	guard(rwsem_read)(&pci_tsm_rwsem);
>> +	if (!pdev->tsm || !is_link_tsm(pdev->tsm->tsm_dev))
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +	/*
>> +	 * The vdevice can use a different PCI function from VIOMMU_ALLOC.
>> The
>> +	 * module pin keeps the vIOMMU's TSM registered, but does not
>> freeze this
>> +	 * function's link. Match its current TSM before pinning the link below.
>> +	 */
>
> this is the example needing a rewrite...
>

I'll simplify this and document the vIOMMU tsm_dev reference in the CCA
code.

	/* The device must be connected to the TSM requested by the caller. */
	if (pdev->tsm->tsm_dev != tsm_dev)
		return ERR_PTR(-EXDEV);

>
>> +	if (pdev->tsm->tsm_dev != viommu_tsm_dev)
>> +		return ERR_PTR(-EXDEV);
>> 
>> -	if (!pdev->tsm)
>> -		return -EINVAL;
>> +	pf0 = to_pci_tsm_pf0(pdev->tsm);
>> +	if (!pf0)
>> +		return ERR_PTR(-ENXIO);
>
> No need to check the return error as other places do?

I didn't quite follow this feedback. Are you asking why we check for
!pf0 here but not in other paths? If so, I think we can drop this check
as well, since a valid pdev->tsm should imply a valid pf0.

-aneesh
