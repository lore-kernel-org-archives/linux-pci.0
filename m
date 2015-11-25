Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 25 Nov 2015 10:46:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Carlos Palminha <CARLOS.PALMINHA@synopsys.com>,
	Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
	arcml <linux-snps-arc@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] PCI support added to ARC
Message-ID: <20151125164636.GB1380@localhost>
References: <cover.1448375184.git.jpinto@synopsys.com>
 <9b80d6c1db4d7e2b5ee5dc0056a3d8284e7c2b9b.1448375184.git.jpinto@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F44D3B42@IN01WEMBXA.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F44D3B42@IN01WEMBXA.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 25, 2015 at 05:25:37AM +0000, Vineet Gupta wrote:
> On Tuesday 24 November 2015 08:02 PM, Joao Pinto wrote:

> > +			pr_err("PCI: Device %s not available because"/
> > +			       " of resource collisions\n", pci_name(dev));
> 
> Better not to break strings - even if they sometime exceed line sz limit of 80.
> You could anyways reduce the string content herer.

Also use dev_err() instead of pr_err().
