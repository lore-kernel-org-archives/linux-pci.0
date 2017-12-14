Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbdLNKvW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Dec 2017 05:51:22 -0500
Date: Thu, 14 Dec 2017 10:51:16 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>, kishon@ti.com
Cc: linux-pci@vger.kernel.org, Niklas Cassel <niklass@axis.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Fix find_first_zero_bit() usage
Message-ID: <20171214105116.GA1442@e107981-ln.cambridge.arm.com>
References: <20171212141634.5985-1-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171212141634.5985-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

On Tue, Dec 12, 2017 at 03:16:31PM +0100, Niklas Cassel wrote:
> find_first_zero_bit()'s parameter 'size' is defined in bits,
> not in bytes.
> 
> Calling find_first_zero_bit() with the wrong size unit
> will lead to insidious bugs.
> 
> Fix all uses of find_first_zero_bit() called with
> sizeof() as size argument in drivers/pci.
> 
> Also had to fix broken error handling in pci_epc_epf_link()
> in order to do proper error handling for find_first_zero_bit().
> 
> Niklas Cassel (3):
>   PCI: designware-ep: Fix find_first_zero_bit() usage
>   PCI: endpoint: Fix error handling in pci_epc_epf_link()
>   PCI: endpoint: Fix find_first_zero_bit() usage
> 
>  drivers/pci/dwc/pcie-designware-ep.c | 34 ++++++++++++++++++++++++++--------
>  drivers/pci/dwc/pcie-designware.h    |  8 ++++++--
>  drivers/pci/endpoint/pci-ep-cfs.c    | 13 ++++++++-----
>  3 files changed, 40 insertions(+), 15 deletions(-)

I would need your ACK asap to queue this series.

Thanks,
Lorenzo
