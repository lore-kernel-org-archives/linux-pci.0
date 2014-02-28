Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:60661 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbaB1Syn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2014 13:54:43 -0500
Received: by mail-vc0-f172.google.com with SMTP id lf12so1143560vcb.31
        for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2014 10:54:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPykPMmLkQ2O5253EcUFuwNdmMKcL-Nr9KQi1EZoMH2yuHXcjQ@mail.gmail.com>
References: <CAPykPMmLkQ2O5253EcUFuwNdmMKcL-Nr9KQi1EZoMH2yuHXcjQ@mail.gmail.com>
Date: Fri, 28 Feb 2014 19:54:42 +0100
Message-ID: <CAPykPM=HhgvAebJbFW76D2umQjH5jz66FVh9egVY5khvGFNH2Q@mail.gmail.com>
Subject: Fwd: Attaching drivers to identical PCI devices.
From: Jeroen Van den Keybus <jeroen.vandenkeybus@triphase.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I would like to use 2 versions of a PCI driver, each for one of 2
identical devices. The driver that gets probed first will seize both
devices in driver_attach().

Using sysfs's bind and unbind methods, you can arrange to release the
device for use by the other driver, but the first driver has
nevertheless been initializing, driving and shutting down the device,
which is unacceptable in my case.

What would be the best way to deal with this ?

Thanks,


J.
