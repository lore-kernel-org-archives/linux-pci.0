Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
To: Joao Pinto <Joao.Pinto@synopsys.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
Subject: Re: [PATCH v6 1/2] PCI support added to ARC
Date: Thu, 14 Jan 2016 11:11:57 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E84E0E@us01wembx1.internal.synopsys.com>
References: <cover.1452611234.git.jpinto@synopsys.com>
 <24c9b782dfade515bbed20ce75d85200a00a2e66.1452611234.git.jpinto@synopsys.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 14 January 2016 04:34 PM, Joao Pinto wrote:

This patch adds PCI support to ARC and updates drivers/pci Makefile
enabling the ARC arch to use the generic PCI setup functions.

Signed-off-by: Joao Pinto <jpinto@synopsys.com><mailto:jpinto@synopsys.com>

Acked-by: Vineet Gupta <vgupta@synopsys.com><mailto:vgupta@synopsys.com>

@Bjorn are you happy with the driver bits.
Although ARC support is independent of driver, and I can pick it up separately, it would be better if you took it along with the driver. I don't see potential for any conflicts.

Thx,
-Vineet
