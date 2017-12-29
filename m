Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41486 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbdL2FP4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Dec 2017 00:15:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 29 Dec 2017 10:45:55 +0530
From: poza@codeaurora.org
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Wei Zhang <wzhang@fb.com>, Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 0/4] Address error and recovery for AER and DPC
In-Reply-To: <20171228173428.GA16071@localhost.localdomain>
References: <1514370022-4431-1-git-send-email-poza@codeaurora.org>
 <20171228173428.GA16071@localhost.localdomain>
Message-ID: <25e27773fd3bd15b22432e6db6f156dc@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017-12-28 23:04, Keith Busch wrote:
> On Wed, Dec 27, 2017 at 02:20:18AM -0800, Oza Pawandeep wrote:
>> DPC should enumerate the devices after recovering the link, which is
>> achieved by implementing error_resume callback.
> 
> Wouldn't that race with the link-up event that pciehp currently 
> handles?

It is with pci_lock_rescan_remove().
I was able to test with and without pciehp on our platform, and things 
seemed to be okay.

Regards,
Oza.
