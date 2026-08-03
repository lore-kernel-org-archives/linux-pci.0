Received: from lf-2-31.ptr.blmpb.com (lf-2-31.ptr.blmpb.com [101.36.218.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66EB320A00
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785746931; cv=none; b=jT6OtjbCnUljfcmmJsd51eXd84gmTCurz5d25LkKCKbBpxaFesuLYn9grPZ614Q/5c/1gOSMNQQVColBLhxWS8O2zxzmMf3tpVo5sRiGLrAzjcxhQgfziz28ZIjJ+O72J7oSsGwjX4g8TetJwmEqTa90DMLg9lIZP0vW9ErdhgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785746931; c=relaxed/simple;
	bh=kSX58KCvTGAFuFOTtRzzSeQidhAC2nINyQA1cySi9h8=;
	h=Date:Mime-Version:Subject:References:To:Cc:From:Message-Id:
	 Content-Type:In-Reply-To; b=cO3MK5WPoPxeaS7d5XEcTf4ELEHLu03CMABKM4cPp5WFInwoyBVOToeDhaD+fFg4dGHUZM0JguWMRQ27eZ9rGbTy1EOX2f4zr8jW8JYCjA52DVT39p9nzRDiHpBnpF7MQQHffTQXwxWZX8QLCJADjibNWnlVIxE/XpUqRWT+YPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=ftjjkMXY; arc=none smtp.client-ip=101.36.218.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="ftjjkMXY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1785746158; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=itj/eBPzJZkc9AMCGxnABWF3vlOJxKztphvjU+hiksY=;
 b=ftjjkMXYPymcf+ys0eaferh17ZvsUNsFWa5FoEhenqpsiSWadsdl74ouk+1ABowVTkXDtZ
 +aev1kEP1U8irNgkemCxKLUMB5eWINnL8iXjitK4KuGctVhwRmmSFu6O4HJDZkHjfHStlf
 Tp/gv/wksRlPMacghKfSMk1i2S/LqPYIQTXcOtN6PCJ8JX8BMGc7rW91OEt5pfeQdelBNz
 6IrzW0Igs34bRVHL4dF8B97mD+1vGLcNi+pbkjZDbpEpfh2yd5ep2Mf+zQR9MX2at9ZjK5
 6HIpTGsudTjVrw7ktSMkCHIuVRO+j62B0e5k1rrU79bynoATRSGddOeC3wmY6A==
Date: Mon, 3 Aug 2026 16:35:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Language: en-US
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] New vendor support and optimizations for DWC PCIe PMU
References: <20260708084507.98242-1-yang.yicong@picoheart.com> <178551552738.353168.18017558423722059226.b4-ty@kernel.org>
X-Lms-Return-Path: <lba+26a7052ec+5f4c79+vger.kernel.org+yang.yicong@picoheart.com>
Content-Transfer-Encoding: 7bit
To: "Will Deacon" <will@kernel.org>
Cc: <xueshuai@linux.alibaba.com>, <renyu.zj@linux.alibaba.com>, 
	<mark.rutland@arm.com>, <jic23@kernel.org>, <bhelgaas@google.com>, 
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yang.yicong@picoheart.com>, <catalin.marinas@arm.com>, 
	<kernel-team@android.com>, <jingoohan1@gmail.com>, <mani@kernel.org>, 
	<juwenlong@picoheart.com>, <geshijian@picoheart.com>, 
	<douyufan@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Message-Id: <d12e720a-eeb3-4750-9834-949bb82eff47@picoheart.com>
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Received: from [100.86.222.180] ([61.141.241.104]) by smtp.feishu.cn with ESMTPS; Mon, 03 Aug 2026 16:35:55 +0800
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <178551552738.353168.18017558423722059226.b4-ty@kernel.org>

On 8/1/26 7:28 PM, Will Deacon wrote:
> On Wed, 08 Jul 2026 16:45:02 +0800, Yicong Yang wrote:
>> This patchset mainly enable the DWC PCIe PMU on our platform (Patch 1/4).
>> Besides do some optimization and refactor:
>> - Patch 2/4 extend the monitoring limit on platforms with narrowed counter width (< 64 bit)
>> - Patch 3/4 switch the driver to use the faux device interface
>> - Patch 4/4 fix an old issue that PMU may counting when corresponding root port
>>   is runtime suspended.
>>
>> [...]
> 
> Applied first two patches to arm64 (for-next/perf), thanks!
> 
> [1/4] perf/dwc_pcie: Add support for Picoheart vendor devices
>       https://git.kernel.org/arm64/c/cf65b4d765b5
> [2/4] perf/dwc_pcie: Support narrowed time-based counter for long time monitoring
>       https://git.kernel.org/arm64/c/18ec1f543ae1
> 
> I haven't understood what you gain from the third patch. If it's purely
> a dependency for the final patch, then Sashiko has left some comments
> on that one:
> 
> https://lore.kernel.org/all/20260708090109.B20D91F00A3E@smtp.kernel.org/

sure, will have a further check (these are "pre-existing" issues as reported
by sashiko) and respin a new version for patch 3/4. it's a cleanup found
when adding support for our platform. this driver looks to fall into the case
where faux device aims to cover [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/device/faux.h#n6

thanks.
