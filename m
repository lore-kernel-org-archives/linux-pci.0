Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63887 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209Ab2JBRj0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 13:39:26 -0400
Received: by bkcjk13 with SMTP id jk13so5657904bkc.19
        for <linux-pci@vger.kernel.org>; Tue, 02 Oct 2012 10:39:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121002133303.GA502@kroah.com>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
	<1349159588-15029-2-git-send-email-yinghai@kernel.org>
	<20121002133303.GA502@kroah.com>
Date: Tue, 2 Oct 2012 10:39:25 -0700
Message-ID: <CAE9FiQVCFs8cgFoU2rb=a8MWCzBcfRT6iNh7UchV8q6Bg6XzGQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] device: add drivers_autoprobe in struct device
From: Yinghai Lu <yinghai@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 2, 2012 at 6:33 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Oct 01, 2012 at 11:32:59PM -0700, Yinghai Lu wrote:
>> To use to control the delay attach driver for specific device.
>>
>> Will use bus notifier to toggle this bits when needed.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Without a whole lot more context as to why you want this change, no,
> sorry, I'll not accept it.

Sorry, I should put you on the to list for the whole patchset.

Those patches address Bjorn's request:
1. kill acpi_pci_root_start in drivers/acpi/pci_root.c
2. register pci device to device as soon as possible, so for_each_pci_device
   could be used early before pci_bus_add_devices.

please check change log patch2-4.

https://patchwork.kernel.org/patch/1535731/
https://patchwork.kernel.org/patch/1535821/
https://patchwork.kernel.org/patch/1535851/

Thanks

Yinghai
