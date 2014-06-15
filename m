Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:51985 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbaFOCS2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Jun 2014 22:18:28 -0400
Received: by mail-ie0-f176.google.com with SMTP id rd18so3772668iec.21
        for <linux-pci@vger.kernel.org>; Sat, 14 Jun 2014 19:18:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140614212132.15202.29174.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
	<20140614212132.15202.29174.stgit@bhelgaas-glaptop.roam.corp.google.com>
Date: Sat, 14 Jun 2014 19:18:28 -0700
Message-ID: <CAE9FiQWQn6SNMTAQ1_RR=NdMszwOBYG_W9ifFdRN1ZLE0k_vbw@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] PCI: pciehp: Compute timeout from hotplug command
 start time
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Jan C. Nordholz" <jckn@gmx.net>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 14, 2014 at 2:21 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index f44fdb5b0b08..18ac24d84f9b 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -142,11 +143,24 @@ static void pcie_wait_cmd(struct controller *ctrl)
>         if (ctrl->no_cmd_complete)
>                 return;
>
> +       if (!ctrl->cmd_busy)
> +               return;

Can you move those two lines to second patch ?

Other than that, for all 4 patches

Acked-by: Yinghai Lu <yinghai@kernel.org>
