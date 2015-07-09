Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33213 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbbGILDP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2015 07:03:15 -0400
Received: by lbzd8 with SMTP id d8so27508492lbz.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2015 04:03:14 -0700 (PDT)
Subject: Re: [RFC Patch V1 02/12] MIPS, PCI: Use for_pci_msi_entry() to access
 MSI device list
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Borislav Petkov <bp@alien8.de>,
	Ralf Baechle <ralf@linux-mips.org>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
 <1436428847-8886-3-git-send-email-jiang.liu@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@linux-mips.org
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <559E54EE.7090504@cogentembedded.com>
Date: Thu, 9 Jul 2015 14:03:10 +0300
MIME-Version: 1.0
In-Reply-To: <1436428847-8886-3-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 7/9/2015 11:00 AM, Jiang Liu wrote:

> Use accessor for_pci_msi_entry() to access MSI device list, so we could

     Maybe for_each_pci_msi_entry()?

> easily move msi_list from struct pci_dev into struct device later.

> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>   arch/mips/pci/msi-octeon.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
> index cffaaf4aae3c..2a5bb849b10e 100644
> --- a/arch/mips/pci/msi-octeon.c
> +++ b/arch/mips/pci/msi-octeon.c
> @@ -200,7 +200,7 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>   	if (type == PCI_CAP_ID_MSI && nvec > 1)
>   		return 1;
>
> -	list_for_each_entry(entry, &dev->msi_list, list) {
> +	for_each_pci_msi_entry(entry, dev) {
>   		ret = arch_setup_msi_irq(dev, entry);
>   		if (ret < 0)
>   			return ret;

WBR, Sergei

