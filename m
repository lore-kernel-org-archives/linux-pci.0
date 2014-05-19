Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24907 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbaESVhX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 19 May 2014 17:37:23 -0400
Message-ID: <1400535439.3289.284.camel@ul30vt.home>
Subject: Re: [PATCH 0/4] VFIO Misc fixes
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org
Date: Mon, 19 May 2014 15:37:19 -0600
In-Reply-To: <1400468470-11262-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1400468470-11262-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2014-05-19 at 13:01 +1000, Gavin Shan wrote:
> Changelog
> =========
> v1 -> v2:
>         * Change the comments and commit log in PATCH[4/4] (Alex).
>         * Export 2 MSI relevant functions (Alex).
> v2 -> v3:
> 	* Add missed header file in PATCH[4/4].

Please specify the version in the Subject for all patches.

It would probably be a good idea to separate this series.  Patches 2 & 3
stand on their own.  Send them that way so we can actually get them in.
Patch 4 is dependent on Patch 1, so send them as a series.

Bjorn, if you approve of the symbol export in 1/4, I'm happy to either
take it with your Ack or let you also take 4/4.  Otherwise please let us
know so Gavin can try something else.  Thanks,

Alex

> Gavin Shan (4):
>   PCI: Export MSI message relevant functions
>   drivers/vfio: Rework offsetofend()
>   drivers/vfio/pci: Fix wrong MSI interrupt count
>   vfio/pci: Restore MSIx message prior to enabling
> 
>  drivers/pci/msi.c                 |  2 ++
>  drivers/vfio/pci/vfio_pci.c       |  3 +--
>  drivers/vfio/pci/vfio_pci_intrs.c | 15 +++++++++++++++
>  include/linux/vfio.h              |  5 ++---
>  4 files changed, 20 insertions(+), 5 deletions(-)
> 



