Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail2.skidata.com ([91.230.2.91]:30348 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750751AbeCNLmK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Mar 2018 07:42:10 -0400
Subject: Re: [PATCH 3/3] usb: host: pci: replace hardcoded renesas PCI IDs
To: Greg KH <gregkh@linuxfoundation.org>,
        Richard Leitner <dev@g0hl1n.net>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <mathias.nyman@intel.com>,
        <bhelgaas@google.com>
References: <20180314102933.21367-1-dev@g0hl1n.net>
 <20180314102933.21367-4-dev@g0hl1n.net> <20180314104925.GC32615@kroah.com>
From: Richard Leitner <richard.leitner@skidata.com>
Message-ID: <d46c3232-1a45-7e28-9691-de2fcb964ae4@skidata.com>
Date: Wed, 14 Mar 2018 12:38:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180314104925.GC32615@kroah.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 03/14/2018 11:49 AM, Greg KH wrote:
> On Wed, Mar 14, 2018 at 11:29:33AM +0100, Richard Leitner wrote:
>> From: Richard Leitner <richard.leitner@skidata.com>
>>
>> Introduce Renesas uPD72020{1,2} PCI device IDs in pci_ids.h and replace
>> the harcoded values with them.
>>
>> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
>> ---
>>  drivers/usb/host/pci-quirks.c | 6 ++++--
>>  drivers/usb/host/xhci-pci.c   | 4 ++--
>>  include/linux/pci_ids.h       | 2 ++
>>  3 files changed, 8 insertions(+), 4 deletions(-)
>>

> Now this patch was fine :)
> 
> Care to redo this series?

Sure. Will send a v2 soon.

> 
> thanks,
> 
> greg k-h
> 

thank you!

regards;Richard.L
