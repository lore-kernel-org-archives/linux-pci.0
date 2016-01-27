Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 27 Jan 2016 15:59:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>,
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
Subject: Re: [PATCH v6 1/2] PCI support added to ARC
Message-ID: <20160127215956.GB4875@localhost>
References: <cover.1452611234.git.jpinto@synopsys.com>
 <24c9b782dfade515bbed20ce75d85200a00a2e66.1452611234.git.jpinto@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E84E0E@us01wembx1.internal.synopsys.com>
 <56A8D441.8080608@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56A8D441.8080608@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joao,

On Wed, Jan 27, 2016 at 02:29:21PM +0000, Joao Pinto wrote:
> Hi Bjorn,
> Could you please tell me what are the perspectives of pulling this patch set to
> mainline?

Sorry for the delay.  I try to handle bug fixes before I look at
functionality, so sometimes things get backed up a little bit.  But I
should be able to take a look later this week or early next week.

Bjorn

> On 1/14/2016 11:11 AM, Vineet Gupta wrote:
> > On Thursday 14 January 2016 04:34 PM, Joao Pinto wrote:
> >> This patch adds PCI support to ARC and updates drivers/pci Makefile
> >> enabling the ARC arch to use the generic PCI setup functions.
> >>
> >> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> > 
> > Acked-by: Vineet Gupta <vgupta@synopsys.com>
> > 
> > @Bjorn are you happy with the driver bits.
> > Although ARC support is independent of driver, and I can pick it up separately,
> > it would be better if you took it along with the driver. I don't see potential
> > for any conflicts.
> > 
> > Thx,
> > -Vineet
> 
> Thanks,
> Joao
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
