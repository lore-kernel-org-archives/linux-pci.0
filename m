Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:46882 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbaJOXs4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Oct 2014 19:48:56 -0400
Received: by mail-qc0-f178.google.com with SMTP id c9so1893217qcz.23
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2014 16:48:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1413416470-14828-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1413416470-14828-1-git-send-email-gwshan@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 15 Oct 2014 17:48:35 -0600
Message-ID: <CAErSpo5iWEiM_0WeLJHfhus_LXo5ByUbDktWzBO1tVqwkko7Sg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Make reset warning messages different
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 15, 2014 at 5:41 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> We have same warning message for FLR and AF FLR and users can't
> know which type of resets the PCI device is taking when there are
> pending transactions. The patch makes them different for FLR and
> AF FLR cases.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  drivers/pci/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 625a4ac..2d708cd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3144,7 +3144,7 @@ static int pcie_flr(struct pci_dev *dev, int probe)
>                 return 0;
>
>         if (!pci_wait_for_pending_transaction(dev))
> -               dev_err(&dev->dev, "transaction is not cleared; proceeding with reset anyway\n");
> +               dev_err(&dev->dev, "Force FLR with pending transaction\n");
>
>         pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
>
> @@ -3178,7 +3178,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>                                  PCI_AF_STATUS_TP << 8))
>                 goto clear;
>
> -       dev_err(&dev->dev, "transaction is not cleared; proceeding with reset anyway\n");
> +       dev_err(&dev->dev, "Force AF FLR with pending transaction\n");

Making the text different is fine, but I don't think "FLR" and "AF
FLR" are meaningful except to extremely technical people.  So I think
"reset" needs to stay spelled out in the message.

>  clear:
>         pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
> --
> 1.8.3.2
>
