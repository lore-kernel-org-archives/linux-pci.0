Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34568 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbbGTNdj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2015 09:33:39 -0400
Received: by wibud3 with SMTP id ud3so87929319wib.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2015 06:33:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG0bkv+Sve7+XWtGk-kkQU=-64CPbpE=5RMbVq-RzWNgg--6ZQ@mail.gmail.com>
References: <CAG0bkv+Sve7+XWtGk-kkQU=-64CPbpE=5RMbVq-RzWNgg--6ZQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 20 Jul 2015 08:33:18 -0500
Message-ID: <CAErSpo5hak56Xm-AqHDM1D+gEiCi+a5r-9cA7bJZWpNO+2oZGw@mail.gmail.com>
Subject: Re: PCIe: Xilinx: sdhci-pci: probe() issue
To: Naveen Kumar Parna <pnaveenkos@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Naveen,

On Mon, Jul 20, 2015 at 5:55 AM, Naveen Kumar Parna
<pnaveenkos@gmail.com> wrote:
> Hi ,
>
> I have a Verilog image & hardware which provides a PCIe interface with
> two BAR’s(BAR0 & BAR1) to host.
>
> BAR0 is having customized UART, GPIO and 1-wire prom modules. These
> modules are accessed via customized PCIe interface driver.
>
> BAR1 is having SD Host controller as per SD Specifications. Here
> requirement is such that we should use Linux kernel stack drivers
> (sdhci.ko & sdhci-pci.ko).
>
>
> Here the issue is only one driver’s probe() function gets executed
> i.e. either customized PCIe driver or sdhci-pci.ko.

The PCI infrastructure is designed such that a bus/device/function
address identifies a single device.  To that device, we can attach a
single driver, which manages all BARs on that device.  There is no
provision for attaching one driver to BAR0 and a different driver to
BAR1.

To manage the device you describe, you'd have to have a driver that
claims the entire PCI device, including both BARs.  That driver would
internally deal with the UART, GPIO, 1-wire prom, and SD host
controller modules.

Bjorn
