Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5A73B27EC;
	Fri,  4 Sep 2026 06:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503198; cv=none; b=I02Eni7y5BuD0kxu+BQnLimYBi+Be1RB3PW9Mp2eCrDocRqHrhXSEUOXVIpqlHoFpsXgfaQhIm4ZM5Yp2/ok+4NaJuyV9c/wSHftEgN9/xRbZrEvnLXKMsdLBv/EnFP6aFQIqZUxbArzJz44zTD0wV17DmpqMfr7TPeDK5yDfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503198; c=relaxed/simple;
	bh=BxMXIpZz9wsp1/vpguoIltklk1+eE7nlnNS75MwA0os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=khuTsi2yNHF9iY9dm51PoI1wX7aMqEzt/z6/tKUMF0ZWZxy8lcCwITKBFRHRCwMkirajC0ghDqQVU1fvwbZvixLglSuwvx96RSrt1ItYCJ5LP8pEV1nmJAh504+YOE4kuuObeTwQ2C6lsV0ZTMESEZSWq39V9f3fqaPC1TusyJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08191093|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0190986-0.000809966-0.980091;FP=16253900164169565509|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=wanglin@open-hieco.net;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.j5HZlil_1788503183;
Received: from 172.18.24.170(mailfrom:wanglin@open-hieco.net fp:SMTPD_---.j5HZlil_1788503183 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 04 Sep 2026 14:26:24 +0800
Message-ID: <0323b9fd-ace5-4a59-ae6e-22746f5bf3a3@open-hieco.net>
Date: Fri, 4 Sep 2026 14:26:23 +0800
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
 <20724518-2bf0-40ac-a5a9-1b2fe9df2b0c@open-hieco.net>
 <20260904053641.GDappY6bdy4hAwyxaK@fat_crate.local>
Content-Language: en-US
From: Lin Wang <wanglin@open-hieco.net>
In-Reply-To: <20260904053641.GDappY6bdy4hAwyxaK@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/2026 1:36 PM, Borislav Petkov wrote:
>> Would this ordering address the Sashiko concern?
> This should address my concerns - we can then see what Sashiko complains
> about and sanity-check it.
> 
> And I explained it already - you basically carve out/split/separate Hygon
> paths from AMD paths and you basically forget X86_FEATURE_ZEN. I don't care if
> Zen and Hygon systems are/were the same or almost the same.
> 
> Obviously they will start diverging so you can carve out Hygon-specific pieces
> now and then keep adding new functionality to them. Just as if this is
> a completely different x86 CPU.
> 
> This way, the code is untangled from the very beginning and there won't be any
> ugly and unmaintainable
> 
> 	if (vendor)
> 
> sprinkling all over the x86 AMD code where neither you nor we will be happy
> about going forward.
> 

Hi Boris,

Thanks, this is clear.

I understand that Hygon should use its own node and SMN implementation
rather than adding Hygon-specific handling to the AMD paths. I will
follow this separation in v5 and in the later driver support.

My concern was how to address the Sashiko finding without making the
later Hygon driver support a prerequisite for the node layer. This
ordering resolves that concern.

For v5, I will remove the existing Hygon matches which rely on the AMD
NB or SMN implementation before making those initializers AMD-only.

Thanks & Br,

Lin

