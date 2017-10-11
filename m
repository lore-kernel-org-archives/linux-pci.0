Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2] nvme-pci: Use PCI bus address for data/queues in CMB
To: Christoph Hellwig <hch@lst.de>, Abhishek Shah <abhishek.shah@broadcom.com>
References: <1506763722-10687-1-git-send-email-abhishek.shah@broadcom.com>
 <20171001074203.GA11115@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d2d574a7-3639-0917-3051-3ea4669de892@grimberg.me>
Date: Wed, 11 Oct 2017 13:00:18 +0300
MIME-Version: 1.0
In-Reply-To: <20171001074203.GA11115@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>, bcm-kernel-feedback-list@broadcom.com,
 stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

> ---
>  From b78f4164881125c4fecfdb87878d0120b2177c53 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Sun, 1 Oct 2017 09:37:35 +0200
> Subject: nvme-pci: Use PCI bus address for data/queues in CMB
> 
> Currently, NVMe PCI host driver is programming CMB dma address as
> I/O SQs addresses. This results in failures on systems where 1:1
> outbound mapping is not used (example Broadcom iProc SOCs) because
> CMB BAR will be progammed with PCI bus address but NVMe PCI EP will
> try to access CMB using dma address.
> 
> To have CMB working on systems without 1:1 outbound mapping, we
> program PCI bus address for I/O SQs instead of dma address. This
> approach will work on systems with/without 1:1 outbound mapping.
> 
> Based on a report and previous patch from Abhishek Shah.
> 
> Fixes: 8ffaadf7 ("NVMe: Use CMB for the IO SQes if available")
> Cc: stable@vger.kernel.org
> Reported-by: Abhishek Shah <abhishek.shah@broadcom.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
