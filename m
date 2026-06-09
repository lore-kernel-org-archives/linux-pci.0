Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20662377ECF
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021492; cv=none; b=tvOAbNObQkrdwjwQrEfQ7Y6Xj2c4IrU/L7dvItcEp7GHVlIwYHmNL1VuotXf7j+YOvJsNCiJ0Ge2vUORXTCp+p+7drnNDwRxfqFdD/0PrJQ/DJAlK6iMG3RzwQDDBUYT18Hs8nEfVMn2BAKUp0Woa3zw3w+HCAMB8lC/QcJMcEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021492; c=relaxed/simple;
	bh=jXG4PWaLculkrGCMBKvWz16KNAcutg4Nr5j1HtVB5eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DInIGTBLEs3ixSGKCpFzb8xyCtKAicnSUbh2L7VV1VB20+I6SpZCJm9QCJqe77LPn/nZWhAl+7p6W/78hsEswPyPeCZH8RRwjMM7ulkgp2q/Txy241zFPK93MJAJFYJoahtSSGpzGfz4t4KbjVYKfnQIgS9rUt5K+Mt7z827knw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=V7pDje4C; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="V7pDje4C"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4866834f8deso2323411b6e.2
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1781021490; x=1781626290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Uz2/S8q1bGzYbvjOi+dd2PPF/EKmkqQlSRIaTmPAZs=;
        b=V7pDje4C/TPP9dOXrkrUmIJyPOX2Tgt2po9yO+HDfanfobPPFHQvO+TEft9fudDwXx
         Hny8Wzv52/+9yD3uJlopCz99QtIGSl6slQ7l4haqjD54Xuhye03LU56L1mTHWk0amcVm
         9VoXYW768TeLL8ktqn418Vbsor7U3kN/eeTBXkwJ+o8GmPf7Kdg4tIhZpZXHlwOgz8zR
         LjNP9iJWSUfCDhVtJ1DSvfzqxOHxNgDt+4tnUXXZmx+TKkAZhXYB5caok0X3gyz60SfS
         w3P+OdpB5ZxCKLRgVvHVzIT5l94n5NrpLF44a5o6gSsGrsHtJl2i+9Bi2dOnKnDc6NKt
         FzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021490; x=1781626290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Uz2/S8q1bGzYbvjOi+dd2PPF/EKmkqQlSRIaTmPAZs=;
        b=fnTaxugpJXS2wdKrrx6htfxubXq0mzNsLYL5V0YsQSoL9Fkt9rjcB+oqyyTNRotEEr
         tXkUsAVD+0/oxtMBV4lJ6cUQf340GPuFOJN/PfiWgk+fuCCyOXO6UbUIqC8ndblxkB7Q
         mKC+9QdjzajQEv4ojebIVrGM/tWHKXaRjJM/2fWRPeJhnUYSy3wKf4GBQQkl8qLQcS2+
         lpJdEufcTsNKbkk/M2NH7Y3aiE8FvkGx5PUwC9eIyI+JwYeFi/3jckQ4nqKPZObFoBOw
         rXrYzY0dSM3a4UgqagifkwAdztMrem0f9E5HJjGXo/vx5356na6gPrgA8qWmLhFcS+Dl
         ERvA==
X-Forwarded-Encrypted: i=1; AFNElJ/LidWw8FB51mQWcchyvFtUF39lGdtOQeTReMVCic9MbRHg0X6+9tjKECZbyFIKOss3T8VdXM5LiEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXLys359cqCBHM7fCgtN9TTPlOZ8D1DTLGxkmJbvY+FUr04Zjy
	+v+6FAx//fLkzklPxBHprSeeYdEPmf2MCXyTFyBY2SL0abPqNEKIgz0fFcvD17XDy6LPPO+1Ha+
	DEqaUosg=
