Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58013 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066AbbIILc2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 Sep 2015 07:32:28 -0400
Date: Wed, 9 Sep 2015 12:32:36 +0100
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
Message-ID: <20150909113235.GA10991@red-moon>
References: <CAAa04yFQEUJm7Jj1qMT57-LG7ZGtnhNDBe=PpSRa70Mj+XhW-A@mail.gmail.com>
 <20150902174716.GA6305@red-moon>
 <20150902203250.GB829@google.com>
 <20150903100115.GA15308@red-moon>
 <20150903162140.GG829@google.com>
 <20150904141903.GA22997@red-moon>
 <CAE9FiQXeByB6zakDKKC=P68fWD-sKiP1tzn-DWZ+kBsVnXZLxg@mail.gmail.com>
 <20150904164412.GD22997@red-moon>
 <CAE9FiQVB0swnTao3eS1kOLvwU-hm0aEpOTXP7wDKFGqtLQta5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQVB0swnTao3eS1kOLvwU-hm0aEpOTXP7wDKFGqtLQta5g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 05, 2015 at 12:53:48AM +0100, Yinghai Lu wrote:
> On Fri, Sep 4, 2015 at 9:44 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > On Fri, Sep 04, 2015 at 05:00:35PM +0100, Yinghai Lu wrote:
> >
> > The problem here is not the last retry, it is the first bridge scan.
> >
> > By moving pci_read_bridge_bases() to core PCI code, if we do not
> > vet the bridge apertures (ie claim them and reset them if the claiming
> > fails) we end up calling (on ARM) __pci_bus_size_bridges() with apertures
> > that can have sizes != 0, which does not make any sense since we are calling
> > __pci_bus_size_bridges() to *discover* what the aperture size should
> > be on first bridge scan, correct ?
> 
> for x86, in pcibios_allocate_bridge_resources(), we do validate
> the bridge resources, and reset size to 1 (strange ?!).
> and they are called before pci_asssign_unassigned_resources()
> 
> so arch ARM would support pcibios_allocate_bridge_resources or other
> call to do the same thing?
> 
> wonder some arches even claim fails, they still does not want you to
> reset it.

While finding a fix for this issue, I bumped into another one
with current pci_claim_bridge_resource() behaviour. Described
and "fixed" (I actually did not fix it, patch below is just there to
show what the problem is) in the patch below.

Comments welcome,
Lorenzo

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
@@ -728,14 +728,10 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 		break;
 	case 2:
 		pci_setup_bridge_mmio_pref(bridge);
-		break;
 	default:
-		return -EINVAL;
+		break;
 	}
 
-	if (pci_claim_resource(bridge, i) == 0)
-		return 0;	/* claimed a smaller window */
-
 	return -EINVAL;
 }
 
-- 
2.2.1

