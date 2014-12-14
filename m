Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:48203 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbaLNFDC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 14 Dec 2014 00:03:02 -0500
Date: Sat, 13 Dec 2014 19:39:58 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Dennis McLeod <umodjm@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: PCI BAR sysfs node permissions
Message-ID: <20141214033958.GA7039@kroah.com>
References: <CAAzF57Sj4ZL4mw5PAwcrGtE8wQsgc9hBWRNNn0DHg5VsctY6mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAzF57Sj4ZL4mw5PAwcrGtE8wQsgc9hBWRNNn0DHg5VsctY6mA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 09, 2014 at 04:22:35PM -0500, Dennis McLeod wrote:
> need help figuring out how to make this happen. If my pci driver is
> instructed to open a pci device, I want to change the mode of bar0's
> sysfs node to o+rw so a user app can mmap it.
> 
> In other words, from the driver, perform this:
> chmod 766 /sys/bus/pci/[slot path]/resource0
> preferably without a lecture on why I shouldn't .. ;-)

Sorry, you will get a lecture if you try to do something as foolish as
this from within the kernel.

If you "really" need this, do it from userspace, with a script you grant
root permissions to change the mode on the files.

> If I chmod that sysfs node for bar0 as root, i can run a user process
> (as regular user) that does an mmap of that and can do reads/writes to
> the bar resource. I would like for my pci driver to do this
> automatically when it is told to open a device.

Nope, that's a bad idea, and you know that as well.

sorry.

greg k-h
