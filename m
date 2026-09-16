Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4474CEE4F
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574484; cv=none; b=PBijF0Y7QGo8Cb094uNCgk73CCIgM1hwkNToJdl6MncEXUF4YzaS16RAy+Ye5avlcksuQUx4FcGkvsN7jmSM7C5KCfcodaSg+pJFnZBAJYwk/MmdJp+m+8Gy3+x0s72l2OZUxz1l93wWcl7khe4/LXi6mNkBpoRh1XI2xxus4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574484; c=relaxed/simple;
	bh=ZOWMZlV7dIId0Oq1envK8gIOfVU0kuIwLpbq58ddKzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlBVJC+chtY2g3VywK1XOYGtGUEWieUGiLhqrP/aHc+Gwo9l8OuFObEEL9H1nkvbAsRhOGYm4AiIeB2TNQSNrZ+9MbefhbK5eWPNvRAl5ojhCGk9pFbpAZMp04VsyiZ3qiMUGg8bGofe1qavV106iDT+rwuopIZFFZ4PS13AYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gFPzrwkE; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gFPzrwkE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=yAL2lM24N2c7+9aduKXD74ve9wflnU4W1RARVreAXIM=;
	b=gFPzrwkE9fHkklMKKW9o+xKAmNFcYkGioWWn1Ll4E/KY3tYXPQ5Uy/Jrl1LEIg
	Ess0cLLgrFMK2ltKMfXV3wqrb7VIIv+d2SqdgEj7z6WQEGC8tpDt8/0gHUeX6X+1
	HzgKXeeBWYSMYfpw4bIpXXXbeZ9cxoVE3et4/oejLmRZ4=
Received: from [IPV6:240e:b8f:91b3:d000:a95a:12fc:887a:b0f1] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3X2sqvapqHFkTBA--.34803S2;
	Thu, 17 Sep 2026 00:00:42 +0800 (CST)
Message-ID: <d8e6c9be-ee1d-4426-9595-faf655ba0306@163.com>
Date: Thu, 17 Sep 2026 00:00:42 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] PCI: Match the hierarchy's MPS to a device's MPSS
 as necessary
To: sashiko-reviews@lists.linux.dev
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org,
 linux-pci@vger.kernel.org
References: <20260916153907.60344-1-18255117159@163.com>
 <20260916153907.60344-2-18255117159@163.com>
 <20260916155239.06ECC1F000FF@smtp.kernel.org>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260916155239.06ECC1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3X2sqvapqHFkTBA--.34803S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JFW8WrWUuw1fWw4kur1UAwb_yoW7Zw1DpF
	WDGF9Yyr4DJryUta1DZ3WrZr95GFs3ZayrJr90k34Iva45CryrKryYyr43Gw4xJrZxGFyj
	yr1qq34xX3Z8taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRO18PUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wq+YmqqvSo1HAAA3D

Hi,

Thanks for the review.

