Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:65009 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbaA3QsL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2014 11:48:11 -0500
Received: by mail-oa0-f46.google.com with SMTP id n16so3883327oag.19
        for <linux-pci@vger.kernel.org>; Thu, 30 Jan 2014 08:48:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140130131236.GW18029@intel.com>
References: <20140130131236.GW18029@intel.com>
Date: Thu, 30 Jan 2014 08:48:10 -0800
Message-ID: <CAE9FiQWDqXNF5Cn5X_muBERMWdZsZFbzmoqWvuPARREz+XO9Gw@mail.gmail.com>
Subject: Re: Commit ef83b0781a73f (PCI: Remove from bus_list and release
 resources in pci_release_dev()) broke TBT hotplug
From: Yinghai Lu <yinghai@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 30, 2014 at 5:12 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Hi,
>
> The latest mainline kernel "hangs" when Thunderbolt devices are
> hot-unplugged to the system. I can't see any oops but after hot-unplug I'm
> getting huge amounts of messages like:
>
> [  352.717001] pci 0000:02:00.0: PME# disabled
> [  352.717011] pci 0000:02:00.0: PME# disabled
> [  352.717021] pci 0000:02:00.0: PME# disabled
> [  352.717032] pci 0000:02:00.0: PME# disabled
> [  352.717041] pci 0000:02:00.0: PME# disabled
> [  352.717051] pci 0000:02:00.0: PME# disabled
> [  352.717061] pci 0000:02:00.0: PME# disabled
> [  352.717070] pci 0000:02:00.0: PME# disabled
> [  352.717083] pci 0000:02:00.0: PME# disabled
> [  352.717094] pci 0000:02:00.0: PME# disabled
> [  352.717104] pci 0000:02:00.0: PME# disabled
> [  352.717113] pci 0000:02:00.0: PME# disabled
> [  352.717124] pci 0000:02:00.0: PME# disabled
> [  352.717133] pci 0000:02:00.0: PME# disabled
> [  352.717143] pci 0000:02:00.0: PME# disabled
> [  352.717153] pci 0000:02:00.0: PME# disabled
> [  352.717162] pci 0000:02:00.0: PME# disabled

that mean pci_stop_dev() get called again and again ?

>
> and then the system becomes really unresponsive.
>
> Reverting the commit in $subject makes TBT work again.

Did you bisect to that commit?

Can you test just before
| 9d16947b75831acd317ab9a53e0e94d160731d33
| Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
| Date:   Fri Jan 10 15:22:18 2014 +0100
|
|    PCI: Add global pci_lock_rescan_remove()

that patch and following patches could change some calling sequence.

>
> Please let me know if you need any additional information. The system I'm
> testing on is Intel NUC.

I am surprised as

| commit ef83b0781a73f9efcb1228256bfdfb97fc9533a8
| Author: Yinghai Lu <yinghai@kernel.org>
| Date:   Sat Nov 30 14:40:29 2013 -0800
|
|    PCI: Remove from bus_list and release resources in pci_release_dev()

has been in pci/next for a while.
So you did not test pci/next before?

Please post boot log with "debug ignore_loglevel initcall_debug".

Thanks

Yinghai
