Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AE3181334
	for <linux-pci@vger.kernel.org>; Sun, 12 Jul 2026 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783818096; cv=pass; b=WH0Y+NClxs6tAwuH/v1PrO+DPz1Xi0nsSQKGVs0xdW7yAJLgeN5xB5xjaa7GM8dQnyHieeKLidXYsBJptnIzmkh5TZYs7ib6QHponSLat+rLh6vRV3QMZEsX7nrDh34a5rNWstD65VYnrZWke8nG8efAxFs7jkYirSRmRKfYN24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783818096; c=relaxed/simple;
	bh=R8xlg3RI6zLmG7lgrIZL1li1QImUsqosewBmuLTRodU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwR6Qd7yki1NqF+JmPbP/upL78QJ+76Zhi1WxC3qpErA61Nol9+cZj0nHxZ3JLweWgq6hGNgaw77MSLn2MLuNAJ8RvYK/4dLPV12F6wPQ8TWY+73R+h7XSOOrkXd06u78gE0OITLcNgnbE7TZWy5fzonkpYhbJBROglynu05hs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F2Bcm8Hw; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F2Bcm8Hw"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84a2dcec51cso148906b3a.3
        for <linux-pci@vger.kernel.org>; Sat, 11 Jul 2026 18:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783818094; cv=none;
        d=google.com; s=arc-20260327;
        b=HJ4oaUNIEeXLMGjOmOKCl6T/ycuOVpLPBYUxOvxmzTULAMOXbCZfcIJNAjsJlJwy/e
         bhsxe7mGI+z0cKPoUn0q3eAGM49DtY4hy/jmsVOt39WCRHl3jR8XvpMD2/ZvC0fjsStz
         cmfEpkwBZObou1dl3ij40yWOl+ANzW0E0EC2CziDwP0cGOnOSwtyflUarA/jFDHGuF/0
         wcYJHrM3e2z3Yoo6KyewoutAvjga1BfzidljURAwZeWxC/Gu8ZvYa5F5V3KUMjX7IswX
         slmR3shDt7WyydBppTTdGG9X4PZ2p6rjtdIkwblT/mJ6d5etsSrnW7bpS3QcOvDOimtV
         xj/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=gGEYW3UAXERRsGZl8/IlnSaBkO9PGZLTdY+qnlryyhU=;
        fh=j/NCsGFDdw63R/Z5r8PUyqzXFkwgRJ78UNSfrsfi29c=;
        b=ieM/gE4/9rHz+C3z2XVuPfh+/hZFeBkVUuoyGEu215mevYqNJ7AoHzithqn86b5qvh
         4ZzRJ1jE2KWprfotR1sfcPm2el4brt+d8MqQsB9TJbF4tkmnC87nDsa8oiT7dFDW4k6f
         ygzh9JEbNV4tbOtw2FpEYVMOLmYZjSG+hpzwB7XZE+vCrdDwHH3yPVjHkmpKKWUxetNZ
         e0GFQ78L6ydqOEq5WMYINqnEWvQbTYxXxUI5cIbcQ9GfQHtdlDMHQjjSljlTRTqz83Yn
         cJiZX62WwAXySm+Ug4e+OKP9URLkaVzEdhacdi7fbwE6Lsa6VX51AWEODxtRZfsM/Sf1
         hzRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783818094; x=1784422894; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gGEYW3UAXERRsGZl8/IlnSaBkO9PGZLTdY+qnlryyhU=;
        b=F2Bcm8HwvOLs7bxy896OiDRS7aOVkXzSRJUgxn73pPsUhRXl90cRBS7fWeF9Pq3i4P
         6WF4MlA/qmoiDZyT4/6EZCgWbHBs7BHU/SEJlV1KHoEKOTV509ukjVajnPveJcqhRLzA
         H4VeEjDgBH1i+to9Y+rirt/kVSzSt9LYgl7M8a0sh0p/lBukORhcnzPCxs6CDPwFEbGV
         ya9lBdjhTycogmawCL+ZGwIYaqxCx+drVf/hhVHlRxHBXHeTvlXHfcVH0/L0RGmPpq3L
         fUp6erk2+3hEnf9ynGSI5RbRvqqGid5Ng6zLWYZohb6uvBZX7A5VGQruM8nGFYeKrhff
         XAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783818094; x=1784422894;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gGEYW3UAXERRsGZl8/IlnSaBkO9PGZLTdY+qnlryyhU=;
        b=RH1ya/ahLEuzM3+C2riCqTDqvt35uEzntq44IQq1g11JedtpndgjLrD4oEvRLxzaOF
         Dd/4lJhof6vBV+OOOPebtHczTDXVrz6RQzCBxvorkGJJBuSfApfK1yU0TaRPCKFrJ5ic
         mMWWtrY1+5THXuQklCdm2SVQ4iI2BpP+jeGizt+8Q/mlSRhhzc41nfn/7Ericw79flJY
         Nlvz3MkpkLmWj8ifyMRLwCPM4hegQb2On3sFxzHtM8OuTpoUNZiVQnKWIjZN52fHgyY1
         lOD+zwlk6Pc+/H0DI8y8COaJkDUPPTMyBxLXMVWfYqdO0lWtl+IDYWcUAyvo05wJujG4
         3i+Q==
