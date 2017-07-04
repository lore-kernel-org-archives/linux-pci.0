Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45088 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbdGDWZr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2017 18:25:47 -0400
Subject: Re: Red Hat (Fedora) bug report 1467674 concerning your kernel
 functional performance enhancements causing PCI Express crashes,
To: Wim ten Have <wim.ten.have@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20170704161352.1cdb2670.wim.ten.have@oracle.com>
 <CAErSpo7PbSZgRtPJiXuOd6FPgLK5AGki51fTUm_-KUDZ96sRww@mail.gmail.com>
 <2acc9a73-0c2c-31f3-fcdf-42289213860e@codeaurora.org>
 <20170704195916.43fbe6e4.wim.ten.have@oracle.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <97b8c58e-7384-0519-5ccb-837fa5054d84@codeaurora.org>
Date: Tue, 4 Jul 2017 18:25:40 -0400
MIME-Version: 1.0
In-Reply-To: <20170704195916.43fbe6e4.wim.ten.have@oracle.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/4/2017 1:59 PM, Wim ten Have wrote:
> On Tue, 4 Jul 2017 11:57:37 -0400
> Sinan Kaya <okaya@codeaurora.org> wrote:
> 
>> Hi,
>>
>> On 7/4/2017 11:32 AM, Bjorn Helgaas wrote:
>>> [+cc linux-pci]
>>>
>>> Thanks very much for the detailed problem report, Wim!  I'm taking the
>>> liberty to forward to the linux-pci list in case others trip over the
>>> same thing.
>>>   
>>
>> So, the spec is lying :) and reality doesn't match theory.
>>
>> "Per the ECN mentioned below, all PCIe Receivers are expected to support
>>  Extended Tags"
>>
>>> The problem is not specific to this piece of h/w.  I did pin-point the
>>> issue to specific kernel code commit  
>> <snip>
>>
>>> 60db3a4d8cc9073cf56264785197ba75ee1caca4
>>>   * <wtenhave@hagen:55> git bisect good
>>>     60db3a4d8cc9073cf56264785197ba75ee1caca4 is the first bad commit
>>>     commit 60db3a4d8cc9073cf56264785197ba75ee1caca4
>>>     Author: Sinan Kaya <okaya@codeaurora.org>
>>>     Date:   Fri Jan 20 09:16:51 2017 -0500
>>>
>>>       PCI: Enable PCIe Extended Tags if supported
>>>   
>> <snip>
>>
>>> 3. Boot and see it crash as soon it starts to operate on specific PCI
>>> Express Ethernet controller.
>>>   
>>
>> I guess we have an endpoint/system with errata that needs to be blacklisted.
>> Can you please try another endpoint with the same system?
>>
>> You have conflicting information above. I want to understand whether it
>> is the endpoint or the system that needs to be blacklisted.
> 
>   Specific PCI Express ethernet are embedded on the systems mainboard.
>   There's only one PCI Express that requires a riser card.  It is empty.
>
>> Please also provide sudo lspci -vvv output from the system with the patch.
>> Sinan
> 
>   Detail (lspci -vvv) is added to RedHat filed bugzilla entry; BugID 1467674
>   since the info is rather large.
> 
> 	https://bugzilla.redhat.com/show_bug.cgi?id=1467674

I think I understand the issue better now. The ECN seems to be introduced against
PCIE 2.0 spec. 

The PCI Express bridge you have is a Broadcom HT 2100 bridge which seems to support
PCI-Express V1.0 and 1.0a compliant only.

http://www.hard-net.de/info_wissen/chipsatz/broadcom/HT-2100.pdf

I can also see this in your lspci output. 

00:08.0 PCI bridge: Broadcom HT2100 PCI-Express Bridge (rev a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 19
	NUMA node: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff [empty]
	Memory behind bridge: efe00000-efefffff [size=1M]
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [empty]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [a0] HyperTransport: MSI Mapping Enable+ Fixed-
		Mapping Address Base: 00000000fee00000
	Capabilities: [b0] Express (v1) Root Port (Slot-), MSI 00

I'll post a patch to apply extended tags to systems with PCI express v2 and higher
bridges only.


> 
> Enjoy,
> - Wim.
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
