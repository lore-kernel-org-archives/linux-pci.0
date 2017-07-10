Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754584AbdGJVrZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jul 2017 17:47:25 -0400
Date: Mon, 10 Jul 2017 16:47:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v8 1/6] PCI: add a define for the PCI resource type mask
 v2
Message-ID: <20170710214721.GF5610@bhelgaas-glaptop.roam.corp.google.com>
References: <1499698794-1718-1-git-send-email-deathsimple@vodafone.de>
 <1499698794-1718-2-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1499698794-1718-2-git-send-email-deathsimple@vodafone.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If you post this again, you can drop the "v2", "v5", etc at the end of
the subject lines.  I don't think it's useful to merge those.

On Mon, Jul 10, 2017 at 04:59:49PM +0200, Christian König wrote:
> From: Christian König <christian.koenig@amd.com>
> 
> We use this mask multiple times in the bus setup.
> 
> v2: fix some style nit picks

And you can put these "v2: ..." notes after the "---" because I don't
think they're useful after merging either.

> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/pci/pci.h       |  3 +++
>  drivers/pci/setup-bus.c | 12 +++---------
>  2 files changed, 6 insertions(+), 9 deletions(-)
