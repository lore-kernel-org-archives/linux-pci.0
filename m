Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA34175A6B;
	Wed,  1 Apr 2026 01:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775008518; cv=none; b=GNsFA6iJ9J938RyMha6W+4znAjUAwS/SKr29M86mJNmzp1deGIsIhU7SmV07DSZt+F5ohKAEeD67mtjoS5Oz05BFQJkDC0y8tYgLyaJeOXtPBTdryXBHMuuTh17y1p4SO83qgGrvc5Yj9A26fGffsgXDcckZ3JkmndezDfwtXVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775008518; c=relaxed/simple;
	bh=q50Bz65E+OyJ9vDk1N9jM1vlWen+ne5EUNUrgXUwgJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+xfYYa5Fv7JREk6InJccbjrRUkXhisSpyNwuwFx2q/Tu4A8AdwjXtx+UT5gcvZd4D2cnIhjpU1qZORkxwmPzBoCrEMKsQ4s2CTgZmn+6VClMY4Cx10JwRMYDCqBqZy+HiX1xCEG5BTQ8Gg8o090tW57sN56nTCC0GxVucWwHQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NOWj6NiB; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NOWj6NiB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775008512; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=etQknAdonqm8UWH0ocwzl5DXIHYZ47qOaMPkJRg7jIs=;
	b=NOWj6NiB9lHDbjmZvcCt+/GLnHv+rSKBrXzp+PfSAPpXtI0fcVpYmsaeBt3TLBOZ/rA6g4pbSOZCUT1Dg6BTyo3askrxS9gTzLBdtynHsUV2/GdQi8GdmojM0k8bbIcaZ38ltzpg/M4tSxMB/Vl4vMlI7nx9m7NvGQ+rIT1bkmw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X061LQV_1775008509;
Received: from 30.246.177.235(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X061LQV_1775008509 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 01 Apr 2026 09:55:10 +0800
Message-ID: <32ad70fc-c07e-47c0-8511-fed3bc3fc76f@linux.alibaba.com>
Date: Wed, 1 Apr 2026 09:55:21 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] ACPI: APEI: GHES: Add
 devm_ghes_register_vendor_record_notifier()
To: Kai-Heng Feng <kaihengf@nvidia.com>, rafael@kernel.org
Cc: jonathan.cameron@huawei.com, helgaas@kernel.org, guohanjun@huawei.com,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-hardening@vger.kernel.org, Shiju Jose <shiju.jose@huawei.com>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, Jason Tian <jason@os.amperecomputing.com>
References: <20260330094203.38022-1-kaihengf@nvidia.com>
 <20260330094203.38022-2-kaihengf@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260330094203.38022-2-kaihengf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/30/26 5:41 PM, Kai-Heng Feng wrote:
> Add a device-managed wrapper around ghes_register_vendor_record_notifier()
> so drivers can avoid manual cleanup on device removal or probe failure.
> 
> Cc: Shiju Jose <shiju.jose@huawei.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>

LGTM.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
