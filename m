Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95363D16E4
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783984567; cv=pass; b=Acin5TmqUL1aKH+kQECbQVnAYNHm4wDPde/Mi+pVzjM0bbLi/75J3m6YIPLE8qsBrnszjBSwD5jFckIP3+ahP/eWIJKf4H8QO1NLfi5BK+5Y0uj7/pBiIlqZl6+iRl09SyuIFoNJT8OheOKO6FWYLF5TdaizvMefBKcTszQ2G5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783984567; c=relaxed/simple;
	bh=jNitDBOyiAnqLYAVTV2WWuN1NaJEYQUlElQBlTgvBIA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjwdDosRli+i3QmIsqOqeWKBcudOX9r/B/e38wWTIsA+tDIeAPv6XiWPUweop1by2bVrcrMNPvm2FWjwlgvLHnJ/fBP9RrJdQle+3I6NKJW0BBCy68QhY5IK4FB8PVLHUk5KLBGzVIlqHA+QG30Vu+xw32DEPBpaTtqXM8uegOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtrAYmM5; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtrAYmM5"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso2174082a12.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 16:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783984564; cv=none;
        d=google.com; s=arc-20260327;
        b=VHMRrMjIYhJyMjC9OV87XRY45zajYON8e0SpqlbMBWjCxfXZ1akG43ZOrEoAigHdi3
         Ik6F0kbU2VFNabQPPQOaEfiiJh/LGFzVw4jtuIGCyW0NZnkoFJqEjb8BYewJkyixMQUG
         P6F2y1KvLFXrvxCtSo3/trz99eRxdORIEfm9RdDa3sepozN+WgPdkBCBznzChnMUdnb0
         6uXZsFsgid7EXQRd0z0+7RGp/gdWIqu1Np1WfgeLjM4fX390Cr1V1Tbtrl+hMvAkjhx0
         hv+hIzhxhp85zXnK2EHOSBoN7wuHEGC+4rH45WnHNmZxr6lOPV/GxQi60pS2pYJeasAc
         Xfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mNe9rM8ZI02kYm64C7ciEQBT8YD2/cothZS9irUHQA8=;
        fh=ZbFWgcja7nIdaF90VJY7hkP2DD+lf5DlPTe/NU7kWWg=;
        b=QdDdlOXtw8hNmLWhuGAWeVfIEeHjhomRSfVGtNuIThHnbnpceVb3omEOVUe4Dclyjg
         eieW34wDEcY3puQBZD5nreJhDSdqFDUOqUOBdKHJbdpudk95b+KagXJE+ZJns3nMRuzH
         5t6BK0zAu9kIsr79b2EQ0ZsjGVvk1ENLualIYn47QWgtJ07yU/RcpDZNpcqrPajExejQ
         2RwZQf7zNj4P0WSePKVhxgSN/A+F0XLfTfRCCySLa5g5KFR+uoqMJ/Ze6WwlDkyxHODT
         hSiSuMGhOeQ1aMgAfw6V4TUo5nGUea3tVqj+yQRXDt5DgnfG2Pbx5navJvOXOGvqB+YU
         glcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783984564; x=1784589364; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mNe9rM8ZI02kYm64C7ciEQBT8YD2/cothZS9irUHQA8=;
        b=dtrAYmM5gcCKTMBJFLfIdvxLIN1TFGu7RAukrH3sgUGEoQIdT8jn7K/J0o1Ob92z8T
         a0cprolYrryzquVOKVdD9Tso/apjFQx0S/TWnaNDzT+4XKP8+TZVK4AJYQG+obu3DXBq
         oPXv+706nt3OtvYOng38qlKNuVbBw98VjmQZMMpw9xy4EDPIiaM3AFPrQrSI0vGXNKQd
         efsZF/YHau9aw97qE71JeoAQlOSlS859bm0v+3++nIT4x6FAjIMt/wlG5frQ9FXlar25
         BVqUYnbQe/TsL8Sr0LkuE8MunM54JmYxjhxr0hvppPg0JBL0pEzFq0FC6FlGAxqBiR8+
         ALDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783984564; x=1784589364;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mNe9rM8ZI02kYm64C7ciEQBT8YD2/cothZS9irUHQA8=;
        b=Yu22WH3Oxub41pkaowO9GNY4WPJGo3QXN1U4Fw9mjTc9c6n6S4cgkcBEPU9s1Nq0Ul
         l3RlMkBOCMvPUf257bWpg/mQTtU+oT2hYnH0L16iTD2bfLFiVwRWYkGMMtFA9EOH5XTG
         WO6U8iDT+1/BCQb5XEeHdsbHGoVCXcSrUnR9dKY44n8JSe/NP+FvxrycbxlmuMEfasWQ
         wrhP8GgXAzVX3EuOq6Y1k9IUSoADCC/QIshZomt5I7Ga0Ngr6ofUQ9USrnaU0gzk74al
         VHLIPiVaGELZwUs7blkEkdWvBRgBkRE0x8dwooKSa5gEwVPcjmGYesqKVJVcQ4Rx44IE
         zUdw==
X-Forwarded-Encrypted: i=1; AHgh+RrMUQESM6T9M59i+O93dTS95Hq4CsnLYLptNVUZ+ymbhPsvlRGCtAyDh56tekhkwSPq9EWNL0TC3mA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6PEVaWnkeUV1BhQPbZI8HSczdYRDohJbzoDiexrirXhtrwmiF
	2AuXt4Dru/pqngLXrCfj0gbGR3ZFnv1KhJofWlHG1iEVpgHMpZ8GzEpizzPTWqiMJyBVr2RL5p1
	H4in8aHZpYY3kqBebyMAGZJiUJBROu+KcY7UFapdi
