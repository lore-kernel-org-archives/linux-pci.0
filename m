Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8863CF031;
	Wed, 15 Apr 2026 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776261341; cv=none; b=fbo6rYQI3xY0+i3+NTgELxKey35x5REubl6rWEPoUSgUKeXqA+v7lqg3+CapW686nJmC9oFfOYBFv6OZSZKpoT1Ca8l7mIfAm0JEKzKP3GSTV3EABn+N45kqAWN0/KwcsdRTfN2EzyHuHbjq5YHKExbZFd5JmQUmwKMx+aO10Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776261341; c=relaxed/simple;
	bh=afT+/AJfr9Pd0za1i+sG5FU8fIdRySrPPxD6GeF5phE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sq14KMISEPvpDpgFPwp/9HbTiOzzMQkBtecoRQjS9TmaDo00ZDDfmPNZrwE+tIN7MUwEh5xclQM8Jc43ADY3MX7gTiSEtKeC6x9syNLhXbFRP3NZg/y++afuX7zlJCBQf9AExcFg0HRByUF4nmCDvaX2FlD1k4Msd6iufybxJEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=k+X5mnHm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="k+X5mnHm"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F8A24FAA;
	Wed, 15 Apr 2026 06:55:32 -0700 (PDT)
Received: from [10.122.46.229] (unknown [10.122.46.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B04E13F7B4;
	Wed, 15 Apr 2026 06:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776261337; bh=afT+/AJfr9Pd0za1i+sG5FU8fIdRySrPPxD6GeF5phE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k+X5mnHm7hL+pj79CT721bT30dLBzwUTIuoMj8u2JJZ8J+Ijnpx99cGgiheJqXXZj
	 KOmB7JtgJz6zyo9B0V8NlpJFgb7D2AjkyUdKLxZuTkHn0pmfkR2ouPjnvvkTY9ugHU
	 YUhZLAvod9LMwm0jz0Bwm90fRZjGt1l2SPVv5E/E=
Message-ID: <518e5e0a-d0b2-4775-a32a-e2dc87c8ba4b@arm.com>
Date: Wed, 15 Apr 2026 08:55:37 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] vfio/pci: Add PCIe TPH GET_ST interface
To: Chengwen Feng <fengchengwen@huawei.com>, alex@shazbot.org, jgg@ziepe.ca
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260415090959.53672-1-fengchengwen@huawei.com>
 <20260415090959.53672-4-fengchengwen@huawei.com>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <20260415090959.53672-4-fengchengwen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Feng,

get_st  feature is unsafe. It allows a rogue userspace driver in 
device-specific
mode to obtain steering tags for arbitrary CPUs, including ones unrelated
to the device or its workload, enabling it to direct traffic into those 
CPUs’
caches and potentially interfere with other workloads, opening doors to
further exploits depending on other vulnerabilities.

That's why we dropped this capability in 
https://lore.kernel.org/kvm/20251013163515.16565-1-wathsala.vithanage@arm.com/

--wathsala

>   }
>   
> +static int vfio_pci_tph_get_st(struct vfio_pci_core_device *vdev,
> +			       struct vfio_device_pci_tph_op *op,
> +			       void __user *uarg)
> +{
> +	struct vfio_pci_tph_entry *ents;
> +	struct vfio_pci_tph_st st;
> +	enum tph_mem_type mtype;
> +	size_t size;
> +	int i, err;
> +
> +	if (copy_from_user(&st, uarg, sizeof(st)))
> +		return -EFAULT;
> +
> +	if (!st.count || st.count > 2048)
> +		return -EINVAL;
> +
> +	size = st.count * sizeof(*ents);
> +	ents = kvmalloc(size, GFP_KERNEL);
> +	if (!ents)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(ents, uarg + sizeof(st), size)) {
> +		err = -EFAULT;
> +		goto out;
> +	}
> +
> +	for (i = 0; i < st.count; i++) {
> +		if (ents[i].mem_type == VFIO_PCI_TPH_MEM_TYPE_VM) {
> +			mtype = TPH_MEM_TYPE_VM;
> +		} else if (ents[i].mem_type == VFIO_PCI_TPH_MEM_TYPE_PM) {
> +			mtype = TPH_MEM_TYPE_PM;
> +		} else {
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		err = pcie_tph_get_cpu_st(vdev->pdev, mtype, ents[i].cpu, &ents[i].st);
> +		if (err)
> +			goto out;
> +	}
> +
> +	if (copy_to_user(uarg + sizeof(st), ents, size))
> +		err = -EFAULT;
> +
> +out:
> +	kvfree(ents);
> +	return err;
> +}
> +
>   static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
>   			      void __user *uarg)
>   {
> @@ -1544,6 +1593,8 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
>   		return vfio_pci_tph_enable(vdev, &op, uarg + minsz);
>   	case VFIO_PCI_TPH_DISABLE:
>   		return vfio_pci_tph_disable(vdev);
> +	case VFIO_PCI_TPH_GET_ST:
> +		return vfio_pci_tph_get_st(vdev, &op, uarg + minsz);
>   	default:
>   		/* Other ops are not implemented yet */
>   		return -EINVAL;
