Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40755 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030430AbeCSSMH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Mar 2018 14:12:07 -0400
Received: by mail-qt0-f193.google.com with SMTP id y6so18974590qtm.7
        for <linux-pci@vger.kernel.org>; Mon, 19 Mar 2018 11:12:07 -0700 (PDT)
Subject: Re: [PATCH 7/9] PCI: improve host drivers compile test coverage
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>
References: <20180307154243.3205-1-robh@kernel.org>
 <20180307154243.3205-8-robh@kernel.org>
 <368a94dc-72d3-9365-447b-07e9e811ade3@broadcom.com>
 <CAL_JsqKemmq8nucjVavhdSahx5NaGupzSt4cNkqvsCpSGMNHWw@mail.gmail.com>
 <20180319180519.GA13211@e107981-ln.cambridge.arm.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <ee5474dc-d905-312a-b3a5-fdbc6677fcfa@broadcom.com>
Date: Mon, 19 Mar 2018 11:11:57 -0700
MIME-Version: 1.0
In-Reply-To: <20180319180519.GA13211@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,


On 18-03-19 11:05 AM, Lorenzo Pieralisi wrote:
> On Fri, Mar 16, 2018 at 02:53:16PM -0500, Rob Herring wrote:
>> On Wed, Mar 7, 2018 at 11:57 AM, Scott Branden
>> <scott.branden@broadcom.com> wrote:
>>> Hi Rob,
>>>
>>> Change to PCIE_IPROC_BCMA to be made.
>>>
>>>
>>> On 18-03-07 07:42 AM, Rob Herring wrote:
>>>> Add COMPILE_TEST on driver config options with it. Some ARM drivers
>>>> still have arch dependencies, so we have to keep those dependent on ARM.
>>>>
>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>> ---
>>>>    drivers/pci/dwc/Kconfig  | 24 ++++++++++++------------
>>>>    drivers/pci/host/Kconfig | 33 +++++++++++++++------------------
>>>>    2 files changed, 27 insertions(+), 30 deletions(-)
>> [...]
>>
>>>> @@ -127,7 +126,7 @@ config PCIE_IPROC_PLATFORM
>>>>      config PCIE_IPROC_BCMA
>>>>          tristate "Broadcom iProc PCIe BCMA bus driver"
>>>> -       depends on ARM && (ARCH_BCM_IPROC || COMPILE_TEST)
>>>> +       depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
>>>>          select PCIE_IPROC
>>>>          select BCMA
>>>>          default ARCH_BCM_5301X
>>> The was intentionally depending on ARM (as it does not apply to ARM64 which
>>> ARCH_BCM__IPROC also applies to).  Please keep that in place.
>>> depends on (ARM && ARCH_BCM_IPROC) || COMPILE_TEST
>> Indeed.
>>
>> Lorenzo, can you fix up or want me to send a new version?
> Hi Rob,
>
> I can fix it up, I am not sure where the dependency on ARM is though,
> isn't patch 2 supposed to remove it ? I am certainly missing something
> here so please chime in.
>
> Thanks,
> Lorenzo
You patch wanted to remove the dependency on ARM during COMPILE_TEST.
But, during normal use, it should not remove such dependency.
As such, the following is the correct change to make:

depends on (ARM && ARCH_BCM_IPROC) || COMPILE_TEST

Thanks,
Scott
