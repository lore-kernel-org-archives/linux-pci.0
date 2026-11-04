Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806710;
	b=E7taOEIN1fd6SxmFOQPs+rZ46Mv3b/BHSdZ7HFsL98Fpb6uMqgYvCwrgdYQ7+31fa1cD
	 6+ovn3NNRv/jhlfrHXtNp+crI4BrnBJCSPAblJYUkqg7Vs2OOv6VGcNf487kTR8B1vK3X
	 NH5aYbIHnyDruOZXJ7u3udy/x5eiwRcM42VTDY2MmGfClP0joGVz99YyRVSIQknaMiPB+
	 HTTT5SzVEhMIhKDN+EDhltAxT7pFVhrdKl5jXHvdJd1gPEOddaG5rLCXt5pE3Mw0qx9Aq
	 6uzvZzIVkl4ZWGM1IsK6YERu2ZlDVlZWqm1D67TfHbrOnIx3uyHMiKfk/FAXTMD0efg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806710;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=N69nyzayYSxR+NwYu0yvIulH3s3QqZkTbmCgK6AZMFs=;
	b=QMMTa1X8YWxwlYFpT6ISdxJc7UzgsqHWy1KDeeXkxRrIEnqkts+Uib/uvAgY3ihkVcjm
	 akUYspeDlYY8+dB8vhLUWgn5FeKg+axPjWZRUaqJWOvl2ogCzXYoTdtUc++UbemWGvXc1
	 AWVS3Fa7y9JUAX6yqf9wdnjBhbHNcQz4V0AAkJ3DKV49duQR1DM2By+O/2qCpgJQx75KY
	 0+iKCXQ5vFwkfvXsQe88vJXzulY6iPPemU9njSiKSQwaCWtsPr9vaFrjNPUBe63cNqNng
	 nyyzhMvDayrO2DqPG5y2+6sLpJEjZvEiDXemLCaa0bKxWklBZy5pFItqCamkt/mHKeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kmcAGjN7;
	arc=none smtp.remote-ip=74.125.225.137
Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977B6082BDA
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 15:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5977B6082BDA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kmcAGjN7
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-4b4e4d13850so1801935e9.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 07:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793806709; x=1794411509; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N69nyzayYSxR+NwYu0yvIulH3s3QqZkTbmCgK6AZMFs=;
        b=kmcAGjN75d/L6lSX1ezkuk9sXECFR0lagd69BJFErdFPzj5Wd6MzDJkznzskgyMeKo
         4pc2wUOtFWSCx+ZM7robeEsZRfAFhSgfKwnGlo0JdaxaiZt7DuLRrynVt03JZYVLVumL
         X5IqXtfvQJsBgIthxecWwGD43ZeOw/Ufs2MXHUnjGF2rNu2E9ph0WvNmFfy/p8wxtmY0
         sXjYnlh1d2fRUktyqS/knL9WJctufsyfVuCaQP61+bjwV25GCYQemTJNvjJhOhU/YriE
         iNKscrKUxgllDyqIbJupqhe7PSccF5oKGdZzzombgx0Gbk/LvrRcPVG3DHB+lKm2kKm6
         06nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806709; x=1794411509;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N69nyzayYSxR+NwYu0yvIulH3s3QqZkTbmCgK6AZMFs=;
        b=qOswb9UD2ideJKMrFwHIrtyMVG+3d+6RmqMRo26FtyjnXOFnG5QQNjyAthK7M0xLz9
         98LWiTmwB7OKNb4krjLwlbcB7CcXVznRuz9V2H3/Gznzeu6/I7Mg69/a7q41nnEswkNy
         GpR33dSK8xsBw+FJHxfWs+NDtZdO2BB+fIHFeitp7kovifiGIKC7PXU1GL3xnEMFyaHw
         86xsialpY4RQfwJh70bFaCGXSomA4AVP7UJlqTS23O2gGK+f55EAy1nklzQa3p6Y5RhX
         7zZvg4uqSf4Oe0ld3/ENP+LkIAJiAV1GOsqH4kwkZdJ+UOgOnBPhGN9PLIw+jgvBWtMg
         fkIg==
X-Forwarded-Encrypted: i=1; AKwUvBw9j8CtDb+PfYK0tlIKtfrDd5csErgAFBzsnrDW4MBgEzr+FYQPS75VKSOrq6/Xmp+vOWZq2cAAC+E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pPizZmL/OpzKHHezq6k5mcMhn50Cy6shdZ5G1QOS49AJ9pi4I
	gTLhIRLmBK0x+WsrH4jHGzcaKPpg2rjDkZ0K5V6lu6c/kQ3EwwLBQldr
