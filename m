Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D19EACD
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522164; cv=none; b=C+midxHhmJBUDnHhdKMP5K9BwR0fbiGdlJauasVe3/ynZH+c6QFlOnBrdr4sgIl0K7UgFzCzy4ifoqUEvilUKdlxeSInNouDc6PIGJUBxx/RGxPQXBPgmsl1o3lR3CHhlYRf5CcT2ORWJWNeUuZuxHACH+QPRX5MQspl7wI+VxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522164; c=relaxed/simple;
	bh=nN2Qu9GFnQ1o9H3knQtLTAOj/0kAFAK30myHIyuh+V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbUOyuINY/zO+Y8pnV4qmY5EMHBJBTgpTVzEuDCqrkH/exp9wLXqpfIqDFAxl476MvqmoNEwCdYQDuJAJBPLZaEpk2wg5Of0jNu2gvoV4wzK04T/VqtSgsSkg9qB8zv3nHDh4CvvKS5anR+jWz2p1frSXpJF10QTBxkbIYRG5w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5YgUf2/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5YgUf2/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772522162; x=1804058162;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nN2Qu9GFnQ1o9H3knQtLTAOj/0kAFAK30myHIyuh+V8=;
  b=B5YgUf2/CB3AkD/5fxQTWCKSVslP0RdUbk3REF0TW4Sywky/sOfGxXwq
   DG02KQqP1PROnsatESqnRx70z0OzYWzKxnZZh1tWBvIjR8kotIAJgCXmF
   Xvsj1yp929vEZ84MKcGSCF3LEUDwqf5+4DtZsTCX4cOYh3YCcOwrq2GNB
   S/Dt9IX8WB8aZkncjzD8al+7KPtKQPQiIP6ZGI0drFx1EtmlBb0EhuSYT
   UkNNJU6wl3N+Q+KwOC6RWRzdOL6kjC7BbdHHDpHhP0pYeMLdoUTMneWqW
   kISFmHz0pxpzpMBO4ionEQ+v8SorLq1KrgbjbbbGAZI7YH3+1iF4eX/0D
   w==;
X-CSE-ConnectionGUID: rJd7l1fMTgOjjK0WuWFXFQ==
X-CSE-MsgGUID: rlnoYyEnQ+if1shAVLwBbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73456088"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73456088"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 23:16:02 -0800
X-CSE-ConnectionGUID: Iaq3mFzLSwGaaiccQc851g==
X-CSE-MsgGUID: NRR6nqt1Rq+ekJ2VKEz8SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="217897252"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 23:15:59 -0800
Message-ID: <e6e1b542-332f-407c-b997-244b5d475276@linux.intel.com>
Date: Tue, 3 Mar 2026 15:15:22 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/19] PCI/TSM: Add Device Security (TVM Guest) ACCEPT
 operation support
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
 yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
 lukas@wunner.de, jgg@nvidia.com
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-8-dan.j.williams@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260303000207.1836586-8-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/26 08:01, Dan Williams wrote:
> The final operation of the PCIe Trusted Execution Environment (TEE) Device
> Interface Security Protocol (TDISP) is asking the TEE Security Manager
> (TEE) to enable private DMA and MMIO.
> 
> The story so far in the security lifecycle of the device is that the VMM
> setup an SPDM session and link encryption with the device's physical
> function0. The VMM then assigned either that physical function or other
> virtual function of that device to a VM. The VM asked the TSM to transition
> the device from TDISP UNLOCKED->LOCKED. With the device LOCKED the VM
> validated signed fresh device evidence and expected MMIO mappings.
> 
> The VM now accepts the device to transition it from LOCKED to RUN and tell
> the TSM to unblock DMA to VM private memory.
> 
> Implement a sysfs trigger to flip the device to private operation and plumb
> that to a 'struct pci_tsm_ops::accept()' operation.
> 
> Co-developed-by: Xu Yilun<yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun<yilun.xu@linux.intel.com>
> Co-developed-by: Aneesh Kumar K.V (Arm)<aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V (Arm)<aneesh.kumar@kernel.org>
> Signed-off-by: Dan Williams<dan.j.williams@intel.com>
> ---
>   drivers/pci/Kconfig                     |  2 +
>   Documentation/ABI/testing/sysfs-bus-pci | 13 +++++
>   include/linux/pci-tsm.h                 |  7 ++-
>   drivers/pci/tsm.c                       | 69 ++++++++++++++++++++++++-
>   4 files changed, 88 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index e3f848ffb52a..c45c6b978e1d 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -127,6 +127,8 @@ config PCI_IDE
>   
>   config PCI_TSM
>   	bool "PCI TSM: Device security protocol support"
> +	depends on ARCH_HAS_CC_PLATFORM
> +	select CONFIDENTIAL_DEVICES
>   	select PCI_IDE
>   	select PCI_DOE
>   	select TSM
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 1ed77b9402a6..c2a5c4fe9373 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -732,3 +732,16 @@ Description:
>   		'lock' to teardown the connection. Writes fail with EBUSY if
>   		this device is bound to a driver. This is a "devsec" TSM
>   		attribute, see Documentation/ABI/testing/sysfs-class-tsm.
> +
> +What:		/sys/bus/pci/devices/.../tsm/accept
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) Write "1" (or any boolean "true" string) to this file to
> +		request that TSM transition the device from the TDISP LOCKED
> +		state to the RUN state and arrange the for the secure IOMMU to

Nit: remove the typo extra 'the'

"...and arrange for the secure IOMMU to..."

> +		accept requests with T=1 in the PCIe packet header (TLP)
> +		targeting private memory. Per TDISP the only exits from the RUN
> +		state are via an explicit unlock request or an event that
> +		transitions the device to the ERROR state. Writes fail with
> +		EBUSY if this device is bound to a driver. This is a "devsec"
> +		TSM attribute, see Documentation/ABI/testing/sysfs-class-tsm.

Thanks,
baolu
