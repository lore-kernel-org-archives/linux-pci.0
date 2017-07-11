Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:35114 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbdGKLCp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2017 07:02:45 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: PCI endpoint API question
To: Christoph Hellwig <hch@infradead.org>
References: <20170618140530.GA22519@infradead.org>
 <f7596eb9-cb96-7b82-699a-c8a1f7e85b6e@ti.com>
 <20170619150547.GA22227@infradead.org>
CC: <linux-pci@vger.kernel.org>
Message-ID: <cd2d33d6-8abd-421f-6992-01c9aa8f4a96@ti.com>
Date: Tue, 11 Jul 2017 16:32:04 +0530
MIME-Version: 1.0
In-Reply-To: <20170619150547.GA22227@infradead.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Monday 19 June 2017 08:35 PM, Christoph Hellwig wrote:
> On Mon, Jun 19, 2017 at 03:20:29PM +0530, Kishon Vijay Abraham I wrote:
>>> for writes to BARs - is this and intentional omission?  It seems
>>> like the only current option is to poll for changes.
>>
>> You mean write to the address that's mapped to BAR in the EP side?
>>
>> PCI doesn't allow hosts to interrupt the EP (AFAIK), so we have to poll for any
>> writes by the host to EP memory.
> 
> At least out on the bus each MMIO access translates to PCIe Memory
> Read/Write TLPs, so the EP itself for sure gets a notification.  I don't
> really know enough about existing programmable endpoint IP to know
> how that could be forwarded to software, though.

yeah, at least in dra7xx I'm not aware of any way in which it is notified to
software. Off late I'm working on enabling endpoint mode in another TI platform
K2G. And there they re-use MSI register for the host to interrupt the endpoint.
See "11.14.4.16.3 Interrupt Generation in RC Mode" section in
http://www.ti.com/lit/ug/spruhy8f/spruhy8f.pdf.

Thanks
Kishon
