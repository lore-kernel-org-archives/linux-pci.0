Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:64877 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755038Ab3I2S1Y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 29 Sep 2013 14:27:24 -0400
MIME-Version: 1.0
Date: Sun, 29 Sep 2013 11:27:23 -0700
Message-ID: <CADTPrLTuzvj3iSMdNVs2BjDFHsWqjRPM4qDkkpmv+P11LMP0JQ@mail.gmail.com>
Subject: pciehp & other hot-plug drivers (shpc etc..)
From: Rajat Jain <rajatjain.linux@gmail.com>
To: linux-pci@vger.kernel.org, linux-hotplug@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello List,

Today all the PCI Hot-plug drivers (shpc, acpihp, cpqhp, ibmhp etc
except pciedhp) directly claim the downstream port bridge device.
Where as in case of pciehp, the PCIe port bus driver claims the bridge
device, and service drivers (aer, pm, pciehp) simply register for the
service with it.

1) Does that mean that in a system where I am using a driver other
than pciehp for hot-plug (eg. shpc), I cannot use service drivers like
AER or PM on the same port (since the device would be claimed by
shpc, it would not be available to port bus driver)?

2) In the same system, can I use SHPC on one port, and pciehp on
another port? I believe not?

Please note that it may not be a realistic scenarios, my intent of
asking is to just understand how things are intended to behave.

Thanks,

Rajat
