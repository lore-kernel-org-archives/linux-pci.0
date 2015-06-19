Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36004 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbbFSNqM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 09:46:12 -0400
Received: by ykdr198 with SMTP id r198so92432703ykd.3
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2015 06:46:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <loom.20150619T074145-299@post.gmane.org>
References: <loom.20150619T074145-299@post.gmane.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 19 Jun 2015 08:45:52 -0500
Message-ID: <CAErSpo52WYqB9hfNKo-ADrJF1LASUz5y9vWzsmp2FaCNc9WZfg@mail.gmail.com>
Subject: Re: PCIe support for ARM64
To: ravikiran gummaluri <rgummal@xilinx.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 19, 2015 at 12:43 AM, ravikiran gummaluri
<rgummal@xilinx.com> wrote:
> HI
>
> I am developing PCIe root port driver for Xilinx device. We have used
> following patch for ARM64 bit support
> "https://lkml.org/lkml/2014/7/3/764". The link explains it as temporary
> patch and main line will be updated soon with those changes. We have not
> seen the changes till now. Can you let us know when we can expect the
> changes in mainline? We are planning to push our drivers to mainline.

There is PCI support for ARM64 in mainline:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d1e6dc91b532

There is also a Xilinx driver already:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/host/pcie-xilinx.c

I don't know if your device is similar to the AXI device, but it would
be good if you can share or modify that driver instead of adding a new
one.

As with several other drivers, the current pcie-xilinx.c uses
pci_common_init_dev(), so it only works on ARM (not ARM64).  This is a
known issue, and people are working on making these drivers less
arch-specific.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
