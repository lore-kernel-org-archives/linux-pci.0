Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:46299 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbdKIFMI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2017 00:12:08 -0500
Received: by mail-wr0-f170.google.com with SMTP id y42so4459183wrd.3
        for <linux-pci@vger.kernel.org>; Wed, 08 Nov 2017 21:12:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171108172424.GA19449@infradead.org>
References: <CAFZiPx1sgxr8X9mtW11fK1XMPuk+4jUFb5Cc-pVJn06ZztHwng@mail.gmail.com>
 <20171108172424.GA19449@infradead.org>
From: subrahmanya l <l.subrahmanya@mobiveil.co.in>
Date: Thu, 9 Nov 2017 10:42:06 +0530
Message-ID: <CAFZiPx0wbm=hA0qXMjJihOaeRHhKzgZdSLTwTZdGZ2aoMM-3Rw@mail.gmail.com>
Subject: Re: [Patch] export irq_set_msi_desc
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-pci@vger.kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Christoph,

Xilinx MSI driver uses it.

file path: https://github.com/Xilinx/linux-xlnx/blob/master/drivers/pci/host/pcie-xilinx.c#L286

I used the same driver as reference to write another Rootport driver
which needs it too.

Thanks,
~subbu

On Wed, Nov 8, 2017 at 10:54 PM, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Nov 08, 2017 at 09:54:09PM +0530, subrahmanya l wrote:
> > Few of the PCIe driver compilation fails with undefined symbol
> > "irq_set_msi_desc".
> > This patch is to export it.
>
> Which ones?  Also please add an explanation of why you thing it should
> be exported and Cc the irq code maintainers.

-- 
Mobiveil INC., CONFIDENTIALITY NOTICE: This e-mail message, including any 
attachments, is for the sole use of the intended recipient(s) and may 
contain proprietary confidential or privileged information or otherwise be 
protected by law. Any unauthorized review, use, disclosure or distribution 
is prohibited. If you are not the intended recipient, please notify the 
sender and destroy all copies and the original message.
