Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:35543 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbbG2MCA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2015 08:02:00 -0400
MIME-Version: 1.0
Date: Wed, 29 Jul 2015 17:31:59 +0530
Message-ID: <CAHhAz+gJ3FKgLQLEjro8P+Dn+FPHykLur4fmEkAwFdrLPNoQng@mail.gmail.com>
Subject: Virtex-5 FPGA PCIE single-function device
From: Muni Sekhar <munisekharrms@gmail.com>
To: linux-pci@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[ Please keep me in CC as I'm not subscribed to the list]

Hello,

We are using the “Virtex-5 FPGA Integrated Endpoint Block for PCI
Express” in Linux platform. It supports only a single-function(Header
Type, Bit 7 is zero), but actually it is having different functions in
different Bar’s.

It has UART hardware module implemented in the first Base Address
Register and MMC host controller in other Base Address Register.

We are planning to develop our own pcie based uart driver for UART
hardware and planning to use the MMC kernel stack for MMC host
controller.

By default MMC kernel stack gets attached to this device. In the pcie
based uart driver, tried configuring the uart module after getting the
pci_dev structure with pci_get_device(not used the
pci_register_driver). After that I could able to communicate with the
UART registers even though MMC stack is attached to the device.

Now I am puzzled and stuck with how to proceed further on UART
Interrupt Service Routine for this kind of device. Can I use
request_irq() for uart isr, do you have any suggestion on this?

Any hint or help would be greatly appreciated.


Regards,
Sekhar
