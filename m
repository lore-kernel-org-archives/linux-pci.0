Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58307 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021Ab2HaAn3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Aug 2012 20:43:29 -0400
Received: by lbbgj3 with SMTP id gj3so898745lbb.19
        for <linux-pci@vger.kernel.org>; Thu, 30 Aug 2012 17:43:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQV4M8cAZ71Pxvm8gAXzVuEz_4Yb3akpk7w9JwBH052_rQ@mail.gmail.com>
References: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com>
 <CAErSpo5eqyuK_yKshHbDyK5LBBG9cCn1MpmHbqpvVYe6x7AxFg@mail.gmail.com> <CAE9FiQV4M8cAZ71Pxvm8gAXzVuEz_4Yb3akpk7w9JwBH052_rQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 30 Aug 2012 17:43:07 -0700
Message-ID: <CAErSpo5ZRapkienpn4ZNWyeC_vfzzxVhmUzViQd0XtAf5ghz2Q@mail.gmail.com>
Subject: Re: [PATCH 0/7][RESEND] acpi, pci: hostbridge hotplug support
To: Yinghai Lu <yinghai@kernel.org>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 30, 2012 at 8:48 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Aug 29, 2012 at 11:23 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

>> 1) For patch [1/7], I pointed out that there is currently no way to
>> remove a non-ACPI host bridge, which means the fact that we don't free
>> the pci_sysdata is not really a leak.  If you want to add the
>> release_fn so that you can add support for removing and adding these
>> non-ACPI host bridges in the future, I do not understand that.  It
>> just doesn't make sense to me to try to support hotplug for those
>> bridges.
>
> for Intel Nehalem and westmere -ex system, there will be root bus from
> 0xf8 to 0xff for cpus.
> and BIOS does not put the in ACPI, but __pci_mmcfg_init will set the
> pcibios_last_bus.
> so those but get probed via pcibios_fixup_peer_bridges.

I understand how these buses get scanned.  What I don't understand is
what value we get from trying to make these buses hot-pluggable.

> I hope I could use /sys to remove non-acpi root bus.

Why?  I don't think there's any value in being able to remove non-ACPI
host bridges.  Any x86 host bridge hotplug that's actually useful to
users will be done via ACPI.

You mention later that you want to remove these buses because they
only contain CPU devices that don't seem to be good for anything.  I
would rather do this by simply not scanning for peer bridges in the
first place.  That's simpler than scanning the bridge, deciding we
don't care about what we found, then trying to hot-remove it.

Bjorn
