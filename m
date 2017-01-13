Return-Path: <SRS0=l9j+=Y3=lst.de=hch@kernel.org>
Return-Path: <SRS0=l9j+=Y3=lst.de=hch@kernel.org>
Date: Fri, 13 Jan 2017 18:15:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	netdev@vger.kernel.org, linux-media@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: kill off pci_enable_msi_{exact,range}
Message-ID: <20170113171519.GA5857@lst.de>
References: <1483994260-19797-1-git-send-email-hch@lst.de> <20170112212900.GE8312@bhelgaas-glaptop.roam.corp.google.com> <20170113075503.GA26014@lst.de> <20170113080553.GA26280@lst.de> <20170113171321.GA22776@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170113171321.GA22776@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 13, 2017 at 11:13:21AM -0600, Bjorn Helgaas wrote:
> I dropped the empty commit and replaced the xgbe patch with the one below.
> Can you take a look at [1] and make sure it's what you expected?

This looks great, thanks!
