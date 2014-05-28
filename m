Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:64204 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbaE1VAA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 May 2014 17:00:00 -0400
Received: by mail-ig0-f178.google.com with SMTP id hl10so3010070igb.5
        for <linux-pci@vger.kernel.org>; Wed, 28 May 2014 13:59:59 -0700 (PDT)
Date: Wed, 28 May 2014 14:59:56 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Will Deacon <will.deacon@arm.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, jgunthorpe@obsidianresearch.com
Subject: Re: [GIT PULL] Generic PCI host controller driver for 3.16
Message-ID: <20140528205956.GU11907@google.com>
References: <20140527224051.GA13786@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140527224051.GA13786@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 27, 2014 at 11:40:51PM +0100, Will Deacon wrote:
> Hi Bjorn,
> 
> Please can you pull my generic PCI host controller driver for 3.16?
> 
> It's been doing the rounds on the lists for some time and things have
> settled down now, despite a recent failed attempt at factoring out the
> configuration space accessors.

Is this the same as patches 2 & 3 of your v7 series of May 23?

The only thing I see that is actually ARM-specific is the
pci_common_init_dev() call and struct hw_pci usage.  That makes sense at
this stage of development.  Maybe someday we'll be able to abstract this
enough to make it truly arch-agnostic.

Bjorn

> --->8
> 
> The following changes since commit d6d211db37e75de2ddc3a4f979038c40df7cc79c:
> 
>   Linux 3.15-rc5 (2014-05-09 13:10:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-bjorn/pci-host-generic
> 
> for you to fetch changes up to 97725ee5aef64b2056c10eabafc92ff89994733d:
> 
>   MAINTAINERS: add entry for generic PCI host controller driver (2014-05-27 23:18:09 +0100)
> 
> ----------------------------------------------------------------
> Will Deacon (2):
>       PCI: ARM: add support for generic PCI host controller
>       MAINTAINERS: add entry for generic PCI host controller driver
> 
>  .../devicetree/bindings/pci/host-generic-pci.txt   | 100 ++++++
>  MAINTAINERS                                        |   8 +
>  drivers/pci/host/Kconfig                           |   7 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pci-host-generic.c                | 388 +++++++++++++++++++++
>  5 files changed, 504 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.txt
>  create mode 100644 drivers/pci/host/pci-host-generic.c
