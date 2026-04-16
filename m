Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B9613B58C;
	Thu, 16 Apr 2026 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776302186; cv=none; b=n4rf8XWg56fXzzsSX1+O2eSFxEojP2pFQfVbGPxP2vz6qnC3gZx9+aGziySHAX894sKee99ZZHHIeFbk+g6B6cQKMO3WVamX7Cz4lm4Ov1eSIT6UolseiyB4te8aKDoUjD7AzeOiGgM28nEv1j5zidOvFg0vSqOJIQHdXubLEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776302186; c=relaxed/simple;
	bh=S6lzco+aUY6xHjvjSvPcuUWmitVVuzM1k4I7ufSflBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Muy+k9RwpacA7jZVgRSK4gzrK1+zJ4m6AnCmTH0L1/52onOMkodDZVaMAmFgZwXFRhFeS+juC30jxIkZFGcK9WU97ptfkTkixRGf/1gvMk7T7FXu+ynATeDq4y5pZednzpZORQ9g78z2NL+ERiX79saMaQhwDvfIIvXWR6bjFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UQnetT4U; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UQnetT4U"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MGT+QgMDGRLeV/oInIFWFUL4aCEDD9cQy1MPH8ZCZWk=;
	b=UQnetT4UB7zPkbAqQXCf9fjgedJh0Z5VEIwwsq3H74aHBhFxWVxnFfx9HjnwNPT4yNvpxOVvv
	MI6h/XL1v8DtdnRVftnqPrcmYy7h0x1/BX7L0C/UChf085SwUo5sJR/r2VCfjYy0iItiw8HR5C1
	c20BEC9j41ampPq0pGzNEb8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fx0L24hRqzpSvH;
	Thu, 16 Apr 2026 09:10:02 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C6EC2012A;
	Thu, 16 Apr 2026 09:16:16 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 09:16:15 +0800
Message-ID: <44d27b03-0d16-4114-9565-ee01e8d6189e@huawei.com>
Date: Thu, 16 Apr 2026 09:16:15 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] vfio/pci: Add PCIe TPH SET_ST interface
To: Wathsala Vithanage <wathsala.vithanage@arm.com>, <alex@shazbot.org>,
	<jgg@ziepe.ca>
CC: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260415090959.53672-1-fengchengwen@huawei.com>
 <20260415090959.53672-5-fengchengwen@huawei.com>
 <e6dbfdd5-5117-4c3e-bb84-ee1e489aa38f@arm.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <e6dbfdd5-5117-4c3e-bb84-ee1e489aa38f@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 4/15/2026 10:01 PM, Wathsala Vithanage wrote:
>>   +static int vfio_pci_tph_set_st(struct vfio_pci_core_device *vdev,
>> +                   struct vfio_device_pci_tph_op *op,
>> +                   void __user *uarg)
>> +{
>> +    struct vfio_pci_tph_entry *ents;
>> +    struct vfio_pci_tph_st st;
>> +    enum tph_mem_type mtype;
>> +    int i, err, size;
>> +    u16 st_val;
>> +
>> +    if (copy_from_user(&st, uarg, sizeof(st)))
>> +        return -EFAULT;
>> +
>> +    if (!st.count || st.count > 2048)
>> +        return -EINVAL;
>> +
>> +    size = st.count * sizeof(*ents);
>> +    ents = kvmalloc(size, GFP_KERNEL);
>> +    if (!ents)
>> +        return -ENOMEM;
>> +
>> +    if (copy_from_user(ents, uarg + sizeof(st), size)) {
>> +        err = -EFAULT;
>> +        goto out;
>> +    }
>> +
>> +    for (i = 0; i < st.count; i++) {
>> +        if (ents[i].mem_type == VFIO_PCI_TPH_MEM_TYPE_VM) {
>> +            mtype = TPH_MEM_TYPE_VM;
>> +        } else if (ents[i].mem_type == VFIO_PCI_TPH_MEM_TYPE_PM) {
>> +            mtype = TPH_MEM_TYPE_PM;
>> +        } else {
>> +            err = -EINVAL;
>> +            goto out;
>> +        }
>> +
>> +        err = pcie_tph_get_cpu_st(vdev->pdev, mtype, ents[i].cpu, &st_val);
>> +        if (err)
>> +            goto out;
>> +        err = pcie_tph_set_st_entry(vdev->pdev, ents[i].index, st_val);
>> +        if (err)
>> +            goto out;
>> +    }
> 
> We also dropped batched updates of steering tags because there is no way a user could tell
> which entry failed unless struct vfio_pci_tph_entry had an error field. But, we thought the
> added complexity is not justified as these calls are only used during initialization.

Thank you for the feedback on batched steering tag updates.

I agree that per-entry error reporting adds unnecessary
complexity, especially for initialization-time operations.

To keep things simple and robust, the next version batch
implementation will use a straightforward failure model:
  if programming any ST entry fails, the kernel will roll
  back all previously programmed entries by clearing them
  to 0, then return an error to userspace.

This avoids partial programming states, requires no per-entry
error fields, and fits well with one-shot device initialization.

Thanks

> 
> --wathsala