X-Gm-Gg: Acq92OGMsAon1p3M1Zg/ntJZwm3f6i0jT/fKzij/DidLRzYXjJd9lWx0fsg9+6CypDb
	2eGeovAcv+Mk0dhutkfHZtx55FMdk208crU/tN3biVfbslCDktU2eZZV7EtMzmat7Rcg0CAK4Le
	FChVPQTsreYP6Gmoi+sEgKNBHHTRnZ7TSG3UH9KuszGg2GP9GvKK+y/R1WqG7OBfUvlaZV/gySD
	uBVyb87a3N8IP0Bzs0SQqSLH43luJWzK29JsLIfi6w+U+ltHJQO4gO3kgV4XyC3PK858ntGljnS
	KxWBE30tlIdtWgRVhvapYOf5+4Ed9ms0+ef1P8x5Jk6cv/tW84458f55JtYS3x/S5JmjOrQoBGj
	xP5BIv58kmzZDkMbyMYWtMrKs6wEmb422Dd1FfPNtDqT0jXi3gbtjGxl1VwKRYi5wcG6AJm4YkM
	n7go70/rjQ2DlWFVTHmqwT+dN1xD5TCan2yGgRaX0Mz8uu
X-Received: by 2002:a05:6808:1301:b0:47b:d07b:ecac with SMTP id 5614622812f47-4868db2e306mr15084950b6e.10.1781021490024;
        Tue, 09 Jun 2026 09:11:30 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b91f944sm16430240b6e.9.2026.06.09.09.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 09:11:29 -0700 (PDT)
Message-ID: <b025f81e-e3a5-4b55-a6b4-cbd9731fe0df@riscstar.com>
Date: Tue, 9 Jun 2026 11:11:27 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
To: Manivannan Sadhasivam <mani@kernel.org>,
 Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Christian Bruel <christian.bruel@foss.st.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
 Nam Cao <namcao@linutronix.de>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Randolph Lin <randolph@andestech.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vidya Sagar <vidyas@nvidia.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
References: <20260517014841.254085-1-inochiama@gmail.com>
 <20260517014841.254085-6-inochiama@gmail.com>
 <wztjdv4t5cn7djj3jyvheest7rn5nr2g3efzwods2fz3yy5wn2@hbl644sd6fst>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <wztjdv4t5cn7djj3jyvheest7rn5nr2g3efzwods2fz3yy5wn2@hbl644sd6fst>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/26 9:18 AM, Manivannan Sadhasivam wrote:
> On Sun, May 17, 2026 at 09:48:40AM +0800, Inochi Amaoto wrote:
>> The PCIe controller on Spacemit K3 is almost a standard Synopsys
>> DesignWare PCIe IP with extra link and reset control. Unlike
>> the PCIe controller on K1, this controller supports external MSI
>> interrupt controller and can use multiple PHYs at the same time.
>>
>> Add driver to support PCIe controller on Spacemit K3 PCIe.
>>
>> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
>> ---
>>   drivers/pci/controller/dwc/Kconfig            |   4 +-
>>   drivers/pci/controller/dwc/pcie-spacemit-k1.c | 169 ++++++++++++++++++
>>   2 files changed, 171 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index f2fde13107f2..fae971ecd876 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -439,7 +439,7 @@ config PCIE_SOPHGO_DW
>>   	  Sophgo SoCs.
>>   
>>   config PCIE_SPACEMIT_K1
>> -	tristate "SpacemiT K1 PCIe controller (host mode)"
>> +	tristate "SpacemiT K1/K3 PCIe controller (host mode)"
> 
> Can you just say 'SpacemiT PCIe controller (host mode)"? I believe I asked Alex
> while adding K1 support and he said this driver might not support future IP
> revisions, but here we are.

(Sorry if I said that in error.)  Will this be K1 and K3 only?
If so what you say is fine, but I agree with Mani, if it's going
to also form the basis of K5 (or whatever) just make it "SpacemiT".
And probably change the Kconfig symbol to PCIE_SPACEMIT.

					-Alex

>>   	depends on ARCH_SPACEMIT || COMPILE_TEST
>>   	depends on HAS_IOMEM
>>   	select PCIE_DW_HOST
>> @@ -447,7 +447,7 @@ config PCIE_SPACEMIT_K1
>>   	default ARCH_SPACEMIT
>>   	help
>>   	  Enables support for the DesignWare based PCIe controller in
>> -	  the SpacemiT K1 SoC operating in host mode.  Three controllers
>> +	  the SpacemiT K1/K3 SoC operating in host mode. Three controllers
>>   	  are available on the K1 SoC; the first of these shares a PHY
>>   	  with a USB 3.0 host controller (one or the other can be used).
>>   . . .
