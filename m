Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35376 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755852AbeASQW3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jan 2018 11:22:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 19 Jan 2018 21:52:28 +0530
From: poza@codeaurora.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v6 7/7] PCI: Unify wait for link active into generic pci
In-Reply-To: <10da80a3-e058-1a21-7af2-405c99b7991e@codeaurora.org>
References: <1516360204-1586-1-git-send-email-poza@codeaurora.org>
 <1516360204-1586-8-git-send-email-poza@codeaurora.org>
 <10da80a3-e058-1a21-7af2-405c99b7991e@codeaurora.org>
Message-ID: <b95d4a6ab14aacdf0925c02448f8fef5@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-01-19 19:47, Sinan Kaya wrote:
> On 1/19/2018 6:10 AM, Oza Pawandeep wrote:
>> +++ b/drivers/pci/pcie/pcie-dpc.c
>> @@ -150,37 +150,9 @@ static void dpc_wait_link_inactive(struct dpc_dev 
>> *dpc)
>>  	struct pci_dev *pdev = dpc->dev->port;
>>  	struct device *dev = &dpc->dev->device;
>>  	u16 lnk_status;
>> +	bool active = false;
>> 
>> -	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>> -	while (lnk_status & PCI_EXP_LNKSTA_DLLLA &&
>> -					!time_after(jiffies, timeout)) {
>> -		msleep(10);
>> -		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>> -	}
>> -	if (lnk_status & PCI_EXP_LNKSTA_DLLLA)
>> -		dev_warn(dev, "Link state not disabled for DPC event\n");
>> -}
> 
> I think you should reorder 6 and 7 to eliminate this.

Sure will reorder them

Regards,
Oza.
