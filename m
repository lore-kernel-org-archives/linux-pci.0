Return-Path: <SRS0=wOng=5U=bombadil.srs.infradead.org=BATV+bef0da5e94eb3b03931e+5044+infradead.org+hch@kernel.org>
Return-Path: <SRS0=wOng=5U=bombadil.srs.infradead.org=BATV+bef0da5e94eb3b03931e+5044+infradead.org+hch@kernel.org>
Date: Thu, 15 Jun 2017 01:30:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	oss-drivers@netronome.com
Subject: Re: [PATCH] pci: iov: use device lock to protect IOV sysfs accesses
Message-ID: <20170615083019.GA2332@infradead.org>
References: <20170522225023.14010-1-jakub.kicinski@netronome.com>
 <20170615024726.GH20778@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170615024726.GH20778@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 14, 2017 at 09:47:26PM -0500, Bjorn Helgaas wrote:
> > Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> 
> Applied with Christoph's reviewed-by to pci/virtualization for v4.13,
> thanks!

Btw, given how you wanted the comments on locking for the reset
methods it might be worth to comment the locking here as well.
