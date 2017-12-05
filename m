Return-Path: <SRS0=olVR=DB=bombadil.srs.infradead.org=BATV+839b15e1e43cccab5553+5217+infradead.org+hch@kernel.org>
Return-Path: <SRS0=olVR=DB=bombadil.srs.infradead.org=BATV+839b15e1e43cccab5553+5217+infradead.org+hch@kernel.org>
Date: Tue, 5 Dec 2017 11:15:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: helgaas@kernel.org, rjw@sisk.pl, linux-pci@vger.kernel.org,
	stable@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH V2 1/2] PCI/portdrv: Fix switch devctrl error report
 enable
Message-ID: <20171205191537.GA21975@infradead.org>
References: <1512467438-42850-1-git-send-email-liudongdong3@huawei.com>
 <1512467438-42850-2-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512467438-42850-2-git-send-email-liudongdong3@huawei.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 05, 2017 at 05:50:37PM +0800, Dongdong Liu wrote:
> +		if ((pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
> +		    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
> +			pci_disable_pcie_error_reporting(dev);

No need for the inner braces here.
