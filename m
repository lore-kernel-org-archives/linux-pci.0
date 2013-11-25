Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52806 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750709Ab3KYUpN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2013 15:45:13 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Move device_del() from pci_stop_dev() to pci_destroy_dev()
Date: Mon, 25 Nov 2013 21:57:58 +0100
Message-ID: <3487591.Y6ONpGmBs6@vostro.rjw.lan>
In-Reply-To: <CAE9FiQUuZO2BtjnG-XVoFMO5kqd97bEt9sNKzh3VZ2BJkvVnLg@mail.gmail.com>
References: <1384866598-19716-1-git-send-email-mika.westerberg@linux.intel.com> <2098030.vsbrD30xN4@vostro.rjw.lan> <CAE9FiQUuZO2BtjnG-XVoFMO5kqd97bEt9sNKzh3VZ2BJkvVnLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, November 25, 2013 11:45:50 AM Yinghai Lu wrote:
> On Mon, Nov 25, 2013 at 3:22 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > Well, is_removed is only used by pci_destroy_dev() in your patch, right?
> >
> > That means its only role is to protect the device from being destroyed
> > twice (or more times) in a row, but that surely would be a bug?  I don't
> > see how that can legitimately happen at least, so what exactly is the
> > scenario?
> 
> The thread:
> https://patchwork.kernel.org/patch/3119001/

Thanks for the pointer.

Well, so we have a bug in there and it is a *race* so adding a device flag
is not going to really help.  Besides, if the put_device() really frees the
struct pci_dev, accessing the flag itself would be a use-after-free,
wouldn't it?

What seems to be necessary is a lock preventing the
/sys/bus/pci/devices/.../remove interface from being used on multiple devices
in parallel.  Of course, it also has to protect against removals from hotplug
events racing with removals from /sys/bus/pci/devices/.../remove.

In any case, it is beyond the scope of the $subject patch, though.

Thanks,
Rafael

