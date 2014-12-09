Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:63465 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbaLIVWh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Dec 2014 16:22:37 -0500
Received: by mail-wi0-f180.google.com with SMTP id n3so3175939wiv.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Dec 2014 13:22:36 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 9 Dec 2014 16:22:35 -0500
Message-ID: <CAAzF57Sj4ZL4mw5PAwcrGtE8wQsgc9hBWRNNn0DHg5VsctY6mA@mail.gmail.com>
Subject: PCI BAR sysfs node permissions
From: Dennis McLeod <umodjm@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

need help figuring out how to make this happen. If my pci driver is
instructed to open a pci device, I want to change the mode of bar0's
sysfs node to o+rw so a user app can mmap it.

In other words, from the driver, perform this:
chmod 766 /sys/bus/pci/[slot path]/resource0
preferably without a lecture on why I shouldn't .. ;-)

If I chmod that sysfs node for bar0 as root, i can run a user process
(as regular user) that does an mmap of that and can do reads/writes to
the bar resource. I would like for my pci driver to do this
automatically when it is told to open a device.

Please help!
