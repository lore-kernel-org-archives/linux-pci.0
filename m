Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B23C1963
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178439; cv=pass; b=mhMdzpFTjkQcqs9cSeogYeJFne9gwG0UHk26NTUsRhoJBCIb+MIreq5UZZPD6vLRMitTRakzYeFXxaTP9XGq9KYwEycMAtjblR+w1wii0GqZX7odQG7O0QFtTVX9Pa9M7JmbS7sZ0NWt30F/bEg4Iw+3V2H1Xa1pdgPTJfDDp7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178439; c=relaxed/simple;
	bh=jBGj3vq73TpQNUHtZ8hP8T9s3Rn/i9PzV5LYqBYc5Jk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/OmDLyreEyUpjvxQ883sqoZbQl3mHm4kxZa6dbLG3tLOT7Lppuc7eHyJ5f1t2CuYf7g7adnwiBmlgH+kof2nSd9JdkXKLn7a19qXGmkrkJxEfdj3yDk/hW3v4piMxqRmnmygTVTwIg/PD3Tt6+C3kQZXvmMrxU4/EbAWx+I8wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UJFxwML0; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJFxwML0"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caea3f742bso37415885ad.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 11:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785178437; cv=none;
        d=google.com; s=arc-20260327;
        b=AGExXQiVENo5hvAMIHD5F4ymeGb89a+3ku3KH8bD5G37ryG78pAN8GtHQ4YAFbppbd
         y9YncehheyL5jkq4QJCozKTA9l+jOlX+QifsieUnQiD3CxJuKb8yI1btSrKz17r/a3+Y
         1co7RoeCmTSgNiGLVPq0pTI5812TiL657FMRHuQoPjHTtqeL8BWJ2blWIEMUYoQ8HG/T
         6ApYr61uMzJYHIp/2LSAwrJJdeu3y0m9m+jBUdHzd8cd//MG+Uy+M1gGc9aISW63FXK3
         2yCpANHq5qFy7u2TJfJC6o2EXHBMxdkjez4eseYg1NUqWpLG6Vqr6fP9FFi6EnS/vOLa
         7aFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Ezc2drTNkvx/EGjvXJcxB1ItRYJScaQpIm5JRHoUsx4=;
        fh=hDxcZac5S52qZl6Dir6yX/kW4tOJx4UpSRoJIEdoXIE=;
        b=NP0RV0gPpO3xsbMT/vD9Rv1nyFinILYSFVEn5DoN7yS4oRGPeI0hNLzG23pEEB+XpM
         r1/2PMVFowd0L/Ekm43RB//WFwvnecAeFweD/7ETHqSv67CpGDwVMDRK3KrDh6DgTMHp
         7DY794q4mSTz4AIdnZcZ0oQRn8XGvCmxnkJWLB2jdzlpwrIGMGpln3gKtyrfaTZVqZ7a
         V4s+NEcx9HATLR0VnkI6X6AZAM6H4Ce3ln7M0tbB9ftN1Fut4LV85mL18QNQZlHjnKCw
         Z9nw/JGlGoSTSAeqr1mRrlw+IMF9j9bEfj2zm7KsibwXc/mRR3OehimZISPEtBfS5TeO
         P85A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785178437; x=1785783237; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ezc2drTNkvx/EGjvXJcxB1ItRYJScaQpIm5JRHoUsx4=;
        b=UJFxwML01OyWDhhGzt5oP/vgee+QKm+snjmmmpDfkX2aopwCujH8dPQQ97ZHKh3mPo
         wSIyJgJm8M004RUsHokQRSTdo6NznNTwTkLQLxPtuxukI7+oeEQ1IAwr4QcBf/thLFNs
         QPn3NSWX2WGIX3Vh/6+MxlWfe+NPvmmR9Gu/mF6iRZwy6vKhYiQezuXx6LAcPikzD+AS
         5tstckADxD/CnHSEThTvm0xQoz7Yk9C//l/boH0tSu4gvLVQMJxSZuJHUllpT42ehOYD
         Lt6qqmz5ilUxbPtbFCIFH8dUHm0pytWZ+sHqFPF5Zvy9Mc7C2ow1sDgxaXWLYsnV5ApX
         SSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785178437; x=1785783237;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ezc2drTNkvx/EGjvXJcxB1ItRYJScaQpIm5JRHoUsx4=;
        b=Yz5BAXksbV1/0ftaYtPBQhYRIssV1fEQdxNkUbX3R05Yu5P8uUZNtuQxtj+5TwL/TM
         rWussbd0gHXN+aSuJwDsT7JIpIXmM7pI/wp2ow00lBQbsgnBXwyvYmEFrm2hqh97FbRU
         k2JDgIKQie116yovqJMO6XWN3JqspdDJUb1/8qEE4/6opLEA8et7H9n2Pw/u4XoXlYYK
         oylXG8Ix3nmoc/Keb5uWj04xYR+G2QFbvLW+z4PtXYAeRxGg9NCVBCquQeM3LAyVCRKk
         SWhoUdwdQNJanXmejhwo9t4LFKrvgTFMvGspKRxN1OT5Tt9c4XdW10lnPoQJoS7akEWQ
         4DRw==
