Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752792AbdF0X0R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jun 2017 19:26:17 -0400
Date: Tue, 27 Jun 2017 18:26:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Switchtec Changes for v4.13
Message-ID: <20170627232615.GL17844@bhelgaas-glaptop.roam.corp.google.com>
References: <20170615201224.5371-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170615201224.5371-1-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 15, 2017 at 02:12:22PM -0600, Logan Gunthorpe wrote:
> Hi Bjorn,
> 
> Can you please queue up these two minor changes for v4.13?
> 
> Thanks,
> 
> Logan
> 
> Logan Gunthorpe (2):
>   switchtec: running status flag to fw partition info ioctl
>   switchtec: add device ids for additional switchtec products
> 
>  drivers/pci/switch/switchtec.c       | 40 ++++++++++++++++++++++++++++++++++--
>  include/uapi/linux/switchtec_ioctl.h |  3 +++
>  2 files changed, 41 insertions(+), 2 deletions(-)

Applied to pci/switchtec for v4.13, thanks!
