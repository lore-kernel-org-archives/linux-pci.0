Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81591223339;
	Mon,  6 Apr 2026 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775442060; cv=none; b=fhMXLIPkw2V/n6IFD8k5QkCGwONvIzBSyHVYFeqBjRStyB564+WoY0kBpUpXrwXTIRQeIUoCCGyhuDSq4U5VULFpWRCajMp94MWB/sjRhoJd0HgaC3vkKXT7RQH34E/EbfsJ5ZJFDVrlW8VVR/loGyNYIg+B64i9kNtcxOUY/NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775442060; c=relaxed/simple;
	bh=vLByfHSZMa5wGmp74nx35NuNR1dAMFBiAAKDIMbbYaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktvrAvV690CfluQsRR69LZZg8cEnl6WA8eH5hchBjMW5IeATRxHdYwgwldEmyRYV14xCuHyfXulXv2k35yRYl8HyPhARfFEJcmndtXO8D0/wBx40X6fyweldCu0QC+l9gHXJQWJ0MVLazFulW0vYfy/9xKVIKI/x6FO95uO4Aw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ND2299YM; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ND2299YM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=3lMlKIxV2FaXBQgtrhP35rTZqaBOKySnkx0QmaSSF84=;
	b=ND2299YMWpgpXxfZpvARdW6Ml9PTXU7fJnFoENvk4i2yaSFB6xcXyAEWKuSk0K
	oRs2HmFd2TEET8xMNYaLMY+Hp9CkFWBKX35pnPFuM7Cx7aaQ5ZE734nk2HoxfXpR
	G+n3WWM30vqIesx/ecnoU6LiZwWHESlgW9ulpizcgvw10=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBnk8NYGNNpzjBcZA--.28982S2;
	Mon, 06 Apr 2026 10:20:08 +0800 (CST)
Message-ID: <e9d967ba-0d9d-4d03-bd4f-ddccd9b9cc55@163.com>
Date: Mon, 6 Apr 2026 10:20:08 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 hans.zhang@cixtech.com, robh@kernel.org, mpillai@cadence.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260321033035.3008585-1-18255117159@163.com>
 <20260321033035.3008585-3-18255117159@163.com>
 <qosem7gsbmpjj45nh7tapp7lmnvixkbmgynwhsmralrbrjqij4@l6baberoe3nt>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <qosem7gsbmpjj45nh7tapp7lmnvixkbmgynwhsmralrbrjqij4@l6baberoe3nt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgBnk8NYGNNpzjBcZA--.28982S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JFy3Jw1ruw17Cw4rWFy7Awb_yoW7XrW7pa
	yDGF4fCa1xZrW3Za4fu3WUGFyft3s7Aa4UG39F934xZFnrur15JF4IgFW5KFZrWr4qgr1x
	Z3W5tasrKr4aya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U53kNUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xhrD2nTGFg1PwAA3n



On 4/5/26 00:30, Manivannan Sadhasivam wrote:
> On Sat, Mar 21, 2026 at 11:30:35AM +0800, Hans Zhang wrote:
>> Add the debugfs property to provide a view of the current link's LTSSM
>> status from the Root Port device.
>>
>> Test example:
>>    # cat /sys/kernel/debug/cdns_pcie_a0c0000.pcie/ltssm_status
>>    L0_STATE (0x29)
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
>>   drivers/pci/controller/cadence/Kconfig        |   9 +
>>   drivers/pci/controller/cadence/Makefile       |   1 +
>>   .../controller/cadence/pcie-cadence-debugfs.c | 214 ++++++++++++++++++
>>   .../pci/controller/cadence/pcie-cadence-ep.c  |   2 +
>>   .../cadence/pcie-cadence-host-hpa.c           |   8 +-
>>   .../controller/cadence/pcie-cadence-host.c    |   8 +-
>>   drivers/pci/controller/cadence/pcie-cadence.h | 145 ++++++++++++
>>   8 files changed, 390 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
>>   create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>
>> diff --git a/Documentation/ABI/testing/debugfs-cdns-pcie b/Documentation/ABI/testing/debugfs-cdns-pcie
>> new file mode 100644
>> index 000000000000..659ad2ab70e4
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-cdns-pcie
>> @@ -0,0 +1,5 @@
>> +What:		/sys/kernel/debug/cdns_pcie_<dev>/ltssm_status
>> +Date:		March 2026
>> +Contact:	Hans Zhang <18255117159@163.com>
>> +Description:	(RO) Read will return the current PCIe LTSSM state in both
>> +		string and raw value.
> 
> Entries should be aligned.

