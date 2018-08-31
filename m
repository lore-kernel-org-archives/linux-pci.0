Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbeIACYg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 22:24:36 -0400
Subject: Re: [PATCH 15/16] PCI/DPC: Wait for reset complete
To: Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-16-keith.busch@intel.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <bcf7d0be-f720-a6ae-3250-222ef8e23228@kernel.org>
Date: Fri, 31 Aug 2018 15:15:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180831212639.10196-16-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/31/2018 2:26 PM, Keith Busch wrote:
> 	/*
> +	 * PCIe 4.0r1 6.6.1, a component must enter LTSSM Detect within 20ms,
> +	 * after which we should expect an link active if the reset was
> +	 * successful. If so, software must wait a minimum 100ms before sending
> +	 * configuration requests to devices downstream this port.
> +	 *
> +	 * If the link fails to activate, either the device was physically
> +	 * removed or the link is permanently failed.
> +	 */
> +	msleep(20);
> +	if (!pcie_wait_for_link(pdev, true))
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	msleep(100);

Can you move these wait statements and spec reference inside the 
pcie_wait_for_link() function?

Nit. There are some whitespace changes in this file.
