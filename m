Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbeIACBw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 22:01:52 -0400
Subject: Re: [PATCH 02/16] PCI: Fix pci_reset_bus
To: Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-3-keith.busch@intel.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <dad1e661-679d-eb4b-8c87-b65afd5eb838@kernel.org>
Date: Fri, 31 Aug 2018 14:52:25 -0700
MIME-Version: 1.0
In-Reply-To: <20180831212639.10196-3-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/31/2018 2:26 PM, Keith Busch wrote:
> The check for slot reset capable, pci_probe_reset_slot, returns 0 when
> slot reset is possible, but pci_reset_bus was proceeding to reset the
> slot when the probe returned an error. This patch reverses the check to
> fix that logic.
> 
> Signed-off-by: Keith Busch<keith.busch@intel.com>

Thanks, dennis.dalessandro@intel.com just posted the same patch.

Reviewed-by: Sinan Kaya <okaya@kernel.org>
