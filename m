Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34796 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbbGWNGn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2015 09:06:43 -0400
Received: by iebmu5 with SMTP id mu5so191243232ieb.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2015 06:06:42 -0700 (PDT)
Date: Thu, 23 Jul 2015 08:06:37 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v5 04/19] PCI/MSI: Add hooks to populate the msi_domain
 field
Message-ID: <20150723130637.GR21967@google.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
 <1437643598-19795-5-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437643598-19795-5-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 23, 2015 at 10:26:23AM +0100, Marc Zyngier wrote:
> In order to be able to populate the device msi_domain field,
> add the necessary hooks to propagate the host bridge msi_domain
> across secondary busses to devices.
> 
> So far, nobody populates the initial msi_domain.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> +static void pci_set_msi_domain(struct pci_dev *dev)
> +{
> +	/*
> +	 * If no domain has been set through the pcibios callback,
> +	 * inherit the default from the bus device.

Nit: there isn't a pcibios callback anymore.

> +	 */
> +	if (!dev_get_msi_domain(&dev->dev))
> +		dev_set_msi_domain(&dev->dev,
> +				   dev_get_msi_domain(&dev->bus->dev));
> +}
