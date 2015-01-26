Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:47402 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbbAZQrR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jan 2015 11:47:17 -0500
Received: by mail-qc0-f175.google.com with SMTP id c9so7802058qcz.6
        for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2015 08:47:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACna6rz8dWYzDzBNV48VHqUYGzbqVneqjiQW5tzs7Nc=_wtX6Q@mail.gmail.com>
References: <1422263957-3148-1-git-send-email-zajec5@gmail.com>
 <CAErSpo4bN0kWP6a6qeU0QCZ23BwC-FJ1RTuaGMvS7zamiVp_Fw@mail.gmail.com> <CACna6rz8dWYzDzBNV48VHqUYGzbqVneqjiQW5tzs7Nc=_wtX6Q@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 26 Jan 2015 10:46:56 -0600
Message-ID: <CAErSpo7WxJ5sFiGRwSXd_ayL-CmxtcH5S8gD3U9wPsnyywRREA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add defines for max read requests sizes
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 26, 2015 at 10:28 AM, Rafał Miłecki <zajec5@gmail.com> wrote:
> On 26 January 2015 at 17:01, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Mon, Jan 26, 2015 at 3:19 AM, Rafał Miłecki <zajec5@gmail.com> wrote:
>>> There are few drivers using magic numbers when operating with PCIe
>>> capabilities and PCI_EXP_DEVCTL_READRQ. Define known values to allow
>>> cleaning their code a bit.
>>>
>>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>>> ---
>>> Hi,
>>>
>>> I'm new to the PCI subsystem, so let me know if there is anything wrong with my
>>> patch. I hope you find these bits worth defining and that my coding style
>>> matches rest of the file.
>>> ---
>>>  include/uapi/linux/pci_regs.h | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>>> index 4a1d0cc..efe3443 100644
>>> --- a/include/uapi/linux/pci_regs.h
>>> +++ b/include/uapi/linux/pci_regs.h
>>> @@ -451,6 +451,10 @@
>>>  #define  PCI_EXP_DEVCTL_AUX_PME        0x0400  /* Auxiliary Power PM Enable */
>>>  #define  PCI_EXP_DEVCTL_NOSNOOP_EN 0x0800  /* Enable No Snoop */
>>>  #define  PCI_EXP_DEVCTL_READRQ 0x7000  /* Max_Read_Request_Size */
>>> +#define  PCI_EXP_DEVCTL_READRQ_128B  0x0000 /* 128 Bytes */
>>> +#define  PCI_EXP_DEVCTL_READRQ_256B  0x1000 /* 256 Bytes */
>>> +#define  PCI_EXP_DEVCTL_READRQ_512B  0x2000 /* 512 Bytes */
>>> +#define  PCI_EXP_DEVCTL_READRQ_1024B 0x3000 /* 1024 Bytes */
>>>  #define  PCI_EXP_DEVCTL_BCR_FLR 0x8000  /* Bridge Configuration Retry / FLR */
>>>  #define PCI_EXP_DEVSTA         10      /* Device Status */
>>>  #define  PCI_EXP_DEVSTA_CED    0x0001  /* Correctable Error Detected */
>>
>> This seems reasonable.  Can you include patches for the drivers to
>> actually use these new symbols?  It's ideal if we can do them at the
>> same time because we try to avoid adding new symbols unless they're
>> going to actually be used.
>
> Sure, but how to send them? Could the go through your (PCI) tree?

I think so.  Something like is probably trivial, obviously-correct
patches, and we can probably get acks from the driver maintainers,
then merge them all at once via my tree.

Bjorn
