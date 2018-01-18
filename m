Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57238 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754363AbeARF5K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jan 2018 00:57:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 18 Jan 2018 11:27:09 +0530
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
Subject: Re: [PATCH v5 3/4] PCI/DPC: Unify and plumb error handling into DPC
In-Reply-To: <c77a3302e34d55d557404d7bdc6892fc@codeaurora.org>
References: <1516185438-31556-1-git-send-email-poza@codeaurora.org>
 <1516185438-31556-4-git-send-email-poza@codeaurora.org>
 <733abfcb-5b31-7394-ab62-19a0888d71c2@codeaurora.org>
 <c77a3302e34d55d557404d7bdc6892fc@codeaurora.org>
Message-ID: <5cf7004e62a2979afb3c29e99d705c60@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-01-18 10:47, poza@codeaurora.org wrote:
> On 2018-01-17 22:16, Sinan Kaya wrote:
>> On 1/17/2018 5:37 AM, Oza Pawandeep wrote:
>>> +++ b/include/linux/dpc.h
>>> @@ -0,0 +1,9 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +
>>> +#ifndef _DPC_H_
>>> +#define _DPC_H_
>>> +
>>> +#define DPC_FATAL		4
>>> +
>>> +#endif //_DPC_H_
>>> +
>> 
>> can you keep this in drivers/pci.h and get rid of this file?
> 
> I thought about this, but if I keep it in drivers/pci.h,
> then AER's defines have to be in that as well. (for unification)
> 
> and then all the dependent files who are using AER_FATAL such as
> drivers/acpi/apei/ghees.c
> have to go on including this drivers file which is odd way of doing it.
> 
> So I am not very sure about this....since AER_FATAL are in aer.h, I
> have made dpc.h
> 
> 
> Regards,
> Oza.

Should I be doing in next patch-set series ?
