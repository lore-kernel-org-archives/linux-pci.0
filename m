Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbeGaSSg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Jul 2018 14:18:36 -0400
Date: Tue, 31 Jul 2018 11:37:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hari Vyas <hari.vyas@broadcom.com>
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
        linux-pci@vger.kernel.org, ray.jui@broadcom.com
Subject: Re: [PATCH v3] PCI: Data corruption happening due to race condition
Message-ID: <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 03, 2018 at 02:35:40PM +0530, Hari Vyas wrote:
> Changes in v3:
> 	As per review comments from Lukas Wunner <lukas@wunner.de>,
> 	squashed 3 commits to single commit. Without this build breaks.
> 	Also clubbed set and clear function for is_added bits to a
> 	single assign function. This optimizes code and reduce LoC.
> 	Removed one wrongly added blank line in pci.c
> 	 
> Changes in v2:
>         To avoid race condition while updating is_added and is_busmaster
>         bits, is_added is moved to a private flag variable.
>         is_added updation is handled in atomic manner also.
> 
> Hari Vyas (1):
>   PCI: Data corruption happening due to race condition
> 
>  arch/powerpc/kernel/pci-common.c          |  4 +++-
>  arch/powerpc/platforms/powernv/pci-ioda.c |  3 ++-
>  arch/powerpc/platforms/pseries/setup.c    |  3 ++-
>  drivers/pci/bus.c                         |  6 +++---
>  drivers/pci/hotplug/acpiphp_glue.c        |  2 +-
>  drivers/pci/pci.h                         | 11 +++++++++++
>  drivers/pci/probe.c                       |  4 ++--
>  drivers/pci/remove.c                      |  5 +++--
>  include/linux/pci.h                       |  1 -
>  9 files changed, 27 insertions(+), 12 deletions(-)

Applied with Lukas' reviewed-by and Michael's ack to for-linus for v4.18,
thanks!
