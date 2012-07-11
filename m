Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59116 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663Ab2GKScw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jul 2012 14:32:52 -0400
Received: by lbbgm6 with SMTP id gm6so2801683lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 11 Jul 2012 11:32:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXK=ByAkjVU53ftMYchsGSKD-yCLUpCLNZoZA_7=bzWOw@mail.gmail.com>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org> <CAE9FiQXK=ByAkjVU53ftMYchsGSKD-yCLUpCLNZoZA_7=bzWOw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 11 Jul 2012 12:32:28 -0600
Message-ID: <CAErSpo4bh0kHSLGShdu5gsSQJqYkjQrA9y5-8-g7qxU+6v=wnw@mail.gmail.com>
Subject: Re: [PATCH 0/5] PCI: hotplug related misc patches
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 10, 2012 at 1:30 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Sat, Jun 23, 2012 at 12:42 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>> minor changes that should be safe for 3.6
>>
>> could get from
>>         git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-next
>>
>> Yinghai Lu (5):
>>   PCI, acpiphp: remove not used res_lock
>>   PCI, acpiphp: Merge acpiphp_debug and debug

I merged the two patches above to my "next" branch.

>>   PCI, acpiphp: add is_hotplug_bridge detection
>>   pciehp: Don't enable presence notification while surprise removal is
>>     not supported.
>>   PCI: add root bus children dev's res to fail list

The above seem to need more work.  We've discussed the acpiphp and
pciehp patches on the list, and the last doesn't seem like enough of a
cleanup to warrant a commit.  I hope that someday resource assignment
becomes intelligible, but I don't want to do it one line at a time.

>>  drivers/pci/hotplug/acpiphp.h      |    4 +---
>>  drivers/pci/hotplug/acpiphp_core.c |    7 ++-----
>>  drivers/pci/hotplug/acpiphp_glue.c |   30 ++++++++++++++++++++++++++----
>>  drivers/pci/hotplug/pciehp_hpc.c   |    5 +++--
>>  drivers/pci/setup-bus.c            |    2 +-
>>  5 files changed, 33 insertions(+), 15 deletions(-)
>
> can you put those 5 patches into pci/next?
>
> Those should be safe for v3.6 merging window.
>
> Thanks
>
> Yinghai
