Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbeBWJgS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Feb 2018 04:36:18 -0500
Date: Fri, 23 Feb 2018 09:36:11 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rolf Evers-Fischer <embedded24@evers-fischer.de>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: Re: [PATCH 1/2] pci: endpoint: Free func_name after last usage
Message-ID: <20180223093611.GA25086@e107981-ln.cambridge.arm.com>
References: <20180221124707.26308-1-embedded24@evers-fischer.de>
 <20180221124707.26308-2-embedded24@evers-fischer.de>
 <20180222181901.GA13694@e107981-ln.cambridge.arm.com>
 <9cdc8c1c-b448-b00b-d5b8-b664bd96f856@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9cdc8c1c-b448-b00b-d5b8-b664bd96f856@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 23, 2018 at 11:40:49AM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On Thursday 22 February 2018 11:49 PM, Lorenzo Pieralisi wrote:
> > On Wed, Feb 21, 2018 at 01:47:06PM +0100, Rolf Evers-Fischer wrote:
> >> From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> >>
> >> This commit decreases the number of jump labels and ensures
> >> that the next commit doesn't increase the number of occurrences
> >> of 'kfree(func_name)'.
> >>
> >> Change-Id: I0d1b6fd652395b85f82b11c43bf9b7db512854d1
> >> Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> >> Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>
> >> ---
> >>  drivers/pci/endpoint/pci-epf-core.c | 7 ++-----
> >>  1 file changed, 2 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> >> index 766ce1dca2ec..23d0e128d1a5 100644
> >> --- a/drivers/pci/endpoint/pci-epf-core.c
> >> +++ b/drivers/pci/endpoint/pci-epf-core.c
> >> @@ -220,9 +220,10 @@ struct pci_epf *pci_epf_create(const char *name)
> >>  	*buf = '\0';
> >>  
> >>  	epf->name = kstrdup(func_name, GFP_KERNEL);
> >> +	kfree(func_name);
> > 
> > I am certainly missing something but what if we reworked the code
> > and just:
> > 
> > kstrdup(name, GFP_KERNEL);
> > 
> > once instead of allocating another local copy (that we then have to
> > free) ?
> 
> name will be something like pci_epf_test.0 and in epf->name we want to just
> have pci_epf_test.
> > 
> > Reworded: why
> > 
> > epf->name = func_name;
> 
> memory should be allocated for epf->name before it can be initialized. IMO
> without kstrdup, there will be a null pointer exception.

I understand that but the point is that func_name *was* allocated with
kstrdup() already I would like to understand why we need to do it twice
(and kfree the first allocation).

Lorenzo
