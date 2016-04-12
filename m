Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35436 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965810AbcDLWdf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2016 18:33:35 -0400
Received: by mail-ig0-f181.google.com with SMTP id gy3so100455369igb.0
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2016 15:33:34 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 12 Apr 2016 15:33:34 -0700
Message-ID: <CAH=XD5-Snbsb3tqH6s_gTuek72QpE1L9yjfWB0R1k-HO1xrexQ@mail.gmail.com>
Subject: Hot Plug: How to determine a device has been removed
From: Kallol Biswas <kallol@nucleodyne.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
    We have been working on a PCIe appliance.

There is a software layer (management layer) that uses pci_dev
structure of underlying devices on downstream port.

The port supports Hot Plug.

We have a test that a device with one or more functions is
removed(surprise removal) from system.
The linux kernel (2.6.38.1) detects presence detect interrupt and
unconfigures the device/functions.

What is the best way to detect from management layer that the
underlying devices are gone and should not be access?

We have used udev to detect device removal and addition, but with
multi-function device we are getting into an issue that while
processing removal event of 1st function, 2nd event comes
asynchronously for 2nd function. If management driver is in the middle
of accessing the config space of 2nd function, system crashes. We need
to check somehow the underlying device is gone.

Any direction/pointer will be appreciated.

Thanks,
Kallol
