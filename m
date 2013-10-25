Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:57186 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab3JYTBW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2013 15:01:22 -0400
Received: by mail-ea0-f179.google.com with SMTP id b10so900289eae.10
        for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2013 12:01:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B704625B1A@DFLE11.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B704625941@DFLE11.ent.ti.com>
	<CAPcvp5Epf+6tOp+0=ZbBLusCzq4dF98aS+Ou0D7Nyko_VwM8KA@mail.gmail.com>
	<3E54258959B69E4282D79E01AB1F32B704625B1A@DFLE11.ent.ti.com>
Date: Fri, 25 Oct 2013 20:01:21 +0100
Message-ID: <CAPcvp5EwTb7qm_aMzqJzLX0ScrD3A0VFog1qga76dqTT5cBW3g@mail.gmail.com>
Subject: Re: AER driver on ARM platform
From: Andrew Murray <amurray@embedded-bits.co.uk>
To: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 25 October 2013 19:18, Karicheri, Muralidharan <m-karicheri2@ti.com> wrote:
>
> >> -----Original Message-----
> >> From: Andrew Murray [mailto:amurray@embedded-bits.co.uk]
> >> Sent: Friday, October 25, 2013 12:27 PM
> >> To: Karicheri, Muralidharan
> >> Cc: linux-pci@vger.kernel.org
> >> Subject: Re: AER driver on ARM platform
> >>
> >> On 25 October 2013 16:56, Karicheri, Muralidharan <m-karicheri2@ti.com> wrote:
> >> > Did anyone successfully tested PCIe AER driver on an ARM platform? I saw this enabled in
> >> a tegra platform. Could someone from nVidia respond?
> >>
> >> I've previously used this on a custom ARM platform - it works.
> >>
> >> You need to ensure that PCIe port services are enabled, I believe at one point this required
> >> 'pcie_ports=native' to be set on the kernel command line.
> >>
> >> Andrew Murray
> >>
>
> Yes. That was it. It probes the driver now. Did you try error inject feature?

I did have a look at that, but it really depends on what exactly you
want to test. There are many things this won't help you with, you
ought to examine the aer inject driver to see what it does. For
example if you are bringing up a new device and want to see it raise
an AER interrupt then aer inject won't help. In this case you'll need
to find a way to trigger real errors.

Andrew Murray
