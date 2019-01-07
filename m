Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F115FC43387
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 22:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C885D2089F
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 22:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfAGW13 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:27:29 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51432 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfAGW13 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jan 2019 17:27:29 -0500
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 8d856251f95b5d62; Mon, 7 Jan 2019 23:27:27 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: pciehp: Disable Data Link Layer State Changed event on suspend
Date:   Mon, 07 Jan 2019 23:26:42 +0100
Message-ID: <3338376.uz3xVmb2pH@aspire.rjw.lan>
In-Reply-To: <20190107143959.75267-3-mika.westerberg@linux.intel.com>
References: <20190107143959.75267-1-mika.westerberg@linux.intel.com> <20190107143959.75267-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday, January 7, 2019 3:39:59 PM CET Mika Westerberg wrote:
> Commit 0e157e528604 ("PCI/PME: Implement runtime PM callbacks") tried to
> solve an issue where the hierarchy immediately wakes up when it is
> transitioned into D3cold. It turns out preventing PME propagation in
> some PCIe hierarchies not supporting D3cold.
> 
> I looked more closely what might cause the immediate wakeup. It happens
> when the ACPI power resource of the root port is turned off. The AML
> code associated with the _OFF() method of the ACPI power resource
> executes PCIe L2/3 ready transition and waits it to complete. Right
> after the L2/3 ready transition is started the root port receives PME
> from the downstream port.
> 
> The simplest hierarchy where this happens looks like this:
> 
>   00:1d.0 PCIe Root port
>     ^
>     |
>     v
>     05:00.0 PCIe switch #1 upstream port
>       06:01.0 PCIe switch #1 downstream hotplug port
>         ^
>         |
>         v
>         08:00.0 Pcie switch #2 upstream port
> 
> It seems that the PCIe link between the two switches, before
> PME_Turn_Off/PME_TO_Ack is complete for the whole hierarchy, goes
> inactive and triggers PME towards the root port bringing it back to D0.
> Disabling Data Link Layer State Changed event (DLLSCE) prevents the
> issue and still allows the downstream hotplug port to notice when a
> device is plugged/unplugged.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202103
> Fixes: 0e157e528604 ("PCI/PME: Implement runtime PM callbacks")
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index cd9eae650aa5..6fdaa8d48ebe 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -736,12 +736,18 @@ void pcie_clear_hotplug_events(struct controller *ctrl)
>  
>  void pcie_enable_interrupt(struct controller *ctrl)
>  {
> -	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_HPIE, PCI_EXP_SLTCTL_HPIE);
> +	u16 mask;
> +
> +	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
> +	pcie_write_cmd(ctrl, mask, mask);
>  }
>  
>  void pcie_disable_interrupt(struct controller *ctrl)
>  {
> -	pcie_write_cmd(ctrl, 0, PCI_EXP_SLTCTL_HPIE);
> +	u16 mask;
> +
> +	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
> +	pcie_write_cmd(ctrl, 0, mask);
>  }
>  
>  /*
> 


