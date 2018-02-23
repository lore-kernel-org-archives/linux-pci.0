Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 23 Feb 2018 18:30:58 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Rolf Evers-Fischer <embedded24@evers-fischer.de>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: Re: [PATCH 1/2] pci: endpoint: Free func_name after last usage
Message-ID: <20180223183058.GA11698@e107981-ln.cambridge.arm.com>
References: <20180221124707.26308-1-embedded24@evers-fischer.de>
 <20180221124707.26308-2-embedded24@evers-fischer.de>
 <20180222181901.GA13694@e107981-ln.cambridge.arm.com>
 <9cdc8c1c-b448-b00b-d5b8-b664bd96f856@ti.com>
 <20180223093611.GA25086@e107981-ln.cambridge.arm.com>
 <a7070bd0-72b7-4870-419e-7ac15c6825ae@ti.com>
 <alpine.LNX.2.20.1802231828250.16055@5HSWXM1.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.20.1802231828250.16055@5HSWXM1.fritz.box>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 23, 2018 at 06:38:42PM +0100, Rolf Evers-Fischer wrote:
> Hi Kishon,
> 
> On Fri, 23 Feb 2018, Kishon Vijay Abraham I wrote:
> > On Friday 23 February 2018 03:06 PM, Lorenzo Pieralisi wrote:
> > > On Fri, Feb 23, 2018 at 11:40:49AM +0530, Kishon Vijay Abraham I wrote:
> > >> Hi Lorenzo,
> > >>
> > >> On Thursday 22 February 2018 11:49 PM, Lorenzo Pieralisi wrote:
> > >>> On Wed, Feb 21, 2018 at 01:47:06PM +0100, Rolf Evers-Fischer wrote:
> > >>>> From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> > >>>>
> > >>>> This commit decreases the number of jump labels and ensures
> > >>>> that the next commit doesn't increase the number of occurrences
> > >>>> of 'kfree(func_name)'.
> > >>>>
> > >>>> Change-Id: I0d1b6fd652395b85f82b11c43bf9b7db512854d1
> > >>>> Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> > >>>> Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>
> > >>>> ---
> > >>>>  drivers/pci/endpoint/pci-epf-core.c | 7 ++-----
> > >>>>  1 file changed, 2 insertions(+), 5 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > >>>> index 766ce1dca2ec..23d0e128d1a5 100644
> > >>>> --- a/drivers/pci/endpoint/pci-epf-core.c
> > >>>> +++ b/drivers/pci/endpoint/pci-epf-core.c
> > >>>> @@ -220,9 +220,10 @@ struct pci_epf *pci_epf_create(const char *name)
> > >>>>  	*buf = '\0';
> > >>>>  
> > >>>>  	epf->name = kstrdup(func_name, GFP_KERNEL);
> > >>>> +	kfree(func_name);
> > >>>
> > >>> I am certainly missing something but what if we reworked the code
> > >>> and just:
> > >>>
> > >>> kstrdup(name, GFP_KERNEL);
> > >>>
> > >>> once instead of allocating another local copy (that we then have to
> > >>> free) ?
> > >>
> > >> name will be something like pci_epf_test.0 and in epf->name we want to just
> > >> have pci_epf_test.
> > >>>
> > >>> Reworded: why
> > >>>
> > >>> epf->name = func_name;
> > >>
> > >> memory should be allocated for epf->name before it can be initialized. IMO
> > >> without kstrdup, there will be a null pointer exception.
> > > 
> > > I understand that but the point is that func_name *was* allocated with
> > > kstrdup() already I would like to understand why we need to do it twice
> > > (and kfree the first allocation).
> > 
> > func_name would be allocated for a size greater than what will be in epf->name.
> > It won't be significant though.
> > 
> > Thanks
> > Kishon
> > 
> I have just an idea, how to use only one copy, but with the shorter 
> length. What about changing the code like this?
>   int len = strchrnul(name, '.') - name;
>   epf->name = kstrndup(name, len, GFP_KERNEL);
> 
> In this case we are only allocating the smaller amount of memory and we 
> don't need the 'buf' and 'func_name' pointers anymore. They will be 
> replaced with 'len' and some pointer arithmetic.

Yes, something along those lines, I do not see the point of having to
allocate two buffers (and actually this simplifies the error path too).

Thanks,
Lorenzo
