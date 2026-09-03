Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B4B344D8C
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788407655; cv=none; b=OcN4trXHipuc8jCfpyOOU5JKKautmLvMHEtWpHkQZXnBo3wqak/yj7Kjw6456PqVTGVKt5biUBvjZz1aJzIYknoIomVvwP7JhboCrixMd4qTKcTErGfNXK7vC/jAB+9bhGCYt6uZuKBYK0fbgnsANbRF7P8jE9lZ3XXt54tZT4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788407655; c=relaxed/simple;
	bh=erRZVfuUtGJEgWTPkI64yhDjJXlDe+LSjk/PBCgLNJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Y0sHvcd5k3cnA7B5Ppf8LBH7WIq1Tmc2TC6WfyQPJAGvHQOe7tXQ3+DJRHt3akQqhUHQXSp6W9QfcS8+R837Q90q16Zk88jmMiPQPZZd35I6VOsa6I3AQms3USKb2Tt8BVRXr4lAb5psdYb21FZ4wQb1QkQx7gXC/NZ5+508d4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SI4oawgm; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SI4oawgm"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260903035405epoutp048fd31bb2ca3370656bab7b52e6bb1183~Rs0cdD3wD0062200622epoutp04N
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 03:54:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260903035405epoutp048fd31bb2ca3370656bab7b52e6bb1183~Rs0cdD3wD0062200622epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1788407645;
	bh=B8tbjwBOcBwbo7WUdq9N5fHu3+dIuQg5wpIJwvIKQF4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=SI4oawgmft8hL+Hw9jiYOiMvmIKNfNQtY+5jcM9235JZmV4jE8ODVKux07NBeQE1u
	 V7WZ72NZ3JTS/ngZ1YDcolxNM6WXWZBCnBPUreGoQAqTY38lGlzX4qjvb2QLygxP67
	 8rOGofTGGWcbdCU065YwLRm9ixOJhvNa7pe/XEAo=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260903035404epcas5p1db13b36a6a20e4771cd89bcab103d40f~Rs0cJ3Ysg2259322593epcas5p1U;
	Thu,  3 Sep 2026 03:54:04 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.91]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4hb5Lg5Lwzz2SSKf; Thu,  3 Sep
	2026 03:54:03 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260903035403epcas5p403f8582851032b5e276ccbb7cc499614~Rs0a1sFkC1883318833epcas5p42;
	Thu,  3 Sep 2026 03:54:03 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260903035400epsmtip28937a2084801fdcafaf19ee58cf9d139~Rs0X0Mu-42016520165epsmtip2r;
	Thu,  3 Sep 2026 03:53:59 +0000 (GMT)
Message-ID: <bc7c089c-9357-448f-b6d4-fbc72b7e3c6c@samsung.com>
Date: Thu, 3 Sep 2026 09:23:52 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme-pci: fix CMB mapping when CMBSZ Size field is
 zero
To: kangfenglong <kangfenglong@huawei.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	liuyonglong@huawei.com, seven.wangyu@huawei.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260622024129.40800-1-kangfenglong@huawei.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260903035403epcas5p403f8582851032b5e276ccbb7cc499614
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260622031353epcas5p20f6585c6c8c9b2753e6884d99fe6670a
References: <CGME20260622031353epcas5p20f6585c6c8c9b2753e6884d99fe6670a@epcas5p2.samsung.com>
	<20260622024129.40800-1-kangfenglong@huawei.com>

On 6/22/2026 8:11 AM, kangfenglong wrote:
>   static void nvme_map_cmb(struct nvme_dev *dev)
>   {
> -	u64 size, offset;
> +	u64 size, unit_size, offset;
>   	resource_size_t bar_size;
>   	struct pci_dev *pdev = to_pci_dev(dev->dev);
>   	int bar;
> @@ -2472,9 +2475,15 @@ static void nvme_map_cmb(struct nvme_dev *dev)
>   	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
>   	if (!dev->cmbsz)
>   		return;
> +	if (!nvme_cmb_size(dev))
> +		return;
>   	dev->cmbloc = readl(dev->bar + NVME_REG_CMBLOC);
>   
> -	size = nvme_cmb_size_unit(dev) * nvme_cmb_size(dev);
> +	unit_size = nvme_cmb_size_unit(dev);
> +	if (!unit_size)
> +		return;
> +	if (check_mul_overflow(unit_size, nvme_cmb_size(dev), &size))
> +		return;
>   	offset = nvme_cmb_size_unit(dev) * NVME_CMB_OFST(dev->cmbloc);

nit: now unit_size can be used in this line.

With that, LGTM.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>


