Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy9.bluehost.com ([69.89.24.6]:39664 "HELO
	oproxy9.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756396Ab1LESPZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2011 13:15:25 -0500
Date: Mon, 5 Dec 2011 10:17:56 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>, prarit@redhat.com,
	brking@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 1/1] PCI:delay configuration of SRIOV capability
Message-ID: <20111205101756.7bccfbae@jbarnes-desktop>
In-Reply-To: <20111106023357.GB2383@ram-ThinkPad-T61>
References: <20111006210320.GA14959@us.ibm.com>
	<CAErSpo7b_6_AaZXW9XBx5p3-0PZJk-1jeCork__KePdzCS89OA@mail.gmail.com>
	<1317970100.29415.305.camel@pasglop>
	<CAErSpo58okGsDW4dOK4i0g_RUejkuQa=iw2uQ5HAJJZCwFtsbw@mail.gmail.com>
	<20111007232516.GF2980@ram-ThinkPad-T61>
	<1318057168.29415.333.camel@pasglop>
	<20111008075353.GK2980@ram-ThinkPad-T61>
	<1318060793.29415.347.camel@pasglop>
	<20111102140325.004b9dad@jbarnes-desktop>
	<20111103013014.GB393@ram-ThinkPad-T61>
	<20111106023357.GB2383@ram-ThinkPad-T61>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 6 Nov 2011 10:33:57 +0800
Ram Pai <linuxram@us.ibm.com> wrote:

>       The SRIOV capability, namely page size and total_vfs of a device are
>       configured during enumeration phase of the device.
>       This can potentially interfere with the PCI operations of the platform,
>       if the IOV capability of the device is not enabled.
> 
>       The following patch postpones the configuration of the IOV capability of the
>       device to a later point, when the IOV capability is explicitly enabled
>       by the device driver.
> 
>       The patch is tested on x86 and power platform.
> 
>       Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  drivers/pci/iov.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index b0446dd..c1a6f5c 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -346,6 +346,8 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  			return rc;
>  	}
>  
> +	pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgsz);
> +
>  	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
>  	pci_block_user_cfg_access(dev);
>  	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
> @@ -451,7 +453,6 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  
>  found:
>  	pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, ctrl);
> -	pci_write_config_word(dev, pos + PCI_SRIOV_NUM_VF, total);
>  	pci_read_config_word(dev, pos + PCI_SRIOV_VF_OFFSET, &offset);
>  	pci_read_config_word(dev, pos + PCI_SRIOV_VF_STRIDE, &stride);
>  	if (!offset || (total > 1 && !stride))
> @@ -464,7 +465,6 @@ found:
>  		return -EIO;
>  
>  	pgsz &= ~(pgsz - 1);
> -	pci_write_config_dword(dev, pos + PCI_SRIOV_SYS_PGSIZE, pgsz);
>  
>  	nres = 0;
>  	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {

Anyone want to volunteer a tested-by for this one?

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
