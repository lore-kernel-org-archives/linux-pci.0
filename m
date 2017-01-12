Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:59202 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbdALQqg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2017 11:46:36 -0500
Subject: Re: [PATCH] PCI: dwc: Add COMPILE_TEST to all designware based
 drivers
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
References: <1484214183-31805-1-git-send-email-kishon@ti.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <d3743b45-a7de-f8a6-feeb-f6a2cd85d6f1@synopsys.com>
Date: Thu, 12 Jan 2017 16:46:31 +0000
MIME-Version: 1.0
In-Reply-To: <1484214183-31805-1-git-send-email-kishon@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Kishon,

Às 9:43 AM de 1/12/2017, Kishon Vijay Abraham I escreveu:
> Add COMPILE_TEST to all designware based drivers so that it is possible
> to perform compile test even when a particular architecture specific
> config symbol is not set.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/Kconfig |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Your suggestion is interesting and I think it will improve the kbuild robot job,
since any change in a common file will be tested in all SoC specific drivers,
which does not happen at this moment.

This option is massively used across the kernel, and so it is a very welcome
addition to PCI in my opinion! Thanks.

Joao

