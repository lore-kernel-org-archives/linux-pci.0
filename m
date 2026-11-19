Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069557;
	b=2pLeTvvPlRby0LG4V4H99dJP8EsfPJuGL9O/hHsnIGQgbI09bymPst0cdYxiYIZ7sqyF
	 NGOL62WVSJo8Bf5dhwgoi+tHJA73EozRcR1Pxo1rIV0OZkmuXbO8i1OC1nVaNZDrTtOi/
	 pu7oRmja2C6tF0gpoxzUYPAtxSyxW9N0+RqRznKo0k6HQsWcb/M2JLNTKwin7xtbGEXJ9
	 +4pSnVCh2ZTCxdkvnCKN3ShFYtd6CrIkKXedEJhTbPSWBWyGr+aTaXJor/6F92vTXkyRa
	 40C0j+5OjggEZHrWlSIbIhHMX4Aqzx74YrSG0rxM5qjJ5QukIuWn706VsknBx/Mi0NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069557;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=04B/Kbaj4vrvBkYG9X6BLP4J62xiOfE4d23QuEZ2PlQ=;
	b=2H7AAL5M4GDmjP39SFoPg9xXpOb1tPxcSHpHVbXwfgA3KFBhlCR7klbJLZ8Nvf+t0mMY
	 X3o3G3Cqiw2dFc/XlaSpYwcmtNd3iBV2KzMvtRHNn4VNoWyDC+oL+WjZ14ycnynQLYgyd
	 +FA87sv+VC0rXBwJes8CcgAN1TuvY72RLQX5/e6GMZ10Xsc+RaWIuGII178AOLsH2vXmT
	 YcOkQb0LImuctNiQz6qxSk/xWbLrUjZrpYEyAX8eOol5BVzNXhS/iuVPo4BCexnkR04H6
	 O4gkrlHcxgGmcG1tca8zSskQlSdwFhQwlXSmZZP+L7Cw0ZiK5uIUkwb8/vGto7X2x6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HwvqI6Ik;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990B606A320;
	Thu, 19 Nov 2026 06:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3990B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HwvqI6Ik
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=04B/Kbaj4vrvBkYG9X6BLP4J62xiOfE4d23QuEZ2PlQ=;
	b=HwvqI6IkrbAt2Nn1mMM+JnTydUqvIxKY01wrQEbnr2uzyQmUgJHl+buYs8IzGxwwQ7ekttN7O
	pLY/G6wxZDnL1csUzuKiFfroqKOVnRmxkezogHIbCLpvTMHJbaAbHb9gMNfRITcAJRKf4zPvP3o
	Hi/oERqmQkVL2u8JdKkqW3c=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jVT3v2lgKzLlSk;
	Thu, 19 Nov 2026 14:25:31 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 810BA4056C;
	Thu, 19 Nov 2026 14:25:51 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 19 Nov 2026 14:25:51 +0800
Message-ID: <142d6813-8677-4524-97a3-fabe77624b39@huawei.com>
Date: Thu, 19 Nov 2026 14:25:50 +0800
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
Subject: Re: [PATCH v21 06/13] PCI/TPH: Add macros to check standard and
 extended TPH support
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-7-fengchengwen@huawei.com>
 <sashiko-outbox-220654@kernel.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <sashiko-outbox-220654@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 11/18/2026 6:06 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] PCI/TPH: pcie_*_tph_supported() macros return true when
>   pci=notph is set
> - [Medium] PCI/TPH: pcie_*_tph_supported() macro stubs do not evaluate
>   or type-check pdev
> --
> 
> commit 80062e3e48e12a212317dc82386d43fd4c4bb4c9
> Author: Chengwen Feng <fengchengwen@huawei.com>
> 
> PCI/TPH: Add macros to check standard and extended TPH support
> 
> This commit adds the pcie_std_tph_supported() and pcie_ext_tph_supported()
> helper macros to query standard and extended TPH requester support via
> pdev->tph_max_type, along with stub definitions for !CONFIG_PCIE_TPH.
> 
>> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
>> index b2bec02f3ea0e..50640fdc84e14 100644
>> --- a/include/linux/pci-tph.h
>> +++ b/include/linux/pci-tph.h
> [ ... ]
>> @@ -21,6 +23,18 @@ enum tph_mem_type {
>>  };
>>  
>>  #ifdef CONFIG_PCIE_TPH
>> +/**
>> + * pcie_std_tph_supported - check standard TPH requester support
>> + * @pdev: PCI device
>> + */
>> +#define pcie_std_tph_supported(pdev) \
>> +	((pdev)->tph_max_type >= PCI_TPH_REQ_TPH_ONLY)
>> +/**
>> + * pcie_ext_tph_supported - check extended TPH requester support
>> + * @pdev: PCI device
>> + */
>> +#define pcie_ext_tph_supported(pdev) \
>> +	((pdev)->tph_max_type == PCI_TPH_REQ_EXT_TPH)
> 
> [Severity: Medium]
> Do pcie_std_tph_supported() and pcie_ext_tph_supported() return true even
> when the kernel is booted with pci=notph?

The helper pcie_std_tph_supported() / pcie_ext_tph_supported() report hardware
TPH capability, which is separate from the global pci_tph_disabled knob. The
pci=notph knob only blocks pcie_enable_tph(), it does not erase hardware
capability.

> 
> pci_tph_init() populates pdev->tph_max_type during probe without checking
> pci_tph_disabled, while pcie_enable_tph_ext() checks pci_tph_disabled and
> returns -EINVAL.  With pci=notph on the command line, callers such as the
> VFIO TPH code later in this series treat TPH as supported and expose it in
> virtual config space, only for hardware enablement to fail with -EINVAL.
> 
>>  int pcie_tph_set_st_entry(struct pci_dev *pdev,
>>  			  unsigned int index, u16 tag);
>>  int pcie_tph_get_cpu_st_ext(struct pci_dev *dev, enum tph_mem_type mem_type,
>> @@ -33,6 +47,8 @@ int pcie_enable_tph(struct pci_dev *pdev, u8 mode);
>>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
>>  #else
>> +#define pcie_std_tph_supported(pdev) false
>> +#define pcie_ext_tph_supported(pdev) false
> 
> [Severity: Medium]
> Should pcie_std_tph_supported() and pcie_ext_tph_supported() be static
> inline functions taking struct pci_dev *pdev instead of macros?

OK, will fix in static inline

> 
> Because the !CONFIG_PCIE_TPH macros discard pdev without evaluating or
> type-checking it, callers whose local pdev variable is only passed to
> these helpers (such as vfio_tph_vcap_rewrite() later in this series)
> trigger a -Wunused-variable warning and break the build under
> CONFIG_WERROR=y when CONFIG_PCIE_TPH is disabled.
> 

