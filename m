Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266665;
	b=Eq9lzaH1zC3y6qPmVFHH8N7pTUyvYr4QEi3e97VpAudYAmfXtBLG2mQFLJKtk7zTxSNF
	 MqhskGvUVXYazeq5chbY6BBSDqLvbqCX9q3KqIxgqysFEpLor1AtWJ7pIlGswUlMf6we9
	 d532RcBkbMjni4yuG2AXmFPRAnZ3xel9AYvViSNAGQGPt297eZlTicIdczIHodXA4ry3x
	 vzHrOhq8CYB2aHv4uwBQmS46WQiuQNa2EzfJLsEuubm4kFXUjmy20rXwfFaIxO81/QKoE
	 t0WJXcztOSM03vDHBV75HzKVQnRNExsSlawgxzkq0v9vOmbRCdXHOEKCFsXB3+2s85g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266665;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=b1L/YgA0unso+/Lv8s9MhtgPB5X7wkfHZu4ut24TmCk=;
	b=YGULWsnAegFdkuZ+MwhXT0AtaXSrXoYLBV13KypWv2uehQo3SCZ3ZgHkTT3DtbuBrP3+
	 FNAUefGK6G8DrrracbGIADNxIW0h5G93A9mMENlQo0khnH5cp7Y8gqUfR3qTL4B8nTwh0
	 jd4NgGXhxhcQ5JVrCb4RY6wnpLqhrMGgjWU0D/+22qUGrhWEoJf+HT7os9iRKyMWwn5X4
	 uCHuzOmWonaboU0J9nHe1mqBrowNdQuxHk+ywsKcEKvApN3gMCZ1kGZTpChkmHXd42jx9
	 ir9XDXU3j4/dDpoVwFmul9E/2v5NWjImf0Yw+J4vaFh0F+vbFufytLK9MLFGLCwqalQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYVH+Mm9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAA160A2609;
	Thu, 29 Oct 2026 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYVH+Mm9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D2D1F01829;
	Thu, 29 Oct 2026 09:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793266665;
	bh=b1L/YgA0unso+/Lv8s9MhtgPB5X7wkfHZu4ut24TmCk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GYVH+Mm9omq5BAsPPLcumqvOBUW7yKv6qRkJyIck5tFwfRa1tUfjtE1geDCpsmBEP
	 2RwHK9Cy8sS2rBXuKXJvctC4Bq6C2jK6S/gBMA9x1sxt6ydKYVAFfAqpCKD+Lbm+RW
	 CTkFLp+EHxcq2Q+0N+MiEyq8LgEaRZKBHMQZslmLTNkQz52CiV4VANY5UuxTSJYiXc
	 HSEiViC0iMwJEQOI2/cy1vL8wqYF36gfQSfNXAqFM2CsYJ00Xwib/fXPCJXdfkBwli
	 uFbEJD7BvWk6qn89ZMam6ipKB0JOazajL/SM6VxCjG3IQq3Hghn8AUsKjF5s6ntxKr
	 WS9/dwDL4KSwQ==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
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
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 10/16] iommufd: Add the vdevice TSM request ioctl
In-Reply-To: <179321444123.2412245.6955528563980811144.b4-review@b4>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-11-aneesh.kumar@kernel.org>
 <179321444123.2412245.6955528563980811144.b4-review@b4>
Date: Thu, 29 Oct 2026 15:07:34 +0530
Message-ID: <yq5a1p98c0f5.fsf@kernel.org>
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

Jason Gunthorpe <jgg@nvidia.com> writes:

>> [ ... 300 lines skipped ... ]
>> +/**
>> + * enum iommu_vdevice_tsm_guest_req_op - Guest TSM request operations
>> + * @TSM_REQ_VALIDATE_MMIO: Validate and map a guest MMIO range for the trusted
>> + *                         device.
>> + * @TSM_REQ_SET_TDI_STATE: Transition the trusted device to the unlocked,
>> + *                         locked, or running state.
>> + * @TSM_REQ_SEV_ENABLE_DMA: Enable DMA for an SEV device.
>> + * @TSM_REQ_SEV_DISABLE_DMA: Disable DMA for an SEV device.
>> + * @TSM_REQ_READ_OBJECT: Read bytes from a device object, such as a certificate,
>> + *                       measurement, or interface report.
>> + * @TSM_REQ_REGEN_OBJECT: Regenerate a device object, such as a measurement or
>> + *                        interface report.
>> + * @TSM_REQ_OBJECT_INFO: Query the size of a device object.
>> + * @TSM_REQ_MAX: One past the last request operation; not a command.
>> + *
>> + * The request payload and response format depend on the TVM architecture.
>> + */
>> +enum iommu_vdevice_tsm_guest_req_op {
>> +	TSM_REQ_VALIDATE_MMIO = 1,
>> +	TSM_REQ_SET_TDI_STATE,
>> +	TSM_REQ_SEV_ENABLE_DMA,
>> +	TSM_REQ_SEV_DISABLE_DMA,
>> +	TSM_REQ_READ_OBJECT,
>> +	TSM_REQ_REGEN_OBJECT,
>> +	TSM_REQ_OBJECT_INFO,
>> +	TSM_REQ_MAX,
>> +};
>
> This is still no where close to being well defined enough.
>
> Everything here must tie back to defined spec references, listed in
> the comments.
>
> I cannot guess what data is passed over any of these APIs, how things
> like "REGEN_OBJECT" select which object to regen, or what the format
> of those objects even is. The formats of req/resp are never specified.
>

