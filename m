Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41798 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398AbcHIRhJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 9 Aug 2016 13:37:09 -0400
Date: Tue, 9 Aug 2016 12:36:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Wei Zhang <wzhang@fb.com>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 0/3] Limiting pci access requests
Message-ID: <20160809173633.GF27301@localhost>
References: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On Mon, Aug 08, 2016 at 01:14:24PM -0600, Keith Busch wrote:
> We observe that error handling and device hot removal creates many
> unnecessary config and memory accesses to devices, some of which are not
> even present. While we expect command processing to proceed, we observe
> on various platforms that the unnecessary accesses create instability
> with hardware performing completion synthesis, and slows down handling
> of such error events as well as normal IO processing.

Is there some hot removal path that we've suddenly starting exercising
more than we used to?  Can you give us any details of that?  I'm
wondering if there are any more generic fixes we can make.  These
patches seem good, but a little piece-meal, so it feels like there
could be more places where we trip over similar issues.

> This patch series aims to reduce unnecessary accesses.
> 
> Keith Busch (3):
>   pcie: Don't search capabilities on removed devices
>   pci/msix: Skip disabling removed devices
>   pcie/aer: Cache capability position
> 
>  drivers/pci/msi.c             |  5 +++++
>  drivers/pci/pci.c             |  2 +-
>  drivers/pci/pcie/aer/aerdrv.c | 38 +++++++++++++++++---------------------
>  drivers/pci/pcie/aer/aerdrv.h |  1 +
>  4 files changed, 24 insertions(+), 22 deletions(-)
> 
> -- 
> 2.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
