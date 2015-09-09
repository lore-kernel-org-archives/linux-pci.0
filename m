Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59107 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753476AbbIIRiS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 Sep 2015 13:38:18 -0400
Date: Wed, 9 Sep 2015 18:38:28 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Yinghai Lu <yinghai@kernel.org>
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
Subject: Re: trouble with PCI: Call pci_read_bridge_bases() from core instead
 of arch code
Message-ID: <20150909173828.GB12341@red-moon>
References: <20150902203250.GB829@google.com>
 <20150903100115.GA15308@red-moon>
 <20150903162140.GG829@google.com>
 <20150904141903.GA22997@red-moon>
 <CAE9FiQXeByB6zakDKKC=P68fWD-sKiP1tzn-DWZ+kBsVnXZLxg@mail.gmail.com>
 <20150904164412.GD22997@red-moon>
 <CAE9FiQVB0swnTao3eS1kOLvwU-hm0aEpOTXP7wDKFGqtLQta5g@mail.gmail.com>
 <20150909113235.GA10991@red-moon>
 <CAE9FiQUsRHgqQ6F58yx5pyWeLJc1U72dWOf2p6OUO2PAbFwF=A@mail.gmail.com>
 <CAE9FiQWUr6f_KsTyJrntRg-uuF1OL9VCqfUXB6eJ3Kpj+bf9=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQWUr6f_KsTyJrntRg-uuF1OL9VCqfUXB6eJ3Kpj+bf9=A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 09, 2015 at 06:22:34PM +0100, Yinghai Lu wrote:
> On Wed, Sep 9, 2015 at 9:59 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> > On Wed, Sep 9, 2015 at 4:32 AM, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> >> Subject: [PATCH] PCI: remove dead code in pci_claim_bridge_resource()
> >>
> > That should be regression from c770cb4cb505 ("PCI: Mark invalid BARs
> > as unassigned")
> > so right fix should be:
> 
> completed format as attached:

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Subject: [PATCH] PCI: Fix clipped bridge resource reserve
> 
> Commit 8505e729a2f6eb ("PCI: Add pci_claim_bridge_resource() to clip
> window if necessary") introduced a new API to claim bridge resources.
> pci_claim_bridge_resource() tries to claim a bridge resource, and if
> the claiming fails the function tries to clip the resource to make
> it fit within the parent resource window.
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
> This patch clear the UNSET in resource flags, and it makes second
> pci_claim_resource() work again.
> 
> Fixes: c770cb4cb505 ("PCI: Mark invalid BARs as unassigned")
> Cc: stable@vger.kernel.org [v4.1+]
> [change to clear UNSET instead, Yinghai]
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

My Signed-off-by is missing, if you do not mind given that I reported
it and I obviously knew this was the real fix (I said that) I will
send the updated patch to the list accordingly or Bjorn can fix it up,
as you both prefer.

Thanks,
Lorenzo

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 508cc56..76b3349 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -733,6 +733,7 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
>  		return -EINVAL;
>  	}
>  
> +	bridge->resource[i].flags &= ~IORESOURCE_UNSET;
>  	if (pci_claim_resource(bridge, i) == 0)
>  		return 0;	/* claimed a smaller window */
>  

