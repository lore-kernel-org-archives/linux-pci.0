Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:38291 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdAWImE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2017 03:42:04 -0500
Subject: Re: PCI: dwc: Add COMPILE_TEST to all designware based drivers
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        nsekhar@ti.com
From: "pankaj.dubey" <pankaj.dubey@samsung.com>
Message-id: <617c6f6c-2e2e-6e55-85c3-076c98faad52@samsung.com>
Date: Mon, 23 Jan 2017 14:14:55 +0530
MIME-version: 1.0
In-reply-to: <1484214183-31805-1-git-send-email-kishon@ti.com>
Content-type: text/plain; charset=utf-8
References: <1484214183-31805-1-git-send-email-kishon@ti.com>
 <CGME20170123084200epcas4p3433a190d7f9ef2c19ba008f62fab3c75@epcas4p3.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

On Thursday 12 January 2017 03:13 PM, Kishon Vijay Abraham I wrote:
> Add COMPILE_TEST to all designware based drivers so that it is possible
> to perform compile test even when a particular architecture specific
> config symbol is not set.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/Kconfig |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Thanks,
Pankaj Dubey
