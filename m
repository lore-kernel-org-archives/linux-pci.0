Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33310 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756151AbbFRSB1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 14:01:27 -0400
Received: by ykfr66 with SMTP id r66so72630862ykf.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2015 11:01:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACK8Z6E_bobMhP1_0Y87R20DMfDa881LVmswZpM=YqQEZC2+=Q@mail.gmail.com>
References: <20150618161207.32739.62577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150618161238.32739.42666.stgit@bhelgaas-glaptop2.roam.corp.google.com> <CACK8Z6E_bobMhP1_0Y87R20DMfDa881LVmswZpM=YqQEZC2+=Q@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 18 Jun 2015 13:01:06 -0500
Message-ID: <CAErSpo6BCtM8zJS=yNTNTugXW--8PpuRhod2GAydZj38tCo+-w@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: pciehp: Clean up debug logging
To: Rajat Jain <rajatja@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 18, 2015 at 12:27 PM, Rajat Jain <rajatja@google.com> wrote:
> Hi,
>
> On Thu, Jun 18, 2015 at 9:12 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> The pciehp debug logging is overly verbose and often redundant.  Almost all
>> of the information printed by dbg_ctrl() is also printed by the normal PCI
>> core enumeration code and by pcie_init().
>>
>> Remove the redundant debug info.
>>
>> When claiming a pciehp bridge, we print the slot characteristics, e.g.,
>>
>>   Slot #6 AttnBtn- AttnInd- PwrInd- PwrCtrl- MRL- Interlock- NoCompl+ LLActRep+
>>
>> Add the Hot-Plug Capable and Hot-Plug Surprise bits to this information,
>
> If the slot is not hotplug capable. then pciehp wouldn't claim it in
> the first place.
>
> So printing of "hotplug capable" may really not be needed..

Yes, I did think about that, and you're right that it probably isn't
needed.  But the criteria for claiming a slot and deciding whether
acpiphp or pciehp should manage it are not 100% clear yet, so I
figured it wouldn't hurt to be a bit more transparent.

Bjorn
