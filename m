Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 9 Jul 2015 15:07:33 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org
Subject: Re: [RFC Patch V1 05/12] x86, PCI: Use for_pci_msi_entry() to access
 MSI device list
Message-ID: <20150709190733.GE21016@l.oracle.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
 <1436428847-8886-6-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436428847-8886-6-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 09, 2015 at 04:00:40PM +0800, Jiang Liu wrote:
> Use accessor for_pci_msi_entry() to access MSI device list, so we could
> easily move msi_list from struct pci_dev into struct device later.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Looks pretty simple. Acked- by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/x86/pci/xen.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index d22f4b5bbc04..ff31ab464213 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -179,7 +179,7 @@ static int xen_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  	if (ret)
>  		goto error;
>  	i = 0;
> -	list_for_each_entry(msidesc, &dev->msi_list, list) {
> +	for_each_pci_msi_entry(msidesc, dev) {
>  		irq = xen_bind_pirq_msi_to_irq(dev, msidesc, v[i],
>  					       (type == PCI_CAP_ID_MSI) ? nvec : 1,
>  					       (type == PCI_CAP_ID_MSIX) ?
> @@ -230,7 +230,7 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  	if (type == PCI_CAP_ID_MSI && nvec > 1)
>  		return 1;
>  
> -	list_for_each_entry(msidesc, &dev->msi_list, list) {
> +	for_each_pci_msi_entry(msidesc, dev) {
>  		__pci_read_msi_msg(msidesc, &msg);
>  		pirq = MSI_ADDR_EXT_DEST_ID(msg.address_hi) |
>  			((msg.address_lo >> MSI_ADDR_DEST_ID_SHIFT) & 0xff);
> @@ -274,7 +274,7 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  	int ret = 0;
>  	struct msi_desc *msidesc;
>  
> -	list_for_each_entry(msidesc, &dev->msi_list, list) {
> +	for_each_pci_msi_entry(msidesc, dev) {
>  		struct physdev_map_pirq map_irq;
>  		domid_t domid;
>  
> @@ -386,7 +386,7 @@ static void xen_teardown_msi_irqs(struct pci_dev *dev)
>  {
>  	struct msi_desc *msidesc;
>  
> -	msidesc = list_entry(dev->msi_list.next, struct msi_desc, list);
> +	msidesc = first_pci_msi_entry(dev);
>  	if (msidesc->msi_attrib.is_msix)
>  		xen_pci_frontend_disable_msix(dev);
>  	else
> -- 
> 1.7.10.4
> 
