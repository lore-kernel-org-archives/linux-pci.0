Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:61730 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381Ab2JaMXk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 08:23:40 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so611194wey.19
        for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 05:23:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5090F723.3090103@gmail.com>
References: <5090F723.3090103@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 31 Oct 2012 06:23:18 -0600
Message-ID: <CAErSpo4sO9qrQdJLD6LxkrAKpzG+dbf9Oekv7PLLdXnZ0QQi2w@mail.gmail.com>
Subject: Re: Linux and multy domain PCIe.
To: fpaolo63 <fpaolo63@gmail.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 31, 2012 at 4:02 AM, fpaolo63 <fpaolo63@gmail.com> wrote:
> Hi guru,
>
> I'm working on a multi socket intel xeon platform.
>
> We have 2 sockets and each socket has a PCIe RootComplex, and we'd to
> implement hw with 2 separated PCIe tree.
>
> Can Linux kernel handle the 2 RC assigning a PCIe domain each one?
>
> Do we need special BIOS in order to configure correctly the 2 sockets, QDPI
> channel, MMIO and MMU?
>
> Can some one point me to one example or documents?

Yes, Linux supports multiple PCI domains (also known as PCI segment groups).

On x86, the BIOS should provide a ACPI PNP0A08/PNP0A03 device for each
root complex.  See drivers/acpi/pci_root.c for details.
