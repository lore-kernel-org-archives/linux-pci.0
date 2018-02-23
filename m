Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50444 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbeBWGxb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Feb 2018 01:53:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 23 Feb 2018 12:23:30 +0530
From: poza@codeaurora.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v10 6/7] PCI: Unify wait for link active into generic pci
In-Reply-To: <20180222184348.GE6267@infradead.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
 <1519315332-26852-7-git-send-email-poza@codeaurora.org>
 <20180222184348.GE6267@infradead.org>
Message-ID: <be1f86033845121116b35ad17ead9527@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-02-23 00:13, Christoph Hellwig wrote:
>> 
>> +/**
>> + * pci__wait_for_link - Wait for link till its active/inactive
> 
> typo - just wants a single underscore.
> 
>> +	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>> +	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> 
> no need for the !! when assigning to a boolean.

bool is 8 bit, while
#define  PCI_EXP_LNKSTA_DLLLA	0x2000	/* Data Link Layer Link Active */
so I think we need it. otherwise it will treat lnk_status & 
PCI_EXP_LNKSTA_DLLLA as 0 even if 13th bit is set.

> 
>> +
>> +	while ((ret != active) && (timeout > 0)) {
> 
> No need for either pair of inner braces.
> 
>> +		msleep(10);
>> +		timeout -= 10;
>> +		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>> +		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> 
> Same as above.
> 
>> +	}
>> +
>> +	if (ret == active)
>> +		return true;
> 
> Seems like the structure is a bit odd.  Why not:
> 
> 	for (;;) {
> 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> 		if ((lnk_status & PCI_EXP_LNKSTA_DLLLA) == active)
> 			return true;
> 		if (timeout <= 0)
> 			break;
> 		timeout -= 10;
> 	}

Thanks for suggestion, will do this way. thanks.
Regards,
Oza.
