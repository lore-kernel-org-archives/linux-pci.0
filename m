Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0464D3ACEFB
	for <linux-pci@vger.kernel.org>; Mon,  9 Mar 2026 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074378; cv=none; b=WAsAeTVXWhudtUap4f3BO71Di93k0sS8j4mEuATuMED5EzAdjXlCys1gDbCbDH/mgYHfd48EcekZnJxuiTnIV8h8A0dRgTXzxl0wLNnXf7qx5zIJbFN89QojeaLIEyKY7W02smaNbQ13Fy05q1QKsksLGtTDj6TEFTQuiwvbZ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074378; c=relaxed/simple;
	bh=FX+VIsoijbpo0GepbvW9PBpEBZuJdMM2qFqdqrcpxwU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViZffRo0sIV0UUeKOQ1WiKKM/P+RLqjD+WS6HNEr+N86fz072jYQaecnK8/xrIQvOiuoy/SJrfqKHoDPVTfxjBP39+rdo+OgMe3xtJvoW7ISJDZtwyLZKIxhWgdMyJk5/VjaTCvfUVHbT6YaDLo1BFHMfmWILpLhPOcqSo1US2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fV2lG6NywzJ46Cc;
	Tue, 10 Mar 2026 00:38:50 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A70440585;
	Tue, 10 Mar 2026 00:39:34 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 16:39:33 +0000
Date: Mon, 9 Mar 2026 16:39:32 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <bhelgaas@google.com>, <alistair23@gmail.com>,
	<lukas@wunner.de>, <jgg@nvidia.com>
Subject: Re: [PATCH v2 02/19] device core: Fix kernel-doc warnings in base.h
Message-ID: <20260309163932.000073e4@huawei.com>
In-Reply-To: <20260303000207.1836586-3-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
	<20260303000207.1836586-3-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon,  2 Mar 2026 16:01:50 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for adding new fields to 'struct device_private' fix up
> existing kernel-doc warnings in this header file of the form:
> 
> Warning: drivers/base/base.h:59 struct member 'subsys' not described in
> 'subsys_private'
> Warning: drivers/base/base.h:59 struct member 'devices_kset' not described
> in 'subsys_private'
> Warning: drivers/base/base.h:59 struct member 'interfaces' not described in
> 'subsys_private'
> Warning: drivers/base/base.h:59 struct member 'mutex' not described in
> 'subsys_private'
> 
> ...which are simple replacements of " - " with ": ".
> 
> Add new descriptions for these previously undescribed fields:
> 
> Warning: drivers/base/base.h:58 struct member 'drivers_autoprobe' not
> described in 'subsys_private'
> Warning: drivers/base/base.h:117 struct member 'deferred_probe_reason' not
> described in 'device_private'
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Maybe if the rest looks 'slow' can send this one ahead?

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


Jonathan
