Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F6636923F;
	Wed, 28 Jan 2026 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612581; cv=none; b=HpjBqXMRFDndCpO02U5PkuzfESXM/bUPvSVMGjdu7JJXL8bqmzA3kBZy/JBx40E79TA4oafYiI2gZh4wl6KM7QkqpTOU+8H5gsc1w1IxbZf5OMpoLdBcrFiQiSkrUNKjm4OxVwJvXyWQ4EJpmNMf5ZQXV2oBNnG8JqYiAuqxtxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612581; c=relaxed/simple;
	bh=zK4ksqvXfIzgsun1URhInQhZ3aAJvpgb5DYSRjkjI4Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUvcsp7TtmNiNEvzndjvXryGG/eeAtEvkJ6SnnDpCuXiDm6QP9MEzJy1ROodzivUDWLOAoBS8qVxHdgKiQIBhfkaZB0LeLZZ9Agka8nRaTJTeCs4jDbmAmOky5COUPSTEhoSZ6Bvq7TJpOOTPt8Lnk/GPbTkzyDVAH2oFWL6Wp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f1QTx62TpzHnH5w;
	Wed, 28 Jan 2026 23:01:57 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A4DF40574;
	Wed, 28 Jan 2026 23:02:45 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Jan
 2026 15:02:44 +0000
Date: Wed, 28 Jan 2026 15:02:43 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <bhelgaas@google.com>, <kbusch@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <terry.bowman@amd.com>, <tianruidong@linux.alibaba.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v7 2/5] PCI/DPC: Run recovery on device that detected
 the error
Message-ID: <20260128150243.000012d8@huawei.com>
In-Reply-To: <09cf1319-619d-4a6b-97f7-188c1a73aea0@linux.alibaba.com>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
	<20260124074557.73961-3-xueshuai@linux.alibaba.com>
	<20260127102402.00004da2@huawei.com>
	<09cf1319-619d-4a6b-97f7-188c1a73aea0@linux.alibaba.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 28 Jan 2026 20:27:31 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> On 1/27/26 6:24 PM, Jonathan Cameron wrote:
> > On Sat, 24 Jan 2026 15:45:54 +0800
> > Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> >   
> >> The current implementation of pcie_do_recovery() assumes that the
> >> recovery process is executed for the device that detected the error.
> >> However, the DPC driver currently passes the error port that experienced
> >> the DPC event to pcie_do_recovery().
> >>
> >> Use the SOURCE ID register to correctly identify the device that
> >> detected the error. When passing the error device, the
> >> pcie_do_recovery() will find the upstream bridge and walk bridges
> >> potentially AER affected. And subsequent commits will be able to
> >> accurately access AER status of the error device.
> >>
> >> Should not observe any functional changes.
> >>
> >> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Hi Shuai,

> >> ---
> >>   drivers/pci/pci.h      |  2 +-
> >>   drivers/pci/pcie/dpc.c | 25 +++++++++++++++++++++----
> >>   drivers/pci/pcie/edr.c |  7 ++++---
> >>   3 files changed, 26 insertions(+), 8 deletions(-)
> >>
...

> >> -void dpc_process_error(struct pci_dev *pdev)
> >> +/**
> >> + * dpc_process_error - handle the DPC error status
> >> + * @pdev: the port that experienced the containment event
> >> + *
> >> + * Return: the device that detected the error.
> >> + *
> >> + * NOTE: The device reference count is increased, the caller must decrement
> >> + * the reference count by calling pci_dev_put().
> >> + */
> >> +struct pci_dev *dpc_process_error(struct pci_dev *pdev)  
> > 
> > Maybe it makes sense to carry the err_port naming for the pci_dev
> > in here as well?  Seems stronger than just relying on people
> > reading the documentation you've added.  
> 
> Good point. I think renaming the parameter would improve clarity. However,
> I'd prefer to handle it in a separate patch to keep this change focused on
> the functional modification. Would that work for you?
> 
Sure. Ideal would be a precursor patch, but if it's much easier to
do on top of this I'm fine with that.

You are absolutely correct that it should be a separate patch!

> >     
> >>   {
> >>   	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
> >>   	struct aer_err_info info = {};
> >> +	struct pci_dev *err_dev;
> >>   
> >>   	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> >>   
> >> @@ -279,6 +289,7 @@ void dpc_process_error(struct pci_dev *pdev)
> >>   			pci_aer_clear_nonfatal_status(pdev);
> >>   			pci_aer_clear_fatal_status(pdev);
> >>   		}
> >> +		err_dev = pci_dev_get(pdev);
> >>   		break;
> >>   	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE:
> >>   	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE:
> >> @@ -290,6 +301,8 @@ void dpc_process_error(struct pci_dev *pdev)
> >>   				"ERR_FATAL" : "ERR_NONFATAL",
> >>   			 pci_domain_nr(pdev->bus), PCI_BUS_NUM(source),
> >>   			 PCI_SLOT(source), PCI_FUNC(source));
> >> +		err_dev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> >> +					    PCI_BUS_NUM(source), source & 0xff);  
> > 
> > Bunch of replication in her with the pci_warn(). Maybe some local variables?
> > Maybe even rebuild the final parameter from PCI_DEVFN(slot, func) just to make the
> > association with the print really obvious?  
> 
> Agreed. Here's the improved version:
> 
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -293,17 +293,28 @@ struct pci_dev *dpc_process_error(struct pci_dev *pdev)
>                  break;
>          case PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE:
>          case PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE:
> -               pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID,
> -                                    &source);
> +       {
> +               int domain, bus;
> +               u8 slot, func, devfn;
> +               const char *err_type;
> +
> +               pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
> +
> +               /* Extract source device location */
> +               domain = pci_domain_nr(pdev->bus);
> +               bus = PCI_BUS_NUM(source);
> +               slot = PCI_SLOT(source);
> +               func = PCI_FUNC(source);
> +               devfn = PCI_DEVFN(slot, func);
> +
> +               err_type = (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
> +                          "ERR_FATAL" : "ERR_NONFATAL";
> +
>                  pci_warn(pdev, "containment event, status:%#06x, %s received from %04x:%02x:%02x.%d\n",
> -                        status,
> -                        (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
> -                               "ERR_FATAL" : "ERR_NONFATAL",
> -                        pci_domain_nr(pdev->bus), PCI_BUS_NUM(source),
> -                        PCI_SLOT(source), PCI_FUNC(source));
> -               err_dev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> -                                           PCI_BUS_NUM(source), source & 0xff);
> +                        status, err_type, domain, bus, slot, func);
> +               err_dev = pci_get_domain_bus_and_slot(domain, bus, devfn);
Maybe don't bother with local variables for the things only used once.
e.g.

		err_dev = pci_get_domain_bus_and_slot(domain, bus, PCI_DEVFN(slot, func));

and possibly the same for err_type.

I don't mind though if you prefer to use locals for everything.



>                  break;
> +       }
>          case PCI_EXP_DPC_STATUS_TRIGGER_RSN_IN_EXT:
>                  ext_reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT;
>                  pci_warn(pdev, "containment event, status:%#06x: %s detected\n",
> 
> > 
> > Is there any chance that this might return NULL?   Feels like maybe that's
> > only a possibility on a broken setup, but I'm not sure of all the wonderful
> > races around hotplug and DPC occurring before the OS has caught up.  
> 
> Surprise Down events are handled separately in
> dpc_handle_surprise_removal() and won't reach dpc_process_error().
> Please correct me if I missed anything.

Probably fine. I just didn't check particularly closely.  

Jonathan
> 
> Thanks for valuable comments.
> 
> Best Regards,
> Shuai

