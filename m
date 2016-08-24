Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from faith.sw1v.org ([109.74.200.146]:35810 "EHLO faith.sw1v.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752038AbcHXRBL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Aug 2016 13:01:11 -0400
Received: from hindenburg.openmarket.com ([83.166.71.24] helo=[192.168.26.176])
        by faith.sw1v.org (envelope-from <linux@rvanderhoff.org.uk>)
        with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        id 1bcbEU-0001MK-QV
        for linux-pci@vger.kernel.org; Wed, 24 Aug 2016 17:40:54 +0100
To: linux-pci@vger.kernel.org
From: Richard van der Hoff <linux@rvanderhoff.org.uk>
Subject: Hotplug not working for USB 3.1 docking station on Dell XPS 13
Message-ID: <57BDCE15.4080201@rvanderhoff.org.uk>
Date: Wed, 24 Aug 2016 17:40:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I'm having problems with a Plugable USB-C docking station, with my 
laptop, a Dell XPS 13 (9350). If the docking station is plugged in at 
boot, it works correctly; however, when I hotplug it after boot, the USB 
devices are not detected until I force a rescan of the PCI bus.

I have also raised this as a bug at 
https://bugzilla.kernel.org/show_bug.cgi?id=151261. There are some dmesg 
traces and lspci logs attached to that bug.

The lspci output suggests a chain of three PCI bridges (00:1c.0, 
01:00.0, 02:02.0) before a PCI->USB bridge (05:00.0 or 39:00.0). If I 
boot without the docking station plugged in, 01:00.0 and beyond do not 
appear, and nor do they appear on hotplug. However, if I hotplug the 
docking station and then force a rescan with "echo 1 > 
/sys/bus/pci/devices/0000:00:1c.0/rescan", the PCI bridges and USB 
devices appear and spring into life.

My impression, and feedback from the linux-usb mailing list, is 
therefore that this is a PCI hotplug problem.

There are some ACPI errors in the dmesg at hotplug but they don't really 
mean much to me.

I'd really appreciate any suggestions on how to proceed with this.

Thanks

Richard van der Hoff
