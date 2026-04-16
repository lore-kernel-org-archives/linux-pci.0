Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9269C37C91A;
	Thu, 16 Apr 2026 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776337955; cv=none; b=FqlPr4LRsDpRZPMFSv5TWyIsp7b5iRSlbumpyC3QmIJ8px80N6dsYZD7oNXcJnDNlW9HmJmPrrB9P9CB+LeBX57NmttOg1guh2jd8zi20uxzOpXmGL7kMe6ioPWHbj7deDHR7Kl39vlwtt/MCmJTzyUI36sz2ytFKbkEwmRg2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776337955; c=relaxed/simple;
	bh=nbLJ0hRyR386N9wS7V1IsU0OIHbb4pNOyPjkoLl6+jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n0hpMYlTcOwuQgNaNYJxN7p3xdQ0GbUNqm6xqhAf0AFxUkLCSv4If/tP7WSt98LxY0k0y1icoXWzkAWmDx88owDmcl2rZ44ZnQqr+Ml9o5yS30xqgRAq3u7bA4uPonmpL8R1xdPQz5P0FCre6lTb6nvIb0d+A1K1CgAvoJ2TkFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fxFZC3xs8z1T4Hx;
	Thu, 16 Apr 2026 19:06:27 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id ADD1940538;
	Thu, 16 Apr 2026 19:12:29 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Apr
 2026 19:12:29 +0800
Message-ID: <522393d1-084d-437c-9349-561cdf43c947@hisilicon.com>
Date: Thu, 16 Apr 2026 19:12:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon PCI Trace and Tune
 maintainer
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sizhe Liu
	<liusizhe5@huawei.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, <linux-kernel@vger.kernel.org>
CC: <linuxarm@huawei.com>, <linux-pci@vger.kernel.org>, <jic23@kernel.org>,
	<yangyccccc@gmail.com>, <yang.yicong@picoheart.com>
References: <20260416094219.25258-1-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260416094219.25258-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 4/16/2026 5:42 PM, Jonathan Cameron wrote:
> Yicong left Huawei a while back so drop both of our entries and add one for
> Sizhe Liu who will be looking after this code going forwards.
Thanks for all the great work (to Yicong as well)!

Acked-by: Jie Zhan <zhanjie9@hisilicon.com>
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
