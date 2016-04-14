Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58275 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbcDNP7B (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2016 11:59:01 -0400
Subject: Re: [PATCH v2 4/4] ACPI: PCI: Add generic PCI host controller
To: Jayachandran C <jchandra@broadcom.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Tomasz Nowicki <tn@semihalf.com>, rafael@kernel.org
References: <1460414707-19153-1-git-send-email-jchandra@broadcom.com>
 <1460414707-19153-5-git-send-email-jchandra@broadcom.com>
 <570FBCF6.50407@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	jiang.liu@linux.intel.com,
	Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>,
	robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>,
	Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Jon Masters <jcm@redhat.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <570FBE41.7040303@codeaurora.org>
Date: Thu, 14 Apr 2016 11:58:57 -0400
MIME-Version: 1.0
In-Reply-To: <570FBCF6.50407@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4/14/2016 11:53 AM, Sinan Kaya wrote:
> On 4/11/2016 6:45 PM, Jayachandran C wrote:
>> +/* find the entry in cfgarr which contains range bus_start..bus_end */
>> +static int mcfg_lookup(u16 seg, u8 bus_start, u8 bus_end)
>> +{
>> +	struct pci_config_window *cfg;
>> +	int i;
>> +
>> +	if (!cfgarr)
>> +		return -ENOENT;
>> +
>> +	for (i = 0; cfgarr[i]; i++) {
>> +		cfg = cfgarr[i];
>> +
> 
> I see that you are allocating an array of cfgarr to keep the MCFG table entries.
> The above way of checking the number of entries is not correct. 
> 
> You should keep track of the number of entries you found out globally instead of 
> relying an element being NULL or not. 
> 
> If you exceed the array size, you may or may not be lucky to find another entry
> in memory.
> 

I see now that you are allocating an extra element in memory. Still, looping to find
out the number of elements didn't quite look good to me.

+		for (i = 0; cfgarr[i]; i++)
+			;
+		pr_info(PREFIX " MCFG table at loaded, %d entries\n", i);


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
