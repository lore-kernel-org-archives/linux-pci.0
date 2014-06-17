Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33783 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaFQANq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jun 2014 20:13:46 -0400
Received: by mail-ig0-f170.google.com with SMTP id h15so382604igd.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2014 17:13:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWQn6SNMTAQ1_RR=NdMszwOBYG_W9ifFdRN1ZLE0k_vbw@mail.gmail.com>
References: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140614212132.15202.29174.stgit@bhelgaas-glaptop.roam.corp.google.com> <CAE9FiQWQn6SNMTAQ1_RR=NdMszwOBYG_W9ifFdRN1ZLE0k_vbw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 16 Jun 2014 18:13:25 -0600
Message-ID: <CAErSpo4WMPUjg-1vS6v7zVnEUcQL9i0SxmmyjViA7njB-ErPoQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] PCI: pciehp: Compute timeout from hotplug command
 start time
To: Yinghai Lu <yinghai@kernel.org>
Cc: "Jan C. Nordholz" <jckn@gmx.net>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 14, 2014 at 8:18 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Sat, Jun 14, 2014 at 2:21 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>> index f44fdb5b0b08..18ac24d84f9b 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -142,11 +143,24 @@ static void pcie_wait_cmd(struct controller *ctrl)
>>         if (ctrl->no_cmd_complete)
>>                 return;
>>
>> +       if (!ctrl->cmd_busy)
>> +               return;
>
> Can you move those two lines to second patch ?

Yeah, those lines don't really fit in this patch.  I don't think they
really fit in the second patch ("Wait for hotplug command completion
lazily") either, since that is simply moving the wait from after
issuing a command to before issuing the next command.

I moved them to the first patch ("Make pcie_wait_cmd()
self-contained") since that is more concerned with cleaning up
pcie_wait_cmd().  It could even be a separate patch; it would have
made sense to check cmd_busy before calling pcie_wait_cmd().  But it
seemed like overkill to make another patch just for that.

Anyway, I put them all at
http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/?h=pci/hotplug
.  I'll add the results of Rajat's testing (assuming that goes well).
It would be good if you could make sure they do what you expect on
your hardware, too.  If you do test it, let me know what sort of
controller you tested on (vendor/device ID).

I think you will see a "Timeout on hotplug command %#010x (issued %u
msec ago)" message.  I don't think there will be any actual slowdown,
but I hope the message doesn't cause users too much heartburn.

> Other than that, for all 4 patches
>
> Acked-by: Yinghai Lu <yinghai@kernel.org>
