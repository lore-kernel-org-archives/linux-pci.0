Return-Path: <linux-kernel-owner@vger.kernel.org>
From: James Bottomley <jbottomley@parallels.com>
To: "arnd@arndb.de" <arnd@arndb.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] DMA-API: Clarify physical/bus address distinction
Date: Fri, 9 May 2014 14:09:31 +0000
Message-ID: <1399644571.2166.1.camel@dabdike.int.hansenpartnership.com>
References: <20140508204257.17877.4639.stgit@bhelgaas-glaptop.roam.corp.google.com>
	 <20140508204854.17877.59304.stgit@bhelgaas-glaptop.roam.corp.google.com>
	 <119388463.n2RtThRsle@wuerfel>
In-Reply-To: <119388463.n2RtThRsle@wuerfel>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2014-05-09 at 08:12 +0200, Arnd Bergmann wrote:
> On Thursday 08 May 2014 14:48:54 Bjorn Helgaas wrote:
> > The DMA-API documentation sometimes refers to "physical addresses" when it
> > really means "bus addresses."  Sometimes these are identical, but they may
> > be different if the bridge leading to the bus performs address translation.
> > Update the documentation to use "bus address" when appropriate.
> > 
> > Also, consistently capitalize "DMA", use parens with function names, use
> > dev_printk() in examples, and reword a few sections for clarity.
> > 
> > No functional change; documentation changes only.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Looks great!
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Yes, from me too (probably only patches 1-2, since that's only what I
directly wrote originally); thanks for listening to the arguments and
persevering.

Acked-by: James Bottomley <jbottomley@Parallels.com>

James

