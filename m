Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F071E230E;
	Tue,  3 Mar 2026 03:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507933; cv=none; b=WlA2F3JVHnddutQ/etuWYe+V0xPMNsyiPhyoHDr+1zzysmXMqlLrldm/tq5pa187gOF64oBpcCn3dNEo+WNoo9XSDdGYSY/sNNHwsgev8/50yzJPgrEFyVpDuVqUJtpsh2IsUSDMz65mhxB6kHE+UiesD/eHU18g2oBAtv2KA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507933; c=relaxed/simple;
	bh=l923nHARXvxldp8HwLbBb+URjQ2HlXto05e/xD5h+m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1OQGkh0W9fgCVFFs0vJhQjZ+sIicLf1maMbpDrT+IgftVXZ5Uq9y/N3YQZ0FAD9BZJpvsYaD7DMuB85ZddRVy/JCRMp2wjmQoQhyaMPD+i48z+0zEDzaKkbRJc+m2yp78WXFmMAHbymzmtZvokVSRqb27n1kPbt0w0vohmf8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9dgVrvd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9dgVrvd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772507931; x=1804043931;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l923nHARXvxldp8HwLbBb+URjQ2HlXto05e/xD5h+m8=;
  b=H9dgVrvde99pIyBAfutMFjULS+MN67K6L+Q/PC4k4kdG5UcJjDlGGmVU
   eoLIcIgS26nddL302pZUuu2OH2qiI12nc0/kBePp+5X2OaXYl6mIz5YIm
   R4sGMAIBIpOrCNquvsQlKZW8sX+VvERwhav++Vx+9BpNrBV0Qe0uQt/BI
   19e2WZmnoiNrL0WSVjmX/rSh36n4YYsuA36MsM+QnzPatqRVcqfmMkOPo
   P969EuhzC/jqqvZCRdZgRhtIHbkItMpY/V3DGjoPLaOLGOcV9wTeLyqq6
   hqpoteEMVH0KT2JOHmkyQOvRmLLB904s+k1IwTjUFp6xNbVGwQ59GgPps
   w==;
X-CSE-ConnectionGUID: 9eepQ9kNQRWM87xTIXQjEg==
X-CSE-MsgGUID: ZdQJkPAFQFin4f1hDWW5ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="76133323"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="76133323"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 19:18:50 -0800
X-CSE-ConnectionGUID: /tj9ZBAGRyubWi/4mV50Tg==
X-CSE-MsgGUID: 0WZfaMdQTba8MPCUc9GxOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="222839607"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 19:18:46 -0800
Message-ID: <102ceb37-c89d-4bb0-a471-42ccffb40c34@linux.intel.com>
Date: Tue, 3 Mar 2026 11:18:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org,
 robin.murphy@arm.com, bhelgaas@google.com
Cc: joro@8bytes.org, praan@google.com, kevin.tian@intel.com,
 miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dan.j.williams@intel.com,
 jonathan.cameron@huawei.com
References: <cover.1771886695.git.nicolinc@nvidia.com>
 <ad4efe2f85958ee1ab0673a1ceb0db5141852732.1771886695.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ad4efe2f85958ee1ab0673a1ceb0db5141852732.1771886695.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/26 06:52, Nicolin Chen wrote:
> +/**
> + * pci_ats_always_on - Whether the PCI device requires ATS to be always enabled
> + * @pdev: the PCI device
> + *
> + * Returns true, if the PCI device requires non-PASID ATS function on an IOMMU
> + * bypassed configuration.

Including iommu-specific policies and configurations here might cause
confusion. How about making it simply as: "Returns true if the PCI
device requires ATS to be enabled for functional operation"?

> + */
> +bool pci_ats_always_on(struct pci_dev *pdev)
> +{
> +	if (pci_ats_disabled() || !pci_ats_supported(pdev))
> +		return false;
> +
> +	/* A VF inherits its PF's requirement for ATS function */
> +	if (pdev->is_virtfn)
> +		pdev = pci_physfn(pdev);
> +
> +	return pci_cxl_ats_always_on(pdev);
> +}
> +EXPORT_SYMBOL_GPL(pci_ats_always_on);

Thanks,
baolu
