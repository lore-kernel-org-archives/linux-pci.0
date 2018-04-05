Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752393AbeDETRu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Apr 2018 15:17:50 -0400
Received: from mail-qt0-f169.google.com (mail-qt0-f169.google.com [209.85.216.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2E93217D8
        for <linux-pci@vger.kernel.org>; Thu,  5 Apr 2018 19:17:49 +0000 (UTC)
Received: by mail-qt0-f169.google.com with SMTP id j26so28100115qtl.11
        for <linux-pci@vger.kernel.org>; Thu, 05 Apr 2018 12:17:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6f9bb82d-0e41-434c-a59b-795b8517161c@broadcom.com>
References: <20180405142655.14892-1-robh@kernel.org> <6f9bb82d-0e41-434c-a59b-795b8517161c@broadcom.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 5 Apr 2018 14:17:28 -0500
Message-ID: <CAL_JsqJTq+o+=w8jS5OJ_Uuji6F2FyifEZw_UNbbgXtKmvisHA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: improve host drivers compile test coverage
To: Scott Branden <scott.branden@broadcom.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 5, 2018 at 1:24 PM, Scott Branden
<scott.branden@broadcom.com> wrote:
> Hi Rob,
>
> I don't think this will work.

Ugg...

> On 18-04-05 07:26 AM, Rob Herring wrote:
>>
>> Add COMPILE_TEST on driver config options with it. Some ARM drivers
>> still have arch dependencies, so we have to keep those dependent on ARM.
>>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> v3: Rework iProc again, adding GICv3 dependency
>>
>> v2: Rework iProc to not enable on arm64 except for COMPILE_TEST

>> @@ -118,7 +117,8 @@ config PCIE_IPROC
>>     config PCIE_IPROC_PLATFORM
>>         tristate "Broadcom iProc PCIe platform bus driver"
>> -       depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
>> +       depends on (ARM && ARCH_BCM_IPROC) || COMPILE_TEST
>> +       depends on ARM_GIC_V3
>>         depends on OF
>>         select PCIE_IPROC
>>         default ARCH_BCM_IPROC
>> @@ -128,7 +128,8 @@ config PCIE_IPROC_PLATFORM
>>     config PCIE_IPROC_BCMA
>>         tristate "Broadcom iProc PCIe BCMA bus driver"
>> -       depends on ARM && (ARCH_BCM_IPROC || COMPILE_TEST)
>> +       depends on (ARM && ARCH_BCM_IPROC) || COMPILE_TEST
>> +       depends on ARM_GIC_V3
>
> GIC v3 is not used for ARM (v7).  So the driver now won't be compiled in
> normal use case.
> It sounds like some code inside the IPROC BCMA driver needs to be wrapped
> with #ifdef ARM_GIC_V3 to fix this problem.

I give up and will just drop these hunks.

Rob
