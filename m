Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F3732C8B
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 04:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778042736; cv=none; b=En9oRlYA07s3eIJKN5+ju3z+oYDcE5sZLPvMXm0lN1sk3EzP82ZrsKdfJGy5/4w4Bb/+GLkQcCRgVifOlLdfUYcghMXdynpQ7peov7oI5Bpzx1PSN5pJogAwy5LFV4BA3PE3bB6r60ceeSoCsunBUechGn7V/hEZxdwDW61Yg+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778042736; c=relaxed/simple;
	bh=e5PTFsd7epzKTjMczHik32rf7d6/3JfPeYlW+6Hm+rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mm3FVutOYLepfgPqbj01AMXX1PRej804/h95a1FjYJU7NJqCbDuDyEpQLFAKW10Zl3EpFh9t5LZBf1M44v/zSCyLc9K3JGqbGGPj5i1qc+ITkh84olPB0SQiwyskqDpkxLGaRH1Xpjoxe8YlHkMQ89QC/jFEKGIe3oc1pwWN9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BHiY5MiH; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BHiY5MiH"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778042732; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=e5PTFsd7epzKTjMczHik32rf7d6/3JfPeYlW+6Hm+rs=;
	b=BHiY5MiHQH/H3ihRxjluDdkD7EF6NZ2v0C0zwRXXq5jB01jkwoS5+KH4skjdBck9+lkPWivqduXkhXIjjVMJgRCowCz7b5trKKtfOjnVkJJ0REb6MlqGXeYpPujSGxCzBh8Q4drSLp9414JdKGToLx/IPfGWY2ki9+V5iJpxV2U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X2Kanr-_1778042413;
Received: from 30.178.82.123(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X2Kanr-_1778042413 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 May 2026 12:40:14 +0800
Message-ID: <7194b440-42c0-48fb-a63a-308a85256197@linux.alibaba.com>
Date: Wed, 6 May 2026 12:40:13 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/2] PCI: Introduce named defines for PCI ROM
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Xunlei Pang <xlpang@linux.alibaba.com>,
 oliver.yang@linux.alibaba.com
References: <20260130080729.96152-1-kanie@linux.alibaba.com>
 <20260130080729.96152-2-kanie@linux.alibaba.com>
 <20260502165133.GB1323630@rocinante>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260502165133.GB1323630@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Changed in v12, thanks.

Best Regards,
Guixin Liu

在 2026/5/3 00:55, Krzysztof Wilczyński 写道:
> Reviewed-by: Krzysztof Wilczyński<kwilczynski@kernel.org>

