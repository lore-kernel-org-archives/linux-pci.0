Received: from va-2-36.ptr.blmpb.com (va-2-36.ptr.blmpb.com [209.127.231.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31AD3D75C4
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838917; cv=none; b=AtfTygR1zQi4skYhxeQHGK8V7436OzjoYUgN/2c1XAXuDF4PFlyWpEXPO2UEaJ1E+8/FU+W5dkxTErRHdQW2V+B2XhuIlD8Q5x+IN5QboBBYRcKg9Ir0cm7TMMt0M19Erwqok4L6TqH28+qgs9PHxLnbT/NoR+18XlGd+k3looQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838917; c=relaxed/simple;
	bh=0aysAHvYrw6B9DOm9jNdP/m2mvIaml2mdRDwdF2lKX0=;
	h=From:Date:References:Subject:Message-Id:To:Mime-Version:
	 In-Reply-To:Content-Type:Cc; b=nLxQWeA2c1uKK68gbZ6tQm8BsFMQtrMoMMh3IQxz+3EgVRXfCU3l0gNs55n0qgLqOo9RAEGX8mVlrM6uVerPp4V2Cesc5Fs8P65NucAwFa4HfhNENfjtGLrxjckqkbcmdoLjeN/R0sZI+QPmSrHtRzLRcUR5htUcNE7yxurbQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=IkJAffwR; arc=none smtp.client-ip=209.127.231.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="IkJAffwR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1782838903; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=6KZAdy4hUS6O7eA6Ywzarc/5CRm7L9erW42ZsoYAQEM=;
 b=IkJAffwRb1BjbpJ6WRS0xvRDfvAVfN1+VM/ugvL0gn490j1OaWsnXleqOmyASFP/AaJO77
 /aItBQKybfEDXBeMHBcbSqYievj93srCa0fZB4CVNp8p32skbgW/eTp6y5kghYyGiDNA4b
 IoPUXnM/PwgH1amG3x+Jtvd9HXX0TZGPte0fLfobj20P5MmDDFRB540bIK+VqPapnnGnrP
 d2PacjORINxbNOeMnOHw/U94bcTEpU4MScI1wO1XQ5HEQr1Qcv0cd2bgTQN9Su18qn326o
 cL4UbhVJrioiHW93npuE9BiHqDoI6U/0swjkiW3KVaIuth9m5MiVkCaG548wsQ==
From: "Yicong Yang" <yang.yicong@picoheart.com>
Date: Wed, 1 Jul 2026 01:01:38 +0800
X-Lms-Return-Path: <lba+26a43f675+e9fa94+vger.kernel.org+yang.yicong@picoheart.com>
References: <20260629092717.74946-1-yang.yicong@picoheart.com> <20260629092717.74946-2-yang.yicong@picoheart.com> <akOpEaCM0TiZB2zD@ryzen>
Subject: Re: [PATCH v2 1/3] perf/dwc_pcie: Add support for Picoheart vendor devices
Message-Id: <9d2e0676-0211-49a8-b63a-2a769211775e@picoheart.com>
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Content-Transfer-Encoding: 7bit
To: "Niklas Cassel" <cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <akOpEaCM0TiZB2zD@ryzen>
Content-Type: text/plain; charset=UTF-8
Received: from [172.16.14.160] ([219.142.31.218]) by smtp.feishu.cn with ESMTPS; Wed, 01 Jul 2026 01:01:41 +0800
Content-Language: en-US
User-Agent: Mozilla Thunderbird
Cc: <yang.yicong@picoheart.com>, <xueshuai@linux.alibaba.com>, 
	<renyu.zj@linux.alibaba.com>, <will@kernel.org>, <mark.rutland@arm.com>, 
	<jic23@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>, 
	<mani@kernel.org>, <juwenlong@picoheart.com>, <geshijian@picoheart.com>, 
	<douyufan@picoheart.com>

On 6/30/26 7:31 PM, Niklas Cassel wrote:
> On Mon, Jun 29, 2026 at 05:27:15PM +0800, Yicong Yang wrote:
>> Add PCI_VENDOR_ID_PICOHEART in pci_ids.h. Update the DWC PCIe
>> vendor table with Picoheart PCIe vendorid to enable the PCIe
>> PMU support.
>>
>> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
>> ---
>>  include/linux/pci_ids.h  | 2 ++
>>  include/linux/pcie-dwc.h | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 1c9d40e09107..2c17239aacea 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2640,6 +2640,8 @@
>>  #define PCI_VENDOR_ID_SUNIX		0x1fd4
>>  #define PCI_DEVICE_ID_SUNIX_1999	0x1999
>>  
>> +#define PCI_VENDOR_ID_PICOHEART		0x20fa
>> +
>>  #define PCI_VENDOR_ID_HINT             0x3388
>>  #define PCI_DEVICE_ID_HINT_VXPROII_IDE 0x8013
>>  
>> diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
>> index 8ff778e7aec0..b0ccb2ad74db 100644
>> --- a/include/linux/pcie-dwc.h
>> +++ b/include/linux/pcie-dwc.h
>> @@ -32,6 +32,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
>>  	  .vsec_id = 0x02, .vsec_rev = 0x4 },
>>  	{ .vendor_id = PCI_VENDOR_ID_SAMSUNG,
>>  	  .vsec_id = 0x02, .vsec_rev = 0x4 },
>> +	{ .vendor_id = PCI_VENDOR_ID_PICOHEART,
>> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> 
> Could you please point to the in-tree device driver for this
> DWC based "picoheart" PCIe controller?
> 
> $ git grep -i picoheart drivers/pci/controller/dwc/
> <nothing>
> 
> It feels wrong to add PMU support for a PCIe controller,
> if that PCIe controller does not have support in mainline.
> 

we're using ACPI thus go through the common ACPI PCI code
for PCIe controller itself. it's same to the already listed
alibaba and ampere here (suppose they're also ACPI based system).

thanks.