X-Forwarded-Encrypted: i=1; AHgh+RrTG6HdGcbJT9XJUWWnt+CJbP9jI2XmtUHXrYsunyPqzOOcqMW4uRd5LXHTXqTt4aVLT/ItcRFHe1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKAbd0lLAGVhaoRRfpBVRA37RUnTMVx/fTACU933OnH5iA4lYY
	mlbp6FaNkqQB0e7f9UMcH2jnV1d421PlBw9rhZXpehvwlQXd/w52d2am/6NgaSxvhGUIZoCgyAp
	OZt6UtBXX2VF1Qum+oe2hOPx3S+Jx7odkAA8n8Rd4
X-Gm-Gg: AR+sD12qUV0TmwOl2hmEn6yq4bCLlsYy0XksX6spymJjQxbVwOFRJajHxFxka4+2Bkr
	de0Rur+wUus0viZkh/m9/7ak3oGmSAVaBiNbgmMYvboFca7TytNlvLmQ1eXqOFGhyZ0oQnORIOd
	6rKkhdVyl+l+ixQm9Hf0XrEMtuWwy3Xx3Gvd6LNaPpGqmjoeJ3l2Jnu4+QbYtJSGgb8yZK0MPLd
	EBKxZEsAI7TCGExePWo76WdgQ5GgClZ5Jv/Vmgs1ysfTLHcn+yQ/zsHsx2uOn2qFrec9jou5BP4
	GwWkbfEnLF5cCJBDbP1kJD9ijiRRMqVjquQ3vRySpIAD68Gl
X-Received: by 2002:a05:6a20:6a05:b0:3c3:7a0a:18a7 with SMTP id
 adf61e73a8af0-3c6c7fb20d4mr796670637.55.1785178436210; Mon, 27 Jul 2026
 11:53:56 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 11:53:55 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 11:53:55 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <amcdueQI1voXWPQb@yilunxu-OptiPlex-7050>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com> <20250602133009.GC233377@nvidia.com>
 <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com>
 <20260712221934.GF674038@nvidia.com> <CAEvNRgEo2kLUmaGU-Vsgx2sTQvU_NNUJ4bRp5Z4Ygs_xvVLOYA@mail.gmail.com>
 <amcdueQI1voXWPQb@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 27 Jul 2026 11:53:55 -0700
X-Gm-Features: AUfX_mylYj_x8eQp0BvgfyW8gHfhB_jFskLbUbWzV0Fgf00qZT4Qn9h3hPlqeKo
Message-ID: <CAEvNRgGYc0B1YyhDhS0Khfm3N85hbkYGMTfDLiXYn+WHTLF2EQ@mail.gmail.com>
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info for importers
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org, sumit.semwal@linaro.org, 
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

Xu Yilun <yilun.xu@linux.intel.com> writes:

>> > If VFIO can create one
>
> It is an interesting idea to let VFIO create a guest_memfd instance, if
> DMABUF doesn't work. But to achieve this goal, I think we still need to
> refactor guest_memfd to allow for different memory/MMIO resource
> exporters/creators, and different resource importers/users like KVM MMU
> & IOMMUFD.
>

Yup I think both ways we'd need some level of integration from both
sides :)

>>
>> At guest_memfd creation time, guest_memfd is always created for a
>> KVM. This is the first place where it is bound to a kvm instance. This
>> is one place where it helps Yilun with Confidential VMs, so KVM can be
>> sure that the memory was meant for a specific CoCo kvm and not any VM.
>>
>> I think it might be weird to have VFIO take a kvm fd to create a
>> guest_memfd?
>
> I think having VFIO create a guest_memfd is better than having KVM
> create a guest_memfd on behalf of VFIO.
>
> The lifecycle of the MMIO resources should be managed by VFIO, cause
> the availability of these MMIO resouces are impacted by device
> operations, e.g., device reset, PCI Memory Space Enable (MSE) ...
> You can't export MMIO resources to KVM MMU without VFIO's awareness.
>

Thanks for explaining the above!

Do you mean that as long as VFIO knows that some addresses are not
usable, those addressses have to be removed from the stage 2 page tables
that KVM manages?

> And VFIO doesn't have to take a kvm fd paramter to create a guest_memfd,
> VFIO has got the kvm instance via KVM_DEV_VFIO_FILE_ADD.
>

I'm new to this - looks to me KVM_DEV_VFIO_FILE_ADD is for linking VFIO
to KVM but some mmap-ing is also required (pre-CoCo) to set up memslots?

With CoCo, setting up memslots would use some fd (guest_memfd wrapping
VFIO or the VFIO-created guest_memfd like you were suggesting) and I'd
think there will still be some notifiers between KVM and VFIO for the
mapping.

Btw is it right to say that KVM_DEV_VFIO_FILE_ADD is only in the case of
setting up irqchip? Is irqchip a requirement for Confidential IO?


Hope you also had a chance to look at [1] that David Woodhouse is
working on :)

[1] https://lore.kernel.org/all/1dc299af6b795a40c8887b3d84f915024f6446a9.camel@infradead.org/

>>
>> I was thinking that the userspace VMM could do something like:
>>
>>   int vfio_fd = open("/dev/vfio/devices/vfio0");
>>   int gmem_fd = ioctl(KVM_CREATE_GUEST_MEMFD, { .fd = vfio_fd });
