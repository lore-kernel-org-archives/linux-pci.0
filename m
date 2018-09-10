Return-Path: <SRS0=tax9=LY=iki.fi=pasik@kernel.org>
Return-Path: <SRS0=tax9=LY=iki.fi=pasik@kernel.org>
Date: Mon, 10 Sep 2018 12:52:31 +0300
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: Sinan Kaya <okaya@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>, jgross@suse.com,
	Sinan Kaya <okaya@codeaurora.org>,
	Govinda Tatti <Govinda.Tatti@Oracle.COM>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Satanand Burla <satananda.burla@caviumnetworks.com>,
	linux-pci@vger.kernel.org,
	Felix Manlunas <felix.manlunas@caviumnetworks.com>,
	linux-kernel@vger.kernel.org,
	Derek Chickles <derek.chickles@caviumnetworks.com>,
	Srikanth Jampala <Jampala.Srikanth@cavium.com>, JBeulich@suse.com,
	Russell Currey <ruscur@russell.cc>, bhelgaas@google.com,
	xen-devel@lists.xenproject.org, boris.ostrovsky@Oracle.COM,
	Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
	roger.pau@citrix.com
Subject: Re: [Xen-devel] [PATCH V3 1/2] Drivers/PCI: Export pcie_has_flr()
 interface
Message-ID: <20180910095231.GD18222@reaktio.net>
References: <20171208202424.GC12367@bhelgaas-glaptop.roam.corp.google.com>
 <426eeeab-0dcd-8de3-9c5f-a166acf2c130@Oracle.COM>
 <20171212005919.GB30595@bhelgaas-glaptop.roam.corp.google.com>
 <49956aaf-5fd5-939d-5fc7-231ffdb98b70@Oracle.COM>
 <20171213212420.GH30595@bhelgaas-glaptop.roam.corp.google.com>
 <fea075cf-fe6f-0d0b-11e4-4279fbfc280a@Oracle.COM>
 <20171215181801.GU30595@bhelgaas-glaptop.roam.corp.google.com>
 <20171218122629.GA18423@infradead.org>
 <20180909185944.GC18222@reaktio.net>
 <9ffe43d2-a44b-974c-85c9-9923d71c5dba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <9ffe43d2-a44b-974c-85c9-9923d71c5dba@kernel.org>
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Sun, Sep 09, 2018 at 10:33:02PM -0400, Sinan Kaya wrote:
> On 9/9/2018 2:59 PM, Pasi Kärkkäinen wrote:
> >I noticed pcie_has_flr() has been recently exported in upstream Linux:
> >https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d2917f7747805a1f4188672f308d82a8ba01700
> >
> >Are there more changes / cleanups planned to these interfaces, as mentioned last year?
> >
> >(context: xen-pciback reset/do_flr features upstreaming, which kind of stalled last year when pcie_has_flr() wasn't exported at the time)
> 
> Exporting pcie_has_flr() is a very simple change which could have been done
> by the XEN porting effort.
> 
> Maybe, the right question is what is so special about XEN reset?
> 
> What feature PCI core is missing to support XEN FLR reset that caused
> the effort to stall?
>

Well one of the reasons probably was because Christoph was planning to deprecate the pcie_has_flr() functionality..

https://lists.xen.org/archives/html/xen-devel/2017-12/msg01057.html
https://lists.xen.org/archives/html/xen-devel/2017-12/msg01252.html

But now that pcie_has_flr() is exported and available I guess it's fine to continue using it also for xen-pciback :)


Thanks,

-- Pasi
