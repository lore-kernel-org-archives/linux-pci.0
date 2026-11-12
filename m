Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480685;
	b=AxM6dlI4UHqkZl1xnwBODr+y2hl7JTOlXBtnPeKRoIzCIGBSTlF8qHs308tH0YHYdg2V
	 7OAt5mwqfq+NbWKDNeDmqrIi7uGrhNGenDP8wltoVdyIa3xKjI5wnJZKpAo8DIM9CwLtX
	 QHZpUrKdHlkfzsXE8cpV/+7qNHtlzmUkzDqfynp643RK8W6ngJOR2nMHeA8NYTpQK+sBF
	 OxHECcoSZZqg9IUeaKXQQLrxz73iRlXX1hZdKYbo9/9Tbsx09DZ8Yj7HTLyBixSorqOji
	 xAqzBBKiNi+Sa6GUuzuAu8ab2FzQH2SJVhMiFSKqXMsRSh/8BA0zSWKJK/JHi0n18Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480685;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=pywy5r6pDPMlHENdQdhMX3LebB9YShrau+u2EOFSYes=;
	b=BcTKobvhrdyIa5YN6+vvxTD6rrJSCEmRlNXehz6g0HioVP5WysVCiD+zad4gc1hSK3nD
	 cPMRlow9AjarAC4XICdyGsSEku8N7g2ii1WRiqz7pEnroB8XKJFxMaGJfG/Giy7sID1ax
	 RmP46waifKs+HJXXtT/ZmSOcW54t+zhfFo714Blcw9ICq0ndgjFqfz7mPH0QSNoWDqVHj
	 TDoi9QniFGun1CGBEViEXOtH7CawrznaaxFaxqFxoNGU8OWOiEImi238BNGoSwBgIsBk+
	 ws9OlEf9MvbEKq6Za9XsTqAjwnlA3iODUbiJhVPGtVA46n2GaIasrDWEjMhUFhaxaOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NyTu+pBP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029AE606A321;
	Thu, 12 Nov 2026 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NyTu+pBP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE0E1F00A05;
	Thu, 12 Nov 2026 10:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794480684;
	bh=pywy5r6pDPMlHENdQdhMX3LebB9YShrau+u2EOFSYes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NyTu+pBPJgo0IB/eZQsoHzsyRKO3iN+jIxpyl8bWDIcxaDufID0hYesdnuAEu5S09
	 Sckhb1ihC0JjNfCe/VZ/0dE6EfvHMq1aeQjOGwGk+OV91Ff47v1Lqs6UvhF605Eta3
	 wqD82AU6Z6Q5HyU9Ltah30EsTw+B1M4g4W5yhvs3eqwGRFkKZ3lxXdMmEjSEumyXip
	 znxH4zR4+tL3nPFrvhzEV7ItlMOu0ZXK4cjY8u2jI7AC6j4dY1Vgqz6/YgsxSq5QDO
	 kxcuLzRHt03BGPhofFDyKegLBVhQ/EevoaFq2FN8rm1xr5+eOOTgX+dssNLgKSFySa
	 LHRs3t7Xtw3bA==
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
Subject: RE: [PATCH v8 12/15] iommufd/viommu: Allow PCI TSM backends to
 provide vIOMMU operations
In-Reply-To: <CO1PR11MB483536F447DF311831A64D4D8C762@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-13-aneesh.kumar@kernel.org>
 <CO1PR11MB483536F447DF311831A64D4D8C762@CO1PR11MB4835.namprd11.prod.outlook.com>
Date: Thu, 12 Nov 2026 16:21:12 +0530
Message-ID: <yq5av762pbkv.fsf@kernel.org>
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
>> In confidential-computing configurations, a vIOMMU may be implemented by
>> a TEE Security Manager rather than by the physical IOMMU driver. Such an
>
> TSM is the firmware. Here it is the TSM driver.
>

Will use TSM driver instead of TSM 

>
>> implementation also needs the TSM identity when creating and validating
>> vdevices.
>> 
>> Allow VIOMMU_ALLOC to first query the TSM associated with the target PCI
>> device for vIOMMU operations. Fall back to the physical IOMMU driver
>> when the TSM does not provide operations for the requested vIOMMU type.
>> 
>> Resolve the PCI TSM association under pci_tsm_rwsem, pin the module
>> providing the operations, and take a TSM device reference. Store the TSM
>> device in the vIOMMU and release both references on allocation failure,
>
> what does "both references" mean?
>

device reference and module reference. How about i update this to

Resolve the PCI TSM association under pci_tsm_rwsem, take a TSM device
reference, and pin the module providing the operations. Store the TSM
device in the vIOMMU. Release the device reference and module pin on
allocation failure, fallback to the physical IOMMU driver, or vIOMMU
destruction. Drop the device reference before releasing the module pin,
since the final put may call into the backend module.



>
>> fallback to the physical IOMMU driver, or vIOMMU destruction. Keep the
>> module pinned until after dropping the device reference, since the final
>> put may release the TSM device.
>> 
>> The device reference preserves the TSM allocation. Backends providing
>> vIOMMU operations must not unregister their TSM while the module is pinned,
>> since the reference does not prevent backend resource teardown.
>> 
>> This enables the Realm vIOMMU implementation to provide its operations
>> through the PCI TSM backend and retain the TSM identity needed by its
>> vdevices.
>
> It's not specific to Realm vIOMMU, and Realm is never explained in
> prior patches.
>

I will drop this para.

>
>> @@ -49,15 +52,33 @@ int iommufd_viommu_alloc_ioctl(struct
>> iommufd_ucmd *ucmd)
>>  		rc = -EOPNOTSUPP;
>>  		goto out_put_idev;
>>  	}
>> -	if (!iommu_dev->ops->get_viommu_ops) {
>> -		rc = -EOPNOTSUPP;
>> +	tsm_dev = tsm_get_device(idev->dev);
>> +	if (IS_ERR(tsm_dev)) {
>> +		rc = PTR_ERR(tsm_dev);
>> +		tsm_dev = NULL;
>>  		goto out_put_idev;
>>  	}
>
> Is it legal to have a device connected in tsm (i.e. with a valid
> pdev->tsm) but one wants to assign it to a non-confidential
> guest using a non-cc vIOMMU type?
>
> If yes we want to fallback to the physical IOMMU driver even
> when tsm_get_device() returns an error.


tsm_get_device() does not use the vIOMMU type, so an error return
(rather than NULL) indicates an actual error. In the case you describe,
tsm_get_device() should return NULL or a valid TSM device. For a valid
TSM device, tsm_viommu_get_ops() will return NULL because the TSM driver
does not support the non-confidential vIOMMU type, allowing fallback to
the physical IOMMU driver.

-aneesh
