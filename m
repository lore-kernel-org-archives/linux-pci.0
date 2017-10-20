Return-Path: <SRS0=Rdd+=BT=lst.de=hch@kernel.org>
Return-Path: <SRS0=Rdd+=BT=lst.de=hch@kernel.org>
Date: Fri, 20 Oct 2017 09:07:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dongdong Liu <liudongdong3@huawei.com>,
	Charles Chenxin <charles.chenxin@huawei.com>, linuxarm@huawei.com,
	Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 2/3] PCI/portdrv: Remove excessive comments
Message-ID: <20171020070731.GD11101@lst.de>
References: <20171019225726.17806.62380.stgit@bhelgaas-glaptop.roam.corp.google.com> <20171019230115.17806.52138.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171019230115.17806.52138.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 19, 2017 at 06:01:15PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Remove some wordy and repetitive comments so we can see the code better.
> The register field #defines should be enough of a hook to find relevant
> descriptions in the spec.  No functional change.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Of course my comments were actually useful ;-)

Looks fine, and fit the style in the rest of the kernel:

Reviewed-by: Christoph Hellwig <hch@lst.de>
