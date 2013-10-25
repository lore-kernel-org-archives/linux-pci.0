Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39494 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab3JYUtS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2013 16:49:18 -0400
Received: by mail-ee0-f46.google.com with SMTP id c1so2267846eek.19
        for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2013 13:49:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4TOvYZsjxc3UhCbPUv1NPEy3m-DjtLh-v8q0geGvPhUg@mail.gmail.com>
References: <3E54258959B69E4282D79E01AB1F32B704625941@DFLE11.ent.ti.com>
	<CAPcvp5Epf+6tOp+0=ZbBLusCzq4dF98aS+Ou0D7Nyko_VwM8KA@mail.gmail.com>
	<3E54258959B69E4282D79E01AB1F32B704625B1A@DFLE11.ent.ti.com>
	<CAErSpo4TOvYZsjxc3UhCbPUv1NPEy3m-DjtLh-v8q0geGvPhUg@mail.gmail.com>
Date: Fri, 25 Oct 2013 21:49:17 +0100
Message-ID: <CAPcvp5GzymFm9c4rirJ-i3a4HVPgJSMGD4bJF8a_ncYJ4GCF1g@mail.gmail.com>
Subject: Re: AER driver on ARM platform
From: Andrew Murray <amurray@embedded-bits.co.uk>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Karicheri, Muralidharan" <m-karicheri2@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 25 October 2013 20:48, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Oct 25, 2013 at 12:18 PM, Karicheri, Muralidharan
> <m-karicheri2@ti.com> wrote:
>>>> -----Original Message-----
>>>> From: Andrew Murray [mailto:amurray@embedded-bits.co.uk]
>>>> Sent: Friday, October 25, 2013 12:27 PM
>>>> To: Karicheri, Muralidharan
>>>> Cc: linux-pci@vger.kernel.org
>>>> Subject: Re: AER driver on ARM platform
>>>>
>>>> On 25 October 2013 16:56, Karicheri, Muralidharan <m-karicheri2@ti.com> wrote:
>>>> > Did anyone successfully tested PCIe AER driver on an ARM platform? I saw this enabled in
>>>> a tegra platform. Could someone from nVidia respond?
>>>>
>>>> I've previously used this on a custom ARM platform - it works.
>>>>
>>>> You need to ensure that PCIe port services are enabled, I believe at one point this required
>>>> 'pcie_ports=native' to be set on the kernel command line.
>>>>
>>>> Andrew Murray
>>>>
>>
>> Yes. That was it. It probes the driver now.
>
> You should not have to boot with "pcie_ports=native" unless you are
> debugging or working around a firmware issue.
>
> It looks like get_port_device_capability() expects the arch to
> implement a pcie_port_platform_notify() that sets a bitmask of PCIe
> services that Linux should take control of.  But that's only
> implemented for ACPI systems (x86 and ia64), so probably every other
> arch is stuck with the "pcie_ports=native" hack.
>
> This is a bug, and somebody should fix it.  Consider yourself
> empowered to implement whatever you need on ARM to negotiate for
> control of these PCIe services.

I'll pick this up.

Andrew Murray
