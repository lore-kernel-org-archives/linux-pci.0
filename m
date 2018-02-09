Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750970AbeBIOjb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Feb 2018 09:39:31 -0500
Received: from mail-qk0-f177.google.com (mail-qk0-f177.google.com [209.85.220.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB03B217B2
        for <linux-pci@vger.kernel.org>; Fri,  9 Feb 2018 14:39:30 +0000 (UTC)
Received: by mail-qk0-f177.google.com with SMTP id 15so10210467qkl.3
        for <linux-pci@vger.kernel.org>; Fri, 09 Feb 2018 06:39:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87vaf6wvwc.fsf@concordia.ellerman.id.au>
References: <20180209024125.38862-1-aik@ozlabs.ru> <87vaf6wvwc.fsf@concordia.ellerman.id.au>
From: Rob Herring <robh@kernel.org>
Date: Fri, 9 Feb 2018 08:39:09 -0600
Message-ID: <CAL_JsqJfv_e2zRJvDT6ZW1MD2kPNWW+e5P2tgkdm8hJRBbhF=w@mail.gmail.com>
Subject: Re: [PATCH kernel v2] powerpc/pci: Fix broken INTx configuration via OF
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 8, 2018 at 11:54 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>
>> Commit 59f47eff03a0 ("powerpc/pci: Use of_irq_parse_and_map_pci() helper")
>> replaced of_irq_parse_pci() + irq_create_of_mapping() with
>> of_irq_parse_and_map_pci() but this change lost virq returned by
>> irq_create_of_mapping() so virq remained zero causing INTx
>> misconfiguration.
>>
>> This fixes pci_read_irq_line() not to loose a virq returned by
>> of_irq_parse_and_map_pci().
>>
>> Fixes: 59f47eff03a0 "powerpc/pci: Use of_irq_parse_and_map_pci() helper"
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v2:
>> * changed the condition from <=0 to !=0 as by design
>> of_irq_parse_and_map_pci() can only return 0 for an error and virq>0.
>
> It returns int, so you should store the result in an int, and check the
> result for <= 0.
>
> Otherwise if it starts returning a negative error value this code will
> break.

That won't happen until we're confident all callers expect NO_IRQ is
only 0 and don't treat negative as NO_IRQ. I expect that to be never,
but maybe of_irq_parse_and_map_pci calls can be audited more easily
than of_irq_parse_and_map. We ended up with of_irq_get() because we
need to return error codes.

Rob
