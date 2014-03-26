Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36439 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbaCZR2t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Mar 2014 13:28:49 -0400
Received: by mail-ie0-f182.google.com with SMTP id y20so2030880ier.13
        for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2014 10:28:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANwwZzXdFsZGcjwOZURNG4=NPj0ZZ20e7euecGjgv==g=pBusQ@mail.gmail.com>
References: <CANwwZzXdFsZGcjwOZURNG4=NPj0ZZ20e7euecGjgv==g=pBusQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 26 Mar 2014 11:28:29 -0600
Message-ID: <CAErSpo5OoxphacWhCCXS7LrpgJSdmq1wgqFdKByMEoqCAamH2Q@mail.gmail.com>
Subject: Re: query regarding BAR mapping
To: Bob Biloxi <iambobbiloxi@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 26, 2014 at 5:50 AM, Bob Biloxi <iambobbiloxi@gmail.com> wrote:
> Hi All,
>
> I am writing a driver for PCIe network device. I am still trying to
> learn, so my question might be like a simple one as I do not
> understand most of the things.

You should start by looking at and copying an existing, working
driver.  bnx2x and ixgbe are examples for some current hardware, but
they are big and complicated.  e100 is older but simpler.  A
networking person could give better advice.

> From the BAR0 address that I read, the memory size is around 256MB.
> But I have only 128MB at my disposal.

The BAR determines the size in MMIO space.  I'm not sure what you mean
by "have only 128MB at my disposal."  If you have limited virtual
memory space and your driver doesn't need the whole MMIO region, you
can just map the part you need.

> So my question is how do i map this BAR so as to access the MMIO region.

pci_iomap() is a good place to start.  That gives you an __iomem
address that you can then pass to ioread*() and iowrite*() to access
the MMIO region.  It maps the entire region, so if you need less,
you'd probably use ioremap() directly.

Bjorn
