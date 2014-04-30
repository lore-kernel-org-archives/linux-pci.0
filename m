Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:56923 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbaD3Vvh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Apr 2014 17:51:37 -0400
Received: by mail-ie0-f175.google.com with SMTP id rl12so2627054iec.34
        for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2014 14:51:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1398893606-22712-1-git-send-email-yinghai@kernel.org>
References: <1398893606-22712-1-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 30 Apr 2014 15:51:17 -0600
Message-ID: <CAErSpo7aWM_BjXqEqgTk0uT4RbpZSqjGJOgOH_hWreoQicMU_A@mail.gmail.com>
Subject: Re: [PATCH v3] pciehp: only wait command complete for real hotplug control
To: Yinghai Lu <yinghai@kernel.org>
Cc: Rajat Jain <rajatxjain@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 30, 2014 at 3:33 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On system with 16 PCI express hotplug slots, customer complain every slot
> will report "Command not completed in 1000 msec" during initialization.
>
> Intel says that we should only wait command complete only for
>            Electromechanical Interlock Control
>            Power Controller Control
>            Power Indicator Control
>            Attention Indicator Control
>
> System with AMD/Nvidia chipset have same problem.

Do you have a datasheet reference for any of these parts?  Do we have
any way of identifying the affected parts?  Is it *all* Intel parts,
*all* AMD parts, *all* Nvidia parts?

I want to have a comment in the code because we basically have two
strategies for dealing with Command Complete.  Both are legal
according to the PCIe spec, and you're changing from strategy A to
strategy B because B works better on these parts.  We need a hint in
the code that tells us not to change from B back to A and why.
Otherwise some future programmer is likely to change back to A, which
will break your box again.

> Two ways to address the problem:
> 1. change to only wait when (EIC, PCC, PIC, AIC) bits get changed.
> 2. or check CMD_COMPLETE and wait before write command. Only wait
>    when CC is set and cmd_busy is true. For chipset from intel
>    will only have CC set for real hotplug control, so we could
>    skip the wait for others.
>
> This patch is using second way.
>
> With that we could save 16 seconds during booting, later with 32 sockets system
> with 64 pcie hotplug slots we could save 64 seconds.
>
> This patch address spurious "cmd completed" event problem that that
> Rajat met.
>
> -v2: use second way that is suggested by Bjorn.
> -v3: rebase after
>         PCI: pciehp: Acknowledge spurious "cmd completed" event
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Tested-by: Rajat Jain <rajatxjain@gmail.com>
>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |   28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
>
> Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
> +++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
> @@ -158,17 +158,8 @@ static void pcie_write_cmd(struct contro
>         mutex_lock(&ctrl->ctrl_lock);
>
>         pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> -       if (slot_status & PCI_EXP_SLTSTA_CC) {
> -               pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
> -                                          PCI_EXP_SLTSTA_CC);
> -               if (!ctrl->no_cmd_complete) {
> -                       /*
> -                        * After 1 sec and CMD_COMPLETED still not set, just
> -                        * proceed forward to issue the next command according
> -                        * to spec. Just print out the error message.
> -                        */
> -                       ctrl_dbg(ctrl, "CMD_COMPLETED not clear after 1 sec\n");
> -               } else if (!NO_CMD_CMPL(ctrl)) {
> +       if (ctrl->no_cmd_complete && slot_status & PCI_EXP_SLTSTA_CC) {
> +               if (!NO_CMD_CMPL(ctrl)) {
>                         /*
>                          * This controller seems to notify of command completed
>                          * event even though it supports none of power
> @@ -184,16 +175,11 @@ static void pcie_write_cmd(struct contro
>         }
>
>         pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
> -       slot_ctrl &= ~mask;
> -       slot_ctrl |= (cmd & mask);
> -       ctrl->cmd_busy = 1;
> -       smp_mb();
> -       pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
> -
>         /*
>          * Wait for command completion.
>          */
> -       if (!ctrl->no_cmd_complete) {
> +       if (!ctrl->no_cmd_complete && (slot_status & PCI_EXP_SLTSTA_CC) &&
> +           ctrl->cmd_busy) {
>                 int poll = 0;
>                 /*
>                  * if hotplug interrupt is not enabled or command
> @@ -205,6 +191,12 @@ static void pcie_write_cmd(struct contro
>                         poll = 1;
>                  pcie_wait_cmd(ctrl, poll);
>         }
> +
> +       slot_ctrl &= ~mask;
> +       slot_ctrl |= (cmd & mask);
> +       ctrl->cmd_busy = 1;
> +       smp_mb();
> +       pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
>         mutex_unlock(&ctrl->ctrl_lock);
>  }
>
