Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51431 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387475AbeHAIv2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2018 04:51:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so5717559wma.1
        for <linux-pci@vger.kernel.org>; Wed, 01 Aug 2018 00:07:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180726105617.GA6181@red-moon>
References: <20180705094539.xkmtfffbzl3kooum@kili.mountain> <20180726105617.GA6181@red-moon>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Wed, 1 Aug 2018 12:37:14 +0530
Message-ID: <CAFZiPx0p5YJz1M_K5AJYXT_NP04QxOQVTG8FLcFGkA=yCXdrWQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: mobiveil: integer overflow in IB_WIN_SIZE
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lorenzo,
Added the compilation support in the next patch submitted at :
https://patchwork.kernel.org/patch/10551771/

please review.

Thanks,
Subrahmanya


On Thu, Jul 26, 2018 at 4:26 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Thu, Jul 05, 2018 at 12:45:39PM +0300, Dan Carpenter wrote:
>> IB_WIN_SIZE is larger than INT_MAX so we need to cast it to u64.
>>
>> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>> Untested...  Possibly the problem is that there are too many multiplies
>> by * 1024.
>>
>> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
>
> Applied to pci/mobiveil for v4.19 (it is still not fixing anything
> given that the driver lacks a Kconfig and Makefile entries - that
> must be fixed with urgency), thanks.
>
> Lorenzo
>
>> index 4d6c20e47bed..cf0aa7cee5b0 100644
>> --- a/drivers/pci/controller/pcie-mobiveil.c
>> +++ b/drivers/pci/controller/pcie-mobiveil.c
>> @@ -107,7 +107,7 @@
>>  #define CFG_WINDOW_TYPE      0
>>  #define IO_WINDOW_TYPE               1
>>  #define MEM_WINDOW_TYPE      2
>> -#define IB_WIN_SIZE          (256 * 1024 * 1024 * 1024)
>> +#define IB_WIN_SIZE          ((u64)256 * 1024 * 1024 * 1024)
>>  #define MAX_PIO_WINDOWS      8
>>
>>  /* Parameters for the waiting for link up routine */
