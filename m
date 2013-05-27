Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:41088 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757341Ab3E0Knq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 May 2013 06:43:46 -0400
Received: by mail-lb0-f179.google.com with SMTP id r11so6475789lbv.24
        for <linux-pci@vger.kernel.org>; Mon, 27 May 2013 03:43:42 -0700 (PDT)
MIME-Version: 1.0
Reply-To: pricardofc@ipfn.ist.utl.pt
Date: Mon, 27 May 2013 11:43:42 +0100
Message-ID: <CAH9N0t_dNJ+u+9BLFTsqRNnbRO4xMaGYqE6_du_u+joZfzBYyA@mail.gmail.com>
Subject: Pcie Linux HotPlug Driver
From: Paulo Fortuna Carvalho <pricardofc@ipfn.ist.utl.pt>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I have an PCI Express ATCA card with an FPGA.
I have a device driver to communicate with the board.
Now we are trying to implement hot-plug using the PCIe Port Bus Driver Model.

Our driver has been modified in order to be compliant to a service
driver as described in the HowTo Documentation.

Using the file pcieport_if.h there were some structs that become
obsolete namely the pci_port_service_id.

1) How can we provide the board ids with the pci_port_service_id
struct removed?
I'm using the old method struct pci_device_id

2) How can we point to the old pci_dev pointer in our functions once
the arguments for probe(), remove() now are pcie_device struct? I'm using
the port item in the struct pcie_device.

3) After changes at insmod time my board appears in the /proc/devices
but my devices and sub-devices never appear in the /dev directory
making me wonder that something is missing in my class_create() and
device_create() function...

4) Are functions resume() and suspend() relevant for the hot-plug
process? At the moment these functions only return -ENOSYS

My Purpose: At the moment i'm only interest in modifying the Linux
Device Driver for the board using the PCIe HotPlug Port Bus Driver
Model (porting it to a Service Driver), detect the board and create
the devices and sub-devices in the /dev directory as it used to do.
I think there is only something missing but I dont know what.

NOTE: Some aditional information:
My _init() and _exit() functions are calling
pcie_port_service_register() and pcie_port_service_unregister(), respectively.

Thanks in Advance,
Paulo (University PhD Student)
