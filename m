Received: from out199-9.us.a.mail.aliyun.com (out199-9.us.a.mail.aliyun.com [47.90.199.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C5306480;
	Wed, 11 Feb 2026 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813837; cv=none; b=RJ/oI24uukkgYhYlclSnDduKCoWq0nXXKIVLeVDujixV3o7lJ4w/7XYaR4GqVh0tlLN+FGJDZx7/n3sGNL4iaX3YoTNGnlNwbH0c9B5CfYLPj1at5EplKKVoYyNVHr6YLgwOL9wbn7pqxUzOwv8Njf1CBVS+DXUL8Oqqeanq2tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813837; c=relaxed/simple;
	bh=y0nrnBG3k9zKy5WlqyUc6qofV1OTOt1f0SZ1xl166Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYXgulCMvEoxJ7ww6W7Hon7/tuJKd5XY/gB+4v13q/36JJwG/guhaseeH8FzJ1fcpZ0vl+eJSQ+nxthJs1P3PnYlD615GXqYvKuSB76eL+eJnGH4PGW4ce9bpPKAowTVCqH/46kNrFffuqnCn9cbowYFlQbsoZhhKOofDEQKLNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VPq7exBO; arc=none smtp.client-ip=47.90.199.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VPq7exBO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770813820; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nvF3yViqgBbFiJpVy33G6Z/vQg2LCKK9VFbBDNSQyEY=;
	b=VPq7exBO4wtCMjjiax1PjmXoaUik99/AR2bLaLlh8sM62DP93zicJlBGAtuTlY6Y13xcRsJTXC9aTgO+d0jo1UmA4qFFLgMrsuXiW7qFTlzUQ1icc9K5T0oeQu2rl/hJTocLWpHo2hPQcaehtd7ZEBu1zdkACHIjdgBSJKrApeU=
Received: from 30.246.162.188(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wz1EWUB_1770813818 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Feb 2026 20:43:39 +0800
Message-ID: <c39b7e1f-8a02-459d-b008-2c620fbee462@linux.alibaba.com>
Date: Wed, 11 Feb 2026 20:42:15 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/AER: Only clear error bits in PCIe Device Status
 register
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
 tianruidong@linux.alibaba.com, zhuo.song@linux.alibaba.com,
 oliver.yang@linux.alibaba.com
References: <20260211054816.22758-1-xueshuai@linux.alibaba.com>
 <aYx3Uy7rE6GM9xq-@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aYx3Uy7rE6GM9xq-@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/11/26 8:34 PM, Lukas Wunner wrote:
> Isn't there one too many blanks before each of the PCI_EXP_DEVSTA_* macros?
> 
> The available space would be sufficient to accommodate two macros per line,
> so just 2 instead of 4 lines for the macros.
> 
> Otherwise this is:
> Reviewed-by: Lukas Wunner<lukas@wunner.de>

Sure, will send a new patch to fix it.

Thanks.
Shuai
