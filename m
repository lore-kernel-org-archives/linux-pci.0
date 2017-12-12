Return-Path: <SRS0=av5M=DI=bombadil.srs.infradead.org=BATV+096fce5175ea1cd588ed+5224+infradead.org+hch@kernel.org>
Return-Path: <SRS0=av5M=DI=bombadil.srs.infradead.org=BATV+096fce5175ea1cd588ed+5224+infradead.org+hch@kernel.org>
Date: Tue, 12 Dec 2017 07:07:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Govinda Tatti <Govinda.Tatti@Oracle.COM>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	boris.ostrovsky@Oracle.COM, jgross@suse.com, JBeulich@suse.com,
	roger.pau@citrix.com, konrad.wilk@Oracle.COM
Subject: Re: [PATCH V3 1/2] Drivers/PCI: Export pcie_has_flr() interface
Message-ID: <20171212150726.GA20341@infradead.org>
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-2-Govinda.Tatti@Oracle.COM>
 <20171208202424.GC12367@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208202424.GC12367@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 08, 2017 at 02:24:24PM -0600, Bjorn Helgaas wrote:
> I'd rather change pcie_flr() so you could *always* call it, and it
> would return 0, -ENOTTY, or whatever, based on whether FLR is
> supported.  Is that feasible?
> 
> I don't like the "Can I do this? Ok, do this" style of interfaces.
> It's racy (not really applicable in this case) and seems clunky.

I was tempted to change all that for the whole reset sequence but didn't
dare to do that because someone probably put some thought into the
current scheme.

I'd love to get rid of the "can I do this" interfaces entirely, and also
change to EOPNOTSUPP for the not supported case.
