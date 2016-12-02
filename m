Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 2 Dec 2016 14:04:41 +0800
From: Dennis Chen <dennis.chen@arm.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] PCI:MSI Return -ENOSPC when requested vectors is not
 enough
Message-ID: <20161202060440.GA16167@arm.com>
References: <1480558504-18691-1-git-send-email-dennis.chen@arm.com>
 <20161201085243.GA24684@lst.de>
MIME-Version: 1.0
In-Reply-To: <20161201085243.GA24684@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-ide@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Steve Capper <steve.capper@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 linux-pci@vger.kernel.org, Tom
 Long Nguyen <tom.l.nguyen@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
 nd@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 01, 2016 at 09:52:43AM +0100, Christoph Hellwig wrote:
> Hi Dennis,
> 
> I've fixed ahci to treat all errors the same in the meantime, please
> try latest Linux tree.  That being said I don't like the different
> error returns from __pci_enable_msi_range (and __pci_enable_msix_range),
> but they have been there for a while.

Ah, I've noticed that you have the fix recently which is somehow to weaken
the necessary of the change. But, that also being said that I don't like we insist
at least the inconsistent either just because something has been there *for a while*.
Both below comments from cpi_alloc_irq_vectors_affinity() and the logic itself
leads us to think that the correct return value is -NOSPC:
/**
 *...
 *Return the number of vectors allocated,
 * (which might be smaller than @max_vecs) if successful, or a negative
 * error code on error. If less than @min_vecs interrupt vectors are
 * available for @dev the function will fail with -ENOSPC.
 * ...
*/

People maybe argue that almost has no device drivers depending on the different
return value, then why we still need to do that?

Thanks,
Dennis 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
