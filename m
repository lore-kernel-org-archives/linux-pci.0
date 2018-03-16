Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbeCPUAK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Mar 2018 16:00:10 -0400
Received: from mail-qt0-f171.google.com (mail-qt0-f171.google.com [209.85.216.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96AED20685
        for <linux-pci@vger.kernel.org>; Fri, 16 Mar 2018 19:53:37 +0000 (UTC)
Received: by mail-qt0-f171.google.com with SMTP id y6so12113474qtm.7
        for <linux-pci@vger.kernel.org>; Fri, 16 Mar 2018 12:53:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <368a94dc-72d3-9365-447b-07e9e811ade3@broadcom.com>
References: <20180307154243.3205-1-robh@kernel.org> <20180307154243.3205-8-robh@kernel.org>
 <368a94dc-72d3-9365-447b-07e9e811ade3@broadcom.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Mar 2018 14:53:16 -0500
Message-ID: <CAL_JsqKemmq8nucjVavhdSahx5NaGupzSt4cNkqvsCpSGMNHWw@mail.gmail.com>
Subject: Re: [PATCH 7/9] PCI: improve host drivers compile test coverage
To: Scott Branden <scott.branden@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 7, 2018 at 11:57 AM, Scott Branden
<scott.branden@broadcom.com> wrote:
> Hi Rob,
>
> Change to PCIE_IPROC_BCMA to be made.
>
>
> On 18-03-07 07:42 AM, Rob Herring wrote:
>>
>> Add COMPILE_TEST on driver config options with it. Some ARM drivers
>> still have arch dependencies, so we have to keep those dependent on ARM.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>   drivers/pci/dwc/Kconfig  | 24 ++++++++++++------------
>>   drivers/pci/host/Kconfig | 33 +++++++++++++++------------------
>>   2 files changed, 27 insertions(+), 30 deletions(-)

[...]

>> @@ -127,7 +126,7 @@ config PCIE_IPROC_PLATFORM
>>     config PCIE_IPROC_BCMA
>>         tristate "Broadcom iProc PCIe BCMA bus driver"
>> -       depends on ARM && (ARCH_BCM_IPROC || COMPILE_TEST)
>> +       depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
>>         select PCIE_IPROC
>>         select BCMA
>>         default ARCH_BCM_5301X
>
> The was intentionally depending on ARM (as it does not apply to ARM64 which
> ARCH_BCM__IPROC also applies to).  Please keep that in place.
> depends on (ARM && ARCH_BCM_IPROC) || COMPILE_TEST

Indeed.

Lorenzo, can you fix up or want me to send a new version?

Rob
