Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753142AbcJZN7D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Oct 2016 09:59:03 -0400
Subject: Re: [PATCH] pci: Don't set RCB bit in LNKCTL if the upstream bridge
 hasn't
To: Johannes Thumshirn <jthumshirn@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1477490014-115917-1-git-send-email-jthumshirn@suse.de>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <9faf0b91-70b3-a46d-cf98-369738094e11@suse.de>
Date: Wed, 26 Oct 2016 15:58:59 +0200
MIME-Version: 1.0
In-Reply-To: <1477490014-115917-1-git-send-email-jthumshirn@suse.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/26/2016 03:53 PM, Johannes Thumshirn wrote:
> The Read Completion Boundary bit must only be set on a device or endpoint if
> it is set on the upstream bridge.
> 
> Fixes: 7a1562d4f ("PCI: Apply _HPX Link Control settings to all devices with a link")
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/pci/probe.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
This fixes a regression where the mlx4 driver would not load (and, in
fact, crash) on certain Ivybridge servers.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
