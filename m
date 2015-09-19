Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33393 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbbISF1G (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 19 Sep 2015 01:27:06 -0400
Received: by vkgd64 with SMTP id d64so41011949vkg.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2015 22:27:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150918223059.GO25767@google.com>
References: <1441877628-28879-1-git-send-email-lorenzo.pieralisi@arm.com>
	<20150918223059.GO25767@google.com>
Date: Fri, 18 Sep 2015 22:27:03 -0700
Message-ID: <CAE9FiQVo4h=D6E+3FkCzw0atg7SMyov8mydJRACidOmqSBiQ2Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix pci_claim_bridge_resource() resource claiming
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 18, 2015 at 3:30 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Sep 10, 2015 at 10:33:48AM +0100, Lorenzo Pieralisi wrote:
>
> I wasn't sure about the provenance of your patch, Lorenzo.  You had a
> Signed-off-by from Yinghai, but I didn't see the original posting.  If
> it originally came from Yinghai, I should change the
> "Based-on-patch-by" below.

Lorenzo posted v1 that removed second claim.

-- >8 --
Subject: [PATCH] PCI: remove dead code in pci_claim_bridge_resource()

Commit 8505e729a2f6eb ("PCI: Add pci_claim_bridge_resource() to clip
window if necessary") introduced a new API to claim bridge resources.

pci_claim_bridge_resource() tries to claim a bridge resource, and if
the claiming fails the function tries to clip the resource to make
it fit within the parent resource window.

If the clipping succeeds the bridge apertures are set-up accordingly
and the pci_claim_bridge_resource() tries to claim the resource
again.

Commit c770cb4cb505 ("PCI: Mark invalid BARs as unassigned") added
code that sets the IORESOURCE_UNSET flag on claiming failure.

This means that the second resource claiming after window clipping will
always fail, since the resource flags contain IORESOURCE_UNSET,
previously set on failure by pci_claim_resource(), so the subsequent
pci_claim_resource() call ends up spitting a log message and return
failure with no chance whatsoever to succeed.

This patch removes the second pci_claim_resource() call in
pci_claim_bridge_resource() since it basically has no chance to
succeed, leaving the current behaviour unchanged.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 508cc56..2bf4ac1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -728,14 +728,10 @@ int pci_claim_bridge_resource(struct pci_dev
*bridge, int i)
                break;
        case 2:
                pci_setup_bridge_mmio_pref(bridge);
-               break;
        default:
-               return -EINVAL;
+               break;
        }

-       if (pci_claim_resource(bridge, i) == 0)
-               return 0;       /* claimed a smaller window */
-
        return -EINVAL;
 }

And I suggested to clear UNSET instead, and posted the patch
but I had the From : Lorenzo to keep him have to authorship
as he noticed the problem.

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] PCI: Fix clipped bridge resource reserve

Commit 8505e729a2f6eb ("PCI: Add pci_claim_bridge_resource() to clip
window if necessary") introduced a new API to claim bridge resources.
pci_claim_bridge_resource() tries to claim a bridge resource, and if
the claiming fails the function tries to clip the resource to make
it fit within the parent resource window.
If the clipping succeeds the bridge apertures are set-up accordingly
and the pci_claim_bridge_resource() tries to claim the resource
again.

Commit c770cb4cb505 ("PCI: Mark invalid BARs as unassigned") added
code that sets the IORESOURCE_UNSET flag on claiming failure.

This means that the second resource claiming after window clipping will
always fail, since the resource flags contain IORESOURCE_UNSET,
previously set on failure by pci_claim_resource(), so the subsequent
pci_claim_resource() call ends up spitting a log message and return
failure with no chance whatsoever to succeed.

This patch clear the UNSET in resource flags, and it makes second
pci_claim_resource() work again.

Fixes: c770cb4cb505 ("PCI: Mark invalid BARs as unassigned")
Cc: stable@vger.kernel.org [v4.1+]
[change to clear UNSET instead, Yinghai]
Signed-off-by: Yinghai Lu <yinghai@kernel.org>

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 508cc56..76b3349 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -733,6 +733,7 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
         return -EINVAL;
     }

+    bridge->resource[i].flags &= ~IORESOURCE_UNSET;
     if (pci_claim_resource(bridge, i) == 0)
         return 0;    /* claimed a smaller window */




>
> commit a4ad03352739c96842af5d06387595665cdd875e
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Sep 18 17:15:01 2015 -0500
>
>     PCI: Clear IORESOURCE_UNSET when clipping a bridge window
>
>     c770cb4cb505 ("PCI: Mark invalid BARs as unassigned") sets IORESOURCE_UNSET
>     if we fail to claim a resource.  If we tried to claim a bridge window,
>     failed, clipped the window, and tried to claim the clipped window, we
>     failed again because of IORESOURCE_UNSET.
>
>     When pci_bus_clip_resource() clips a bridge window to fit inside an
>     upstream window, we're reassigning the window, so clear the
>     IORESOURCE_UNSET flag.  Also clear IORESOURCE_UNSET in our copy of the
>     unclipped window so we can see exactly what the original window was and how
>     it now fits inside the upstream window.
>
>     Fixes: c770cb4cb505 ("PCI: Mark invalid BARs as unassigned")
>     Based-on-patch-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     CC: stable@vger.kernel.org  # 4.1+
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 6fbd3f2..d3346d2 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -256,6 +256,8 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
>
>                 res->start = start;
>                 res->end = end;
> +               res->flags &= ~IORESOURCE_UNSET;
> +               orig_res.flags &= ~IORESOURCE_UNSET;
>                 dev_printk(KERN_DEBUG, &dev->dev, "%pR clipped to %pR\n",
>                                  &orig_res, res);
>

Yes that should be ok too.

Acked-by: Yinghai Lu <yinghai@kernel.org>
