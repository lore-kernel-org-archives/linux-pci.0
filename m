Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36714 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751760AbeABK2A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jan 2018 05:28:00 -0500
Date: Tue, 2 Jan 2018 10:28:52 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Gustavo.Pimentel@synopsys.com
Subject: Re: [PATCH v2] PCI: dwc: Use {upper,lower}_32_bits() macros for
 clarity
Message-ID: <20180102102852.GA10536@red-moon>
References: <20171227232540.22341-1-sboyd@codeaurora.org>
 <f855815f-79a3-9be2-1513-2c9edc907079@synopsys.com>
 <20171228160955.GF7997@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171228160955.GF7997@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 28, 2017 at 08:09:55AM -0800, Stephen Boyd wrote:
> On 12/28, Joao Pinto wrote:
> > >  	if (pp->ops->get_msi_data)
> > >  		msg.data = pp->ops->get_msi_data(pp, pos);
> > > 
> > 
> > Thanks for the patch.
> > Gustavo' patch-set targeting the update of the Interrupt API for
> > pcie-designware* already does this modification, so I would suggest that we wait
> > for Gustavo' patch to be stable and get the same modification.
> > 
> 
> Ok.

Ok, marked as superseded, thanks.

Lorenzo
