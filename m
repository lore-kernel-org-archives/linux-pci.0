Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:32905 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbbGVVkK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2015 17:40:10 -0400
Received: by ietj16 with SMTP id j16so177893937iet.0
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2015 14:40:10 -0700 (PDT)
Date: Wed, 22 Jul 2015 16:40:00 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Ray Jui <rjui@broadcom.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/4] PCI: iproc: enable arm64 support for iProc PCIe
Message-ID: <20150722214000.GP21967@google.com>
References: <1437528583-855-1-git-send-email-rjui@broadcom.com>
 <1437528583-855-2-git-send-email-rjui@broadcom.com>
 <20150722205316.GO21967@google.com>
 <55B00684.7070502@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55B00684.7070502@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 22, 2015 at 02:09:24PM -0700, Ray Jui wrote:
> I'm fine with the entire change. Both of us understand it's temporary
> and will be removed as soon as struct pci_sys_data is removed from ARM32.
> 
> Note I don't know how the code merge should work here. The iProc PCIe
> driver is enabled when CONFIG_ARCH_BCM_IPROC is enabled. Note patch #3
> of this series enables CONFIG_ARCH_BCM_IPROC for arm64. Without this
> patch, arm64 build will be broken because of struct pci_sys_data.
> 
> I know you are taking PCI changes and I assume Catalin will be merging
> arm64 related changes. But patches in this patch series need to go
> together to keep things intact.

The easiest thing to do would be to merge them all through one tree.
Catalin could ack the arm64 config changes and I could merge everything via
PCI, or I could ack the PCI changes and he could merge them.

I propose the former since the PCI changes are more substantive, but if the
latter works better, feel free to add my:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

to the revised first patch and the second one.

Bjorn
