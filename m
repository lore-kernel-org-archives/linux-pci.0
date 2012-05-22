Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38726 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760400Ab2EVUew (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2012 16:34:52 -0400
Received: by dady13 with SMTP id y13so8734627dad.19
        for <linux-pci@vger.kernel.org>; Tue, 22 May 2012 13:34:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201205222011.q4MKBcMo024624@int-mx02.intmail.prod.int.phx2.redhat.com>
References: <201205222011.q4MKBcMo024624@int-mx02.intmail.prod.int.phx2.redhat.com>
Date: Tue, 22 May 2012 13:34:51 -0700
Message-ID: <CAE9FiQX1zUUMr4YM7A=WWvj2cYi2ztyDU6wADw1aucTsV6TH8g@mail.gmail.com>
Subject: Re: [PATCH] pci hotplug: rescan bridge after device hotplug
From: Yinghai Lu <yinghai@kernel.org>
To: Jason Baron <jbaron@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2012 at 1:11 PM, Jason Baron <jbaron@redhat.com> wrote:
> I'm tyring to support bridge hotplug and devices below it in qemu via acpi
> hotplug. Currently only 1 level or 32 slots are supported. By allowing for a
> second level, we will be able to support 32^2 devices.
>
> If I first hotplug the bridge with no devices intially below it, the hotplug
> code sets the bridge memory window to 0 and does not increase it when
> subsequent devices are added below it.
>
> Fix this, by calling pci_rescan_bus_bridge_resize(), on the bridge directly
> below the root to re-size all the birdge windows that may have changed.
>
> Signed-off-by: Jason Baron <jbaron@redhat.com>

can you check patch in

http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=patch;h=174dfefc6066bf0af21e0989ad3aa7b1cc3cd46a

During checking acpiphp code, found following sequence:
        pci_bus_size_bridges(bus);
        pci_bus_assign_resources(bus);
	pci_enable_bridges(bus);

The problem is that when bus is not root bus, pci_bus_size_bridges
would also size
own pci bridge bus->self if that bridge resource is not inserted before.
but later pci_bus_assign_resources will not allocate those size bridge res.

So try make it less confusing, let it does not include self sizing.
and add with_self parameter info __pci_bus_size_bridge()

Fixes caller in pci hotplug componets.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/hotplug/acpiphp_glue.c |    3 ++-
 drivers/pci/setup-bus.c            |   24 +++++++++++++++---------
 include/linux/pci.h                |    1 +
 3 files changed, 18 insertions(+), 10 deletions(-)
..

it should address your problem.

Yinghai
