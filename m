Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753847AbeE3QtP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 May 2018 12:49:15 -0400
Date: Wed, 30 May 2018 11:49:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] xtensa/PCI: Trivial cleanup
Message-ID: <20180530164913.GK39853@bhelgaas-glaptop.roam.corp.google.com>
References: <152699456050.162480.13521209483758803324.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152699456050.162480.13521209483758803324.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2018 at 08:10:07AM -0500, Bjorn Helgaas wrote:
> Remove some dead code, make things static, use dev_printk() to follow style
> of other arches.
> 
> I'll merge these via the PCI tree unless there are objections.
> 
> ---
> 
> Bjorn Helgaas (3):
>       xtensa/PCI: Remove dead code
>       xtensa/PCI: Make variables static
>       xtensa/PCI: Use dev_printk() when possible
> 
> 
>  arch/xtensa/include/asm/pci.h |    2 -
>  arch/xtensa/kernel/pci.c      |   69 ++---------------------------------------
>  2 files changed, 4 insertions(+), 67 deletions(-)

I applied these to pci/misc for v4.18.
