Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:57428 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbaE3WuF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 May 2014 18:50:05 -0400
Received: by mail-ie0-f177.google.com with SMTP id y20so2373150ier.22
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2014 15:50:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWCsKwb3aqUQ96x__xwR_+K=k5LzjxWCCS1+xz2Wd5baA@mail.gmail.com>
References: <1398966055-19325-1-git-send-email-yinghai@kernel.org>
	<20140520205340.GA22821@google.com>
	<CAE9FiQWCsKwb3aqUQ96x__xwR_+K=k5LzjxWCCS1+xz2Wd5baA@mail.gmail.com>
Date: Fri, 30 May 2014 15:50:03 -0700
Message-ID: <CAE9FiQX=YqnB_eW-ejRjH6biyLXJqEUevPrQ+7r6TUbvYq2b8g@mail.gmail.com>
Subject: Re: [PATCH v4] pciehp: only wait command complete for real hotplug control
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatxjain@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 30, 2014 at 3:28 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, May 20, 2014 at 1:53 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> I don't understand this change.  Why do you test "slot_status &
>> PCI_EXP_SLTSTA_CC" here?  Did you mean to write this:
>>
>>   if (!ctrl->no_cmd_complete && !(slot_status & PCI_EXP_SLTSTA_CC) && ...
>>
>> instead?  I think we want to wait if (1) the controller generates Command
>> Complete events and (2) Slot Status indicates that a command is still in
>> progress.
>
> Yes. your logic is right for those real hotplug event, that means
> CC is not set, and isr is not called to clear cmd_busy.
>
> but it will wait for real or non-real cmd right after non-real hotplug cmd.
>
> looks like we need to start one timer for non-real hotplug to clear cmd_busy?

That looks make it too complicated.

I would revert back to first way
   change to only wait when (EIC, PCC, PIC, AIC) bits get changed.
and add one flag in ctrl to see if need to apply the rule.

Thanks

Yinghai
