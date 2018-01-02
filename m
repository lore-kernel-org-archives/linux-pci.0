Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbeABTAN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jan 2018 14:00:13 -0500
Date: Tue, 2 Jan 2018 13:00:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: pci driver loads right after unload
Message-ID: <20180102190003.GB6211@bhelgaas-glaptop.roam.corp.google.com>
References: <13c000eb-5fbe-1787-54c0-d113500cf3db@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <13c000eb-5fbe-1787-54c0-d113500cf3db@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Greg, linux-kernel]

Hi Max,

Thanks for the report!

On Tue, Jan 02, 2018 at 01:50:23AM +0200, Max Gurtovoy wrote:
> hi all,
> I encountered a strange phenomena using 2 different pci drivers
> (nvme and mlx5_core) since 4.15-rc1:
> when I try to unload the modules using "modprobe -r" cmd it calls
> the .probe function right after calling the .remove function and the
> module is not realy unloaded.
> I think there is some race condition because when I added a
> msleep(1000) after "pci_unregister_driver(&nvme_driver);" (in the
> nvme module testing, it also worked in the mlx5_core), the issue
> seems to dissapear.

You say "since 4.15-rc1".  Does that mean it's a regression?  If so,
what's the most recent kernel that does not have this problem?  Worst
case, you could bisect to find where it broke.

I don't see anything obvious in the drivers/pci changes between v4.14
and v4.15-rc1.  Module loading and driver binding is mostly driven by
the driver core and udev.  Maybe you could learn something with
"udevadm monitor" or by turning on the some of the debug in
lib/kobject_uevent.c?

Bjorn
