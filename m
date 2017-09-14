Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbdINIBa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Sep 2017 04:01:30 -0400
Date: Thu, 14 Sep 2017 03:01:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sascha El-Sharkawy <elscha@sse.uni-hildesheim.de>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Klaus Schmid <schmid@sse.uni-hildesheim.de>
Subject: Re: [PATCH] PCI SUBSYSTEM allows inconsistent configuration, current
 Kernel version
Message-ID: <20170914080128.GA32091@bhelgaas-glaptop.roam.corp.google.com>
References: <171b5343-c8c2-47bb-b29d-ef21bac15637@messagesink.samelson.uni-hildesheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <171b5343-c8c2-47bb-b29d-ef21bac15637@messagesink.samelson.uni-hildesheim.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sascha,

On Wed, Aug 23, 2017 at 08:22:38AM +0200, Sascha El-Sharkawy wrote:
> We detected that the selection of "PCI resource re-allocation detection"
> (CONFIG_PCI_REALLOC_ENABLE_AUTO) is ignored in some situations. This can
> happen as the related functionality (drivers/pci/setup-bus.c, lines 1702
> - 1738) depends on CONFIG_PCI_REALLOC_ENABLE_AUTO and CONFIG_PCI_IOV,
> while in Kconfig (drivers/pci/Kconfig, lines 42 - 53) this functionality
> is only controlled by CONFIG_PCI_REALLOC_ENABLE_AUTO.
> 
> The dependency on CONFIG_PCI_IOV is only mentioned in the comment of
> CONFIG_PCI_REALLOC_ENABLE_AUTO, but not checked by Kconfig. As
> CONFIG_PCI_IOV is selected by many other configuration options, we expect
> the failure to happen in very few configurations only, which makes it
> even harder to detect and fix. However, there exist configurations that
> will still be faulty.  The suggested fix ensures that the re-allocation
> is always working as specified through an automated selection of
> CONFIG_PCI_IOV if CONFIG_PCI_REALLOC_ENABLE_AUTO is selected.

I'm sorry that I missed this patch.  I normally work from patchwork
(https://patchwork.ozlabs.org/project/linux-pci/list/), and it apparently
doesn't pick up patches that are attached (or maybe it just misses gzipped
ones).

Can you please repost this as plain-text email with the patch included
inline, with a changelog and Signed-off-by?  Then patchwork should pick it
up and I won't forget about it.

For details about Signed-off-by, etc, see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst

Bjorn
