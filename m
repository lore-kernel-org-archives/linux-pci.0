Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
Date: Wed, 14 Sep 2016 08:44:22 -0600
From: Jon Derrick <jonathan.derrick@intel.com>
To: "Busch, Keith" <keith.busch@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [RFCv2 0/3] vmd irq list shortening, map allocation
Message-ID: <20160914144422.GA8315@localhost.localdomain>
References: <1472838786-3441-1-git-send-email-jonathan.derrick@intel.com>
 <20160913205745.GF4138@localhost>
 <B58D82457FDA0744A320A2FC5AC253B93D722BF9@fmsmsx104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B93D722BF9@fmsmsx104.amr.corp.intel.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

Thanks for the review

On Tue, Sep 13, 2016 at 04:16:19PM -0600, Busch, Keith wrote:
> Sorry for the delay. I've been looking into these new PCI IRQ API's and found an unrelated issue that I stuck myself with working through with Christoph and Thomas. :)
> 
> Patches 1/3 and 2/3 look good to me.
> 
> I'm not convinced 3/3 is an improvement. At the very least, we don't want to BUG_ON from a failed kmalloc when we can return an appropriate error instead. I'll take a closer look at 3/3 and get back to Jon with more feedback.
> 
Yes the BUG_ON was a mistake I would have removed for the next rev. But I agree with you where I am not convinced either. I have been trying to put together a test vehicle to prove that this is actually an improvement, but I have not had much luck yet.

Also, from what I can tell as well, nobody is using ida for indexing into a map, so that would be converted to the bitmap api instead.

I'll follow up in a (long) while when I get the test case figured out and some real results.

If it's not clear yet, 3/3 can be killed :)

> 
> 
> -----Original Message-----	
> From: Bjorn Helgaas [mailto:helgaas@kernel.org] 
> Sent: Tuesday, September 13, 2016 2:58 PM
> To: Derrick, Jonathan <jonathan.derrick@intel.com>
> Cc: Busch, Keith <keith.busch@intel.com>; linux-pci@vger.kernel.org
> Subject: Re: [RFCv2 0/3] vmd irq list shortening, map allocation
> 
> On Fri, Sep 02, 2016 at 11:53:03AM -0600, Jon Derrick wrote:
> > V2:
> > Added a map for vmd irqs to attempt to allocate all vmd irqs within an
> > irq list into a single page. Once we start getting many devices
> > sharing the irq in an irq list, this may help the list traversal latency.
> > 
> > V1:
> > Couple of RFC patches here. I don't really notice a positive benefit but
> > it does reduce the struct size of vmd_irq_list and hopefully we gain some
> > cache benefits from that.
> > 
> > Both are based on:
> > https://patchwork.kernel.org/patch/9304179/
> > https://patchwork.kernel.org/patch/9304181/
> > 
> > Jon Derrick (3):
> >   vmd: eliminate vmd_vector member from list type
> >   vmd: eliminate index member from irq list
> >   pci/vmd: Create irq map for irq nodes
> > 
> >  arch/x86/pci/vmd.c | 94 ++++++++++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 73 insertions(+), 21 deletions(-)
> 
> These look OK to me, so if Keith acks them I'll merge them.
