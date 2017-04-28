Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:34066 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753603AbdD1O46 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Apr 2017 10:56:58 -0400
Received: by mail-wr0-f178.google.com with SMTP id l9so35224713wre.1
        for <linux-pci@vger.kernel.org>; Fri, 28 Apr 2017 07:56:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEhpy_c96xmviS8fE4rMDeK9dPiSLhTrW_MQNtdkKXkwoU8PEg@mail.gmail.com>
References: <CAEhpy_c96xmviS8fE4rMDeK9dPiSLhTrW_MQNtdkKXkwoU8PEg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Apr 2017 09:56:36 -0500
Message-ID: <CAErSpo640q4rgaDE=59TGGAw9_MhNQj2=4+A_4Qgoy2ZUAW7sQ@mail.gmail.com>
Subject: Re: PCI Rescan Question
To: Kyle Gale <kylewgale@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi  Kyle,

On Wed, Apr 26, 2017 at 5:56 PM, Kyle Gale <kylewgale@gmail.com> wrote:
> Hi,
>
>
>
> Can someone help me understand why I need to remove my stale PCI
> device files from the tree if I want to properly get my device
> re-initialized after unplugging and reinserting?
>
>
>
> For example, I turn on my system with my PCI device plugged in. All is
> fine. I unplug it, plug it back in, and rescan (echo 1 >
> /sys/bus/pci/devices/rescan) and end up in this state where my BAR0 is
> not set, and other things are not entirely correct.

Ideally, the PCI hotplug code would automatically remove the PCI
device files when you remove the physical device, and it would also
automatically scan the device when you plug it back in.

You shouldn't need to do either the remove or the rescan manually via sysfs.

Apparently your system does actually support hotplug.  Do you have it
enabled in the kernel?  The "lspci -vv" output, dmesg output, and your
.config would help answer these questions.

Bjorn
