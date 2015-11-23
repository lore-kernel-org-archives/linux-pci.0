Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:49592 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbbKWL2I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Nov 2015 06:28:08 -0500
Date: Mon, 23 Nov 2015 11:27:44 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v3 2/6] PCI: designware: add memory barrier after
 enabling region
Message-ID: <20151123112744.GL8644@n2100.arm.linux.org.uk>
References: <cover.1448270813.git.stanimir.varbanov@linaro.org>
 <d38a9c1a87c4e40ad6d17fcbe0fd41b33d7d2912.1448270813.git.stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d38a9c1a87c4e40ad6d17fcbe0fd41b33d7d2912.1448270813.git.stanimir.varbanov@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 23, 2015 at 11:28:59AM +0200, Stanimir Varbanov wrote:
> Add 'write memory' barrier after enable region in PCIE_ATU_CR2
> register. The barrier is needed to ensure that the region enable
> request has been reached it's destination at time when we
> read/write to PCI configuration space.
> 
> Without this barrier PCI device enumeration during kernel boot
> is not reliable, and reading configuration space for particular
> PCI device on the bus returns zero aka no device.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/pci/host/pcie-designware.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 02a7452bdf23..e15a2ae1583f 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -164,6 +164,11 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
>  	dw_pcie_writel_rc(pp, upper_32_bits(pci_addr), PCIE_ATU_UPPER_TARGET);
>  	dw_pcie_writel_rc(pp, type, PCIE_ATU_CR1);
>  	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
> +	/*
> +	 * ensure that the ATU enable has been happaned before accessing
> +	 * pci configuration/io spaces through dw_pcie_cfg_[read|write].
> +	 */
> +	smp_wmb();

So, why is this a SMP barrier?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
