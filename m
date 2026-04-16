Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B749533F595;
	Thu, 16 Apr 2026 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333989; cv=none; b=kTovlieLgtGpBYKFb6AaCNm5P9uc9d5Gj3xEfg7706zpVb5eor4N7w2wk2/0ptK/xUVgpVfKM8H4mDo/mr/arGCEUsZlkgO3VNmUNPVHBb25CEVi+NSLEEmgIdpdJmo6Ve3n0TWsafjggipuvdDygUxR5w4KlWV6HAnay+Z665E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333989; c=relaxed/simple;
	bh=p0z4RKChWVVUpVn9BhJ1DrxOKhLGvqcYvznx1ZQR2r0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+Qdhq+sxUraKpKHAZjGV9aXKVtR+1mUPaVqacmn1tLsz7t192AMnQl03b6526tYHX/S1hayBtCqyi1i6Q+fpiCpxLiDJIaON+UwwN4ZKs0mgQk0nSKRNnZ9zExnNzQhafxG09eR5txLozenQpOwWYR24kfFexp9rqjCGqx8Fi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fxDD369FQzJ46Cy;
	Thu, 16 Apr 2026 18:05:39 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 754D440584;
	Thu, 16 Apr 2026 18:06:24 +0800 (CST)
Received: from localhost (10.123.51.176) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Apr
 2026 11:06:20 +0100
Date: Thu, 16 Apr 2026 11:06:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Sizhe Liu <liusizhe5@huawei.com>, Jie Zhan <zhanjie9@hisilicon.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, <linux-kernel@vger.kernel.org>
CC: <linuxarm@huawei.com>, <linux-pci@vger.kernel.org>, <jic23@kernel.org>,
	Yicong Yang <yangyccccc@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon PCI Trace and Tune
 maintainer
Message-ID: <20260416110619.0000678a@huawei.com>
In-Reply-To: <20260416094219.25258-1-Jonathan.Cameron@huawei.com>
References: <20260416094219.25258-1-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 16 Apr 2026 10:42:19 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Yicong left Huawei a while back so drop both of our entries and add one for
> Sizhe Liu who will be looking after this code going forwards.

+Cc Yicong (Sorry!)

> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1cc0e12fe1f..79efa7b94c9e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11572,8 +11572,7 @@ F:	drivers/perf/hisilicon
>  F:	tools/perf/pmu-events/arch/arm64/hisilicon/
>  
>  HISILICON PTT DRIVER
> -M:	Yicong Yang <yangyicong@hisilicon.com>
> -M:	Jonathan Cameron <jonathan.cameron@huawei.com>
> +M:	Sizhe Liu <liusizhe5@huawei.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt

