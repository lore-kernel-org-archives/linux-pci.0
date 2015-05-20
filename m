Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36411 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbbETF1a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2015 01:27:30 -0400
Received: by igbpi8 with SMTP id pi8so93836098igb.1
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2015 22:27:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1431465781-10753-3-git-send-email-hauke@hauke-m.de>
References: <1431465781-10753-1-git-send-email-hauke@hauke-m.de>
	<1431465781-10753-3-git-send-email-hauke@hauke-m.de>
Date: Wed, 20 May 2015 07:27:30 +0200
Message-ID: <CACna6rxfKT5+LEDHq+QgPuSgX5t-HpOfX93pfnHRXX1_cGy3+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: iproc: add bcma pcie driver
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Ray Jui <rjui@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Scott Branden <sbranden@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12 May 2015 at 23:23, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This driver adds support for the PCIe 2.0 controller found on the bcma
> bus. This controller can be found on (mostly) all Broadcom BCM470X /
> BCM5301X ARM SoCs.
>
> The driver found in the Broadcom SDK does some more stuff, like setting
> up some DMA memory areas, chaining MPS and MRRS to 512 and also some
> PHY changes like "improving" the PCIe jitter and doing some special
> initializations for the 3rd PCIe port.
>
> This was tested on a bcm4708 board with 2 PCIe ports and wireless cards
> connected to them.
>
> PCI_DOMAINS is needed by this driver, because normally there is more
> than one PCIe controller and without PCI_DOMAINS only the first
> controller gets registered.
> This controller gets 6 IRQs, the last one is trigged by all IRQ events.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Acked-by: Rafał Miłecki <zajec5@gmail.com>
