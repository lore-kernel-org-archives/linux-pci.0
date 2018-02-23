Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58452 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeBWFYh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Feb 2018 00:24:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 23 Feb 2018 10:54:35 +0530
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
Subject: Re: [PATCH v10 1/7] PCI/AER: Rename error recovery to generic pci
 naming
In-Reply-To: <20180222183403.GA6267@infradead.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
 <1519315332-26852-2-git-send-email-poza@codeaurora.org>
 <20180222183403.GA6267@infradead.org>
Message-ID: <4388ff68e84185bd825abf7ff4ae952d@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-02-23 00:04, Christoph Hellwig wrote:
> On Thu, Feb 22, 2018 at 09:32:06PM +0530, Oza Pawandeep wrote:
>> This patch renames error recovery to generic name with pci prefix
>> 
>> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>> 
>> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c 
>> b/drivers/pci/pcie/aer/aerdrv_core.c
>> index a4bfea5..306bf2f 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_core.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
>> @@ -478,7 +478,7 @@ static pci_ers_result_t reset_link(struct pci_dev 
>> *dev)
>>  }
>> 
>>  /**
>> - * do_recovery - handle nonfatal/fatal error recovery process
>> + * pci_do_recovery - handle nonfatal/fatal error recovery process
>>   * @dev: pointer to a pci_dev data structure of agent detecting an 
>> error
>>   * @severity: error severity type
>>   *
>> @@ -486,7 +486,7 @@ static pci_ers_result_t reset_link(struct pci_dev 
>> *dev)
>>   * error detected message to all downstream drivers within a 
>> hierarchy in
>>   * question and return the returned code.
>>   */
>> -static void do_recovery(struct pci_dev *dev, int severity)
>> +static void pci_do_recovery(struct pci_dev *dev, int severity)
> 
> Maybe pcie_do_recovery?
> 

sure will take care.
Thanks.

> Otherwise looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