X-Gm-Gg: AfdE7cnWP9pY/sEmtL0EX2ORlUobWb9Ij0m74zRbqNOR63A8nIyQsbKvnCFJ7DIZpFg
	3QmfS5RhidSLiwOf2IybGGtdAKau6noB45RGUiT1mfa9sfJaBfLphjCES1Y0+BO7qWRWj+pvp4K
	ji6X0WHaBVX0scz3cJi2ybfoIMnWYhfxErgiTuuJzBvnbkAsDLNJZUd7Q8ZShDpJQnAWR+lGQXL
	4gCBpUbM/Q4BrOrzfRE3Us32IHt8dc2wlhBMmDqd9d6tmQNW9oPpqa5WKQnV4/odm2BzHF3YjxK
	ZEyqDk5K3AjF+z4Csxm1xIGfpC3FI/4tSndOgPI+3B5eb0YWka36jZJLHp4=
X-Received: by 2002:a05:6a20:cd8f:b0:3bf:83f3:b810 with SMTP id
 adf61e73a8af0-3c110a7b287mr11689858637.29.1783984563364; Mon, 13 Jul 2026
 16:16:03 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 16:16:02 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 16:16:02 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260712221934.GF674038@nvidia.com>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com> <20250602133009.GC233377@nvidia.com>
 <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com> <20260712221934.GF674038@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Jul 2026 16:16:02 -0700
X-Gm-Features: AVVi8CczeGanVcGdhsy5HlDfD2XYPmjZautNceRH5dXiMXcxQCHaSODxjV4xdX8
Message-ID: <CAEvNRgEo2kLUmaGU-Vsgx2sTQvU_NNUJ4bRp5Z4Ygs_xvVLOYA@mail.gmail.com>
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info for importers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, pbonzini@redhat.com, seanjc@google.com, 
	alex.williamson@redhat.com, dan.j.williams@intel.com, aik@amd.com, 
	linux-coco@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	vivek.kasireddy@intel.com, yilun.xu@intel.com, linux-kernel@vger.kernel.org, 
	lukas@wunner.de, yan.y.zhao@intel.com, daniel.vetter@ffwll.ch, 
	leon@kernel.org, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, 
	tao1.su@intel.com, linux-pci@vger.kernel.org, zhiw@nvidia.com, 
	simona.vetter@ffwll.ch, shameerali.kolothum.thodi@huawei.com, 
	aneesh.kumar@kernel.org, iommu@lists.linux.dev, kevin.tian@intel.com
Content-Type: text/plain; charset="UTF-8"

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Sat, Jul 11, 2026 at 06:01:31PM -0700, Ackerley Tng wrote:
>
>> In the course of a CoCo guest's operation, will the guest need to
>> convert between private/shared MMIO? Will the guest need some pages
>> shared and others private? If these are required operations, guest_memfd
>> already provides the tracking and is going to have a conversion ioctl
>> very soon. Instead of further extending dmabuf to track more things, how
>> about letting guest_memfd track it?
>
> Use another FD type was sort of my fallback if we couldn't get DMABUF
> into something workable. I'm kind of surprised to see guestmemfd
> proposed as the other FD, but I don't know much about its insides.
>

For now guest_memfd only supports 4K pages, so the interfaces we're
interested in are:

+ The .fault() handler, which core mm calls to service any page
  faults. For this, guest_memfd first checks if the page is shared, and
  if so, proceeds to return a struct page.
    + For VFIO, guest_memfd could call vfio_pci_mmap_huge_fault() and do
      vmf_insert_pfn().
+ The kvm_gmem_get_pfn() function, which kvm calls to get a pfn and a
  max_order to set up stage 2 page tables. Now guest_memfd returns
  folio_pfn(folio) and max_order = 0 since guest_memfd only supports
  PAGE_SIZE pages now.
    + For VFIO, guest_memfd would need some way to get the PFN, so
      probably something like dma_buf_get_pfn_unlocked() [1], but
      probably from VFIO instead of dmabuf. Perhaps pci_resource_start()
      is good enough to get a pfn.

[1] https://lore.kernel.org/all/20250529053513.1592088-2-yilun.xu@linux.intel.com/

> If VFIO can create one

At guest_memfd creation time, guest_memfd is always created for a
KVM. This is the first place where it is bound to a kvm instance. This
is one place where it helps Yilun with Confidential VMs, so KVM can be
sure that the memory was meant for a specific CoCo kvm and not any VM.

I think it might be weird to have VFIO take a kvm fd to create a
guest_memfd?

I was thinking that the userspace VMM could do something like:

  int vfio_fd = open("/dev/vfio/devices/vfio0");
  int gmem_fd = ioctl(KVM_CREATE_GUEST_MEMFD, { .fd = vfio_fd });

and creating from a template fd would also disable/close the vfio_fd so
that the following will fail:

  addr = mmap(vfio_fd);  // Maybe this should fail too?
  *addr = 1;             // But this should definitely fail so that
                         // guest_memfd gets to block private writes.

> and fill it with MMIO physical addresses then
> maybe it is OK?
>
> Jason

What interface would be used fill a guest_memfd with MMIO physical
addresses?

When a vdev is associated with a vfio file, can some other vfio file be
created that can also do MMIO to the vdev's PFNs? Would I be able to set
something to block any future associations to those PFNs? This will help
guest_memfd to prevent any other writes to private PFNs.
