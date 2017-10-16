Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:59359 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbdJPMk1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2017 08:40:27 -0400
Subject: Re: [PATCH 09/10] PCI: dwc: make cpu_addr_fixup take struct dw_pcie
 as argument
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesper Nilsson <jespern@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@axis.com>
References: <20171013160914.3220-1-niklas.cassel@axis.com>
 <20171013160914.3220-10-niklas.cassel@axis.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <3970f7e1-c5bf-3c0c-98fb-fc0bf5b14212@axis.com>
Date: Mon, 16 Oct 2017 14:40:24 +0200
MIME-Version: 1.0
In-Reply-To: <20171013160914.3220-10-niklas.cassel@axis.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/13/2017 06:09 PM, Niklas Cassel wrote:
(snip)

Hello Kishon

I just wanted to say that the function
artpec6_pcie_calc_cpu_fixup_mask should work on dra7xx
as well. (I had dra7xx in mind when I wrote it.)
However, I did not want to change pci-dra7xx.c to
also use this function, since your current code is
quite simple.
But if you think that it's a good idea, we could
rename and move artpec6_pcie_calc_cpu_fixup_mask
to pcie-designware.c, and migrate pci-dra7xx
to utilize this function as well, as it is strictly
more correct to use values from device tree, rather
than having a hard coded define in the SoC driver.


Regards,
Niklas
