Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20171004063027.GA20459@lst.de>
References: <1506763722-10687-1-git-send-email-abhishek.shah@broadcom.com>
 <20171001074203.GA11115@lst.de> <20171002172128.GV8463@localhost.localdomain>
 <20171004063027.GA20459@lst.de>
From: Abhishek Shah <abhishek.shah@broadcom.com>
Date: Wed, 4 Oct 2017 15:07:17 +0530
Message-ID: <CAKUFe6aqX5V10eszHMaD906+zhvk9iavOKSn0t0=XYM1rA9_3w@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-pci: Use PCI bus address for data/queues in CMB
To: Christoph Hellwig <hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 stable@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

yes, this patch works for our platform.

On Wed, Oct 4, 2017 at 12:00 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Oct 02, 2017 at 11:21:29AM -0600, Keith Busch wrote:
>> Yah, calling this a DMA address was a misnomer and confusing.
>
> Abhishek, can you test if this works for you?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
