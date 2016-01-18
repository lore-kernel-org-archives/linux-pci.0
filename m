Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:34440 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273AbcARLaV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jan 2016 06:30:21 -0500
Subject: Re: [PATCH v6 1/2] PCI support added to ARC
To: "helgaas@kernel.org" <helgaas@kernel.org>
References: <cover.1452611234.git.jpinto@synopsys.com>
 <24c9b782dfade515bbed20ce75d85200a00a2e66.1452611234.git.jpinto@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E84E0E@us01wembx1.internal.synopsys.com>
CC: Vineet Gupta <Vineet.Gupta1@synopsys.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-snps-arc@lists.infradead.org"
	<linux-snps-arc@lists.infradead.org>,
	"CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>,
	"Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"arnd@arndb.de" <arnd@arndb.de>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <569CCCC5.3070906@synopsys.com>
Date: Mon, 18 Jan 2016 11:30:13 +0000
MIME-Version: 1.0
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4E84E0E@us01wembx1.internal.synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 1/14/2016 11:11 AM, Vineet Gupta wrote:
> On Thursday 14 January 2016 04:34 PM, Joao Pinto wrote:
>> This patch adds PCI support to ARC and updates drivers/pci Makefile
>> enabling the ARC arch to use the generic PCI setup functions.
>>
>> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> 
> Acked-by: Vineet Gupta <vgupta@synopsys.com>
> 
> @Bjorn are you happy with the driver bits.
> Although ARC support is independent of driver, and I can pick it up separately,
> it would be better if you took it along with the driver. I don't see potential
> for any conflicts.
> 
> Thx,
> -Vineet

In your opinion the patch set is ready for merge or do you need me to make any
more tweaks?

Thanks a lot.

Joao
