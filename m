Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:43925 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbaEUEzD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 May 2014 00:55:03 -0400
Received: by mail-ig0-f172.google.com with SMTP id uy17so5786891igb.5
        for <linux-pci@vger.kernel.org>; Tue, 20 May 2014 21:55:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+eFSM2CBiWZNmpnSNGKZGjEpK6gc=T0a5r7m6sbORi==XTCjQ@mail.gmail.com>
References: <CA+eFSM2CBiWZNmpnSNGKZGjEpK6gc=T0a5r7m6sbORi==XTCjQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 20 May 2014 22:54:42 -0600
Message-ID: <CAErSpo61Ge078ip6x5XqosMaa4+TYvH8d6pTkR9OE1-_DPbu7g@mail.gmail.com>
Subject: Re: PCI-to-USB ExpressCard Hotplugging can't work in v3.15-rc5
To: Gavin Guo <gavin.guo@canonical.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>, YK <yk@canonical.com>,
	Yung Shen <yung.shen@canonical.com>,
	Po-Hsu Lin <po-hsu.lin@canonical.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 20, 2014 at 10:36 PM, Gavin Guo <gavin.guo@canonical.com> wrote:
> Hi all,
>
> I have a APIOTEK PCI-to-USB ExpressCard and found that when it is
> plugged at cold boot, the card can be detected. But, hotplug cannot
> work at run time. The bug may be related to the commit which I
> reported last year:
>
> commit 3f327e39b4b8f760c331bb2836735be6d83fbf53

Where is your report from last year?  How did you identify this
commit?  Did you verify that it works correctly with v3.10-rc1, but
fails when you add this commit?

> Author: Yinghai Lu <yinghai@kernel.org>
> Date:   Tue May 7 11:06:03 2013 -0600
>
>     PCI: acpiphp: Re-enumerate devices when host bridge receives Bus Check
>
>     When a PCI host bridge device receives a Bus Check notification, we
>     must re-enumerate starting with the bridge to discover changes (devices
>     that have been added or removed).
>
>     Prior to 668192b678 ("PCI: acpiphp: Move host bridge hotplug to
>     pci_root.c"), this happened in _handle_hotplug_event_bridge().  After that
>     commit, _handle_hotplug_event_bridge() is not installed for host bridges,
>     and the host bridge notify handler, _handle_hotplug_event_root() did not
>     re-enumerate.
>
>     This patch adds re-enumeration to _handle_hotplug_event_root().
>
>     This fixes cases where we don't notice the addition or removal of
>     PCI devices, e.g., the PCI-to-USB ExpressCard in the bugzilla below.
>
> Dmesg is attached. The scenario of the dmesg: The PCI-to-USB
> ExpressCard is attached at cold boot. Then, you can see that the usb
> storage can be detected in the dmesg. Finally, I've done hotplug 2
> times to see if it can detect the PCI-to-USB ExpressCard. At the end
> of Dmesg, it only has several "ACPI: \_SB_.PCI0: ACPI_NOTIFY_BUS_CHECK
> event" and can't detect the card.
>
> Thanks,
> Gavin Guo
