Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ECB26AF4;
	Thu, 16 Apr 2026 01:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776301798; cv=none; b=awbI7g3/qheEavxtFGJ0mMsQAhAyXe7b4MAY5ovEBV/SoCOa9oozsfPTGaVbhUK5i22QVzJzxGBcRLk3RMC30Z4S/T4XvaxGoDrY/xW91GuOHCnyJiOdWFGPK1RBcXe6X1reUQaT2wSBikEJ9e1CXVU1VrG9V6v0gJDorDT3zOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776301798; c=relaxed/simple;
	bh=E7SGXbGxKh0ZpZ9Qh9s4jm02yr8nkNGxmiq15Mo7dbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BEpbiZWqW/GQegRA12iXl5yPa2H2r7o2N3uIQGnOgoMT2W1PQji1tNLrzdfpZPthJ/l6hUaUQn4XioFw4zUgwn+cYWFPoVUIVyUMZo7PjYXnSOdTMUQkKNXkatm2UUidxpFyN42Lv9JSOeiX/9bc8g0CYDZkCBlZwphBNFEqcAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Vm4pJhQJ; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Vm4pJhQJ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NHDiCQ6LLDvqkjDtqZT0emfpZJwHIt5pQk1ry5pNd4E=;
	b=Vm4pJhQJDbt3F73dV/rXoWeDqwxdklnL882vUOBfjJOB0j23k1wNwMf1+gq2KxYlVOPX8dmFV
	FL43fOaFYGOqv+jOFEDpSknn1AKr/65t5fCaRs0szOBBaWWsS4yE7r+8EiwRPaQpa0WxnSAkNcV
	OkS+n+oB9KFiBqQ83SkzRkQ=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fx0BY42S6zLlYJ;
	Thu, 16 Apr 2026 09:03:33 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 85C304048B;
	Thu, 16 Apr 2026 09:09:51 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 09:09:51 +0800
Message-ID: <41d5b3ea-abe2-4583-be88-2addf6b4d394@huawei.com>
Date: Thu, 16 Apr 2026 09:09:50 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] vfio/pci: Add PCIe TPH GET_ST interface
To: Wathsala Vithanage <wathsala.vithanage@arm.com>, <alex@shazbot.org>,
	<jgg@ziepe.ca>
CC: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260415090959.53672-1-fengchengwen@huawei.com>
 <20260415090959.53672-4-fengchengwen@huawei.com>
 <518e5e0a-d0b2-4775-a32a-e2dc87c8ba4b@arm.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <518e5e0a-d0b2-4775-a32a-e2dc87c8ba4b@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 4/15/2026 9:55 PM, Wathsala Vithanage wrote:
> Hi Feng,
> 
> get_st  feature is unsafe. It allows a rogue userspace driver in device-specific
> mode to obtain steering tags for arbitrary CPUs, including ones unrelated
> to the device or its workload, enabling it to direct traffic into those CPUs’
> caches and potentially interfere with other workloads, opening doors to
> further exploits depending on other vulnerabilities.

Thank you for the follow-up and for referencing the prior RFC
discussion on this topic. I appreciate you clarifying the
historical context of the safety concerns.

I acknowledge the risks you’ve highlighted, but I believe the
risk profile in this VFIO interface is different and already
well bounded by existing design and practice:

1. VFIO device access requires elevated privileges
   A userspace process can only open a VFIO device node if it
   has sufficient privileges (typically root). This is not an
   interface for unprivileged users.

2. In the thread "[RFC v2 0/2] Retrieve tph from dmabuf for PCIe
   P2P memory access", applications can configure the steertag
   of exported dmabufs from userspace to the kernel. Kernel PCIe
   drivers (e.g., mlx5 NIC) then use these steertags and set them
   to their ST tables. Even here, userspace could set invalid
   steertags that impact GPU performance—but this model is
   basically accepted I think (refer from maillist discuss).

3. Malicious resource consumption is not unique to TPH
   A malicious thread can be created to forcibly consume CPU
   resources and bound to a specific CPU, affecting other CPUs.
   This is a general system security concern, not one specific
   to TPH GET_ST, and is addressed by existing system hardening
   and access control mechanisms—not by removing useful features.

4. GET_ST is strictly necessary for Device-Specific (DS) mode
   when no ST table is present on the device.
   For devices that do not have a dedicated ST table (a common
   scenario in many PCIe endpoints), DS mode requires userspace
   to retrieve per-CPU steering tags first, then program them
   into the device’s steering logic via other registers. Without
   GET_ST, userspace cannot obtain the required steertags to
   enable TPH DS mode at all—rendering TPH support useless for
   these devices. This is not an optional feature but a
   fundamental requirement to unlock TPH functionality for a
   large class of hardware.

Given these points—privilege restriction, existing industry
practice, general system security mitigations, and strict
functional necessity for DS mode—I believe GET_ST is reasonable
and consistent with existing VFIO security boundaries.

Thanks

> 
> That's why we dropped this capability in https://lore.kernel.org/kvm/20251013163515.16565-1-wathsala.vithanage@arm.com/
> 
> --wathsala
> 
>>   }
>>   +static int vfio_pci_tph_get_st(struct vfio_pci_core_device *vdev,
>> +                   struct vfio_device_pci_tph_op *op,
>> +                   void __user *uarg)
>> +{
>> +    struct vfio_pci_tph_entry *ents;
>> +    struct vfio_pci_tph_st st;
>> +    enum tph_mem_type mtype;
>> +    size_t size;
>> +    int i, err;
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
>> +        err = pcie_tph_get_cpu_st(vdev->pdev, mtype, ents[i].cpu, &ents[i].st);
>> +        if (err)
>> +            goto out;
>> +    }
>> +
>> +    if (copy_to_user(uarg + sizeof(st), ents, size))
>> +        err = -EFAULT;
>> +
>> +out:
>> +    kvfree(ents);
>> +    return err;
>> +}
>> +
>>   static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
>>                     void __user *uarg)
>>   {
>> @@ -1544,6 +1593,8 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
>>           return vfio_pci_tph_enable(vdev, &op, uarg + minsz);
>>       case VFIO_PCI_TPH_DISABLE:
>>           return vfio_pci_tph_disable(vdev);
>> +    case VFIO_PCI_TPH_GET_ST:
>> +        return vfio_pci_tph_get_st(vdev, &op, uarg + minsz);
>>       default:
>>           /* Other ops are not implemented yet */
>>           return -EINVAL;
> 

