Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA41648BD26;
	Mon,  5 Oct 2026 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208245; cv=none; b=lGkZIXpjvIbtx5jOPk8uzWoQXa6QQug+9xBXoBQ8zn8q1I2XVpZXF1rWO1/KuO0wixoH1DaqrETZBRAjfrn2LBLubzh858/Ah/SUMaT4aZgmrbBN7Q638B5aDPy/hz2Ju3j4bL7W8dYqJ9H89ZB3GLuj/0x9yvbXtfU2/IgSPCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208245; c=relaxed/simple;
	bh=EbVxswirfPudSM4HJY8LWk3cfzRiX/+HVgm2KbKQ9eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMJLz0LXzlZaJCdwM8W3HuLAT7CTZoIO9MREyRPuIFbqlwmKZOHaUQ+uCaQHkdV2/5xtV7LWtgn+hCd8jGjJmOeVo/UAuHTBVZuunOTYsXJu/mMjTRC7OXk2BN2W0IyOEx38HDHC6sWSMLoEcpnKgaDyA3nCdIE/YWK4WBLZR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfuRrMtq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfuRrMtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F951F000FF;
	Mon,  5 Oct 2026 13:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208243;
	bh=nw0bPeo1wRUICh0D3V423poJaprJh+1r7N7ZXcacTag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bfuRrMtqMChLZ6ocYcYECzVIu6tKiJZT8CK/Qsc5DYAxlu26zWzn5ULL9qSRHNrzA
	 dcrqEIOJP2yLXjvX5w00OII8Wg/92UNlfdbHh7Dt5VUExbHMy2KHS0eZrrQfU0yZUN
	 i/es33fvhXGVJ9Rm1A9EjEdgJn3r4qGlhNYuNMxLAf1E6RawaKYMe/4LxgwnjvZUI2
	 J8I/yqozoH8Mg7/NdWkUEO3ssBRWQ8I31WiHHnCaaEquO/xGAVX2yJ0hBnPbDFPUeO
	 HWPVAE6fypJO9uV9OM1QDU8qBDYmVAQjNEFd8QCu+cb215PWTfWJEORVv9vdN4zIbM
	 QgS5MwIX5+4bw==
Message-ID: <f5144b5b-0890-4c19-9e0b-1c8a7b462233@kernel.org>
Date: Mon, 5 Oct 2026 16:50:41 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] PCI: rzg3s-host: Select PCI_HOST_COMMON
To: sashiko-reviews@lists.linux.dev
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
References: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
 <20261002110935.2004349-4-claudiu.beznea@kernel.org>
 <20261002112227.DB32A1F000FF@smtp.kernel.org>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <20261002112227.DB32A1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/2/26 14:22, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Kconfig: unnecessary selection of PCI_HOST_COMMON causes kernel bloat
> --
> 
> commit 45902cd2b000fac7ca52cf6e5a8c266554c39e27
> Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> PCI: rzg3s-host: Select PCI_HOST_COMMON
> 
> This commit adds a select for PCI_HOST_COMMON to the PCIE_RENESAS_RZG3S_HOST
> kconfig option. It states this is needed for pci_host_common_link_train_delay()
> to avoid build failures.
> 
>> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
>> index d246bbe37948e..3e2889a7f1a09 100644
>> --- a/drivers/pci/controller/Kconfig
>> +++ b/drivers/pci/controller/Kconfig
>> @@ -296,6 +296,7 @@ config PCIE_RENESAS_RZG3S_HOST
>>   	depends on ARCH_RENESAS || COMPILE_TEST
>>   	select MFD_SYSCON
>>   	select IRQ_MSI_LIB
>> +	select PCI_HOST_COMMON
> 
> [Severity: Medium]
> Is this select actually required for the build?
> 
> The commit message notes that pci_host_common_link_train_delay() depends on
> PCI_HOST_COMMON. However, looking at the header,
> pci_host_common_link_train_delay() is implemented as a static inline function
> entirely within pci-host-common.h and only requires linux/delay.h. There
> doesn't appear to be any link dependency on pci-host-common.c.

That's true. I did a mistake here. I should have select this flag on patch 9 
which uses pci_host_handle_link_down().

> 
> Since selecting a tristate from a bool config forces PCI_HOST_COMMON and
> PCI_ECAM to be built-in rather than modules, could this be pulling in
> unneeded infrastructure and unnecessarily increasing the vmlinux size?
> 
>>   	help
>>   	  Say Y here if you want PCIe host controller support on Renesas RZ/G3S
>>   	  SoC.
> 

