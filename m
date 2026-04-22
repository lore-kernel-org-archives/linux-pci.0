Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289337C0F2;
	Wed, 22 Apr 2026 02:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776825063; cv=none; b=g1SBiRSCyaaBcYqeQUxMVJvQtB62gBdTW3mu+nEA9Q9uVcP5WZKer8Xnba7vh/Jjnnxvuk+x1p+gX494oUEXZHM6HbPqbY5v83IDdHvOfTpdXOGOu8HwyY+yHLzbFInAwFbWxyjSQ7YFY8DRNqRTw/BzRRRDVmidOm1Vubgli6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776825063; c=relaxed/simple;
	bh=JPATYPYGBBQUUf/BoeEEX3QmLyl6F9JR/HmuQFXzMh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gifg6X91gI2rLYJnMUk8HKSN1RBy0oahF1En0mvqZ3DjaWKop1I41BdWlGS3b5aK0479OON2mnUQAr0/dxKIJMdfvXYp0FdG+3qZhSFieAbtsH/wQtGWfmrRTQLrRw/frc1smKaEdSoeKstOhUZCeE4KYocREfI/SphlUJFw/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2+LHgl2Q; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2+LHgl2Q"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=v2mK18BsBvPSTONwESQ4nMackEaR4Y/ypyIV3y1RQtU=;
	b=2+LHgl2Qe4H/GGbyis4Zht4mDEyLFzVfHnocxmvfUc4Iy9RTTuabOzufPzwlxgZwAE1/D61/i
	/Its62ETzhsGLYI7c7Uv8L4IQXtJIDjCLikS+e1c8Bv+h98jEpwWWUVt4nAwpA7owbFQ9SprKf0
	aR1W9FHLMW/485f5zFRj878=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4g0jhy06yzz1K99M;
	Wed, 22 Apr 2026 10:24:18 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B16B40573;
	Wed, 22 Apr 2026 10:30:38 +0800 (CST)
Received: from kwepemn200012.china.huawei.com (7.202.194.135) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Apr 2026 10:30:38 +0800
Received: from [10.67.120.233] (10.67.120.233) by
 kwepemn200012.china.huawei.com (7.202.194.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Apr 2026 10:30:37 +0800
Message-ID: <5ddede9a-7062-42cc-a224-b0dde3f95e2c@huawei.com>
Date: Wed, 22 Apr 2026 10:30:37 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon PCI Trace and Tune
 maintainer
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jie Zhan
	<zhanjie9@hisilicon.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
CC: <linuxarm@huawei.com>, <linux-pci@vger.kernel.org>, <jic23@kernel.org>,
	Yicong Yang <yangyccccc@gmail.com>
References: <20260416094219.25258-1-Jonathan.Cameron@huawei.com>
From: Sizhe Liu <liusizhe5@huawei.com>
In-Reply-To: <20260416094219.25258-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn200012.china.huawei.com (7.202.194.135)


On 2026/4/16 17:42, Jonathan Cameron wrote:
> Yicong left Huawei a while back so drop both of our entries and add one for
> Sizhe Liu who will be looking after this code going forwards.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Sorry for getting back to this late. Thanks a lot for your efforts!

Acked-by: Sizhe Liu <liusizhe5@huawei.com>
> ---
>   MAINTAINERS | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1cc0e12fe1f..79efa7b94c9e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11572,8 +11572,7 @@ F:	drivers/perf/hisilicon
>   F:	tools/perf/pmu-events/arch/arm64/hisilicon/
>   
>   HISILICON PTT DRIVER
> -M:	Yicong Yang <yangyicong@hisilicon.com>
> -M:	Jonathan Cameron <jonathan.cameron@huawei.com>
> +M:	Sizhe Liu <liusizhe5@huawei.com>
>   L:	linux-kernel@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
