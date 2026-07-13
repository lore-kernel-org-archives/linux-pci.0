Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3341D376481
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783982425; cv=pass; b=XEokpdMVr0L/IU4EKDavJ/XtHUmL4TY4BMC6Ehkq5/I2F/Dc7B5Uaq7b5wzhRWeY2mNw2NAu7aPefhJh5WbMaL2rb/Okgd6OOGifjUBAiXoFn70lPZiizCzWGNdn1V5jSjNPZVANRRXq8/pc9IQUFwIM+tHGygqxMZd6WzTFRUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783982425; c=relaxed/simple;
	bh=7LkfD6aXl9dK90wHStXoX1dSfuVb2Ck7kctZehI6Xxk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9LN8RLSnz5IE4xlhlD6uXZSIYKP2EZRAIFySGpAQGJt7x3B9AY7ozjBZvcGZ+e3sWxHtojE/XwM3VAwFLGjlR/jNG8BcQjhxaQgAdkkH6S+PdnG5j3rXgo7RDZsnTWZdXKBpPB5igjofSveUGgqhdJH6Dbsvq2ne6xmaglRERo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MET43OUc; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MET43OUc"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15d47266baso52896166b.3
        for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 15:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783982421; cv=none;
        d=google.com; s=arc-20260327;
        b=pxznO0ZYdHFtcPpbq4/LHvHFrpty0lsBWXVsTogbS3T5NzAfA/OU+PGveNpSCFB8Mt
         DzTbqgn41oWvW+EjZjFUHw2AFfyaL+m8F2kJ2uuW70TkW0EF171pVn05YXHtvng2ZYSd
         A2tCj7SLt4d9aFYd+krKkG76jsnwhXpxaMIYNckU2Xze4wcqXf4Q+6+JoqR3zcCjHfOJ
         85gPB3KZIceNcNGSgKdoG4+jexznwN/NSMlIUZT6Zx9znTWC4XkzsRUduMZxI4IyHEOW
         cyernVxUmW7gR3sawiMR5P3Nh2Y6RG5UslT7XAwvVy2JLfcPeO1tZyIlnqqMr37EBqqG
         hD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=7LkfD6aXl9dK90wHStXoX1dSfuVb2Ck7kctZehI6Xxk=;
        fh=THm+kr4KEFZ1n+toDayrPDp4vsEHhlWNJ6z5rF7LyoA=;
        b=q4smV3N9MoTqUa5vCXi806UGiwYsTYFUrEizmCf1gJUK0Wu79jkC6lyZQ/ocoP+ezz
         SwGM+tdbsv8z35GBcFL/8c2XZ5b+iFdK0ujvnUbCXHfB4UoyC3DPToP2FM048p92UXXK
         nIU4TIgq/SZIERBC6JAqvbXQd/dlmRd4x7IQ5QPSt0t5kPb/UxLy5GoO1ZUXfQfaAdrQ
         qeHkPtGB1knY/7C+lT+vaR+k4eAvCI2UsErPbcoD28VOxXo99GBt4ybaURVBJ35FRkp9
         Hgh2FtfeUZaHqvMQlj3j4w58yriqhcjOqTMH3hcADqn4kUisII0hjRceWcZGX4jiT9OU
         GIjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783982421; x=1784587221; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LkfD6aXl9dK90wHStXoX1dSfuVb2Ck7kctZehI6Xxk=;
        b=MET43OUcURM8pFPrJQDWyENy3H19795XEqQCyrqsduHYio7M5nTQXLYG/OmO9cp7pu
         NSSIOdLDvXWVZ9I0oqHIPHx2CUMjFjdXlMjUOYtxQRcEe+Dvyq3MDcJYRF4IZqwcNW2Z
         1hfEhawPHBmOGGjG5SGkQ5i2ptqFmy8aS9H0YzRMa+i6hYP7EPL5lZkT/Eo5A9f2ZEIF
         xZcjgdxAwdiRI8yIW1fMgK8wsKugVNDr7Cl3XaNqvTN64quYFZc3g5Rxu1pspm/jay9b
         GeMTQKsBFEdtQKWr0fqjg8EB0f2b9eodHg8CqAhpyh5mMy+THoxXrrWrVf7r1k2OZbPh
         uuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783982421; x=1784587221;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7LkfD6aXl9dK90wHStXoX1dSfuVb2Ck7kctZehI6Xxk=;
        b=ijjfRaVhsAKdMXOGzpDoV5wsPoJIi7FB8ObSqunoRuR7WUFMkNPBGhJ9pRQLsbYyNg
         9kf5rCRqlKTAwLeriGNqDWWDZT1keMvYxMcnpgLHi4wV2P0cx5h38JNsTmYdKY26j0bl
         CwjiIJGLOnBKIAQtTiypPzo50fgC3VnKvAiDf1XN7mumSpYEd74v9wKklgOrl+dN+tTz
         p4BqkGsBnnWRhY9OSX4RND92XE3SPjeJez5yXkc7XBwu7eYnZj2RRhjQYTpNG196YKal
         zJV/gdTkC3OX5zNXfLZU5zU2eI3dto4v91huINr191BSngJ2fxSi6LeOyllociXXAZJS
         uxQw==
