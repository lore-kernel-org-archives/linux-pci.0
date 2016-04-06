Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 6 Apr 2016 10:48:40 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
	aik@ozlabs.ru, alex.williamson@redhat.com,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
	nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com
Subject: Re: [RFC v5 1/7] PCI: Ignore resource_alignment if PCI_PROBE_ONLY
 was set
Message-ID: <20160406004840.GA6187@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1459863813-2830-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1459863813-2830-2-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459863813-2830-2-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 05, 2016 at 09:43:29PM +0800, Yongji Xie wrote:
>The resource_alignment will releases memory
>resources allocated by firmware so that kernel
>can reassign new resources later on. But this
>will cause the problem that no resources can be
>allocated by kernel if PCI_PROBE_ONLY was set,
>e.g. on pSeries platform because PCI_PROBE_ONLY
>force kernel to use firmware setup and not to
>reassign any resources.
>
>To solve this problem, this patch ignores
>resource_alignment if PCI_PROBE_ONLY was set.
>
>Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>---
> drivers/pci/pci.c |    6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>index 602eb42..1db9267 100644
>--- a/drivers/pci/pci.c
>+++ b/drivers/pci/pci.c
>@@ -4607,6 +4607,12 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
> 	spin_lock(&resource_alignment_lock);
> 	p = resource_alignment_param;
> 	while (*p) {
>+		if (pci_has_flag(PCI_PROBE_ONLY)) {
>+			printk(KERN_ERR "PCI: Ignore resource_alignment parameter: %s with"
>+					" PCI_PROBE_ONLY set\n", p);
>+			*p = 0;
>+			break;

It seems no "*p = 0" isn't required if I don't miss anything. If the check
on flag PCI_PROBE_ONLY is moved before the spin_lock(), it would save a bit
CPU cycles at least. Also, the logic looks more clear.

>+		}
> 		count = 0;
> 		if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
> 							p[count] == '@') {

Thanks,
Gavin

>-- 
>1.7.9.5
>
