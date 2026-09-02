Received: from out198-21.us.a.mail.aliyun.com (out198-21.us.a.mail.aliyun.com [47.90.198.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BDD243956;
	Wed,  2 Sep 2026 06:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330159; cv=none; b=AqwEeFPY8P1eOcMdP5kM25wfMELvgm3ad4I8AiZYr4fSLWDL7Xhy8amEswsAfDW++bx56AvJiGrMnIDqCjg7Ii7yU4ZB4qNLLDhoyueyzaElGCjtWwJXBoU91b95xvY/Ccai5b6DuqFSa+Cnztc1JKC4jCtarzoEQcLF9UUFzVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330159; c=relaxed/simple;
	bh=dXEcfhD5yDg66IOIu9KvXrOCJWfxnipSzTXzf/cCccU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BK9juI8UATt/ABM/jVXSZh+qGcGGOHsbcAGo1KHCJcmf/sfqzJsv4LFb0c+p+aWMhm9haPHK7D3xECFYa905xjGv7ofSRmVSKcdKZUxR0MoiNrUkib8igayhfusCwT2SPVVjZaEZiaXEIZfEXMxx6tSXp0odhbuTmsRa02DC9Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08171883|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.00775139-0.00178939-0.990459;FP=6992961113209668745|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=wanglin@open-hieco.net;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.j3B4ChJ_1788330133;
Received: from 172.18.24.170(mailfrom:wanglin@open-hieco.net fp:SMTPD_---.j3B4ChJ_1788330133 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 02 Sep 2026 14:22:14 +0800
Message-ID: <5c6ebbf5-3b3c-47e7-800d-adb4049cd636@open-hieco.net>
Date: Wed, 2 Sep 2026 14:22:13 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] x86/amd_node: Skip SMN setup on Hygon Fam18h
 models 0x04-0x08
To: Borislav Petkov <bp@alien8.de>
Cc: yazen.ghannam@amd.com, mario.limonciello@amd.com, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, "H. Peter Anvin"
 <hpa@zytor.com>, bhelgaas@google.com, x86@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260901071700.3255382-1-wanglin@open-hieco.net>
 <20260901071700.3255382-5-wanglin@open-hieco.net>
 <20260902024833.GJapeOgRJ50RAZvI3e@fat_crate.local>
Content-Language: en-US
From: Lin Wang <wanglin@open-hieco.net>
In-Reply-To: <20260902024833.GJapeOgRJ50RAZvI3e@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/2/2026 10:48 AM, Borislav Petkov wrote:
> On Tue, Sep 01, 2026 at 03:16:59PM +0800, Lin Wang wrote:
>> @@ -252,6 +252,18 @@ static int __init amd_smn_init(void)
>>   	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
> 
> This driver should exit on Hygon right here.
> 
> Why doesn't it do that?
> 
> I know why - you set X86_FEATURE_ZEN.
> 
> Why?
> 
> What do you really need it for?
> 

Hi Boris,

Thanks for pointing this out.

X86_FEATURE_ZEN has been set in init_hygon() since the initial Hygon
CPU support. I knew that it made amd_smn_init() run on Hygon, but I
treated it as part of the existing CPU setup and did not revisit
whether Hygon still needed it.

However, removing it would change other existing code paths that use
this feature. That would need a separate audit and hardware testing,
which I did not do for this series. I am therefore not sure that
changing the CPU capability here only to avoid an explicit Hygon check
in the SMN code would be safe.

Please let me know how you would prefer this to be handled.

Thanks & Br;

Lin
