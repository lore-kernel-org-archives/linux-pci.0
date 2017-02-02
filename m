Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 2 Feb 2017 10:46:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lists@ssl-mail.com, "Jayachandran C." <jnair@caviumnetworks.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [GIT PULL] PCI fixes for v4.10
Message-ID: <20170202164617.GC21267@bhelgaas-glaptop.roam.corp.google.com>
References: <20170202161812.GB21267@bhelgaas-glaptop.roam.corp.google.com>
 <20170202163024.GA30074@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170202163024.GA30074@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 02, 2017 at 08:30:24AM -0800, Christoph Hellwig wrote:
> On Thu, Feb 02, 2017 at 10:18:12AM -0600, Bjorn Helgaas wrote:
> > PCI fixes:
> > 
> >   - configure ASPM on the link from a PCI-to-PCIe bridge (avoids a NULL
> >     pointer dereference on topologies including these bridges)
> 
> Any reason you didn't include the affinity use outside the allocate
> range fix sent on Tuesday?

I assume you mean https://patchwork.ozlabs.org/patch/721415/

I just hadn't gotten to that one.  I hadn't read the description carefully
enough to see that it needed to go in v4.10.
