Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 2 Aug 2016 07:53:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: jingoohan1@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jszhang@marvell.com,
	CARLOS.PALMINHA@synopsys.com, MiguelFalcao.Sousa@synopsys.com
Subject: Re: [PATCH v2 1/2] pcie-designware: add iATU Unroll feature
Message-ID: <20160802125335.GA31847@localhost>
References: <cover.1469193895.git.jpinto@synopsys.com>
 <0ce5678ac78d082afa3df7ad284111afcc03b2a1.1469193895.git.jpinto@synopsys.com>
 <20160725204443.GB15939@localhost>
 <e00f4953-eb9f-8b6c-0c16-f6fd1abcb717@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e00f4953-eb9f-8b6c-0c16-f6fd1abcb717@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 02, 2016 at 11:27:45AM +0100, Joao Pinto wrote:
> On 7/25/2016 9:44 PM, Bjorn Helgaas wrote:
> > On Fri, Jul 22, 2016 at 02:29:38PM +0100, Joao Pinto wrote:
> >> This patch adds the support to the new iATU mechanism that will be used
> >> from Core version 4.80, which is called iATU Unroll.
> >> The new Cores can support the iATU Unroll or support the "old" iATU 
> >> method now called Legacy Mode. The driver is perfectly capable of
> >> performing well for both.
> >>
> >> In order to make sure that the iATU is really enabled a for loop was
> >> introduced in dw_pcie_prog_outbound_atu() to improve reliability.
> >>
> >> This patch also moves the sleep definitions to the *.c file like
> >> suggested by Jisheng Zhang in a previous patch.
> >>
> >> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> ...

> >> +/* Registers */
> >> +#define PCIE_ATU_UNR_REGION_CTRL1	0x00
> >> +#define PCIE_ATU_UNR_REGION_CTRL2	0x01
> >> +#define PCIE_ATU_UNR_LOWER_BASE		0x02
> >> +#define PCIE_ATU_UNR_UPPER_BASE		0x03
> >> +#define PCIE_ATU_UNR_LIMIT		0x04
> >> +#define PCIE_ATU_UNR_LOWER_TARGET	0x05
> >> +#define PCIE_ATU_UNR_UPPER_TARGET	0x06
> >> +#define PCIE_ATU_UNR_REGION_CTRL3	0x07
> >> +#define PCIE_ATU_UNR_UPPR_LIMIT		0x08
> > 
> > Last two items aren't used.
> 
> I can take them off, but don't you think it is useful to include them for future
> applications?

This isn't a huge deal either way.  Personally I wouldn't include them
because if they're not used, they haven't been tested, and there's
always the possibility of transcription errors.  If you need to use
them in the future, it makes perfect sense to add the register
definition in the same patch that uses the register.

> ...
> >> +static inline void dw_pcie_readl_unroll(struct pcie_port *pp, u32 type,
> >> +						u32 index, u32 reg, u32 *val)
> >> +{
> >> +	u32 reg_addr = 0;
> >> +
> >> +	if (type == PCIE_TRANSL_OUTB)
> >> +		reg_addr = PCIE_GET_ATU_OUTB_UNR_REG_ADDR(index, reg);
> >> +	else if  (type == PCIE_TRANSL_INB)
> >> +		reg_addr = PCIE_GET_ATU_INB_UNR_REG_ADDR(index, reg);
> > 
> > PCIE_TRANSL_INB is never used.  In fact, dw_pcie_readl_unroll() is
> > *always* called with PCIE_TRANSL_OUTB, so it's not clear what the
> > value of passing it as an argument is.
> 
> I included The Inbound translation mechanism because you can have Inbound or
> Outbound translation in the iATU. The old mechanism also had Inbound properties
> that are not used in the code. I suggest we keep the Inbound mechanism to avoid
> future rework. Agree?

Again, not a huge deal, but since PCIE_TRANSL_INB is not used, it
makes life harder for the reader, and the related code is not tested.
So personally, I would remove it and add it back if/when it is needed.

Bjorn
