Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbeDTS4z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Apr 2018 14:56:55 -0400
Date: Fri, 20 Apr 2018 13:56:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] microblaze/PCI: Remove unused code
Message-ID: <20180420185653.GV28657@bhelgaas-glaptop.roam.corp.google.com>
References: <152336656418.18958.17017091754578447948.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152336656418.18958.17017091754578447948.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 10, 2018 at 08:24:59AM -0500, Bjorn Helgaas wrote:
> Remove some unused microblaze PCI code.
> 
> I can merge these via PCI if you like, Michal.  I have some related
> changes coming for some sparc resource claim issues.  Or it's fine if
> you pick them up.

I applied these to pci/microblaze for v4.17.  If you pick them up,
Michal, I'll drop them; just let me know.

> ---
> 
> Bjorn Helgaas (2):
>       microblaze/PCI: Remove pcibios_finish_adding_to_bus() dead code
>       microblaze/PCI: Remove pcibios_claim_one_bus() dead code
> 
> 
>  arch/microblaze/include/asm/pci.h |    4 --
>  arch/microblaze/pci/pci-common.c  |   61 -------------------------------------
>  2 files changed, 65 deletions(-)
