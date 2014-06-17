Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:56662 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933325AbaFQRdt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jun 2014 13:33:49 -0400
Received: by mail-ig0-f175.google.com with SMTP id h3so873igd.8
        for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2014 10:33:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4WMPUjg-1vS6v7zVnEUcQL9i0SxmmyjViA7njB-ErPoQ@mail.gmail.com>
References: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
	<20140614212132.15202.29174.stgit@bhelgaas-glaptop.roam.corp.google.com>
	<CAE9FiQWQn6SNMTAQ1_RR=NdMszwOBYG_W9ifFdRN1ZLE0k_vbw@mail.gmail.com>
	<CAErSpo4WMPUjg-1vS6v7zVnEUcQL9i0SxmmyjViA7njB-ErPoQ@mail.gmail.com>
Date: Tue, 17 Jun 2014 10:33:48 -0700
Message-ID: <CAE9FiQWSpC78CdGJ+Ys_yh5BnbZuN+gJkvrRHT6EjA8=U2uOmw@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] PCI: pciehp: Compute timeout from hotplug command
 start time
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Jan C. Nordholz" <jckn@gmx.net>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 16, 2014 at 5:13 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Sat, Jun 14, 2014 at 8:18 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Sat, Jun 14, 2014 at 2:21 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>>> index f44fdb5b0b08..18ac24d84f9b 100644
>>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>>> @@ -142,11 +143,24 @@ static void pcie_wait_cmd(struct controller *ctrl)
>>>         if (ctrl->no_cmd_complete)
>>>                 return;
>>>
>>> +       if (!ctrl->cmd_busy)
>>> +               return;
>>
>> Can you move those two lines to second patch ?
>
> I moved them to the first patch ("Make pcie_wait_cmd()
> self-contained") since that is more concerned with cleaning up
> pcie_wait_cmd().  It could even be a separate patch; it would have
> made sense to check cmd_busy before calling pcie_wait_cmd().  But it
> seemed like overkill to make another patch just for that.

Agreed.
