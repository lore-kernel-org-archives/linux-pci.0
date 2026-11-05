Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899007;
	b=ICLC1hMKO0tB+2ZzZmJr3H7NXg29NyThaaH/SN1rfytki+EhXEaY1kSI6aMIv+HWxFT1
	 wb+Z4PPMT53jb0BOC5vN+mqTKEKlfE2qziCeP7HiJ9wx4jM7FlQZA6Oaxqg6G8QGpk/9+
	 i0Jq3+3ppfCPbjBw5I1DLKpZYzoA7Ag2YSRGPAkqBL57cWIuRKs8D2kDYzT8COCfxsWhi
	 v1VBWJ7VLX/StC0eF8zcwT9QWjRThiSqKubqzK9UPsJHweFfIqQwiZaJd7DcEfse9dC21
	 IdUT71+zswWj/r3mRBWeOtpTnaJ/H4vuncDZZJQnrrbwSARtgTaDG5NKzJoZnmp6sDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899007;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=sZzW7JYVrmh754uY37zU3QW1aKqFPt/3sf0AcxHaA8U=;
	b=XYRfpbFlBpy0AgpE5n0y6O8tpaJ7XplceeHt5JDUL71/GmUSJvbxslmmdrHc4Th3On5D
	 TuLfTSKEijbpoTcQOtJOMv7V5JtPWb8J/4idl3MgRJlx/gA0ngbo4Ib2TNo22lVRuh86X
	 PVSp62491jOMSE425daFezowAxRIOq9/xKIH+PdaPyCmF0/hhj6pVYAl9P8R59NxX0PJG
	 KUh0XF1ZNRfnNFE/CwKkcxWUCdwByFLIsf+R2TiLIX29nI4XKRcHhBlyaRpk2ynfZjiQQ
	 dc+m9aQS3NgblWURuckP84tvPmr/SXjjdfe7lmRGUawv2hcIhUL7STu1KHJTjSls0JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=BDigdHUc;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37876082BF4;
	Thu,  5 Nov 2026 17:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A37876082BF4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=BDigdHUc
Received: from localhost (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id DC88420B7166;
	Thu,  5 Nov 2026 09:16:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC88420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793898990;
	bh=sZzW7JYVrmh754uY37zU3QW1aKqFPt/3sf0AcxHaA8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BDigdHUcFCn/BGRR+msSMNpyCmQhCddheyhTHa7wwd9XqbOQJv7c+S9FDhQb3VNVZ
	 RLnMGIyNgvt+VCa/EaPADFS35i/IrjwJEXySHjy9vWowetESB57/SzTQSzchZl/PMv
	 YUtjHkuVWQPmp+6/ZuXR4XHcImqNujF+A/aE2m08=
Date: Thu, 5 Nov 2026 09:16:22 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>, Alexey
 Kardashevskiy <aik@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Jonathan
 Cameron <jic23@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, Kevin
 Tian <kevin.tian@intel.com>, Krishna Reddy <vdumpa@nvidia.com>, Lukas
 Wunner <lukas@wunner.de>, Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy
 <robin.murphy@arm.com>, Samuel Ortiz <sameo@rivosinc.com>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, Steven Price
 <steven.price@arm.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thierry Reding <thierry.reding@kernel.org>, Vasant Hegde
 <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, Xu Yilun
 <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v8 12/15] iommufd/viommu: Allow PCI TSM backends to
 provide vIOMMU operations
Message-ID: <20261105091622.00004a9c@linux.microsoft.com>
In-Reply-To: <20261105004934.GE3889730@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
	<20261104161632.3547423-13-aneesh.kumar@kernel.org>
	<20261104152351.00002565@linux.microsoft.com>
	<20261105004934.GE3889730@ziepe.ca>
Organization: LSG
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Wed, 4 Nov 2026 20:49:34 -0400
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Nov 04, 2026 at 03:23:51PM -0800, Jacob Pan wrote:
> 
> > I am thinking MSHV/pKVM can register an assignment-only tsm_dev to
> > leverage this? Could PCI/TSM support this role without
> > device-security?  
> 
> It is certainly not what TSM was originally imagined for, but with our
> new arrangement, yah maybe so?
I will rebase on this set and send out patches for a detailed review.

> TSM basically just becomes this weird overlay driver on the PCI device
> that does stuff. Some of the stuff it might do:
>  - Register an attestation subsystem device to do SPDM
>  - Register to allow iommufd to create a viommu
>  - Some status sysfs ?
>  - ??
> 
So we may expand pci tsm to have more than one role? currently it has
one.
int pci_tsm_register(struct tsm_dev *tsm_dev) {
...
	roles = is_link_tsm(tsm_dev) + is_devsec_tsm(tsm_dev) +
		is_assignment_tsm(tsm_dev);
	if (roles != 1)
		return -EINVAL;
> It all seems separable and composable to me, so if you don't want to
> launch an attestation subsystem device because there is no SPDM then I
> think that might be OK?
> 
> Another option would be to somehow obtain the viommu from the kvm file
> descriptor and rely on the fd to handle the module pinning/etc. I
> don't know how to do that nicely with the way the modules work
> though..
I did this in mshv-iommufd RFC to associate hypervisor FD file to
viommu.
VMM:
	struct iommu_viommu_hypervisor hypervisor = {
		.vm_fd = vm_fd,
	};
	struct iommu_viommu_alloc alloc = {
		.size = sizeof(alloc),
		.type = IOMMU_VIOMMU_TYPE_HYPERVISOR,
		.dev_id = dev_id,
		.data_len = sizeof(hypervisor),
		.data_uptr = (uintptr_t)&hypervisor,
	};
	rc = do_ioctl(iommufd, IOMMU_VIOMMU_ALLOC, &alloc,
		      "IOMMU_VIOMMU_ALLOC");

Since mshv creates partition file with anon_inode_getfile() which does a
try_module_get(fops->owner), then in mshv_viommu_init, it does
fget(hypervisor.vm_fd) which will indirectly keep the module pinned.

I guess we have to enforce this pattern to make it universally viable?

Thanks,

Jacob
