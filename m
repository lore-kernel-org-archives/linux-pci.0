Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:48677 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbcBEKoi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Feb 2016 05:44:38 -0500
Subject: Re: [PATCH v8 2/2] add new platform driver for PCI RC
To: Bjorn Helgaas <helgaas@kernel.org>,
	Joao Pinto <Joao.Pinto@synopsys.com>
References: <cover.1454600622.git.jpinto@synopsys.com>
 <c7af1603d4f18d11cb0ccee1c07708a1455ea4ed.1454600622.git.jpinto@synopsys.com>
 <20160204181911.GA2143@localhost> <56B398E9.3080902@synopsys.com>
 <20160204234334.GH7031@localhost>
CC: <Vineet.Gupta1@synopsys.com>, <arnd@arndb.de>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-snps-arc@lists.infradead.org>,
	<CARLOS.PALMINHA@synopsys.com>, <Alexey.Brodkin@synopsys.com>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <56B47D0D.5030204@synopsys.com>
Date: Fri, 5 Feb 2016 10:44:29 +0000
MIME-Version: 1.0
In-Reply-To: <20160204234334.GH7031@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 2/4/2016 11:43 PM, Bjorn Helgaas wrote:
>> What do you think?
> 
> I don't think the "dw" part is relevant (none of the other
> DesignWare-based drivers includes it in the driver or file name).
> 
> How do people typically refer to this board?
> 
> I really like "synopsys" because it fits the pattern of being
> recognizable and pronounceable like "altera", "designware", "qcom",
> "keystone", "layerscape", "tegra", etc.  But I can't tell whether it's
> too generic.
> 
> "ipk" or "haps" would be fine with me.  I think it's OK if it doesn't
> cover 100% of the possible systems.

I think we should follow the iproc example: pcie-iproc-platform.c
In this case we would have pcie-designware-platform.c
I think this would be the best name because the driver is a non soc specific
designware platform driver.

Arnd and Bjorn agree on this name?

> 
> Bjorn
> 

Joao