X-Forwarded-Encrypted: i=1; AHgh+Rpheq1xErPwpRGzNuJLy6UoyP3xhrYPIJWFc+Vt18FwhhxS2QtiHJyoISMTa54MCEKIepJd7PqV9ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQnpF7jRLsiqsBSf5G3H54tEUx50MFEiiwHHwMt1ZyEvO7w1Ns
	r1tKLWQF/VOPDVohMAgIwxx3pUolM/rJK52hi+ALtCnUpiCpfLGlP89M+bwI/mZk4YvMu+2T+yS
	utoUGhePT+8SmZlGXsUHyst7d8tCmqHi4+j2K27lx
X-Gm-Gg: AfdE7cmsci4gtun95z5syfjfmAt66y1WTTH2qTjqM9wo+4awV5voVHDROZrSxBLS80w
	905O2YStu1EATLQtpxydz3PTOKygU9a/TxRyyMaqecXn1e7NjDWtn4dbGlqW4sTgF8nMd09ZlOH
	/8V4QwM26Ikn4bBlqhj9XD3gy1Jrlxbnvz0zmiwgcVKkmALxUOgeVnKJF/82ALR6Yzpv6cy4IfY
	2eToRYuuLwi8rCrhpqv1l9h9BQ3aYsIyLSIzAHhGcOK0g8D55HcxybXBjIaqn7Ucm9M9R9swnTG
	NSgf0t74SpYsLX/mo4h5i4T6BdOWju8n5dgIWil07+zjWs/+Qzs+QkhANLM=
X-Received: by 2002:a17:907:398c:b0:c16:13e7:fd63 with SMTP id
 a640c23a62f3a-c161de05ceemr462764166b.0.1783982420699; Mon, 13 Jul 2026
 15:40:20 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 15:40:18 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 15:40:18 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260713191727.GH674038@nvidia.com>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com> <20250602133009.GC233377@nvidia.com>
 <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com>
 <CA+EHjTwd9uku-ZV5y8xcK8VWdOfhcchyW=_fzjpCf5Vk2wQoGQ@mail.gmail.com> <20260713191727.GH674038@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Jul 2026 15:40:18 -0700
X-Gm-Features: AVVi8CeLrPp9U0h6s0bW1dfkDuvwNQDlx835UcZJGSgXNK2eLWnyQH0juXRBY34
Message-ID: <CAEvNRgEvGmOK3dXD4qdw5uXYD2sXNEVGT9NV2Zz-4H8VPb+KUw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info for importers
To: Jason Gunthorpe <jgg@nvidia.com>, Fuad Tabba <fuad.tabba@linux.dev>
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
	aneesh.kumar@kernel.org, iommu@lists.linux.dev, kevin.tian@intel.com, 
	fvdl@google.com
