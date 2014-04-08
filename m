Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:52396 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbaDHJ1e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Apr 2014 05:27:34 -0400
Message-ID: <5343C0C7.3050806@huawei.com>
Date: Tue, 8 Apr 2014 17:26:31 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/2] PCI: Refactor pci_is_bridge()
References: <1394789926-11912-1-git-send-email-wangyijing@huawei.com> <20140404233251.GB15806@google.com>
In-Reply-To: <20140404233251.GB15806@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> +static inline bool pci_is_bridge(struct pci_dev *dev)
>> +{
>> +	return dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
>> +		dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
>> +}
> 
> There's no point in adding this unless somebody uses it (but I assume
> you probably meant to use it in acpi_pci_find_companion() as I mentioned).

I will resend a complete patchset soon if you think it make sense.

Thanks!
Yijing.

> 
>>  /**
>>   * pcie_caps_reg - get the PCIe Capabilities Register
>>   * @dev: PCI device
>> -- 
>> 1.7.1
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Thanks!
Yijing

