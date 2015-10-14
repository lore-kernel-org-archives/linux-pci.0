Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, lftan.linux@gmail.com,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v9 3/6] pci:host: Add Altera PCIe host controller driver
Date: Wed, 14 Oct 2015 10:20 +0200
Message-ID: <6044983.WR9BTgsOaA@wuerfel>
In-Reply-To: <1444790492-4051-4-git-send-email-lftan@altera.com>
References: <1444790492-4051-1-git-send-email-lftan@altera.com> <1444790492-4051-4-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 14 October 2015 10:41:29 Ley Foon Tan wrote:
> +static int altera_pcie_remove(struct platform_device *pdev)
> +{
> +	struct altera_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	altera_pcie_free_irq_domain(pcie);
> +	platform_set_drvdata(pdev, NULL);
> +	return 0;
> +}

I just noticed this. Does it actually work to unload the module
and tear down all the pci_dev structures in a safe way?

	Arnd
