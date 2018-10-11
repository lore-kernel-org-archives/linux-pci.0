Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E9FC677FC
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DA92098A
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DA92098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbeJKXbv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:31:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:10426 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbeJKXbv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 19:31:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 09:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,368,1534834800"; 
   d="scan'208";a="80672084"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga008.jf.intel.com with ESMTP; 11 Oct 2018 09:00:16 -0700
Date:   Thu, 11 Oct 2018 09:57:16 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Matthew Wilcox <willy@infradead.org>,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] PCI/AER: Enable reporting for ports enumerated after
 AER driver registration
Message-ID: <20181011155715.GD11034@localhost.localdomain>
References: <153927123657.40414.9802241131940995491.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153927157816.40414.5263399018962087014.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153927157816.40414.5263399018962087014.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 11, 2018 at 08:26:18AM -0700, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously we enabled AER error reporting only for Switch Ports that were
> enumerated prior to registering the AER service driver.  Switch Ports
> enumerated after AER driver registration were left with error reporting
> disabled.
> 
> A common order, which works correctly, is that we enumerate devices before
> registering portdrv and the AER driver:
> 
>   - Enumerate all the devices at boot-time
> 
>   - Register portdrv and bind it to all Root Ports and Switch Ports, which
>     disables error reporting for these Ports
> 
>   - Register AER service driver and bind it to all Root Ports, which
>     enables error reporting for the Root Ports and any Switch Ports below
>     them
> 
> But if we enumerate devices *after* registering portdrv and the AER driver,
> e.g., if a host bridge driver is loaded as a module, error reporting is not
> enabled correctly:
> 
>   - Register portdrv and AER driver (this happens at boot-time)
> 
>   - Enumerate a Root Port
> 
>   - Bind portdrv to Root Port, disabling its error reporting
> 
>   - Bind AER service driver to Root Port, enabling error reporting for it
>     and its children (there are no children, since we haven't enumerated
>     them yet)
> 
>   - Enumerate Switch Port below the Root Port
> 
>   - Bind portdrv to Switch Port, disabling its error reporting
> 
>   - AER service driver doesn't bind to Switch Ports, so error reporting
>     remains disabled
> 
> Hot-adding a Switch fails similarly: error reporting is enabled correctly
> for the Root Port, but when the Switch is enumerated, the AER service
> driver doesn't claim it, so there's nothing to enable error reporting for
> the Switch Ports.
> 
> Change the AER service driver so it binds to *all* PCIe Ports, including
> Switch Upstream and Downstream Ports.  Enable AER error reporting for all
> these Ports, but not for any children.
> 
> Link: https://lore.kernel.org/linux-pci/1536085989-2956-1-git-send-email-jonathan.derrick@intel.com
> Based-on-patch-by: Jon Derrick <jonathan.derrick@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aer.c |   16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 90b53abf621d..c40c6607849b 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1316,12 +1316,6 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>  	pci_read_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, &reg32);
>  	pci_write_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, reg32);
>  
> -	/*
> -	 * Enable error reporting for the root port device and downstream port
> -	 * devices.
> -	 */
> -	set_downstream_devices_error_reporting(pdev, true);
> -
>  	/* Enable Root Port's interrupt in response to error messages */
>  	pci_read_config_dword(pdev, aer_pos + PCI_ERR_ROOT_COMMAND, &reg32);
>  	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> @@ -1378,10 +1372,17 @@ static void aer_remove(struct pcie_device *dev)
>   */
>  static int aer_probe(struct pcie_device *dev)
>  {
> +	struct pci_dev *pdev = dev->port;
> +	int type = pci_pcie_type(pdev);
>  	int status;
>  	struct aer_rpc *rpc;
>  	struct device *device = &dev->device;
>  
> +	if (type == PCI_EXP_TYPE_UPSTREAM || type == PCI_EXP_TYPE_DOWNSTREAM) {
> +		pci_enable_pcie_error_reporting(pdev);
> +		return 0;
> +	}

I think we need to either return an error in this case so that the
pcie_device won't be eligable for the .remove() callback, or add a
similiar type check in aer_remove().
