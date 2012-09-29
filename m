Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36826 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab2I2EIe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 29 Sep 2012 00:08:34 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo4Or84GO-DjKcu=G7hqUo8BF8Lu7czHwfmZDecvVS-tMQ@mail.gmail.com>
References: <1348733519-24684-1-git-send-email-yinghai@kernel.org>
	<1348733519-24684-5-git-send-email-yinghai@kernel.org>
	<CAErSpo4WYEFg9HBRm8z=sSUTYLv5eLNfH07RQaQGh2+ZScp8sw@mail.gmail.com>
	<CAE9FiQW2mvXGVKF7Wn0Td+_Wafu1sPMYr-sn2zffAfBycKi=Hg@mail.gmail.com>
	<CAErSpo4Or84GO-DjKcu=G7hqUo8BF8Lu7czHwfmZDecvVS-tMQ@mail.gmail.com>
Date: Fri, 28 Sep 2012 21:08:32 -0700
Message-ID: <CAE9FiQXno7kmQ526dFx+jVSicxxuqLk8Cz4a4Da9fb_Ha-yigQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] PCI, ACPI: assign unassigned resource for hot add
 root bus
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 28, 2012 at 8:31 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Sep 28, 2012 at 7:56 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Fri, Sep 28, 2012 at 4:46 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> On Thu, Sep 27, 2012 at 2:11 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>> After we get hot-added ioapic registered.
>>>> pci_enable_bridges will try to enable ioapic irq for pci bridges.
>>>
>>> What makes this specifically related to IOAPICs?
>
> I think you missed this question.

in another response:

 pci_enable_bridges
    ==> pci_enable_device
        ==> ...
           ===> pcibios_enable_device
               ===> pcibios_enable_irq

and one of driver in acpi_pci_drivers, is ioapic drivers and it will
enable ioapic there.

So we need to enable bridges that later.
