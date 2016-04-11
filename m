Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34611 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbcDKBoV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 Apr 2016 21:44:21 -0400
Received: by mail-pa0-f41.google.com with SMTP id ot11so27816334pab.1
        for <linux-pci@vger.kernel.org>; Sun, 10 Apr 2016 18:44:20 -0700 (PDT)
In-Reply-To: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
References: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 1/2] PCI: iproc: Support DT property for ignoring aborts when probing
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 10 Apr 2016 18:43:52 -0700
To: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>
CC: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <79DC79A7-D4CE-4983-B1C5-CBD2E9CBBFB9@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On April 9, 2016 2:50:23 PM PDT, "Rafał Miłecki" <zajec5@gmail.com> wrote:
>Some devices (e.g. Northstar ones) may have bridges that forward
>harmless errors to the ARM core. In such case we need an option to
>add a handler ignoring them.
>
>Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>---

>+- brcm,pcie-hook-abort-handler: During PCI bus probing (device
>enumeration)
>+  there can be errors that are expected and harmless. Unfortunately
>some bridges
>+  can't be configured to ignore them and they forward them to the ARM
>core
>+  triggering die().
>+  This property should be set in such case, it will make driver add
>its own
>+  handler ignoring such errors.

The property is named after the function that allows you to catch abort handlers, whereas you should be describing the HW here. Something like brcm,bridge-error-forward or a better name even would be preferable.

>+#ifdef CONFIG_ARM
>+static int iproc_pcie_abort_handler(unsigned long addr, unsigned int
>fsr,
>+				    struct pt_regs *regs)
>+{
>+	if (fsr == 0x1406)
>+		return 0;
>+
>+	return 1;

As you later noted this prevents this driver from being a module now. Since the expectation is that either a fixed bootloader or a platform should enot produce these data aborts, or allow them to be ignored, why not just put this code back where it belongs in the machine specific file which kills many birds with the same stone:

- code is ways built-in, and hook_fault_code is installed prior to PCIe loading (function is marked with __init)
- platforms which do not need that, just do not install it for that specific code
- it is clear which platforms need it and which do not, yet the driver remains agnostic

NB: there could be other platforms some day needing that which also propagate the error differently, forcing you to add more and more of these codes in the PCIe driver.

-- 
Florian
