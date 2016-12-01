Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 1 Dec 2016 09:52:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dennis Chen <dennis.chen@arm.com>
Subject: Re: [PATCH] PCI:MSI Return -ENOSPC when requested vectors is not
 enough
Message-ID: <20161201085243.GA24684@lst.de>
References: <1480558504-18691-1-git-send-email-dennis.chen@arm.com>
MIME-Version: 1.0
In-Reply-To: <1480558504-18691-1-git-send-email-dennis.chen@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-ide@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
 Steve Capper <steve.capper@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Tom Long Nguyen <tom.l.nguyen@intel.com>, Tejun Heo <tj@kernel.org>,
 nd@arm.com, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Dennis,

I've fixed ahci to treat all errors the same in the meantime, please
try latest Linux tree.  That being said I don't like the different
error returns from __pci_enable_msi_range (and __pci_enable_msix_range),
but they have been there for a while.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