X-Forwarded-Encrypted: i=1; AHgh+RqULTQlikq1ilmxW1G7G2DhEdLqIXh801RbusyWsPZizs6KIuq3oyYUErjuyjU5zNRC6KvXKKl7ntY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIVPsxWz64s2md6G/MT8XLpqQBB47a6GMEVwePAErLlipNXNZH
	rVBjw6kwJ0mj4PqSqZ1+CZn8HUSMd3l72No7v+rYW/3vCknFW/XsEPM5tiT1oxT4tUsF7EXH8JV
	7dzZ1xmg/mlmY0+HNO3ZpytiPoi/UNe+lNlQlWBtk
X-Gm-Gg: AfdE7ckHsgs9+5iNgbXETkiEmfgHMHVyhQKyRkJsQ2fIHUWAXDYzbn6u3NBtSL7GtLw
	8pYY4bUA4fND/EFruZLred4uSsM7LXxRMcuPIIvJNfMDy6StIP7NpCucp2X7iyyIScUsYqcOLqN
	tO+Hh/y75/8Gred/L2JZ5oBF+4OeMXpfEek51lKSdgqRhuqAhJ4A01FW04BQS/HYI/361Pnivmc
	xDAdwQ7zShsb6gRe+6QGjc9Lr0n3tHAh5KMH+fwI+XPNLvsBkNaRwC+/W5KAVnafkoEA1ufe/qh
	nAlhwLdEOsUU1OzI51AIRo2tWLrF
X-Received: by 2002:a05:6a21:3990:b0:3bf:a7d5:df38 with SMTP id
 adf61e73a8af0-3c11075f8f6mr4812182637.9.1783818093599; Sat, 11 Jul 2026
 18:01:33 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 11 Jul 2026 18:01:31 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 11 Jul 2026 18:01:31 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20250602133009.GC233377@nvidia.com>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com> <20250602133009.GC233377@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 11 Jul 2026 18:01:31 -0700
X-Gm-Features: AVVi8Cd0bGOMjMsYrL4vU20fXx-xb2mKPsbs-m9K5p8jfizmd9no0laxFphKWjw
Message-ID: <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info for importers
To: Jason Gunthorpe <jgg@nvidia.com>, Xu Yilun <yilun.xu@linux.intel.com>
Cc: kvm@vger.kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com, 
	pbonzini@redhat.com, seanjc@google.com, alex.williamson@redhat.com, 
	dan.j.williams@intel.com, aik@amd.com, linux-coco@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, vivek.kasireddy@intel.com, yilun.xu@intel.com, 
	linux-kernel@vger.kernel.org, lukas@wunner.de, yan.y.zhao@intel.com, 
	daniel.vetter@ffwll.ch, leon@kernel.org, baolu.lu@linux.intel.com, 
	zhenzhong.duan@intel.com, tao1.su@intel.com, linux-pci@vger.kernel.org, 
	zhiw@nvidia.com, simona.vetter@ffwll.ch, shameerali.kolothum.thodi@huawei.com, 
	aneesh.kumar@kernel.org, iommu@lists.linux.dev, kevin.tian@intel.com
