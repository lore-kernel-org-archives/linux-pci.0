Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:43728 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbbALQ6s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jan 2015 11:58:48 -0500
Received: by mail-qg0-f50.google.com with SMTP id z60so18496277qgd.9
        for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2015 08:58:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAH9N0t9KvhzmZDgD8PD5VBPR-pPhuE8MmBgK9RY8+ZtKyz++pQ@mail.gmail.com>
References: <CAH9N0t9KvhzmZDgD8PD5VBPR-pPhuE8MmBgK9RY8+ZtKyz++pQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 12 Jan 2015 10:58:25 -0600
Message-ID: <CAErSpo48mPENuHpES1Q73ep+NKG8x2Zgb+g71do02y7vufbtfQ@mail.gmail.com>
Subject: Re: Hot add a PCIe device driver upon hotplug event
To: Paulo Fortuna Carvalho <pricardofc@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 12, 2015 at 5:42 AM, Paulo Fortuna Carvalho
<pricardofc@gmail.com> wrote:
> Hello,
> I want to automatically load/unload a PCIe device driver when a card
> is inserted/removed from the system. I can see in the system logger
> with dmesg that the interrupt event is captured and acknowledged by
> the pciehp hotplug service driver.
> What I want to do next is that the operating system load/unload the
> corresponding PCIe device driver for that card.

When pciehp receives the interrupt, it should enumerate the device,
and you should see a line in dmesg similar to this (of course, it will
have different bus/device/function and different vendor/device IDs):

  pci 0000:00:16.0: [8086:9c3a] type 00 class 0x078000

The PCI core should then add the device using device_add(), and part
of that is to emit a uevent, which can be read by user-space.
Generally udev would handle the event and load the appropriate driver.
I don't know the details of how the user-space side works.

Bjorn
