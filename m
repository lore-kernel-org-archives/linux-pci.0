Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:57191 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757486Ab3KMQr1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2013 11:47:27 -0500
Received: by mail-ie0-f169.google.com with SMTP id tp5so888540ieb.14
        for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2013 08:47:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52837A10.3040301@linux.vnet.ibm.com>
References: <52837A10.3040301@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 13 Nov 2013 09:47:07 -0700
Message-ID: <CAErSpo4T3poaKkamm1rqZDmSvom0R5PC7Yb1BU-jT0t+6iW95A@mail.gmail.com>
Subject: Re: A question about the patch: [PATCH] PCI/PM: Keep runtime PM
 enabled for unbound PCI devices
To: mike <qiudayu@linux.vnet.ibm.com>
Cc: Huang Ying <ying.huang@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael, linux-pm]

On Wed, Nov 13, 2013 at 6:09 AM, mike <qiudayu@linux.vnet.ibm.com> wrote:
> Hi Huang Ying,
>
> I see you are the author of this patch, commit id is:
> 967577b062417b4e4b8e27b711220f4124f5153a
>
> I have a question while I try to understand this patch,
> So I would very grateful if you or others can give me some reply.....
>
> ............
> -       rc = ddi->drv->probe(ddi->dev, ddi->id);
> +       pm_runtime_get_sync(dev);
> +       pci_dev->driver = pci_drv;
> ^^^^^^^^^^^^^^^^^^^^^^^^^^
> I see here you make the driver to initialize before probe,
> But I have no idea of why you do this change.....
>
> and I look inside the code, it may be pm_runtime relate??
>
> Thanks
> Mike
> +       rc = pci_drv->probe(pci_dev, ddi->id);
>         if (rc) {
> -               pm_runtime_disable(dev);
> -               pm_runtime_set_suspended(dev);
> -               pm_runtime_put_noidle(dev);
> +               pci_dev->driver = NULL;
> +               pm_runtime_put_sync(dev);
>         }
> -       if (parent)
> -               pm_runtime_put(parent);
>         return rc;
>  }
>
> @@ -330,10 +325,8 @@ __pci_device_probe(struct pci_driver *drv, struct
> pci_dev *pci_dev)
>                 id = pci_match_device(drv, pci_dev);
>                 if (id)
>                         error = pci_call_probe(drv, pci_dev, id);
> -               if (error >= 0) {
> -                       pci_dev->driver = drv;
> +               if (error >= 0)
>                         error = 0;
> -               }
>         }
>         return error;
>  }
> .......................
>
