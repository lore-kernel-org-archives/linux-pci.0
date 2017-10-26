Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:45442 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932369AbdJZVqO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Oct 2017 17:46:14 -0400
Date: Fri, 27 Oct 2017 00:46:09 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
cc: linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCH] alpha/pci: Fix pci_map_irq()/pci_swizzle() functions
 section markers
In-Reply-To: <1509029655-30493-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <alpine.LRH.2.21.1710270045170.20563@math.ut.ee>
References: <1509029655-30493-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Fix the issue by removing the __init/__initdata markers from all subarch
> struct alpha_machine_vector.pci_map_irq()/pci_swizzle() functions (and
> data).
> 
> Fixes: 0e4c2eeb758a ("alpha/PCI: Replace pci_fixup_irqs() call with host bridge IRQ mapping hooks")
> Link: http://lkml.kernel.org/r/alpine.LRH.2.21.1710251043170.7098@math.ut.ee
> Reported-by: Meelis Roos <mroos@linux.ee>

This works on both DS10L and PC164.

-- 
Meelis Roos (mroos@linux.ee)