Content-Type: text/plain; charset="UTF-8"

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Mon, Jul 13, 2026 at 08:08:14PM +0100, Fuad Tabba wrote:
>> On Sun, 12 Jul 2026 at 02:02, Ackerley Tng <ackerleytng@google.com> wrote:
>> >
>> > Jason Gunthorpe <jgg@nvidia.com> writes:
>> >
>> > > On Thu, May 29, 2025 at 01:34:53PM +0800, Xu Yilun wrote:
>> > >> Export vfio dma-buf specific info by attaching vfio_dma_buf_data in
>> > >> struct dma_buf::priv. Provide a helper vfio_dma_buf_get_data() for
>> > >> importers to fetch these data. Exporters identify VFIO dma-buf by
>> > >> successfully getting these data.
>> > >>
>> > >> VFIO dma-buf supports disabling host access to these exported MMIO
>> > >> regions when the device is converted to private. Exporters like KVM
>> > >> need to identify this type of dma-buf to decide if it is good to use.
>> > >> KVM only allows host unaccessible MMIO regions been mapped in private
>> > >> roots.
>> > >>
>> > >> Export struct kvm * handler attached to the vfio device. This
>> > >> allows KVM to do another sanity check. MMIO should only be assigned to
>> > >> a CoCo VM if its owner device is already assigned to the same VM.
>> > >
>> > > This doesn't seem right, it should be encapsulated into the standard
>> > > DMABUF API in some way.
>> > >
>> >
>> > I'd like to propose an alternative. I've been working on guest_memfd and
>> > new to the world of IO, please help me along! :)
>> >
>> > It seems like using dmabufs are used a little awkwardly here. IIUC
>> > dmabufs were originally meant to expose memory of one device to another
>> > device, mostly meant to share memory. Dmabufs do expose MMIO too, for
>> > device to device communications. Without virtualization, userspace MMIO
>> > would be done by mmap()-ing a VFIO fd and having the userspace program
>> > write to the userspace addresses.
>> >
>> > Before CoCo, device passthrough (MMIO) is mostly handled by mmap()-ing a
>> > VFIO fd and setting up the userspace address in a KVM memslot for the
>> > guest.
>> >
>> > With CoCo, is the problem we're solving that we want KVM to know what
>> > pfns to set up in stage 2 page tables, but not via userspace addresses?
>> >
>> > guest_memfd already does that for regular host memory, tracks the
>> > private/shared-ness of the memory, tracks which struct kvm the memory
>> > belongs to.
>> >
>> > guest_memfd functions as KVM's bridge to host memory. KVM already can
>> > ask guest_memfd for the pfn to map into stage 2 page tables, and already
>> > asks guest_memfd for the shared/private state of the memory. guest_memfd
>> > already also blocks the host from faulting guest private memory
>> > (mmap()-ing is always allowed).
>> >
>> >
>> > Instead of using dmabuf as the intermediary between the MMIO PFNs and
>> > KVM, why not use guest_memfd?
>> >
>> > What if we make guest_memfd accept a VFIO fd, or a dmabuf fd?
>>
>> This is interesting for pKVM too, provided it covers more than MMIO.
>>
>> We need guest_memfd to be backable by a dmabuf for ordinary guest memory, not
>> only for device MMIO. There is mobile hardware that doesn't tolerate scattered
>> private memory (DMA engines that can't gather, IOMMU page-table size
>> constraints), and a CMA-backed dmabuf heap is the practical way to get
>> contiguous memory at runtime.
>
> Why can't guestmemfd allocate directly from CMA? Allocating struct
> page memory through dmabuf just to put it back in a guestmemfd sounds
> very ugly to me.
>

I'd like to understand this use case better too, is using CMA through
dmabuf basically because CMA doesn't really have a direct userspace
interface? As in, for HugeTLB there's fd = memfd_create(HUGETLB) and
HugeTLBfs fds, but not CMA?

I did hope for this API shape to extend beyong VFIO and HugeTLB to
anything that has an fd today, but Frank did bring up the counter point
that not all memory has an fd.

>> HugeTLB doesn't help, it wants boot-time
>> reservation. Those pages are struct-page backed, so it's a different problem
>> from the non-struct-page MMIO case, and the shared parts still need to be
>> GUP-able.
>
> Isn't dmabuf pretty allergic to mmaping refcounted struct page backed
> memory since that wrecks its lifetime model?
>
>> More important for the API shape: conversions have to work on subsets of such a
>> region, at page granularity. A pKVM guest doesn't know what backs its memory, so
>> it will issue share/unshare hypercalls over arbitrary ranges of whatever it was
>> given.

For my future reference, does this mean for the CMA case, some page
splitting on conversion to shared (so each page can have its own
refcount to track users) will be necessary? (and merging)

>> If a dmabuf-backed guest_memfd can only be converted as a whole, we can't
>> use it for memory, and the guest can't be taught to care.
>
> More reasons not to involve DMABUF since guestmemfd already does all
> of this...
>
> Jason
