Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8313988FA;
	Mon, 27 Jul 2026 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142723; cv=none; b=jKcTegMtLvfnSHm2gYPDiq0iDs9fuIIWoX4IZsHTrVjkcnge4R00v1pN+fxIU4qHQ+v9QvJMzs6sdY///yKNa3WtNoTwkaazsHJnRsUwdNzQNHmMYjyRmk1rwf9YNhnHr4ckb8O8gwgCuVH/InHTvqnDRRp9unLsogjFPyZ75HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142723; c=relaxed/simple;
	bh=p4GxXbND5TPyo3OOr6lg+sp1rMmvzB4utICG8CVozEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBXGK+OVZ4n4FfLoBamDZQCKAE+Qb1pWcXibj+Njk4S3205UUjTfonhckAyrGoPx8Z5/sLwNd5yZeUcUUaTqGTi6Fk0ZMsNZR4l9OFLx++oG5y6LxfSfN+CcZkoxYTkO8nEe3JHCDySckkNel1oTUWvGP7plExgG/+G9J2b09k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIZVrLI1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIZVrLI1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785142722; x=1816678722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p4GxXbND5TPyo3OOr6lg+sp1rMmvzB4utICG8CVozEM=;
  b=FIZVrLI11gKoPIva8y0lD912sDktKph9d8mk6oXQ1GjAQLbKQihYT4IG
   1wNDyI2gXKpZ4Nz1NyA6DBzSW9lj1pQn+I/uQ1vz2cHr4WbdnNKWBob2P
   CgudK0WJC93ZgSmi7P4t6pHFlhKHqKiJSkF8yXbI+UqBkPFk6hD1lHgly
   XvVnJ6TjvgWODuupoPq87WxEwQ3wS+/cY4dHQmMbk5YRulVdqFdzTIdim
   g0caRBQo8UCyytGs+jSM1Dc4xE46rtWc6T5P5AkFb5ca0ht+1jskBY18h
   RZqX2teKTckB+IDDNOHca5r3fJD+RWp9E2h0G1yb17aLrJBcmgcrfTBV4
   w==;
X-CSE-ConnectionGUID: 2BIKu84BRJubb0Kw/OaWbA==
X-CSE-MsgGUID: oNKFiD4hSpuCXUqcbK+YIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="97219195"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="97219195"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 01:58:41 -0700
X-CSE-ConnectionGUID: Ukn8GXhCSgmjHJjVv1Wp3w==
X-CSE-MsgGUID: l6CaLv3WT6OdACIcNyQLIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="255040744"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Jul 2026 01:58:35 -0700
Date: Mon, 27 Jul 2026 16:58:33 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
	sumit.semwal@linaro.org, christian.koenig@amd.com,
	pbonzini@redhat.com, seanjc@google.com, alex.williamson@redhat.com,
	dan.j.williams@intel.com, aik@amd.com, linux-coco@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, vivek.kasireddy@intel.com,
	yilun.xu@intel.com, linux-kernel@vger.kernel.org, lukas@wunner.de,
	yan.y.zhao@intel.com, daniel.vetter@ffwll.ch, leon@kernel.org,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	tao1.su@intel.com, linux-pci@vger.kernel.org, zhiw@nvidia.com,
	simona.vetter@ffwll.ch, shameerali.kolothum.thodi@huawei.com,
	aneesh.kumar@kernel.org, iommu@lists.linux.dev,
	kevin.tian@intel.com
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info
 for importers
Message-ID: <amcdueQI1voXWPQb@yilunxu-OptiPlex-7050>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com>
 <20250602133009.GC233377@nvidia.com>
 <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com>
 <20260712221934.GF674038@nvidia.com>
 <CAEvNRgEo2kLUmaGU-Vsgx2sTQvU_NNUJ4bRp5Z4Ygs_xvVLOYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEvNRgEo2kLUmaGU-Vsgx2sTQvU_NNUJ4bRp5Z4Ygs_xvVLOYA@mail.gmail.com>

> > If VFIO can create one

It is an interesting idea to let VFIO create a guest_memfd instance, if
DMABUF doesn't work. But to achieve this goal, I think we still need to
refactor guest_memfd to allow for different memory/MMIO resource
exporters/creators, and different resource importers/users like KVM MMU
& IOMMUFD.

> 
> At guest_memfd creation time, guest_memfd is always created for a
> KVM. This is the first place where it is bound to a kvm instance. This
> is one place where it helps Yilun with Confidential VMs, so KVM can be
> sure that the memory was meant for a specific CoCo kvm and not any VM.
> 
> I think it might be weird to have VFIO take a kvm fd to create a
> guest_memfd?

I think having VFIO create a guest_memfd is better than having KVM
create a guest_memfd on behalf of VFIO.

The lifecycle of the MMIO resources should be managed by VFIO, cause
the availability of these MMIO resouces are impacted by device
operations, e.g., device reset, PCI Memory Space Enable (MSE) ...
You can't export MMIO resources to KVM MMU without VFIO's awareness.

And VFIO doesn't have to take a kvm fd paramter to create a guest_memfd,
VFIO has got the kvm instance via KVM_DEV_VFIO_FILE_ADD.

> 
> I was thinking that the userspace VMM could do something like:
> 
>   int vfio_fd = open("/dev/vfio/devices/vfio0");
>   int gmem_fd = ioctl(KVM_CREATE_GUEST_MEMFD, { .fd = vfio_fd });
