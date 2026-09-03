Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B717325B091;
	Thu,  3 Sep 2026 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400212; cv=none; b=PSMMD9TF7Y5rwU0/GIhc5UfgvXFQva5SeltPOQxbEOXr5FL/Mp9o91U+q26zE5FuyCm/TmlR9F9D1qNnX5Anye2RF3P6OlmOIqkhAt7EN5cR+FEF0dPGZS2EayVCZARc2iAFvaZ9AAfivsYoDAOo4o+JIhq7f11xtTtXV8IsMtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400212; c=relaxed/simple;
	bh=QoRbGvlWRyOigwL0rRuHT2Ilh+UMn/ho/vlrnOml29E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0GrnXp3p+FsQoqMrlRqPcaWV3gIy2vwcVdw3INaSIjbAVmNdSHVhkORM1Yl9DikiRw+BETfWpQPByvM0KQKOLnNmonuNGpQtS/deLfgwY6DYaVsHxEaGD1uXvJRgVnJHF/j0ADjyzpqV6pjcvOrsjjkuD1JAEGX7NsHzkwELgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09585249|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0152336-0.000653306-0.984113;FP=7031228498881406144|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=wanglin@open-hieco.net;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.j3xEdz7_1788400198;
Received: from 172.18.24.170(mailfrom:wanglin@open-hieco.net fp:SMTPD_---.j3xEdz7_1788400198 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 03 Sep 2026 09:49:59 +0800
Message-ID: <20724518-2bf0-40ac-a5a9-1b2fe9df2b0c@open-hieco.net>
Date: Thu, 3 Sep 2026 09:49:58 +0800
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
 <5c6ebbf5-3b3c-47e7-800d-adb4049cd636@open-hieco.net>
 <20260902151340.GAapg9JDQMt2WTkjLM@fat_crate.local>
Content-Language: en-US
From: Lin Wang <wanglin@open-hieco.net>
In-Reply-To: <20260902151340.GAapg9JDQMt2WTkjLM@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/2/2026 11:13 PM, Borislav Petkov wrote:
> On Wed, Sep 02, 2026 at 02:22:13PM +0800, Lin Wang wrote:
>> Please let me know how you would prefer this to be handled.
> 
> Well, X86_FEATURE_ZEN isn't Hygon apparently. Otherwise, we wouldn't be having
> this conversation. And we wouldn't need ugly workarounds like that.
> 
> Which means, you cannot set it on Hygon. Instead, you should check vendor or
> define your own X86_FEATURE_HYGON if you think it would be useful to denote
> common set of features between all Hygon cores.
> 
> Reusing an AMD-specific flag but then having different hardware which needs
> hacks and workarounds to the code is not what you do. Hygon is a different
> vendor and it should be treated as such - not piggyback on AMD code.
> 
> Unless you wanna piggyback. But then you have to extract it properly and make
> it generic so that it can be shared. I have been asking all people submitting
> Hygon code to do that and you are starting to do it but then you need to stick
> to it and do only that.
> 

Hi Boris,

Thanks for clarifying the direction.

My proposed approach is to use explicit vendor checks to make
init_amd_nbs() and amd_smn_init() AMD-only. Hygon node enumeration and
SMN setup would remain in Hygon code.

Sashiko's concern with v3 was that the AMD initializers were restricted
while Hygon call sites remained. However, as currently implemented, the
AMD NB and SMN paths are based on AMD topology assumptions and cannot
provide the Hygon node and SMN mappings.

I would first stop the affected Hygon call sites from entering those AMD
paths, and then make the two initializers AMD-only in the same series.
Later driver support would use the Hygon interfaces.

Would this ordering address the Sashiko concern?

Thanks & Br,

Lin

