Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:50240 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbaDXXKF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Apr 2014 19:10:05 -0400
Received: by mail-pd0-f182.google.com with SMTP id y10so2426668pdj.41
        for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2014 16:10:05 -0700 (PDT)
Date: Thu, 24 Apr 2014 17:10:03 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Rob Herring <robherring2@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, liviu.dudau@arm.com,
	linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/3] Versatile PCI DT support
Message-ID: <20140424231003.GM29593@google.com>
References: <1395960398-4238-1-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395960398-4238-1-git-send-email-robherring2@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 27, 2014 at 05:46:35PM -0500, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> This series adds a platform driver for Versatile PB's PCI host using
> Liviu's recent patch series[1] for DT parsing and setup.
> 
> The first patch is a hack to get Liviu's current patches to work on ARM.
> It at least shows we are not that far off from being able to use the
> series on ARM.

Since this depends on Liviu's work that is not yet upstream, I guess I
can't do anything with this yet, right?  Poke me again when I can.

I assume you would want a MAINTAINERS update, too (at least, *I* do :))

> I've tested PCI under QEMU, but need someone with actual h/w to test.
> A branch with this series and which includes full conversion of
> Versatile to DT is available here[2].
> 
> Rob
> 
> [1] https://lkml.org/lkml/2014/3/14/279
> [2] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git versatile
> 
> Rob Herring (3):
>   ARM: hackup pcibios support for commmon bridge code
>   dt/bindings: add versatile PCI binding
>   pci: add DT based ARM Versatile PCI host driver
> 
>  .../devicetree/bindings/pci/versatile.txt          |  59 +++++
>  arch/arm/kernel/bios32.c                           |  63 +++++
>  drivers/pci/host/Kconfig                           |   4 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pci-versatile.c                   | 275 +++++++++++++++++++++
>  5 files changed, 402 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/versatile.txt
>  create mode 100644 drivers/pci/host/pci-versatile.c
> 
> -- 
> 1.8.3.2
> 
