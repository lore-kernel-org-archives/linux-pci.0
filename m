Return-Path: <BATV+ed117a9fd85595ee3ae0+4656+infradead.org+hch@bombadil.srs.infradead.org>
Return-Path: <BATV+ed117a9fd85595ee3ae0+4656+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 23 May 2016 10:09:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] nvme/pci: Enable SR-IOV capabilities
Message-ID: <20160523170932.GA26398@infradead.org>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
 <1463521199-16604-2-git-send-email-keith.busch@intel.com>
 <20160523170652.GA12826@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160523170652.GA12826@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 23, 2016 at 12:06:52PM -0500, Bjorn Helgaas wrote:
> > +static int nvme_sriov_configure(struct pci_dev *pdev, int numvfs)
> > +{
> > +	int ret = 0;
> > +
> > +	if (numvfs == 0)
> > +		pci_disable_sriov(pdev);
> > +	else
> > +		ret = pci_enable_sriov(pdev, numvfs);
> > +
> > +	return ret ? ret : numvfs;
> > +}
> 
> I do not subscribe to the belief that every function should have a
> single exit.  In this case, I think it makes the function much harder
> to understand than this:
> 
>   if (numvfs == 0)
>     pci_disable_sriov(pdev);
>     return 0;
>   }
> 
>   return pci_enable_sriov(pdev, numvfs);

I'd tend to agree.  But then again the real issue here is that we should
have two methods instead, and useful defaults.  I.e. if the SR-IOV API
was properly designed NVMe wouldn't even need this callout at all,
and drivers that need it should have one method each for enable /
disable.
