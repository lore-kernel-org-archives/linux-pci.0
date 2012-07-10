Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:37234 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab2GJTas (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jul 2012 15:30:48 -0400
Received: by vbbff1 with SMTP id ff1so257803vbb.19
        for <linux-pci@vger.kernel.org>; Tue, 10 Jul 2012 12:30:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
Date: Tue, 10 Jul 2012 12:30:47 -0700
Message-ID: <CAE9FiQXK=ByAkjVU53ftMYchsGSKD-yCLUpCLNZoZA_7=bzWOw@mail.gmail.com>
Subject: Re: [PATCH 0/5] PCI: hotplug related misc patches
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 23, 2012 at 12:42 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> minor changes that should be safe for 3.6
>
> could get from
>         git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-next
>
> Yinghai Lu (5):
>   PCI, acpiphp: remove not used res_lock
>   pciehp: Don't enable presence notification while surprise removal is
>     not supported.
>   PCI, acpiphp: Merge acpiphp_debug and debug
>   PCI, acpiphp: add is_hotplug_bridge detection
>   PCI: add root bus children dev's res to fail list
>
>  drivers/pci/hotplug/acpiphp.h      |    4 +---
>  drivers/pci/hotplug/acpiphp_core.c |    7 ++-----
>  drivers/pci/hotplug/acpiphp_glue.c |   30 ++++++++++++++++++++++++++----
>  drivers/pci/hotplug/pciehp_hpc.c   |    5 +++--
>  drivers/pci/setup-bus.c            |    2 +-
>  5 files changed, 33 insertions(+), 15 deletions(-)

can you put those 5 patches into pci/next?

Those should be safe for v3.6 merging window.

Thanks

Yinghai
