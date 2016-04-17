Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:55167 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbcDQOCp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 17 Apr 2016 10:02:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>, linux-pci@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH 1/2] PCI: iproc: Support DT property for ignoring aborts when probing
Date: Sun, 17 Apr 2016 16:02:13 +0200
Message-ID: <5420659.scnjID7ZLn@wuerfel>
In-Reply-To: <79DC79A7-D4CE-4983-B1C5-CBD2E9CBBFB9@gmail.com>
References: <1460238624-2086-1-git-send-email-zajec5@gmail.com> <79DC79A7-D4CE-4983-B1C5-CBD2E9CBBFB9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday 10 April 2016 18:43:52 Florian Fainelli wrote:
> >+#ifdef CONFIG_ARM
> >+static int iproc_pcie_abort_handler(unsigned long addr, unsigned int
> >fsr,
> >+                                  struct pt_regs *regs)
> >+{
> >+      if (fsr == 0x1406)
> >+              return 0;
> >+
> >+      return 1;
> 
> As you later noted this prevents this driver from being a module now. Since the expectation is that either a fixed bootloader or a platform should enot produce these data aborts, or allow them to be ignored, why not just put this code back where it belongs in the machine specific file which kills many birds with the same stone:
> 
> - code is ways built-in, and hook_fault_code is installed prior to PCIe loading (function is marked with __init)
> - platforms which do not need that, just do not install it for that specific code
> - it is clear which platforms need it and which do not, yet the driver remains agnostic
> 
> NB: there could be other platforms some day needing that which also propagate the error differently, forcing you to add more and more of these codes in the PCIe driver.
> 

I think ideally the driver should be able to access some of its internal
registers to figure out what really happened, but the handler above doesn't
do that, it just silently ignores *any* errors based on the fsr.

Could one of you check the datasheets for the iproc PCI hardware to
see if there are any error handling registers we may want to use to
further drill down on what went wrong and whether it is safe to ignore
the CPU fault?

	Arnd
