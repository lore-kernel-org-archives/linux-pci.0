Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793856498;
	b=cZmR/JHxcaSfZw3zs+7DG5BPH3lrWdeZwrtQYacTMY3RoKZYNzqJzXXeWzZhr56GPC/E
	 SaEWTv2bSdSSGXz+sZYDVGiy7/bO8dY6cD5iIsoDi0qOOI9MLsSLmNSQIBbi5lkWzWsun
	 oeGKs7Pja7pabg8+q2ptSG4GbJf0Pc2TYvqazMfNwP3qXu/qc+MFeIfx2BWk4WuGXGZYn
	 hOR2jMHunDCedo/0lg5mZcmmoD3EnUNot5HrdrdykpbEs4RG9PIV659rv6i3448MZ92UQ
	 AnqVncRTpH/GPmEDbnmLUGx7JYZuJA0mCC8aOcV4zOkqBiiCvFznEheBIOPQERoqlVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793856498;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=HcoU1mf7kO9fvwMNLAx61kTpoNrJasMlL0pCTHLa1Co=;
	b=YaWgLZX/r5skNzx9BX1NJPi5J0UZh6zIRGi1v7RPrUwWFGaAT23Y1nReVxc2P1+z76eQ
	 GEp3iwAQYx3Yo6WiSmbLh60LAb2fysXwH23zsJIikwCtr+tevoAuIlmWrd9qqMiUl8Azf
	 2CG7QykqWOI/6wmGYsCi5fu0ar7Z8wmL+/emrslZgk2ilDcMgDxtFuTZjHhzk56W2dX6j
	 h2cL0prtvbFM7koJbSYaG6blZMEz3o8HZZZNIvRgA0tx4zHMPgpQ77JwLdp5UcVRq+ZWO
	 y+Kq89Q0Gr4fwzkR3BBssz6vSreAruUOXanloDJEq+AWjeh7iAF4SvSze9WD2r0JOYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KBrD/Ngd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27111606A31B;
	Thu,  5 Nov 2026 05:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KBrD/Ngd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADF31F000C1;
	Thu,  5 Nov 2026 05:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793856497;
	bh=HcoU1mf7kO9fvwMNLAx61kTpoNrJasMlL0pCTHLa1Co=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=KBrD/Ngds9bqLOcBa7RpvNd4iMkexWpa+DzC6+ffKh1NhLEcaCBmEuvd0SpOEEPHV
	 8jL17aLET5sVc1/TAi2tTazVETSBSX1k5gdhp8dNc51yhlt825KrAfTsm/PLVPQfs1
	 9DrfPotW/M5CJ7LWNRkY9NQVWMQL33DBsrkDB24mg07HUa2Aj8OlTXilnd46qOgQEv
	 k3CuSvDbuwDNqcLyuF0M2036cdvl79e8QDDblmq3o0qYsa+f6X05yCvSN7xzjURY4I
	 9npdc1/J6QCtCKe6MDyezbs+VUY/TM6+1/uf5gFICQVmA2vkwcCTCg1cwzx5WXcGu5
	 d6UQgbCzYGvFg==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Lukas Wunner <lukas@wunner.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v8 13/15] iommufd/viommu: Allow vIOMMUs without a parent
 HWPT
In-Reply-To: <20261104193139.GB3889730@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-14-aneesh.kumar@kernel.org>
 <auuBjRjQwXl7UvvO@nvidia.com> <20261104193139.GB3889730@ziepe.ca>
Date: Thu, 05 Nov 2026 10:58:06 +0530
Message-ID: <yq5afqxf97a1.fsf@kernel.org>
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

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Wed, Nov 04, 2026 at 11:03:41AM -0800, Nicolin Chen wrote:
>> On Wed, Nov 04, 2026 at 09:46:30PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> > VIOMMU_ALLOC currently requires a nesting parent HWPT_PAGING even when
>> > the selected vIOMMU implementation has no use for one. This would force
>> > implementations such as the following Arm Realm vIOMMU to create an
>> > unused parent.
>> 
>> IIRC, MSI on ARM still goes through the NS pathway. So, it wouldn't
>> be "unused" if the device attaches to it (or its nested hwpts)?
>
> It is unused by the RMM VIOMMU. I think that is what is Aneesh is
> explaining.
>

We create an IOMMU_HWPT_ALLOC_NEST_PARENT HWPT outside the vIOMMU and
attach it before allocating the vIOMMU. This HWPT is used for untrusted
devices and MSI-X.

The sequence is:
	ret = __iommufd_configure_device(kvm, vdev);
	ret = iommufd_get_hwpt(vdev, hwpt_flags, &hwpt_id);
	ret = iommufd_attach_hwpt(vdev, hwpt_id);
	ret = iommufd_create_vdevice(kvm, vdev);
        	viommu = iommufd_alloc_viommu(kvm, vdev, vdev->link_tsm_name);
		if (ioctl(iommu_fd, IOMMU_VDEVICE_ALLOC, &alloc_vdev)) {


Alloc viommu does the below:
	viommu->_viommu.size = sizeof(struct iommu_viommu_alloc);
	viommu->_viommu.flags =  0;
	viommu->_viommu.type = kvm__arch_get_viommu_type(kvm);
	viommu->_viommu.dev_id = vdev->bound_devid;
	viommu->_viommu.hwpt_id = 0;

	if (ioctl(iommu_fd, IOMMU_VIOMMU_ALLOC, &viommu->_viommu)) {
		vfio_dev_err(vdev, "failed to allocate VIOMMU %d", -errno);
		free(viommu);
		return NULL;
	}

>
>> By dropping the nesting parent from VIOMMU, it just simplifies the
>> attachment to an S1 paging hwpt, right?
>
> Yes.
>
> The VMM must always maintain a S1 paging attachment that is the
> identity map of the VM on all devices, same action as when there is no
> viommu.
>

I am currently creating an S2 paging attachment. This results in a
configuration with S1 disabled and S2 enabled, which is used by all
untrusted devices.

-aneesh
