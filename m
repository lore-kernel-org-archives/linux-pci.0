Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52142 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbeCOHyE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Mar 2018 03:54:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 15 Mar 2018 13:24:03 +0530
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
Subject: Re: [PATCH v2] PCI/DPC: Fix PCI legacy interrupt acknowledgement
In-Reply-To: <20180314205230.GF29867@localhost.localdomain>
References: <1521042648-20522-1-git-send-email-poza@codeaurora.org>
 <20180314205230.GF29867@localhost.localdomain>
Message-ID: <b67f0624a9643f73a86126f4c6f18657@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-03-15 02:22, Keith Busch wrote:
> On Wed, Mar 14, 2018 at 09:20:48PM +0530, Oza Pawandeep wrote:
>> Current DPC driver acknowledges the interrupt in deferred work, which 
>> works
>> since MSI are edge triggered.
>> 
>> But when MSI is disabled (e.g. pci=nomsi boot option) port service
>> driver falls back to PCI legacy INT interrupt.
>> 
>> With current code we do not acknowledge the interrupt back in 
>> dpc_irq()
>> and we get dpc interrupt storm.
>> 
>> This patch acknowledges the interrupt in interrupt handler.
>> 
>> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> Thanks, this looks good to me.
> 
> Reviewed-by: Keith Busch <keith


checkpatch script shows
WARNING: 'acknowledgement' may be misspelled - perhaps 'acknowledgment'?

but dictionaries shows acknowledgement.

Regards,
Oza.
