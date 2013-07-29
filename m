Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34165 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab3G2T6e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jul 2013 15:58:34 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so1377864obc.10
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2013 12:58:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1374937868-24437-2-git-send-email-yinghai@kernel.org>
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org> <1374937868-24437-2-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 29 Jul 2013 13:58:13 -0600
Message-ID: <CAErSpo7xk-NGp+4ZFo-jnVnQSEomY=7=CXDSbZPzrhdjZ4zVSA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: Stop sriov after stop PF if PF's driver skip that
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <liuj97@gmail.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	Donald Dutile <ddutile@redhat.com>,
	Greg Rose <gregory.v.rose@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 27, 2013 at 9:11 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> After commit dc087f2f6a2925e81831f3016b9cbb6e470e7423
> (PCI: Simplify IOV implementation and fix reference count races)
> VF need to be removed via virtfn_remove to make sure ref to PF
> is put back.
>
> Some driver (like ixgbe) does not call pci_disable_sriov() if
> sriov is enabled via /sys/.../sriov_numvfs setting.
> ixgbe does allow driver for PF get detached, but still have VFs
> around.

Is this something ixgbe should be doing differently?

I'm not 100% sold on the idea of the VFs staying active after the
driver releases the PF.  It seems asymmetric because I think the
driver has to claim the PF to *enable* the VFs, but we don't disable
them when releasing the PF.

What's the use case for detaching the PF driver while the VFs are active?

> But how about PF get removed via /sys or pciehp finally?
>
> During hot-remove, VF will still hold one ref to PF and it
> prevent PF to be removed.
> That make the next hot-add fails, as old PF dev struct is still around.
>
> We need to add pci_disable_sriov() calling during stop PF .
>
> Need this one for v3.11

Don had a concern that there might be a regression here ... I'm a bit
confused on the details, but you guys need to come to agreement that
this doesn't make things worse.

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Jiang Liu <liuj97@gmail.com>
> Cc: Alexander Duyck <alexander.h.duyck@intel.com>
> Cc: Donald Dutile <ddutile@redhat.com>
> Cc: Greg Rose <gregory.v.rose@intel.com>
>
> ---
>  drivers/pci/remove.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> Index: linux-2.6/drivers/pci/remove.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/remove.c
> +++ linux-2.6/drivers/pci/remove.c
> @@ -25,6 +25,8 @@ static void pci_stop_dev(struct pci_dev
>                 pci_proc_detach_device(dev);
>                 pci_remove_sysfs_dev_files(dev);
>                 device_del(&dev->dev);
> +               /* remove VF, if PF driver skip that */
> +               pci_disable_sriov(dev);
>                 dev->is_added = 0;
>         }
>
