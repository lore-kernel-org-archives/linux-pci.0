Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33990 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbaE3W2R (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 May 2014 18:28:17 -0400
Received: by mail-ie0-f173.google.com with SMTP id lx4so2385939iec.32
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2014 15:28:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140520205340.GA22821@google.com>
References: <1398966055-19325-1-git-send-email-yinghai@kernel.org>
	<20140520205340.GA22821@google.com>
Date: Fri, 30 May 2014 15:28:16 -0700
Message-ID: <CAE9FiQWCsKwb3aqUQ96x__xwR_+K=k5LzjxWCCS1+xz2Wd5baA@mail.gmail.com>
Subject: Re: [PATCH v4] pciehp: only wait command complete for real hotplug control
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatxjain@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 20, 2014 at 1:53 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, May 01, 2014 at 10:40:55AM -0700, Yinghai Lu wrote:

>> With that we could save 16 seconds during booting, later with 32 sockets system
>> with 64 pcie hotplug slots we could save 64 seconds.
>
> Doesn't this just move a timeout out of the boot path and into a future
> hotplug event?

Both. But not affect real Hotplug events (EIC, PCC, PIC, AIC).

>
> These controllers do not set the "No Command Completed Support" bit, so
> pciehp expects that they will generate Command Completed events after they
> process commands.
>
> During initialization, pcie_enable_notification() writes a command to set
> the DLLSCE, ABPE, PDCE, MRLSCE, HPIE, CCIE bits.  The (EIC, PCC, PIC, AIC)
> bits aren't changed, so per CF118, the controller will not set the Command
> Completed bit.
>
> Later, when we turn on power to the slot, ctrl->cmd_busy will still be set,
> so won't we timeout waiting for the Command Completed bit?

If it is real hotplug events, cmd_busy will be cleared by pcie_isr.

If it is not real hotplug events, cmd_busy is still set, and but CC is not set.

later before we try to write cmd again, but only cmd_busy is set &&
CC is not set, that means previous write cmd is not real hotplug event.
so we should not wait.


>
> (I think there's a bug in your patch (see below) that would explain why you
> wouldn't see this timeout in testing.)
>
>>       /*
>>        * Wait for command completion.
>>        */
>> -     if (!ctrl->no_cmd_complete) {
>> +     if (!ctrl->no_cmd_complete && (slot_status & PCI_EXP_SLTSTA_CC) &&
>> +         ctrl->cmd_busy) {
>
> I don't understand this change.  Why do you test "slot_status &
> PCI_EXP_SLTSTA_CC" here?  Did you mean to write this:
>
>   if (!ctrl->no_cmd_complete && !(slot_status & PCI_EXP_SLTSTA_CC) && ...
>
> instead?  I think we want to wait if (1) the controller generates Command
> Complete events and (2) Slot Status indicates that a command is still in
> progress.

Yes. your logic is right for those real hotplug event, that means
CC is not set, and isr is not called to clear cmd_busy.

but it will wait for real or non-real cmd right after non-real hotplug cmd.

looks like we need to start one timer for non-real hotplug to clear cmd_busy?

Thanks

Yinghai
