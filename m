Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:54281 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab3JYTsb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2013 15:48:31 -0400
Received: by mail-ie0-f173.google.com with SMTP id u16so7390917iet.32
        for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2013 12:48:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B704625B1A@DFLE11.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B704625941@DFLE11.ent.ti.com>
 <CAPcvp5Epf+6tOp+0=ZbBLusCzq4dF98aS+Ou0D7Nyko_VwM8KA@mail.gmail.com> <3E54258959B69E4282D79E01AB1F32B704625B1A@DFLE11.ent.ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 25 Oct 2013 13:48:10 -0600
Message-ID: <CAErSpo4TOvYZsjxc3UhCbPUv1NPEy3m-DjtLh-v8q0geGvPhUg@mail.gmail.com>
Subject: Re: AER driver on ARM platform
To: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
Cc: Andrew Murray <amurray@embedded-bits.co.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 25, 2013 at 12:18 PM, Karicheri, Muralidharan
<m-karicheri2@ti.com> wrote:
>>> -----Original Message-----
>>> From: Andrew Murray [mailto:amurray@embedded-bits.co.uk]
>>> Sent: Friday, October 25, 2013 12:27 PM
>>> To: Karicheri, Muralidharan
>>> Cc: linux-pci@vger.kernel.org
>>> Subject: Re: AER driver on ARM platform
>>>
>>> On 25 October 2013 16:56, Karicheri, Muralidharan <m-karicheri2@ti.com> wrote:
>>> > Did anyone successfully tested PCIe AER driver on an ARM platform? I saw this enabled in
>>> a tegra platform. Could someone from nVidia respond?
>>>
>>> I've previously used this on a custom ARM platform - it works.
>>>
>>> You need to ensure that PCIe port services are enabled, I believe at one point this required
>>> 'pcie_ports=native' to be set on the kernel command line.
>>>
>>> Andrew Murray
>>>
>
> Yes. That was it. It probes the driver now.

You should not have to boot with "pcie_ports=native" unless you are
debugging or working around a firmware issue.

It looks like get_port_device_capability() expects the arch to
implement a pcie_port_platform_notify() that sets a bitmask of PCIe
services that Linux should take control of.  But that's only
implemented for ACPI systems (x86 and ia64), so probably every other
arch is stuck with the "pcie_ports=native" hack.

This is a bug, and somebody should fix it.  Consider yourself
empowered to implement whatever you need on ARM to negotiate for
control of these PCIe services.

Bjorn
