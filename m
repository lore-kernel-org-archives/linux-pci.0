Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:44994 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab3E0QqB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 May 2013 12:46:01 -0400
Received: by mail-la0-f54.google.com with SMTP id eg20so6684891lab.13
        for <linux-pci@vger.kernel.org>; Mon, 27 May 2013 09:45:56 -0700 (PDT)
MIME-Version: 1.0
Reply-To: pricardofc@ipfn.ist.utl.pt
In-Reply-To: <CAErSpo7TXMOake9=oXwa-JA9qd9FmwNtHqM6RSt12QO=WORshA@mail.gmail.com>
References: <CAH9N0t_dNJ+u+9BLFTsqRNnbRO4xMaGYqE6_du_u+joZfzBYyA@mail.gmail.com>
	<CAErSpo7TXMOake9=oXwa-JA9qd9FmwNtHqM6RSt12QO=WORshA@mail.gmail.com>
Date: Mon, 27 May 2013 17:45:56 +0100
Message-ID: <CAH9N0t8-6CgmhQhiu7zy1r4UnYyjJqkmAnrDRhjt3t71F7SxNA@mail.gmail.com>
Subject: Re: Pcie Linux HotPlug Driver
From: Paulo Fortuna Carvalho <pricardofc@ipfn.ist.utl.pt>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

My card includes a PCIe Switch.
My coordinators told me that a solution for hotplug (remove/insert
board without shutting down the system) could be the PCIe Port Bus
Driver Model using also pciehp.ko already installed in Linux System.

Paulo.


> Why do you want to use the "Port Bus Driver Model"?  That is only
> intended for the ports in PCIe switches.  Does your card include a
> switch with non-standard services?

> If your driver is specifically for some new switch functionality, you
> might want to make it a port service driver.  But if this is a PCIe
> endpoint device, then you should make it a plain old PCI driver with
> pci_register_driver().

> Bjorn






>> Our driver has been modified in order to be compliant to a service
>> driver as described in the HowTo Documentation.
>>
>> Using the file pcieport_if.h there were some structs that become
>> obsolete namely the pci_port_service_id.
>>
>> 1) How can we provide the board ids with the pci_port_service_id
>> struct removed?
>> I'm using the old method struct pci_device_id
>>
>> 2) How can we point to the old pci_dev pointer in our functions once
>> the arguments for probe(), remove() now are pcie_device struct? I'm using
>> the port item in the struct pcie_device.
>>
>> 3) After changes at insmod time my board appears in the /proc/devices
>> but my devices and sub-devices never appear in the /dev directory
>> making me wonder that something is missing in my class_create() and
>> device_create() function...
>>
>> 4) Are functions resume() and suspend() relevant for the hot-plug
>> process? At the moment these functions only return -ENOSYS
>>
>> My Purpose: At the moment i'm only interest in modifying the Linux
>> Device Driver for the board using the PCIe HotPlug Port Bus Driver
>> Model (porting it to a Service Driver), detect the board and create
>> the devices and sub-devices in the /dev directory as it used to do.
>> I think there is only something missing but I dont know what.
>>
>> NOTE: Some aditional information:
>> My _init() and _exit() functions are calling
>> pcie_port_service_register() and pcie_port_service_unregister(),
>> respectively.
>>
>> Thanks in Advance,
>> Paulo (University PhD Student)
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