Content-Type: text/plain; charset="UTF-8"

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Thu, May 29, 2025 at 01:34:53PM +0800, Xu Yilun wrote:
>> Export vfio dma-buf specific info by attaching vfio_dma_buf_data in
>> struct dma_buf::priv. Provide a helper vfio_dma_buf_get_data() for
>> importers to fetch these data. Exporters identify VFIO dma-buf by
>> successfully getting these data.
>>
>> VFIO dma-buf supports disabling host access to these exported MMIO
>> regions when the device is converted to private. Exporters like KVM
>> need to identify this type of dma-buf to decide if it is good to use.
>> KVM only allows host unaccessible MMIO regions been mapped in private
>> roots.
>>
>> Export struct kvm * handler attached to the vfio device. This
>> allows KVM to do another sanity check. MMIO should only be assigned to
>> a CoCo VM if its owner device is already assigned to the same VM.
>
> This doesn't seem right, it should be encapsulated into the standard
> DMABUF API in some way.
>

I'd like to propose an alternative. I've been working on guest_memfd and
new to the world of IO, please help me along! :)

It seems like using dmabufs are used a little awkwardly here. IIUC
dmabufs were originally meant to expose memory of one device to another
device, mostly meant to share memory. Dmabufs do expose MMIO too, for
device to device communications. Without virtualization, userspace MMIO
would be done by mmap()-ing a VFIO fd and having the userspace program
write to the userspace addresses.

Before CoCo, device passthrough (MMIO) is mostly handled by mmap()-ing a
VFIO fd and setting up the userspace address in a KVM memslot for the
guest.

With CoCo, is the problem we're solving that we want KVM to know what
pfns to set up in stage 2 page tables, but not via userspace addresses?

guest_memfd already does that for regular host memory, tracks the
private/shared-ness of the memory, tracks which struct kvm the memory
belongs to.

guest_memfd functions as KVM's bridge to host memory. KVM already can
ask guest_memfd for the pfn to map into stage 2 page tables, and already
asks guest_memfd for the shared/private state of the memory. guest_memfd
already also blocks the host from faulting guest private memory
(mmap()-ing is always allowed).


Instead of using dmabuf as the intermediary between the MMIO PFNs and
KVM, why not use guest_memfd?

What if we make guest_memfd accept a VFIO fd, or a dmabuf fd?

guest_memfd can then take the mmap() calls from userspace and .fault()
from mm, and then forward them to VFIO or dmabuf. This way, VFIO/dmabuf
can stick to their original functions, and the changes to VFIO/dmabuf
would probably revolve around disabling access.

Disabling access would probably involve some of these:

+ When guest_memfd receives the fd, it could return error for existing
  mappings, or perhaps it could just force-unmap.
+ 1 extra flag or field to indicate that guest_memfd is controlling this
  file, so that if userspace tries to take some actions with the
  original VFIO or dmabuf fd, the request should be blocked.
+ Perhaps just close the original fd, like dup2(oldfd, newfd) closes
  newfd?


I'm about to restart work on guest_memfd HugeTLB and I'm thinking about
a similar approach for guest_memfd HugeTLB, where perhaps the interface
could be that userspace will give guest_memfd a HugeTLB fd at creation
time, and then the original HugeTLB fd would be rendered unusable in the
same way as above, perhaps like with the S_IMMUTABLE inode flag, but
also blocking reads, and not userspace-modifiable.


In the course of a CoCo guest's operation, will the guest need to
convert between private/shared MMIO? Will the guest need some pages
shared and others private? If these are required operations, guest_memfd
already provides the tracking and is going to have a conversion ioctl
very soon. Instead of further extending dmabuf to track more things, how
about letting guest_memfd track it?
