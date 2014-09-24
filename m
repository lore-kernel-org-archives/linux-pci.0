Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:48859 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbaIXBxb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 21:53:31 -0400
Received: by mail-ie0-f181.google.com with SMTP id tr6so10537594ieb.40
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2014 18:53:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140923023501.GO1880@google.com>
References: <1408756512-16885-1-git-send-email-yinghai@kernel.org>
	<1408756512-16885-3-git-send-email-yinghai@kernel.org>
	<20140923023501.GO1880@google.com>
Date: Tue, 23 Sep 2014 18:53:30 -0700
Message-ID: <CAE9FiQVOkNrJ0mmdoZSLp_ZndTfLPVZ54VC9QhAqf0SUh7ia_g@mail.gmail.com>
Subject: Re: [PATCH] PCI: print out exact timeout in pciehp for wait_cmd
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 22, 2014 at 7:35 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>     [bhelgaas: changelog, use current jiffies instead of adding timeout]

> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 9e0f4aec5f0c..3673a913379f 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -173,7 +173,7 @@ static void pcie_wait_cmd(struct controller *ctrl)
>         if (!rc)
>                 ctrl_info(ctrl, "Timeout on hotplug command %#06x (issued %u msec ago)\n",
>                           ctrl->slot_ctrl,
> -                         jiffies_to_msecs(now - ctrl->cmd_started));
> +                         jiffies_to_msecs(jiffies - ctrl->cmd_started));
>  }
>
>  /**

Yeah, that is more simple.

Thanks

Yinghai
