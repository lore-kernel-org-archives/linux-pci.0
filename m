Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:38261 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751653AbdFZP7z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Jun 2017 11:59:55 -0400
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20170615201224.5371-1-logang@deltatee.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1820c06c-7849-5b9c-5c6a-7202e0979e2b@deltatee.com>
Date: Mon, 26 Jun 2017 09:59:49 -0600
MIME-Version: 1.0
In-Reply-To: <20170615201224.5371-1-logang@deltatee.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH 0/2] Switchtec Changes for v4.13
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Poke.

I'd *really* like to see these two patches in for 4.13 because otherwise
we'll have an annoying conflict with the NTB work I'm trying to do for
4.14. (See the RFC set I've already posted.)

Thanks,

Logan

On 15/06/17 02:12 PM, Logan Gunthorpe wrote:
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
> 
> --
> 2.11.0
> 