On 9/16/26 23:52, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] pci: pci_walk_bus() modifies MPS of active devices causing Malformed TLPs
> - [High] pci: dynamically modified MPS in pcie_set_mps() is lost on system resume
> - [High] pci: unlocked RMW of PCI_EXP_DEVCTL in pcie_set_mps() causes data races
> --
> 
> commit 5af1f52d57f95fe2335fa9124a2d504949bbc917
> Author: Hans Zhang <18255117159@163.com>
> 
> PCI: Match the hierarchy's MPS to a device's MPSS as necessary
> 
> When a device's MPSS is too small to match the upstream bridge,
> pci_configure_mps() now walks the hierarchy from the Root Port down
> and reduces every device that is above the new value to avoid
> Malformed TLPs on Switch egress ports.
> 
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 27008e2ea5afc..232bce2819f06 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2200,9 +2200,28 @@ int pci_setup_device(struct pci_dev *dev)
>>   	return 0;
>>   }
>>   
>> +static int pcie_reduce_mps(struct pci_dev *dev, void *data)
>> +{
>> +	int mps = *(int *)data;
>> +	int ret;
>> +
>> +	/* MPS is of type 'RsvdP' for VFs */
>> +	if (!pci_is_pcie(dev) || dev->is_virtfn)
>> +		return 0;
>> +
>> +	if (pcie_get_mps(dev) > mps) {
>> +		ret = pcie_set_mps(dev, mps);
>                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [Severity: High]
> Does bypassing the PM software save state here cause the dynamically modified
> MPS to be lost on system resume?
> 
> If the sibling driver previously called pci_save_state() during its probe,
> dev->state_saved becomes true. During the next suspend, the PM core skips
> saving the new hardware state. On resume, the old, larger MPS would be
> restored, potentially desynchronizing the hierarchy.
> 

pci_save_state() is called from the driver's probe path, which runs 
after enumeration has completed.  pcie_reduce_mps() runs during 
enumeration, i.e. before any driver can have called pci_save_state(). 
The saved state therefore already contains the reduced MPS and it is 
restored correctly on resume.


> [Severity: High]
> Also, does modifying the hardware MPS of active third-party endpoints using
> an unlocked Read-Modify-Write of PCI_EXP_DEVCTL cause data races?
> 
> pcie_set_mps() performs an unlocked RMW of PCI_EXP_DEVCTL. If the sibling
> driver or userspace (via VFIO) modifies the same register concurrently
> (e.g., via pcie_set_readrq()), could it corrupt the configuration state of
> active endpoints?


pcie_set_mps() does not perform an unlocked RMW.  It calls
pcie_capability_clear_and_set_word(), which serializes config space
access through pci_lock.  Concurrent access from userspace (VFIO) or 
from pcie_set_readrq() cannot corrupt PCI_EXP_DEVCTL.

> 
>> +		if (ret)
>> +			dev_warn(&dev->dev, "failed to set MPS\n");
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static void pci_configure_mps(struct pci_dev *dev)
>>   {
>>   	struct pci_dev *bridge = pci_upstream_bridge(dev);
> 
> [ ... ]
> 
>> @@ -2252,10 +2271,21 @@ static void pci_configure_mps(struct pci_dev *dev)
>>   		return;
>>   
>>   	mpss = 128 << dev->pcie_mpss;
>> -	if (mpss < p_mps && pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT) {
>> -		pcie_set_mps(bridge, mpss);
>> -		pci_info(dev, "Upstream bridge's Max Payload Size set to %d (was %d, max %d)\n",
>> -			 mpss, p_mps, 128 << bridge->pcie_mpss);
>> +	rp = pcie_find_root_port(bridge);
>> +	if (mpss < p_mps && rp) {
>> +		/*
>> +		 * dev cannot be programmed to the MPS already in use above
>> +		 * it, so reduce the hierarchy to what dev supports.  A Switch
>> +		 * may not repackage TLPs, so reducing only the upstream
>> +		 * bridge is not enough: every port up to the Root Port has to
>> +		 * come down as well, and so do the devices already programmed
>> +		 * below that Root Port, which would otherwise be left sending
>> +		 * TLPs too large for their egress port.
>> +		 */
>> +		pcie_reduce_mps(rp, &mpss);
>> +		pci_walk_bus(rp->subordinate, pcie_reduce_mps, &mpss);
>                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [Severity: Critical]
> Does unconditionally walking the bus and dynamically reducing the MPS of active
> siblings cause Malformed TLPs?
> 
> PCIe specifications prohibit changing MPS while a device is active. Active
> devices will continue generating TLPs based on their driver's internal state
> (or previously negotiated packet sizes). When these larger TLPs hit the
> dynamically reduced upstream bridge, won't they be dropped as Malformed
> TLPs, potentially leading to a system crash or bus reset?

The concern is valid in principle, but pci_configure_mps() is only
called from pci_configure_device() during pci_setup_device(), i.e. while
the device is being enumerated and before its driver has probed.  No
device below the Root Port can be actively driving TLPs at that point,
so the "active NIC or early firmware-driven display controller" scenario
does not apply on this path.

The same applies to the hotplug case: the newly added device goes 
throughpci_setup_device() and pci_configure_mps() before it is bound to 
a driver.  Reducing the Root Port's MPS when a downstream device has a
smaller MPSS is also pre-existing behaviour from 9f0e89359775; this
series extends it to Switch ports and already-programmed siblings, which
is required to fix the Switch mismatch reported in v8.  I will document
this precondition in the commit message.




Best regards,
Hans

> 
>> +		pci_info(dev, "Max Payload Size of %s hierarchy set to %d (was %d)\n",
>> +			 pci_name(rp), mpss, p_mps);
>>   		p_mps = pcie_get_mps(bridge);
>>   	}
> 

