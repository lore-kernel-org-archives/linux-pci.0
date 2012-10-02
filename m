Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mms1.broadcom.com ([216.31.210.17]:2804 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753412Ab2JBIBJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Oct 2012 04:01:09 -0400
Message-ID: <506A9892.5090707@broadcom.com>
Date: Tue, 2 Oct 2012 09:32:34 +0200
From: "Yuval Mintz" <yuvalmin@broadcom.com>
MIME-Version: 1.0
To: "Donald Dutile" <ddutile@redhat.com>
cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	davem@davemloft.net
Subject: Re: [RFC] PCI: enable and disable sriov support via sysfs at
 per device level
References: <1349134020-62152-1-git-send-email-ddutile@redhat.com>
In-Reply-To: <1349134020-62152-1-git-send-email-ddutile@redhat.com>
Content-Type: text/plain;
 charset=iso-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> +static void pci_sriov_remove_sysfs_dev_files(struct pci_dev *dev)
> +{
> +	int pos;
> +
> +	if ((dev->is_physfn) && pci_is_pcie(dev)) {
> +            pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
> +            if (pos)
> +		device_remove_file(&dev->dev, pci_dev_sriov_attrs);

Shouldn't it iterate over the attributes when removing them?



