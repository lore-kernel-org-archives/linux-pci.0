Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B3C3D5226;
	Thu,  9 Jul 2026 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594844; cv=none; b=jBNhgt1fDJsi5WVkO8pnjTYRub2OB3nQNvDHuRxMmWmnZTNj2NkmNewM3ENdYHI7VspBCuWLLjLADKznQzkbahTI7WtA1vlExUvpq5PNmiKzT768+YmEbCug0rvTd5Mh8MrJmz8ugU8CPkvWe/yNubtH+4WvaTNJfprb8MpGP0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594844; c=relaxed/simple;
	bh=Ch98t3hk+nExhkCAEcqEvlZnOYinIAww9HQf8ffofzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J/W5UC6HlmOEO+Y/oWg7iKHw/7A//jEhVuLht388SwFyxijhXjl2iLcTyGwRRkfyuf35XEYYm+kkWyuPDNgd2LaUI5TDQlE14W0PfLMbeCKoBDoatNa9SSJCqdRy6wLWOhkZ0FdPTjI6Byv9BhPU2b7oDEfFaI6tJhpPLLwvbgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Lp+9Hres; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Lp+9Hres"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VezVOVkaWKil784uHcfljB+3QlsVwOtJUBLd3pGpIVg=;
	b=Lp+9HresC/SPwgvCPus+V3P5NVCKIPq71cDpu6fMUQ6L1NN1+LQ0INZdPrBqMLjl34eYKPw7s
	jSdwnH1VyWSFTXcZbVXFoip1V8GoOiHoy8N8LyOg9t6JKpr64Qd3D8rOf+Z7XDr6iczWdkC4y1q
	ml8AGNvPjAURmwQpGZWTk+g=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gwsG46JHMzRhVc;
	Thu,  9 Jul 2026 18:51:24 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B4494057F;
	Thu,  9 Jul 2026 19:00:38 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 9 Jul 2026 19:00:37 +0800
Message-ID: <e9682d40-bee2-4f91-8874-1a7340b4a9c4@huawei.com>
Date: Thu, 9 Jul 2026 19:00:37 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 09/18] vfio/pci: Hide TPH capability when TPH is
 unsupported
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
	<wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-10-fengchengwen@huawei.com>
 <20260708173213.1173162c@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260708173213.1173162c@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 7/9/2026 7:32 AM, Alex Williamson wrote:
> On Thu, 2 Jul 2026 20:42:15 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> Check the device negotiated TPH support status before parsing the TPH
>> extended capability. Return zero length to hide the capability from
>> userspace if TPH is disabled during topology negotiation.
> 
> This doesn't match the proposal and introduces an ABI incompatibility
> to the user.  A device that includes a TPH capability and supports
> migration would break if the source and target systems disagree about
> whether the capability is present, even if read-only.
> 
> The proposal did not suggest hiding the TPH capability, instead it used
> SET on the device feature ioctl as the opt-in mechanism to introduce
> virtualization of the TPH capability and control registers.  Nak to
> this change.  Thanks,

Got it, will drop this commit in v20

Thanks

> 
> Alex
> 
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  drivers/vfio/pci/vfio_pci_config.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
>> index a10ed733f0e3..5c6ab172df6c 100644
>> --- a/drivers/vfio/pci/vfio_pci_config.c
>> +++ b/drivers/vfio/pci/vfio_pci_config.c
>> @@ -22,6 +22,7 @@
>>  
>>  #include <linux/fs.h>
>>  #include <linux/pci.h>
>> +#include <linux/pci-tph.h>
>>  #include <linux/uaccess.h>
>>  #include <linux/vfio.h>
>>  #include <linux/slab.h>
>> @@ -1450,6 +1451,8 @@ static int vfio_ext_cap_len(struct vfio_pci_core_device *vdev, u16 ecap, u16 epo
>>  		byte &= PCI_DPA_CAP_SUBSTATE_MASK;
>>  		return PCI_DPA_BASE_SIZEOF + byte + 1;
>>  	case PCI_EXT_CAP_ID_TPH:
>> +		if (!pcie_tph_supported(pdev, false))
>> +			return 0;
>>  		ret = pci_read_config_dword(pdev, epos + PCI_TPH_CAP, &dword);
>>  		if (ret)
>>  			return pcibios_err_to_errno(ret);
> 