X-Gm-Gg: AYBFou39+7xHCDI6BI5ci1DP5dPv7WEIrCpkgVSkej2nSAB7T4dppuPKuIQBFbq4oOu
	WE9raOG3B/9QO/CiEBWYz1Q8ELXOzCauulcdm7JVFLu44d7h9CeRhlJICGXQQHj+EtZAInsi0yt
	JXV6W6vGIH4pQXAYOQVRCJeELSrew0NhGt91/guPpFGgXGO2PV+i1iyukn8y7KKdSdQ4jgmEuFi
	jb3ogBWgllwhwWPx+ZGo6pJBElNFR2M76PZIekjTAbyzl1fKUDz9//MHpkaqtTHuvoYjQHYxAua
	+OwjG5xYKBljxnSfJuuDoMu5hUsotBUfXwN7l5DRXFkbOhsNSk8tx/WdUo1yRuwE3i9VqWYgY9V
	fBmkO5t+tAy7yHnli6/reglLMH/OVCsQwTX2Pn1rc1iInTbwlJFBSCpjqOXROaCL55BDPQg5opt
	eITgcHeYGGVJPIsqUZxHlwH4pkKjgXVWj1mgWaR0eIQvT7jLaHoIMq0ESxnIy9Se57fr0Hj+DDm
	ukyYfQK0LL63axuye1elfLlQe5Gl1LcEkmgEg9lly78TIcCNPWgNiSMqYBV1wHaYzwInpVtOWE1
	P8w9B4bbRS8whSZSQd4nTND48TrWnj52j5LQ5nor
X-Received: by 2002:a05:600c:8706:b0:4a1:e0d5:293e with SMTP id 5b1f17b1804b1-4ac1765d3ddmr394129375e9.21.1793806708283;
        Wed, 04 Nov 2026 07:38:28 -0800 (PST)
Received: from [192.168.100.182] ([182.180.105.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43c17ecdasm89849875e9.5.2026.11.04.07.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 07:38:27 -0800 (PST)
Message-ID: <496706c6-e15c-43ab-ae0f-6230e098dfb2@gmail.com>
Date: Wed, 4 Nov 2026 20:38:23 +0500
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: spacemit: Ignore PERST# bit for controllers
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Alex Elder <elder@riscstar.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>,
 "open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
 "open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20261104140750.761330-1-alitariq45892@gmail.com>
 <DMMHM7OIO97H.2SHNC575QC4PY@linux.spacemit.com>
Content-Language: en-US
From: Ali Tariq <alitariq45892@gmail.com>
In-Reply-To: <DMMHM7OIO97H.2SHNC575QC4PY@linux.spacemit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/4/26 7:14 PM, Troy Mitchell wrote:
> On Wed Nov 4, 2026 at 2:07 PM GMT, Ali Tariq wrote:
>> The k1_pcie_init() does not set PCIE_IGNORE_PERSTN bit of the
>> control logic register, which causes controller to reset itself once
>> PERST# signal is asserted even when acting as host.
>> On Orange Pi RV2 (SpacemiT K1), this resets the controller and wipes
>> the IDs. k1_pcie_deinit() leaves PERST# asserted, so when k1_pcie_init()
>> runs again, its first DBI access hangs the CPU.
>>
>> Set PCIE_IGNORE_PERSTN bit of the control logic register of APMU
>> in k1_pcie_init() before enabling resources so controllers
>> dont end up resetting themselves when PERST# signal is asserted.
>>
>> Fixes: ff64e078e45f ("PCI: spacemit: Add SpacemiT PCIe host driver")
>> Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
>> ---
>> Hang log: https://kernelci.cloud-v.co/scheduler/job/420
>> Fixed Log: https://kernelci.cloud-v.co/scheduler/job/430
>> ---
>>   drivers/pci/controller/dwc/pcie-spacemit-k1.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
>> index 92a71ea90ac3..af6028e8825a 100644
>> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
>> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
>> @@ -47,6 +47,7 @@
>>   
>>   #define PCIE_CONTROL_LOGIC			0x0004
>>   #define PCIE_SOFT_RESET			BIT(0)
>> +#define PCIE_IGNORE_PERSTN		BIT(2)	/* 1: ignore PERST# */
> A similar but earlier patch can be found here [1]
> 
> Link: https://lore.kernel.org/all/20260924-spacemit-k1-pcie-fix-v1-1-002b5c1ba9fc@linux.spacemit.com/ [1]
> 

Thank you for pointing.

I missed that. I will check that patch.

You can drop my patch.

Regards,
Ali

