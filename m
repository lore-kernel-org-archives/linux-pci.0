Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 6 Jan 2016 12:20:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Russell King <linux@arm.linux.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH v5 1/5] PCI: designware: ensure ATU is enabled before
 IO/conf space accesses
Message-ID: <20160106182003.GA16231@localhost>
References: <1450442339-18765-1-git-send-email-stanimir.varbanov@linaro.org>
 <1450442339-18765-2-git-send-email-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450442339-18765-2-git-send-email-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jisheng]

On Fri, Dec 18, 2015 at 02:38:55PM +0200, Stanimir Varbanov wrote:
> There is no guarantees that enabling ATU will hit the hardware
> immediately, and subsequent accesses to configuration / IO spaces
> are reliable. So fixing this by read back PCIE_ATU_CR2 register
> just after writing.
> 
> Without such a fix the PCI device enumeration during kernel boot
> is not reliable, and reading configuration space for particular
> PCI device on the bus returns zero aka no device.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/pci/host/pcie-designware.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 02a7452bdf23..7880de63895d 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -154,6 +154,8 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
>  static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
>  		int type, u64 cpu_addr, u64 pci_addr, u32 size)
>  {
> +	u32 val;
> +
>  	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | index,
>  			  PCIE_ATU_VIEWPORT);
>  	dw_pcie_writel_rc(pp, lower_32_bits(cpu_addr), PCIE_ATU_LOWER_BASE);
> @@ -164,6 +166,11 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
>  	dw_pcie_writel_rc(pp, upper_32_bits(pci_addr), PCIE_ATU_UPPER_TARGET);
>  	dw_pcie_writel_rc(pp, type, PCIE_ATU_CR1);
>  	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
> +	/*
> +	 * ensure that the ATU enable has been happaned before accessing
> +	 * pci configuration/io spaces through dw_pcie_cfg_[read|write].
> +	 */
> +	dw_pcie_readl_rc(pp, PCIE_ATU_CR2, &val);

This particular fix makes sense to me.

But I have a larger question about how the ATU works.  I see these
definitions:

  #define PCIE_ATU_TYPE_MEM
  #define PCIE_ATU_TYPE_IO
  #define PCIE_ATU_TYPE_CFG0
  #define PCIE_ATU_TYPE_CFG1

and these uses:

  - In dw_pcie_host_init(), set PCIE_ATU_TYPE_MEM for unit 1
    (but only if rd_other_conf is not overridden)

  - In dw_pcie_rd_other_conf() and dw_pcie_wr_other_conf(),
    set PCIE_ATU_TYPE_CFG0 before config access to own bus;
    set PCIE_ATU_TYPE_CFG1 before config access to other bus;
    set PCIE_ATU_TYPE_IO after completion

I'm confused:

1) I assume PCIE_ATU_TYPE_MEM is for access to PCI memory space.  Why
is that initialization related to rd_other_conf?  Shouldn't that be
set up always?  A comment here would be nice, to clarify that this is
not related to the subsequent dw_pcie_wr_own_conf() calls.

2) Why doesn't dw_pcie_host_init() use dw_pcie_rd_conf() instead of
dw_pcie_rd_own_conf()?  Using pci_read_config_dword() might be even
better.  Using the internal interfaces piecemeal like we do today is
just an opportunity for doing it wrong.

3) The definitions and your comment about "accessing PCI
configuration/io spaces" suggest that the ATU must be programmed
differently for accesses to PCI config space vs. I/O space.  If that's
the case, we'd need some kind of mutex to protect inl(), etc., during
config accesses.  For example, in this scenario:

  thread A                                         thread B
  ---------------------------------------------    ----------
  pci_read_config_dword()
  dw_pcie_prog_outbound_atu(PCIE_ATU_TYPE_CFG0)
                                                   inl()
  dw_pcie_cfg_read()
  readl()
  dw_pcie_prog_outbound_atu(PCIE_ATU_TYPE_IO)
                                                   inl()

Do both inl() calls by thread B work correctly, even though the ATU
seems to be programmed for CFG0 for the first but IO for the second?

Bjorn
