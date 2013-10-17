Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:37747 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754721Ab3JQNKj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2013 09:10:39 -0400
Date: Thu, 17 Oct 2013 09:10:31 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2] PCI: mvebu - Support a bridge with no IO port window
Message-ID: <20131017131031.GD22434@titan.lakedaemon.net>
References: <1381868182-8544-1-git-send-email-jgunthorpe@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381868182-8544-1-git-send-email-jgunthorpe@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 15, 2013 at 02:16:22PM -0600, Jason Gunthorpe wrote:
> Make pcie-io-aperture and the IO port MBUS ID in ranges optional.
> If not provided the bridge reports to Linux that IO space mapping is
> not supported and refuses to configure an IO mbus window.
> 
> This allows both complete disable (do not specify pcie-io-aperture) and
> per-port disable (do not specify a IO target ranges entry for the port)
> 
> Most PCIE devices these days do not require IO support to function,
> so having an option to disable it in the driver is useful.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 64 +++++++++++++++++++++++++++++---------------
>  1 file changed, 43 insertions(+), 21 deletions(-)

Applied to mvebu/drivers

thx,

Jason.
