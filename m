Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B13369D57
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369006; cv=none; b=mivvW4WyIpmXOp7NCx+olUatcw/8dklu7zb54OugubgIScRBC4zta86JSMHRYk3QTYZ8wiqbIDm2GwRSzhiLdlOGvBQYiaNz82o7XWdDGW1pY2uUZ/hq2Ln9isZNreQjZPRYuxfprZY7wN4RyELKMZbb1q6ncbETY96+YHovnls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369006; c=relaxed/simple;
	bh=4V7tt6XLw4V4umfg1+RDtii6Iv2mhc7bGilN2zhZNdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCRgkKpnn8EfqgENzKLq0taSBmsRONItpb+N6et9IrBavyyrNkKviJlQM9x+nNZF4efFclI1GSi9rhfQoQJ2ey/0kc2D/0/jTYBZ+6X46xaFO5Atd1qsqorqGsKazBKhSFTdQEQuqokSSqtdhnrkA3LpvquSgmFvG5Ym0nq3Pho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=plGpfuZ5; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plGpfuZ5"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a68ab90eb8so1712930a12.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 10:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788369003; x=1788973803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=28+B5GlJLp4gFsP3ptN/fGqKS5qZmDeIbhky9qWb7ys=;
        b=plGpfuZ5gJSFK2j8QsyiTz/5M2l/1JKHLMNwg9RXbp0WYYnPwYYXX0gmzKT95PJ8CF
         Vr7ffM8WmO+rT2vtqdAsDf1MFzI96lKiWQoE3V+sLXe/WLTOJClsEchnMrc+ATCdqIJa
         ah6sROlW7RqjaQ0ozHfiILNZuHqxrVzeMC/9BOIoWFKsXvq+Mh4TerTZ/kqelHz0wVyZ
         kusoXLNirw9iF3G7YcgumbITtvc1vaAY9UJiwlhq6rqbgdfLZJxZcOIuiURkfbrPl8qc
         F4j40VSfNVpu/vGMOBsJE0VNNCyHZnOJ0Pl726xOxMJGLHdz8RN76SBvl1uY0zwPw4oC
         YmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788369003; x=1788973803;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=28+B5GlJLp4gFsP3ptN/fGqKS5qZmDeIbhky9qWb7ys=;
        b=VBbAK51BrES6V9Irax7AAWBemg+pnNaMP8pDDaozCOrIh7zKJGhQ6jKquZcZyxx2Kx
         mzKOi/doehl2yajQggrkT779lYyFTDm4Vt2lREJ9AXiVyM6zOOqNFEvKG4LDBvGBHgop
         wEOJdDMKEjkojg0k9O/8K+gQjKZCzYpV3zrxSPV0w2OuXpFrx3Hfksp12SrWm28e1wu2
         GA1/qPFYD7S8qxQ3ez2LFpFTANO+cwBzTL/wE86whpU+AZOhfkxWeGgIhc04qDNwAcKD
         Q+R8jm47SgD6DpsrqDFvvlI+daHcCWwLBqCU3cTRRS0vHeRnsAGQ2qiEtDqekMyvkmvo
         8ErA==
X-Forwarded-Encrypted: i=1; AKwUvBxAaZ9K0w9+X/JceN+bZfKQLzB71yAGFsJ6w7c+afFUS+d6XFjP3uaxkKiD65XN3HtFKX8WF1eXRD8=@vger.kernel.org
X-Gm-Message-State: AFuF++lAx9nX2bfUGpcAHg96PHh9VydDvfT1GHfPQGsfINnum2z3is4Z
	Ck3+yYi/IBld+tWROi4oMi3oYTC6WV9poLB+k79HgIpS4w6t9MGhd2vw
X-Gm-Gg: AYBFou0DGen4MdXHNgWvTk4BADsEe1dRpFbSVzJE/xoqUqxt96oNeckg6lt4ZdwgG0F
	G8RPxEriT4XK1h2f37HoqXkqa1hOllj0G+EmXd3/gGFLzjfFCBp2wvpS0Rv6gGTZsep1tXoiB+w
	bVUsjUqyMc5JKgQyuDYszMAsj8taW0LPWQxTpnFbG28JjbrlhZd4avQ2nLqn5dsa+SciD8KgPoa
	eJW7iCItxcWl/SP7Onr9gLH1R1AMWmuEpU60S4sy817w1dw8ABp5jY7Mzm32HSCJFhgBrAb4NmZ
	/Y/4P/2ZSKJOzPLsv/JNKsdVvAADQhLtHS+IGMLBAff90JUMD/lgWGYOrvY9vzUPzJsznjJKmU2
	OVvce979izN+COOOHK8FYCbr2N18k+UMSkfchpyZG7UByWZGPzlvmWQqbhPJKeuyvX0NTlSSLvF
	feiUZafdk2y35TCMlnqYGA3tPYpnsT5u7tNvsN3E8roc7+lfq/0QC0ytB5r/Rjc+qYbDBWLQ==
X-Received: by 2002:a05:6402:4382:b0:6a1:7825:5230 with SMTP id 4fb4d7f45d1cf-6a68289ce4dmr4714838a12.16.1788369002421;
        Wed, 02 Sep 2026 10:10:02 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f895f29sm1513137a12.2.2026.09.02.10.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 10:10:01 -0700 (PDT)
Message-ID: <3eeb3465-a1e6-4fdc-8019-3907d9c55691@gmail.com>
Date: Wed, 2 Sep 2026 19:09:58 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Allow D3 for native Hotplug capable Root Ports on
 non-x86 platforms
To: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, mani@kernel.org
References: <20260811232245.GA805297@bhelgaas>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <20260811232245.GA805297@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 1:22 AM, Bjorn Helgaas wrote:
> On Wed, Jul 29, 2026 at 06:50:05PM +0200, Manivannan Sadhasivam wrote:
>> Commit eb3b5bf1a88d ("PCI: Whitelist native hotplug ports for runtime D3"),
>> prevented native Hotplug capable Root Ports from entering D3 citing issues
>> on old Intel SkyLake Xeon-SP platform.
>>
>> But there is no reason to restrict D3 for native Hotplug capable Root
>> Ports on non-x86 platforms. We recently enabled D3 on non-Hotplug capable
>> Root Ports on non-x86 platforms (specifically for DT platforms) in commit
>> a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86"). So
>> do the same for native Hotplug capable Root Ports as well.
>>
>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Applied to pci/pm for v7.3, thanks!

This breaks system suspend entry (crashes the system) on Qualcomm SC8280XP
CRD.. this SoC is known for fragile PCIe.

It doesn't repro on e.g. the Qualcomm Glymur CRD (2 gens newer), perhaps we
need an explicit opt-out like

if (of_machine_is_compatible("qcom,sc8280xp"))

or some targetted fix inside the qcom driver

Konrad
