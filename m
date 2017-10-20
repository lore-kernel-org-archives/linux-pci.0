Return-Path: <SRS0=Rdd+=BT=lst.de=hch@kernel.org>
Return-Path: <SRS0=Rdd+=BT=lst.de=hch@kernel.org>
Date: Fri, 20 Oct 2017 15:37:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Dongdong Liu <liudongdong3@huawei.com>,
	Charles Chenxin <charles.chenxin@huawei.com>, linuxarm@huawei.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 2/3] PCI/portdrv: Remove excessive comments
Message-ID: <20171020133736.GA29368@lst.de>
References: <20171019225726.17806.62380.stgit@bhelgaas-glaptop.roam.corp.google.com> <20171019230115.17806.52138.stgit@bhelgaas-glaptop.roam.corp.google.com> <20171020070731.GD11101@lst.de> <20171020133143.GG6332@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171020133143.GG6332@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 20, 2017 at 08:31:43AM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 20, 2017 at 09:07:31AM +0200, Christoph Hellwig wrote:
> > On Thu, Oct 19, 2017 at 06:01:15PM -0500, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > Remove some wordy and repetitive comments so we can see the code better.
> > > The register field #defines should be enough of a hook to find relevant
> > > descriptions in the spec.  No functional change.
> > > 
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Of course my comments were actually useful ;-)
> 
> Oops, I thought I was mainly removing stuff I had added myself :)
> I added back this single comment in place of the three essentially
> similar ones:

I don't think we need these - it's pretty clear that you need to
spec for those.

It was just intended as a snarky comment that you basically kept mine,
just rewritten to be a little more clear.  Sorry for the confusion.
