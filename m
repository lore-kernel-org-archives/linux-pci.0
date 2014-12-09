Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45981 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975AbaLIVsc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 9 Dec 2014 16:48:32 -0500
Message-ID: <1418161707.1095.151.camel@bling.home>
Subject: Re: PCI BAR sysfs node permissions
From: Alex Williamson <alex.williamson@redhat.com>
To: Dennis McLeod <umodjm@gmail.com>
Cc: linux-pci@vger.kernel.org
Date: Tue, 09 Dec 2014 14:48:27 -0700
In-Reply-To: <CAAzF57Sj4ZL4mw5PAwcrGtE8wQsgc9hBWRNNn0DHg5VsctY6mA@mail.gmail.com>
References: <CAAzF57Sj4ZL4mw5PAwcrGtE8wQsgc9hBWRNNn0DHg5VsctY6mA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2014-12-09 at 16:22 -0500, Dennis McLeod wrote:
> need help figuring out how to make this happen. If my pci driver is
> instructed to open a pci device, I want to change the mode of bar0's
> sysfs node to o+rw so a user app can mmap it.
> 
> In other words, from the driver, perform this:
> chmod 766 /sys/bus/pci/[slot path]/resource0
> preferably without a lecture on why I shouldn't .. ;-)
> 
> If I chmod that sysfs node for bar0 as root, i can run a user process
> (as regular user) that does an mmap of that and can do reads/writes to
> the bar resource. I would like for my pci driver to do this
> automatically when it is told to open a device.

This sounds like a future exploit.  Can the device to DMA?  Do you have
an IOMMU?  If yes & yes, have you heard of vfio-pci?  Thanks,

Alex

