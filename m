Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752137AbeFFW1W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Jun 2018 18:27:22 -0400
Date: Wed, 6 Jun 2018 17:27:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Rename directory from host to controller and move
 back drivers
Message-ID: <20180606222720.GB128611@bhelgaas-glaptop.roam.corp.google.com>
References: <1527729157-201428-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1527729157-201428-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 31, 2018 at 09:12:37AM +0800, Shawn Lin wrote:
> In early discussion, the PCI drivers were scattered across three
> different places, including host, cadence and dwc directories.
> The reason behind that is we thought the name, host, was confusing
> since it seems contain the driver for RC. And dwc drivers set a
> precedent for supporting both of RC and EP mode, so that they were
> moved to a separate directory called dwc which is parallel to the host
> directory. Then cadence drivers follow this convention, and so on.
> But this confuses more and potentially make the drivers/pci/ look
> fragmented if more and more drivers follow this way.
> 
> So this patch rename directory from host to controller and make it
> obvious that this is for controller drivers which applies to both
> of RC and EP drivers. Then it moves back cadence and dwc drivers.
> 
> Hope all are settled down and all the following patches submitting
> new drivers could benefit from it.
> 
> No functional change intended.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

This seems reasonable to me.  It would be even nicer if you had any
URLs for previous conversation about it.  If you find any, just
respond here (no need to repost the patch; I can fold them into the
changelog).

If there's consensus to do this, I can so a second pull request for
v4.18-rc1 next week.  I haven't even done the first one yet, but
hopefully end of this week or early next week.

Bjorn
