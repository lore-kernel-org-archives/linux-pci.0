Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46789 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244Ab3JYSSF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2013 14:18:05 -0400
From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
To: Andrew Murray <amurray@embedded-bits.co.uk>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: AER driver on ARM platform
Date: Fri, 25 Oct 2013 18:18:02 +0000
Message-ID: <3E54258959B69E4282D79E01AB1F32B704625B1A@DFLE11.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B704625941@DFLE11.ent.ti.com>
 <CAPcvp5Epf+6tOp+0=ZbBLusCzq4dF98aS+Ou0D7Nyko_VwM8KA@mail.gmail.com>
In-Reply-To: <CAPcvp5Epf+6tOp+0=ZbBLusCzq4dF98aS+Ou0D7Nyko_VwM8KA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> -----Original Message-----
>> From: Andrew Murray [mailto:amurray@embedded-bits.co.uk]
>> Sent: Friday, October 25, 2013 12:27 PM
>> To: Karicheri, Muralidharan
>> Cc: linux-pci@vger.kernel.org
>> Subject: Re: AER driver on ARM platform
>> 
>> On 25 October 2013 16:56, Karicheri, Muralidharan <m-karicheri2@ti.com> wrote:
>> > Did anyone successfully tested PCIe AER driver on an ARM platform? I saw this enabled in
>> a tegra platform. Could someone from nVidia respond?
>> 
>> I've previously used this on a custom ARM platform - it works.
>> 
>> You need to ensure that PCIe port services are enabled, I believe at one point this required
>> 'pcie_ports=native' to be set on the kernel command line.
>> 
>> Andrew Murray
>> 

Yes. That was it. It probes the driver now. Did you try error inject feature?

Thanks for your email.

Murali Karicheri
Linux Kernel, Software Development

>> >
>> > Murali Karicheri
>> > Team Lead, Linux Kernel
