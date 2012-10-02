Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:47293 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333Ab2JBSAg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 14:00:36 -0400
Received: by lagh6 with SMTP id h6so2528982lag.19
        for <linux-pci@vger.kernel.org>; Tue, 02 Oct 2012 11:00:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121002174712.GA11843@kroah.com>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
 <1349159588-15029-2-git-send-email-yinghai@kernel.org> <20121002133303.GA502@kroah.com>
 <CAE9FiQVCFs8cgFoU2rb=a8MWCzBcfRT6iNh7UchV8q6Bg6XzGQ@mail.gmail.com> <20121002174712.GA11843@kroah.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 2 Oct 2012 12:00:14 -0600
Message-ID: <CAErSpo7_vKi9iov2t49hNYV==SmsW5arNdp8eYBKv+mu6VvWVA@mail.gmail.com>
Subject: Re: [PATCH 01/10] device: add drivers_autoprobe in struct device
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 2, 2012 at 11:47 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Oct 02, 2012 at 10:39:25AM -0700, Yinghai Lu wrote:
>> On Tue, Oct 2, 2012 at 6:33 AM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > On Mon, Oct 01, 2012 at 11:32:59PM -0700, Yinghai Lu wrote:
>> >> To use to control the delay attach driver for specific device.
>> >>
>> >> Will use bus notifier to toggle this bits when needed.
>> >>
>> >> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >
>> > Without a whole lot more context as to why you want this change, no,
>> > sorry, I'll not accept it.
>>
>> Sorry, I should put you on the to list for the whole patchset.
>>
>> Those patches address Bjorn's request:
>> 1. kill acpi_pci_root_start in drivers/acpi/pci_root.c
>> 2. register pci device to device as soon as possible, so for_each_pci_device
>>    could be used early before pci_bus_add_devices.

Just to be clear, I'm in favor of eliminating acpi_pci_root_start()
eventually, but I didn't suggest this approach, and I don't like it
much either.  I don't have much constructive feedback yet, but this
feels like a special case that's not cleanly integrated into the
existing infrastructure.

>> please check change log patch2-4.
>
> Sorry, I still don't see what is so special about PCI that they have to
> do something different here.  What am I missing?
