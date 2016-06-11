Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50306 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249AbcFKAPg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jun 2016 20:15:36 -0400
Date: Fri, 10 Jun 2016 19:15:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chris Blake <chrisrblake93@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] Add AR9485 & QCA988X to no_bus_reset quirk
Message-ID: <20160611001533.GG16462@localhost>
References: <1464611198-11494-1-git-send-email-chrisrblake93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464611198-11494-1-git-send-email-chrisrblake93@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 30, 2016 at 07:26:36AM -0500, Chris Blake wrote:
> Both the AR9485 and QCA988x require the no_bus_reset quirk to be set for them
> to work correctly with PCI Passthrough. Both of these have been tested on
> Linux 4.4.8 and work as intended.
> 
> Chris Blake (2):
>   Add Quirk for Atheros AR9485 Bus Reset
>   Add Quirk for Qualcom Atheros QCA9882 Bus Reset

I squashed these into a single patch, marked it for stable just like
we did for the original, c3e59ee4e766 ("PCI: Mark Atheros AR93xx to
avoid bus reset"), and applied it to pci/virtualization for v4.8.

Thanks, Chris!
