Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20183 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756193Ab2IFOeq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 6 Sep 2012 10:34:46 -0400
From: Prarit Bhargava <prarit@redhat.com>
To: linux-pci@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH part1 1/4] PCI, pciehp: Turn on link again after power off the slot
Date: Thu,  6 Sep 2012 10:34:31 -0400
Message-Id: <1346942071-15188-1-git-send-email-prarit@redhat.com>
In-Reply-To: <1346622458-30595-2-git-send-email-yinghai@kernel.org>
References: <1346622458-30595-2-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: stable@vger.kernel.org

>diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>index 13b2eaf..7cee8db 100644
>--- a/drivers/pci/hotplug/pciehp_hpc.c
>+++ b/drivers/pci/hotplug/pciehp_hpc.c
>@@ -631,6 +631,8 @@ int pciehp_power_off_slot(struct slot * slot)
> 	slot_cmd = POWER_OFF;
> 	cmd_mask = PCI_EXP_SLTCTL_PCC;
> 	retval = pcie_write_cmd(ctrl, slot_cmd, cmd_mask);
>+	/* need to enable link again for present bit report */
>+	pciehp_link_enable(ctrl);

You're not checking the return value of pciehp_link_enable().  I wonder if
enabling the link is the only way to get the present bit to report correctly...

Also, should the pciehp_link_enable() be called in pciehp_power_on_slot() if
we already reenable it on the power off?

P.