Hi Mani,

 From my code, it seems to be that of it. The tab size is 8. And it was 
copied from the file /sys/kernel/debug/dwc_pcie_<dev>/ltssm_status in 
the Documentation/ABI/testing/debugfs-dwc-pcie directory that I 
previously submitted.


> 
>> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
>> index 9e651d545973..b277c5f6e196 100644
>> --- a/drivers/pci/controller/cadence/Kconfig
>> +++ b/drivers/pci/controller/cadence/Kconfig
>> @@ -6,6 +6,15 @@ menu "Cadence-based PCIe controllers"
>>   config PCIE_CADENCE
>>   	tristate
>>   
>> +config PCIE_CADENCE_DEBUGFS
>> +	bool "Cadence PCIe debugfs entries"
>> +	depends on DEBUG_FS
>> +	depends on PCIE_CADENCE_HOST || PCIE_CADENCE_EP
>> +	help
>> +	  Say Y here to enable debugfs entries for the PCIe controller. These
>> +	  entries provide various debug features related to the controller and
>> +	  the LTSSM status of link can be displayed.
>> +
>>   config PCIE_CADENCE_HOST
>>   	tristate
>>   	depends on OF
>> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
>> index b8ec1cecfaa8..2cdc4617e0c2 100644
>> --- a/drivers/pci/controller/cadence/Makefile
>> +++ b/drivers/pci/controller/cadence/Makefile
>> @@ -4,6 +4,7 @@ pcie-cadence-host-mod-y := pcie-cadence-host-common.o pcie-cadence-host.o pcie-c
>>   pcie-cadence-ep-mod-y := pcie-cadence-ep.o
>>   
>>   obj-$(CONFIG_PCIE_CADENCE) = pcie-cadence-mod.o
>> +obj-$(CONFIG_PCIE_CADENCE_DEBUGFS) += pcie-cadence-debugfs.o
>>   obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-mod.o
>>   obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
>>   obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>> new file mode 100644
>> index 000000000000..16addd919eae
>> --- /dev/null
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>> @@ -0,0 +1,214 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Cadence PCIe controller debugfs driver
>> + *
>> + * Copyright (C) 2026 Hans Zhang <18255117159@163.com>
>> + * Author: Hans Zhang <18255117159@163.com>
>> + */
>> +
>> +#include <linux/debugfs.h>
>> +
>> +#include "pcie-cadence.h"
>> +
>> +#define CDNS_DEBUGFS_BUF_MAX		128
>> +#define CDNS_PCIE_LGA_LTSSM_STATUS_MASK	GENMASK(29, 24)
>> +#define CDNS_PCIE_HPA_LTSSM_STATUS_MASK	GENMASK(27, 20)
>> +
> 
> [...]
> 
>> +static const struct file_operations cdns_pcie_ltssm_status_ops = {
>> +	.open = ltssm_status_open,
>> +	.read = seq_read,
>> +};
>> +
>> +static void cdns_pcie_ltssm_debugfs_init(struct cdns_pcie *pci, struct dentry *dir)
>> +{
>> +	debugfs_create_file("ltssm_status", 0444, dir, pci,
>> +			    &cdns_pcie_ltssm_status_ops);
>> +}
>> +
>> +void cdns_pcie_debugfs_deinit(struct cdns_pcie *pci)
>> +{
>> +	if (!pci->debug_dir)
>> +		return;
>> +
>> +	debugfs_remove_recursive(pci->debug_dir);
>> +}
> 
> You've never called this API in any controller driver. So the debugfs entries
> are not cleaned up properly.
> 
> If you do so, please export this function also.

Thank you for pointing out the issue. It seems that the call to 
cdns_pcie_debugfs_deinit was omitted, and it needs to be exported as 
well. It will be fixed in the next version.

Best regards,
Hans

> 
> - Mani
> 

