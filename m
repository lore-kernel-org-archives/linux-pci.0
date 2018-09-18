Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59590 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbeISAiw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2018 20:38:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 19 Sep 2018 00:34:52 +0530
From: poza@codeaurora.org
To: Sinan Kaya <okaya@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Wei Zhang <wzhang@fb.com>, linux-kernel@vger.kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] PCI/AER: Clear uncorrectable error status for device
In-Reply-To: <ab1ee64e-d257-4521-1517-4c2c648d0d9c@kernel.org>
References: <1537258829-15763-1-git-send-email-poza@codeaurora.org>
 <ab1ee64e-d257-4521-1517-4c2c648d0d9c@kernel.org>
Message-ID: <49a44a7202802c20d52164403139284b@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-09-18 20:00, Sinan Kaya wrote:
> On 9/18/2018 4:20 AM, Oza Pawandeep wrote:
>> +++ b/drivers/pci/pcie/err.c
>> @@ -265,6 +265,8 @@ static pci_ers_result_t 
>> broadcast_error_message(struct pci_dev *dev,
>>   		 * The error is non fatal so the bus is ok; just invoke
>>   		 * the callback for the function that logged the error.
>>   		 */
>> +		if (cb == report_resume)
>> +			pci_cleanup_aer_uncorrect_error_status(dev);
>>   		cb(dev, &result_data);
>>   	}
> 
> In order to follow the existing behavior (drivers are calling
> pci_cleanup_aer_uncorrect_error_status() right before return),
> you should probably move the pci_cleanup_aer_uncorrect_error_status
> after
> 
> cb(dev, &result_data);
> 
> line.

some drivers are calling it in slot_reset, which is before resume,
while some are calling in beginning of resume (e.g. netxen_io_resume)

hence I have kept it before calling resume()   (e.g. before cb(dev, 
&result_data))

Regards,
Oza.
