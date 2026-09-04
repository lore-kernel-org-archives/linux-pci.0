Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com [115.124.28.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED3138F24C;
	Fri,  4 Sep 2026 02:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490129; cv=none; b=CoydtFlgPK5kYMTfZ4yfn4wsmku4+fI7uvcxerrh/WiyIkKH3gSyHmJp0+3VFmZHf+molhTfcJVhn4VWhB4bjT6Yp4KXeCIJHEtRUktYT9F8XUZHqQznvadfXKBQWNdf1Rlz+aP5WHKuoo1n5734TfLyqeIUfdqr8MBzh0rudzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490129; c=relaxed/simple;
	bh=fSVst5CLOg8+tZZvSn+RiQKAlQOOvcxHa+MiFYD+4mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnSi5msBrivNsJLFjfsWlGX8hHywy+60bA4G2cz9P9lcXenzalwzMsObpIf1ufIhSSAP9jI3kbvV6SHWPEqWh2drJLoVB/lQf4p/xqp5z61q9GLVrHuUA4m5OAXU/V7B6vq04T53l1IEbo4kCaANyN8yQRVqnav/SQWqcgI2ipQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07467782|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.020564-0.000552926-0.978883;FP=7030525099344127367|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=wanglin@open-hieco.net;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.j51KLzw_1788489801;
Received: from 172.18.24.170(mailfrom:wanglin@open-hieco.net fp:SMTPD_---.j51KLzw_1788489801 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 04 Sep 2026 10:43:22 +0800
Message-ID: <463f4811-344e-4540-bf72-33cc99008f6f@open-hieco.net>
Date: Fri, 4 Sep 2026 10:43:21 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] x86/amd_node: Skip SMN setup on Hygon Fam18h
 models 0x04-0x08
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, mario.limonciello@amd.com,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 "H. Peter Anvin" <hpa@zytor.com>, bhelgaas@google.com, x86@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260901071700.3255382-1-wanglin@open-hieco.net>
 <20260901071700.3255382-5-wanglin@open-hieco.net>
 <20260902024833.GJapeOgRJ50RAZvI3e@fat_crate.local>
 <5c6ebbf5-3b3c-47e7-800d-adb4049cd636@open-hieco.net>
 <20260902151340.GAapg9JDQMt2WTkjLM@fat_crate.local>
 <20724518-2bf0-40ac-a5a9-1b2fe9df2b0c@open-hieco.net>
 <20260903173444.GA27025@yaz-khff2.amd.com>
Content-Language: en-US
From: Lin Wang <wanglin@open-hieco.net>
In-Reply-To: <20260903173444.GA27025@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yazen,

Thanks for your feedback!

On 9/4/2026 1:34 AM, Yazen Ghannam wrote:
> On Thu, Sep 03, 2026 at 09:49:58AM +0800, Lin Wang wrote:
>>
>> My proposed approach is to use explicit vendor checks to make
>> init_amd_nbs() and amd_smn_init() AMD-only. Hygon node enumeration and
>> SMN setup would remain in Hygon code.
>>
>> Sashiko's concern with v3 was that the AMD initializers were restricted
>> while Hygon call sites remained. However, as currently implemented, the
>> AMD NB and SMN paths are based on AMD topology assumptions and cannot
>> provide the Hygon node and SMN mappings.
>>
> 
> The "vendor != HYGON" restriction would be fair.
> 
> I don't understand how the "model-specific" restriction is better.
> Wouldn't it cause similar problems?

It was intended only to limit the scope of the change and address the
Sashiko finding, but it does not provide the AMD SMN code with a valid
Hygon node-to-root mapping. I will drop the model-specific check.

> 
>> I would first stop the affected Hygon call sites from entering those AMD
>> paths, and then make the two initializers AMD-only in the same series.
>> Later driver support would use the Hygon interfaces.
>>
>> Would this ordering address the Sashiko concern?
>>
> 
> Right, so first you provide a Hygon-only option for all affected call
> sites. Then you add the vendor check. This ensures that the affected
> callers don't break in the middle of the patch series.
> 
> Is this your intent?

Not quite. By stopping the affected call sites, I meant removing the
Hygon match entries from the drivers which currently route them through
the AMD NB or SMN mapping. I did not mean adding complete Hygon EDAC,
ATL and k10temp support in this series. These paths do not provide
usable Hygon support with the current AMD node mapping.

Those implementations depend on the Hygon node and SMN interfaces. The
intended order is:

   1. add the Hygon node interfaces;
   2. stop the affected Hygon drivers from entering the AMD paths;
   3. make AMD NB and SMN initialization AMD-only;
   4. add the Hygon SMN implementation.

EDAC, ATL and temperature monitoring support can then be submitted
separately using the Hygon interfaces. This ordering addresses the v3
Sashiko concern without making those drivers a prerequisite for the
node layer.

> 
> Regarding the Zen feature flag, I think it may be overloaded.
> 
> Hygon systems are Zen systems. The same Zen1 architecture was used
> orginally, though I don't know how much things have diverged since then.
> 
> All Hygon systems are Zen systems, but not all AMD systems are Zen
> systems.
> 
> So we have three diverging Platforms:
> 1) AMD legacy (Northbridge / !Zen)
> 2) AMD modern (Zen)
> 3) Hygon (Zen by default)
> 
> (2) and (3) where the same until recently.
> 
> Maybe we define new feature flags that indicate a Platform/Interconnect
> group? That way we won't need to rely on PCI IDs or vendor+core
> combinations.

I agree that X86_FEATURE_ZEN describes the core architecture and should
not be used to select an interconnect implementation. A separate
interconnect capability may be useful, but defining it and converting
its users would be broader than this node series. For this series, I
would prefer to use explicit vendor checks and keep the interconnect
capability work separate.

That is the ordering I intended.

Thanks & Br;

Lin
> 
> FYI, that was the intent to use the Zen feature flag here. It was a way
> to distinguish (1) and (2/3) above. It worked until it didn't. :)
> 
> Thanks,
> Yazen

