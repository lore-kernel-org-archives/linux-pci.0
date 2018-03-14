Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.skidata.com ([91.230.2.99]:1612 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750855AbeCNLqd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Mar 2018 07:46:33 -0400
Subject: Re: [PATCH 2/3] usb: host: pci: introduce PCI vendor ID for Netlogic
To: Greg KH <gregkh@linuxfoundation.org>,
        Richard Leitner <dev@g0hl1n.net>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <mathias.nyman@intel.com>,
        <bhelgaas@google.com>
References: <20180314102933.21367-1-dev@g0hl1n.net>
 <20180314102933.21367-3-dev@g0hl1n.net> <20180314104849.GB32615@kroah.com>
From: Richard Leitner <richard.leitner@skidata.com>
Message-ID: <d755d623-2bb3-460f-45a0-2be6ab6f47ea@skidata.com>
Date: Wed, 14 Mar 2018 12:36:17 +0100
MIME-Version: 1.0
In-Reply-To: <20180314104849.GB32615@kroah.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 03/14/2018 11:48 AM, Greg KH wrote:
> On Wed, Mar 14, 2018 at 11:29:32AM +0100, Richard Leitner wrote:
>> From: Richard Leitner <richard.leitner@skidata.com>
>>
>> Replace the hardcoded PCI vendor ID of Netlogic with a definition in
>> pci_ids.h
> 
> Why?  It's only being used in one file, so it should not be in
> pci_ids.h, right?

It's also used as PCI_VENDOR_NETLOGIC in arch/mips/netlogic/xlp/.

Should this be replaced with PCI_VENDOR_ID_NETLOGIC from pci_ids.h?

> 
> thanks,
> 
> greg k-h
> 

thank you!

regards;Richard.L
