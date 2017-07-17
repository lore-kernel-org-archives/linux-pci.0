Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36830 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbdGQJzd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 05:55:33 -0400
Received: by mail-lf0-f52.google.com with SMTP id h22so82127140lfk.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Jul 2017 02:55:32 -0700 (PDT)
Subject: Re: [PATCH] pci: ftpci100: fix of_irq_get() error check
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
References: <20170715214406.657273405@cogentembedded.com>
 <CACRpkdbwMm_YwDG=e1Dyi1B7yp-++2u5frQiL_cbw_eRTiGiiQ@mail.gmail.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <73a59815-4305-52eb-df51-22da21291e85@cogentembedded.com>
Date: Mon, 17 Jul 2017 12:55:31 +0300
MIME-Version: 1.0
In-Reply-To: <CACRpkdbwMm_YwDG=e1Dyi1B7yp-++2u5frQiL_cbw_eRTiGiiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

On 7/17/2017 12:17 AM, Linus Walleij wrote:

>> of_irq_get() may return a negative error number as well as 0 on failure,
>> while the driver only checks for 0, blithely continuing with the call to
>> irq_set_chained_handler_and_data() -- that function expects *unsigned int*
>> so should probably do nothing when a large IRQ number resulting from a
>> conversion of a negative error number is passed to it. The driver then
>> probes successfully while being only partly functional...
>>
>> Check for 'irq <= 0' instead and propagate the negative error number to
>> the probe method --  that will allow the deferred probing as well...
>>
>> Fixes: d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Looks correct!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

    Thanks!

>> -               return -EINVAL;
>> +               return irq ?: -EINVAL;
> 
> I thought I knew C but I learn something new all the time.
> I had no clue one can use the ternary operator like this.

    It's not a standard C, it's gcc's trickery. :-)

> Linus Walleij

MBR, Sergei
