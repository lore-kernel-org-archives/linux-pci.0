Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38854 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbbIIQ72 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2015 12:59:28 -0400
Received: by igxx6 with SMTP id x6so19101794igx.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2015 09:59:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150909113235.GA10991@red-moon>
References: <CAAa04yFQEUJm7Jj1qMT57-LG7ZGtnhNDBe=PpSRa70Mj+XhW-A@mail.gmail.com>
	<20150902174716.GA6305@red-moon>
	<20150902203250.GB829@google.com>
	<20150903100115.GA15308@red-moon>
	<20150903162140.GG829@google.com>
	<20150904141903.GA22997@red-moon>
	<CAE9FiQXeByB6zakDKKC=P68fWD-sKiP1tzn-DWZ+kBsVnXZLxg@mail.gmail.com>
	<20150904164412.GD22997@red-moon>
	<CAE9FiQVB0swnTao3eS1kOLvwU-hm0aEpOTXP7wDKFGqtLQta5g@mail.gmail.com>
	<20150909113235.GA10991@red-moon>
Date: Wed, 9 Sep 2015 09:59:27 -0700
Message-ID: <CAE9FiQUsRHgqQ6F58yx5pyWeLJc1U72dWOf2p6OUO2PAbFwF=A@mail.gmail.com>
Subject: Re: trouble with PCI: Call pci_read_bridge_bases() from core instead
 of arch code
From: Yinghai Lu <yinghai@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"oe5hpm@gmail.com" <oe5hpm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Richard Henderson <rth@twiddle.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Howells <dhowells@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Michal Simek <monstr@monstr.eu>,
	Chris Zankel <chris@zankel.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 9, 2015 at 4:32 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Subject: [PATCH] PCI: remove dead code in pci_claim_bridge_resource()
>
> Commit 8505e729a2f6eb ("PCI: Add pci_claim_bridge_resource() to clip
> window if necessary") introduced a new API to claim bridge resources.
>
> pci_claim_bridge_resource() tries to claim a bridge resource, and if
> the claiming fails the function tries to clip the resource to make
> it fit within the parent resource window.
>
> If the clipping succeeds the bridge apertures are set-up accordingly
> and the pci_claim_bridge_resource() tries to claim the resource
> again.
>
> Commit c770cb4cb505 ("PCI: Mark invalid BARs as unassigned") added
> code that sets the IORESOURCE_UNSET flag on claiming failure.
>
> This means that the second resource claiming after window clipping will
> always fail, since the resource flags contain IORESOURCE_UNSET,
> previously set on failure by pci_claim_resource(), so the subsequent
> pci_claim_resource() call ends up spitting a log message and return
> failure with no chance whatsoever to succeed.
>
> This patch removes the second pci_claim_resource() call in
> pci_claim_bridge_resource() since it basically has no chance to
> succeed, leaving the current behaviour unchanged.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/setup-bus.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 508cc56..2bf4ac1 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -728,14 +728,10 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
>                 break;
>         case 2:
>                 pci_setup_bridge_mmio_pref(bridge);
> -               break;
>         default:
> -               return -EINVAL;
> +               break;
>         }
>
> -       if (pci_claim_resource(bridge, i) == 0)
> -               return 0;       /* claimed a smaller window */
> -
>         return -EINVAL;
>  }

That should be regression from c770cb4cb505 ("PCI: Mark invalid BARs
as unassigned")
so right fix should be:

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 508cc56..76b3349 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -733,6 +733,7 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
                return -EINVAL;
        }

+       bridge->resource[i].flags &= ~IORESOURCE_UNSET;
        if (pci_claim_resource(bridge, i) == 0)
                return 0;       /* claimed a smaller window */
