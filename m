Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:53307 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbaEAR4n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 May 2014 13:56:43 -0400
Received: by mail-pa0-f45.google.com with SMTP id kq14so3959167pab.32
        for <linux-pci@vger.kernel.org>; Thu, 01 May 2014 10:56:43 -0700 (PDT)
MIME-Version: 1.0
Reply-To: rajatxjain@gmail.com
In-Reply-To: <1398966055-19325-1-git-send-email-yinghai@kernel.org>
References: <1398966055-19325-1-git-send-email-yinghai@kernel.org>
Date: Thu, 1 May 2014 10:56:42 -0700
Message-ID: <CAA93t1oMk1hGkGfbHohai+Pe37uEA0bsiUQM3WCRfWp1=2yP4g@mail.gmail.com>
Subject: Re: [PATCH v4] pciehp: only wait command complete for real hotplug control
From: Rajat Jain <rajatxjain@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Guenter Roeck <groeck@juniper.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Yinghai,

On Thu, May 1, 2014 at 10:40 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On system with 16 PCI express hotplug slots, customer complain every slot
> will report "Command not completed in 1000 msec" during initialization.
>
> Intel says that we should only wait command complete only for
>            Electromechanical Interlock Control
>            Power Controller Control
>            Power Indicator Control
>            Attention Indicator Control

The document that you sent is an Intel ERRATA. Thus it would be nice
if you can please also mention CF118 in the context of it being an
Intel "errata", so that people do not confuse it with being expected /
default / standard behavior on all platforms.

Thanks,

Rajat

>
> For detail please check CF118 on
>   http://www.intel.com/content/www/us/en/processors/xeon/xeon-e7-v2-spec-update.html
>
> We saw same problems on system with AMD/Nvidia chipsets.
>
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
> -v4: add comments according to Bjorn.
>      also add URL for Intel doc about the CC set on intel chipset.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Tested-by: Rajat Jain <rajatxjain@gmail.com>
>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |   48 ++++++++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 18 deletions(-)
>
> Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
> +++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
> @@ -155,20 +155,30 @@ static void pcie_write_cmd(struct contro
>         u16 slot_status;
>         u16 slot_ctrl;
>
> +       /*
> +        * We basically have two strategies for dealing with Command Complete.
> +        * Both are legal according to the PCIe spec:
> +        * A: Write command at first and wait for Command Complete is set.
> +        * B: Wait at first iff Command Complete and cmd_busy are set,
> +        *    that means previous command is not complete yet.
> +        *    Then write command.
> +        *
> +        * Second way also cover "Command not completed in 1000 msec"
> +        * Problem on system with chipsets that only set Command Complete
> +        * for some "real" hotplug events like:
> +        *      Electromechanical Interlock Control
> +        *      Power Controller Control
> +        *      Power Indicator Control
> +        *      Attention Indicator Control
> +        * like CF118 in
> +        * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e7-v2-spec-update.html
> +        */
> +
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
> @@ -184,16 +194,11 @@ static void pcie_write_cmd(struct contro
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
> @@ -205,6 +210,13 @@ static void pcie_write_cmd(struct contro
>                         poll = 1;
>                  pcie_wait_cmd(ctrl, poll);
>         }
> +
> +       slot_ctrl &= ~mask;
> +       slot_ctrl |= (cmd & mask);
> +       ctrl->cmd_busy = 1;
> +       smp_mb();
> +       pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
> +
>         mutex_unlock(&ctrl->ctrl_lock);
>  }
>
