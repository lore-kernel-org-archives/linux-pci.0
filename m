Return-Path: <SRS0=3xk2=44=bombadil.srs.infradead.org=BATV+9d60cda5512020ade5e3+5020+infradead.org+hch@kernel.org>
Return-Path: <SRS0=3xk2=44=bombadil.srs.infradead.org=BATV+9d60cda5512020ade5e3+5020+infradead.org+hch@kernel.org>
Date: Mon, 22 May 2017 10:44:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>,
	Linuxarm <linuxarm@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"lukas@wunner.de" <lukas@wunner.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>
Subject: Re: [PATCH v3 1/2] PCI/portdrv: add support for different MSI
 interrupts for PCIe port services
Message-ID: <20170522174411.GA29861@infradead.org>
References: <1495103748-7876-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495103748-7876-2-git-send-email-gabriele.paoloni@huawei.com>
 <20170521083234.GA20658@infradead.org>
 <EE11001F9E5DDD47B7634E2F8A612F2E40A45545@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40A45545@FRAEML521-MBX.china.huawei.com>
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 21, 2017 at 03:00:46PM +0000, Gabriele Paoloni wrote:
> 
> I thought that in your previous review you meant to say that we should
> avoid 2 instances of the same comment (in this patchset I only have this 
> instance as I have removed the same comment from patch 2/2...)

No, there is no pointin the comment.  The whole point of pci_irq_vector
is to abstract away from how to get at the interrupt in detail.  There
is no need to comment on this at the callsite.  If you think the
existing documentation for the function is not good enough send a patch
to improve it there instead of commenting the callsites.