The request and response payload formats are specific to each CoCo
backend. Since iommufd treats the payloads as opaque and does not
validate their contents, what would documenting those formats here
achieve?

The limited validation is intended to prevent this from becoming a
general-purpose multiplexer ioctl. It restricts the ioctl to a defined
set of guest-initiated operations that the host forwards to the
firmware. The path is essentially:

guest -> vmexit -> VMM -> iommufd ioctl -> TSM backend -> firmware 

> The comment for this should probably be *enormous*. Every arch should
> explain what they do on every one of these ops, and it should be
> identical if it is structured like this.
>

That would require documenting a significant amount of backend-specific
detail in iommufd. Could we instead require each TSM backend's
guest_request callback to document its request and response formats?


> I have a strong guess almost none of this is actually general, but
> lets find out.
>
> You can also put enum kdocs directly before each enum which helps alot
> when they get as big as this stuff has to get.
>
> My guesses with no information
> 1) VALIDATE_MMIO why would the hypervisor ever need this? Guest
>    validates MMIO through secure communication to the secure world.
>

With VFIO PCI BARs backed by guest_memfd, the VMM can validate that the
IPA and PA values provided by the guest belong to the VFIO device. We
previously also used this operation to ask the CoCo TSM backend to map
the device memory (the BAR regions). I have removed this operation from
the latest series because that responsibility is now split between the
VMM and guest_memfd. TDX and SNP still need to be updated accordingly.

> 2) TDI_STATE I thought at least RMM did this with an RSI?
>

CCA uses RHI. The RHI reaches the VMM, which issues the ioctl to
complete the request.

> 3) ENABLE/DISABLE DMA, see #1, must not be done by hypervisor
>    See my reply to Alexey:
>    https://lore.kernel.org/linux-iommu/20261022123058.GC3008132@nvidia.com/
>
> 4) READ/REGEN/INFO, what are the objects? What format are they in? How
>    do you select them?
>

These objects are cached by the hypervisor. For CCA, they include the
certificate, measurement, interface report, and VCA. They are read in
response to guest requests. The requests reach the VMM through an
RHI, and the VMM issues the ioctl to read the requested object. REGEN
refreshes the objects/evidence at the guest's request.

>    Does this overlap with attestation subsystem? Should attestation
>    subsystem be used to access the SPDM related data?
>


I had hoped we could use it, but I could not find an easy way to
integrate the two. We need a simple way to read these evidence objects
into userspace. I am not yet sure whether evidence-get can be used for
that, since it does more than simply read the objects; it also updates
evidence.generation, among other things.

>
> Update the comment to explain all this, don't need to answer here.
>
> We really need to do these defines along with implementations, that
> probably will settle alot of the questions above.
>
>> +
>> +/**
>> + * struct iommu_vdevice_tsm_req - ioctl(IOMMU_VDEVICE_TSM_REQ)
>> + * @size: sizeof(struct iommu_vdevice_tsm_req)
>> + * @vdevice_id: vDevice ID the guest request is for
>> + * @op: One of enum iommu_vdevice_tsm_guest_req_op, excluding TSM_REQ_MAX
>> + * @tvm_arch: One of enum iommu_vdevice_tsm_guest_tvm_arch
>> + * @req_len: Size in bytes of the input payload at @req_uptr, at most INT_MAX
>> + * @resp_len: Size in bytes of the output buffer at @resp_uptr, at most INT_MAX
>> + * @req_uptr: Userspace pointer to the guest-provided request payload
>> + * @resp_uptr: Userspace pointer to the guest response buffer
>> + * @out_tsm_code: TSM-specific result code returned by the TSM implementation
>> + *
>> + * Forward a TSM request to the TSM bound vDevice. This is intended for
>> + * guest TSM/TDISP message transport where the host kernel only marshals
>> + * bytes between userspace and the TSM implementation.
>> + *
>> + * The request operation is guest initiated. The vDEVICE implementation
>> + * declares the TVM architecture and operations it accepts; iommufd checks
>> + * both before forwarding the request.
>> + *
>> + * The request payload is read from @req_uptr/@req_len. If a response is
>> + * expected, userspace provides @resp_uptr/@resp_len as writable storage for
>> + * response bytes returned by the TSM path.
>> + *
>> + * The ioctl is only suitable for commands and results that the host kernel
>> + * has no use, the host is only facilitating guest to TSM communication.
>> + */
>> +struct iommu_vdevice_tsm_req {
>> +	__u32 size;
>> +	__u32 vdevice_id;
>> +	__u32 op;
>> +	__u32 tvm_arch;
>> +	__u32 req_len;
>> +	__u32 resp_len;
>> +	__aligned_u64 req_uptr;
>> +	__aligned_u64 resp_uptr;
>> +	__aligned_u64 out_tsm_code;
>> +};
>
> Should the viommu_id be passed in as well, or we know it implicitly
> from the vdevice_id?
>

We get final callback via

vdev->viommu->ops->vdevice_tsm_req

>
> I think this is probably a fine generic API, it should probably not be
> "TSM request" so that the other viommu people can reuse the transport.
>
> I would probably try to stick to exactly like the other APIs do with a
> single enum. Two enums for op/arch is saying already that the ops are
> not well defined.
>
> So maybe strip this patch out to have no tsm stuff, define no ops and
> just give a command transport into the viommu driver?
>

Are you suggesting one ioctl per each guest request ops?

-aneesh
