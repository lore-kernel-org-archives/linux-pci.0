Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34303 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbdGEHmS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2017 03:42:18 -0400
Received: by mail-oi0-f43.google.com with SMTP id l130so119731098oib.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Jul 2017 00:42:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <17f06c42-a96f-d1da-38e5-95117626eb29@codeaurora.org>
References: <20170704161352.1cdb2670.wim.ten.have@oracle.com>
 <CAErSpo7PbSZgRtPJiXuOd6FPgLK5AGki51fTUm_-KUDZ96sRww@mail.gmail.com>
 <2acc9a73-0c2c-31f3-fcdf-42289213860e@codeaurora.org> <20170704195916.43fbe6e4.wim.ten.have@oracle.com>
 <97b8c58e-7384-0519-5ccb-837fa5054d84@codeaurora.org> <17f06c42-a96f-d1da-38e5-95117626eb29@codeaurora.org>
From: Ethan Zhao <ethan.kernel@gmail.com>
Date: Wed, 5 Jul 2017 15:42:16 +0800
Message-ID: <CABawtvOOWV1aKk=1LBk+S0UfG02UTNMvtdJM58HQYW4JXFAyrQ@mail.gmail.com>
Subject: Re: Red Hat (Fedora) bug report 1467674 concerning your kernel
 functional performance enhancements causing PCI Express crashes,
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Wim ten Have <wim.ten.have@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sinan=EF=BC=8C

    About the patch attached, why clear the word of
PCI_EXP_DEVCTL_EXT_TAG ?  does the device will be set by default after
POST it is not supported ?

   dev_info(&dev->dev, "clearing extended tags capability\n");

+ pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
+   PCI_EXP_DEVCTL_EXT_TAG);


Thanks,
Ethan

On Wed, Jul 5, 2017 at 9:00 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 7/4/2017 6:25 PM, Sinan Kaya wrote:
>> On 7/4/2017 1:59 PM, Wim ten Have wrote:
>>> On Tue, 4 Jul 2017 11:57:37 -0400
>>> Sinan Kaya <okaya@codeaurora.org> wrote:
>>>
>>>> Hi,
>>>>
>>>> On 7/4/2017 11:32 AM, Bjorn Helgaas wrote:
>>>>> [+cc linux-pci]
>>>>>
>>>>> Thanks very much for the detailed problem report, Wim!  I'm taking th=
e
>>>>> liberty to forward to the linux-pci list in case others trip over the
>>>>> same thing.
>>>>>
>>>>
>>>> So, the spec is lying :) and reality doesn't match theory.
>>
>> The PCI Express bridge you have is a Broadcom HT 2100 bridge which seems=
 to support
>> PCI-Express V1.0 and 1.0a compliant only.
>>
>> http://www.hard-net.de/info_wissen/chipsatz/broadcom/HT-2100.pdf
>>
>> I can also see this in your lspci output.
>>
>> 00:08.0 PCI bridge: Broadcom HT2100 PCI-Express Bridge (rev a2) (prog-if=
 00 [Normal decode])
>>       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr=
- Stepping- SERR+ FastB2B- DisINTx+
>>       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <=
TAbort- <MAbort- >SERR- <PERR- INTx-
>>       Latency: 0, Cache Line Size: 64 bytes
>>       Interrupt: pin A routed to IRQ 19
>>       NUMA node: 0
>>       Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=
=3D0
>>       I/O behind bridge: 0000f000-00000fff [empty]
>>       Memory behind bridge: efe00000-efefffff [size=3D1M]
>>       Prefetchable memory behind bridge: 00000000fff00000-00000000000fff=
ff [empty]
>>       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <=
TAbort- <MAbort+ <SERR- <PERR-
>>       BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
>>               PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>       Capabilities: [a0] HyperTransport: MSI Mapping Enable+ Fixed-
>>               Mapping Address Base: 00000000fee00000
>>       Capabilities: [b0] Express (v1) Root Port (Slot-), MSI 00
>>
>> I'll post a patch to apply extended tags to systems with PCI express v2 =
and higher
>> bridges only.
>>
>
> Please give this patch a try. I can make the patch pretty and re-post if =
it works for you.
>
> You should be seeing messages like this during boot.
>
> [    3.949621] pci 0003:01:00.0: clearing extended tags capability
> [    3.959540] pci 0003:01:00.1: clearing extended tags capability
> [    3.969454] pci 0003:01:00.2: clearing extended tags capability
> [    3.979373] pci 0003:01:00.3: clearing extended tags capability
> [    3.989290] pci 0003:01:00.4: clearing extended tags capability
>
>
>
> --
> Sinan Kaya
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Techno=
logies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux=
 Foundation Collaborative Project.
