Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:39962 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752878AbdKWOPD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Nov 2017 09:15:03 -0500
MIME-Version: 1.0
In-Reply-To: <20171123141131.GA1801@kroah.com>
References: <1511445862-4383-1-git-send-email-oded.gabbay@gmail.com> <20171123141131.GA1801@kroah.com>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Thu, 23 Nov 2017 16:14:32 +0200
Message-ID: <CAFCwf12D=PEfxDj9QBg=hNSRoQmOasx68Xc7Wuy2p5LUXiCPnA@mail.gmail.com>
Subject: Re: [PATCH] pci: add class codes for processing accelerators
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 23, 2017 at 4:11 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Nov 23, 2017 at 04:04:22PM +0200, Oded Gabbay wrote:
>> Add PCI codes to include/linux/pci_ids.h for Processing Accelerators. There
>> are new ASICs (now in development) for Deep Learning that will utilize this
>> base class.
>>
>> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
>> ---
>>  include/linux/pci_ids.h | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index ab20dc5..4c210cd 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -139,6 +139,9 @@
>>  #define PCI_CLASS_SP_DPIO            0x1100
>>  #define PCI_CLASS_SP_OTHER           0x1180
>>
>> +#define PCI_BASE_CLASS_PROCESSING_ACCELERATOR        0x12
>> +#define PCI_CLASS_PA_VENDOR_SPECIFIC         0x1200
>
> Did you read the top of this file?
Yes, but I thought that since this value is defined in the PCI spec
then it is ok to add it here.
>
> And if these really do belong here, then it should go in as part of a
> patch series that contains a driver that uses these values.
ok, then I'll need to resend this in a couple of months.

Thanks,
Oded

>
> thanks,
>
> greg k-h
