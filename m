Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:37798 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbaC1LqX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Mar 2014 07:46:23 -0400
Date: Fri, 28 Mar 2014 11:46:18 +0000
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Rob Herring <robherring2@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/3] Versatile PCI DT support
Message-ID: <20140328114618.GY17163@e106497-lin.cambridge.arm.com>
References: <1395960398-4238-1-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1395960398-4238-1-git-send-email-robherring2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 27, 2014 at 10:46:35PM +0000, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> This series adds a platform driver for Versatile PB's PCI host using
> Liviu's recent patch series[1] for DT parsing and setup.
> 
> The first patch is a hack to get Liviu's current patches to work on ARM.
> It at least shows we are not that far off from being able to use the
> series on ARM.
> 
> I've tested PCI under QEMU, but need someone with actual h/w to test.
> A branch with this series and which includes full conversion of
> Versatile to DT is available here[2].

Hi Rob,

Thanks for doing this. Hopefully others will take inspiration and start to
convert their host bridge controllers as well.

I will post an updated series soon. (Un)fortunately it will look slightly
different than the last one I've posted as I am trying to get more code
that I've currently placed in arch/arm64/kernel/pci.c into drivers/pci,
so you will need to revisit your series.

Regarding your comment about bridge->bus->self being needed: root busses
are supposed to have bus->self == NULL, and the bridge->bus *is* the root
bus. Where would you need to use bridge->bus->self?

Best regards,
Liviu

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
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

