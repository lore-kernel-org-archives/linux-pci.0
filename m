Return-Path: <SRS0=1wOV=DO=bombadil.srs.infradead.org=BATV+fb56882d68e01a86ab56+5230+infradead.org+hch@kernel.org>
Return-Path: <SRS0=1wOV=DO=bombadil.srs.infradead.org=BATV+fb56882d68e01a86ab56+5230+infradead.org+hch@kernel.org>
Date: Mon, 18 Dec 2017 04:26:30 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Govinda Tatti <Govinda.Tatti@Oracle.COM>,
	Christoph Hellwig <hch@infradead.org>, jgross@suse.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	JBeulich@suse.com, bhelgaas@google.com,
	xen-devel@lists.xenproject.org, boris.ostrovsky@Oracle.COM,
	roger.pau@citrix.com, Russell Currey <ruscur@russell.cc>,
	Sinan Kaya <okaya@codeaurora.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Srikanth Jampala <Jampala.Srikanth@cavium.com>,
	Derek Chickles <derek.chickles@caviumnetworks.com>,
	Satanand Burla <satananda.burla@caviumnetworks.com>,
	Felix Manlunas <felix.manlunas@caviumnetworks.com>,
	Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>
Subject: Re: [Xen-devel] [PATCH V3 1/2] Drivers/PCI: Export pcie_has_flr()
 interface
Message-ID: <20171218122629.GA18423@infradead.org>
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-2-Govinda.Tatti@Oracle.COM>
 <20171208202424.GC12367@bhelgaas-glaptop.roam.corp.google.com>
 <426eeeab-0dcd-8de3-9c5f-a166acf2c130@Oracle.COM>
 <20171212005919.GB30595@bhelgaas-glaptop.roam.corp.google.com>
 <49956aaf-5fd5-939d-5fc7-231ffdb98b70@Oracle.COM>
 <20171213212420.GH30595@bhelgaas-glaptop.roam.corp.google.com>
 <fea075cf-fe6f-0d0b-11e4-4279fbfc280a@Oracle.COM>
 <20171215181801.GU30595@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171215181801.GU30595@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 15, 2017 at 12:18:02PM -0600, Bjorn Helgaas wrote:
> I think Christoph volunteered to do some restructuring, but I don't
> know his timeframe.  If you can, I would probably wait for that
> because there's so much overlap here.

I'll have some time over the holidays.  If you need it more urgent
than that feel free to take over.
