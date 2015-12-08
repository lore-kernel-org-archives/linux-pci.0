Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59776 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755512AbbLHAqn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Dec 2015 19:46:43 -0500
Date: Mon, 7 Dec 2015 18:46:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Horman <simon.horman@netronome.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH repost 0/3] Support Netronome NFP6000 family quirks
Message-ID: <20151208004631.GF14429@localhost>
References: <1443594907-16196-1-git-send-email-simon.horman@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443594907-16196-1-git-send-email-simon.horman@netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 30, 2015 at 03:35:04PM +0900, Simon Horman wrote:
> Hi,
> 
> this short patch-set adds support for Netronome NFP6000 family quirks.
> 
> Base:
> 
> This patchset is based on the next branch of Bjorn Helgaas's PCI tree.
> 
> About NFP6000 Drivers (someone is bound to ask):
> 
> My understanding is that Netronome is actively working on preparing to
> submit NFP6000 family drivers to mainline.  For now they can be found on
> github at https://github.com/Netronome/nfp-drv-kmods
> 
> Jason S. McMullan (3):
>   PCI: Support PCIe devices with short cfg_size
>   PCI: Add Netronome vendor and device IDs
>   PCI: Support Netronome NFP6000 family quirks
> 
>  drivers/pci/pci-sysfs.c | 18 +++++++++---------
>  drivers/pci/quirks.c    | 11 +++++++++++
>  include/linux/pci_ids.h |  6 ++++++
>  3 files changed, 26 insertions(+), 9 deletions(-)

Applied to pci/misc for v4.5, thanks!

Bjorn
