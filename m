Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750846AbdGMDZ3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jul 2017 23:25:29 -0400
Date: Wed, 12 Jul 2017 22:25:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] constify pci attribute_group structures.
Message-ID: <20170713032526.GF4486@bhelgaas-glaptop.roam.corp.google.com>
References: <1499765228-543-1-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499765228-543-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 11, 2017 at 02:57:06PM +0530, Arvind Yadav wrote:
> attribute_groups are not supposed to change at runtime. All functions
> working with attribute_groups provided by <linux/sysfs.h> work
> with const attribute_group. So mark the non-const structs as const.
> 
> Arvind Yadav (3):
>   [PATCH 1/3] PCI: pci-sysfs: constify attribute_group structures.
>   [PATCH 2/3] PCI: pci-label: constify attribute_group structures.
>   [PATCH 3/3] PCI: hotplug: constify attribute_group structures.
> 
>  drivers/pci/hotplug/rpadlpar_sysfs.c |  2 +-
>  drivers/pci/pci-label.c              |  4 ++--
>  drivers/pci/pci-sysfs.c              | 10 +++++-----
>  3 files changed, 8 insertions(+), 8 deletions(-)

Applied to pci/misc for v4.14, thanks!

For some reason the list got two copies of the cover letter and patch
3 was a response to the *second* cover letter.  But I think I got the
right stuff.
