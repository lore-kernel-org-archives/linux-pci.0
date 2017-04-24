Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8849 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1168607AbdDXKhE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Apr 2017 06:37:04 -0400
Date: Mon, 24 Apr 2017 13:36:58 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Pan Bian <bianpan201603@163.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: Re: [PATCH 1/1] PCI: check return value of pci_find_ext_capability
Message-ID: <20170424103658.GU7152@lahna.fi.intel.com>
References: <1492956020-32271-1-git-send-email-bianpan201603@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1492956020-32271-1-git-send-email-bianpan201603@163.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 23, 2017 at 10:00:20PM +0800, Pan Bian wrote:
> From: Pan Bian <bianpan2016@163.com>
> 
> Function pci_find_ext_capability() will returns 0 on failure, and its
> return value should be checked before it is used. However, in function
> pcie_port_enable_msix(), its return value is not checked. This patch
> adds the check.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/pci/pcie/portdrv_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index cea504f..001951d 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -103,6 +103,8 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *irqs, int mask)
>  		 * interrupt message."
>  		 */
>  		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> +		if (!pos)
> +			goto out_free_irqs;

I don't think this can happen because get_port_device_capability() will
enumerate this capability and only if it exists, set PCIE_PORT_SERVICE_AER.
