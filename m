Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51098 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbeDLIk6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Apr 2018 04:40:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 12 Apr 2018 14:10:57 +0530
From: poza@codeaurora.org
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Wei Zhang <wzhang@fb.com>, Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v13 5/6] PCI: Unify wait for link active into generic PCI
In-Reply-To: <20180409232528.GE6283@localhost.localdomain>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-6-git-send-email-poza@codeaurora.org>
 <20180409232528.GE6283@localhost.localdomain>
Message-ID: <ce67a10c0626f9ef27aae056fe5dd286@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-04-10 04:55, Keith Busch wrote:
> On Mon, Apr 09, 2018 at 10:41:53AM -0400, Oza Pawandeep wrote:
>> +/**
>> + * pcie_wait_for_link - Wait for link till it's active/inactive
>> + * @pdev: Bridge device
>> + * @active: waiting for active or inactive ?
>> + *
>> + * Use this to wait till link becomes active or inactive.
>> + */
>> +bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
>> +{
>> +	int timeout = 1000;
>> +	bool ret;
>> +	u16 lnk_status;
>> +
>> +	for (;;) {
>> +		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>> +		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
>> +		if (ret == active)
>> +			return true;
>> +		if (timeout <= 0)
>> +			break;
>> +		timeout -= 10;
>> +	}
> 
> This is missing an msleep(10) at each iteration.

will take care.

> 
>> +
>> +	pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
>> +		 active ? "set" : "cleared");
>> +
>> +	return false;
>> +}
