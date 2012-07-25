Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15714 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821Ab2GYEe1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Jul 2012 00:34:27 -0400
Message-ID: <1343190864.10311.26.camel@yhuang-dev>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB
 hotplug failure
From: Huang Ying <ying.huang@intel.com>
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 25 Jul 2012 12:34:24 +0800
In-Reply-To: <87pq7ko532.fsf@nemi.mork.no>
References: <Pine.LNX.4.44L0.1207241312050.1164-100000@iolanthe.rowland.org>
	 <87r4s0opck.fsf@nemi.mork.no> <87pq7ko532.fsf@nemi.mork.no>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Bjorn,

On Wed, 2012-07-25 at 06:08 +0200, Bjørn Mork wrote:
> Enabling autosuspend for USB causes hotplug failure in the current
> linux-next. Newly plugged devices are not detected at all until the
> port/controller is manually powered on by writing "on" to power/control.
> Testing is pretty simple:
> 
>   1) for f in /sys/bus/usb/devices/*/power/control; do echo auto > $f; done

Have you done:

for f in /sys/bus/pci/devices/*/power/confol; do echo auto > $f; done

?

If not, the pci device will not be suspended at all.

>   2) wait for the controllers to suspend
>   3) plugin a new USB device

After plugin the new USB device, is there anything in dmesg?

> 
> I've bisected the regression down to this commit:
> 
> 
> commit 448bd857d48e69b33ef323739dc6d8ca20d4cda7
> Author: Huang Ying <ying.huang@intel.com>
> Date:   Sat Jun 23 10:23:51 2012 +0800
> 
>     PCI/PM: add PCIe runtime D3cold support
>     
> 
> Looks like this somehow powers down my USB host controllers in such a
> way that they are unable to detect connections to their ports.  The
> system is a pretty standard 4 year old intel based laptop.  Full lspci
> listing is attached.
>
> Please let me know if you need further information.  And please fix this
> before rc1.  It effectively makes USB non-functional if autosuspend is
> enabled.

Can you provide the output of the following command lines?

grep . /sys/bus/pci/devices/*/power/*
grep . /sys/bus/usb/devices/*/power/*
lsusb

After the controllers suspended.

Best Reards,
Huang Ying


