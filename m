Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40688 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdL1QJ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 11:09:57 -0500
Date: Thu, 28 Dec 2017 08:09:55 -0800
From: Stephen Boyd <sboyd@codeaurora.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Gustavo.Pimentel@synopsys.com
Subject: Re: [PATCH v2] PCI: dwc: Use {upper,lower}_32_bits() macros for
 clarity
Message-ID: <20171228160955.GF7997@codeaurora.org>
References: <20171227232540.22341-1-sboyd@codeaurora.org>
 <f855815f-79a3-9be2-1513-2c9edc907079@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f855815f-79a3-9be2-1513-2c9edc907079@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/28, Joao Pinto wrote:
> >  	if (pp->ops->get_msi_data)
> >  		msg.data = pp->ops->get_msi_data(pp, pos);
> > 
> 
> Thanks for the patch.
> Gustavo' patch-set targeting the update of the Interrupt API for
> pcie-designware* already does this modification, so I would suggest that we wait
> for Gustavo' patch to be stable and get the same modification.
> 

Ok.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
