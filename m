Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:51356 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab3JYQ0z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2013 12:26:55 -0400
Received: by mail-ea0-f178.google.com with SMTP id a15so795476eae.9
        for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2013 09:26:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B704625941@DFLE11.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B704625941@DFLE11.ent.ti.com>
Date: Fri, 25 Oct 2013 17:26:53 +0100
Message-ID: <CAPcvp5Epf+6tOp+0=ZbBLusCzq4dF98aS+Ou0D7Nyko_VwM8KA@mail.gmail.com>
Subject: Re: AER driver on ARM platform
From: Andrew Murray <amurray@embedded-bits.co.uk>
To: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 25 October 2013 16:56, Karicheri, Muralidharan <m-karicheri2@ti.com> wrote:
> Did anyone successfully tested PCIe AER driver on an ARM platform? I saw this enabled in a tegra platform. Could someone from nVidia respond?

I've previously used this on a custom ARM platform - it works.

You need to ensure that PCIe port services are enabled, I believe at
one point this required 'pcie_ports=native' to be set on the kernel
command line.

Andrew Murray

>
> Murali Karicheri
> Team Lead, Linux Kernel
