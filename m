Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36181 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981AbcBZRYy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Feb 2016 12:24:54 -0500
MIME-Version: 1.0
In-Reply-To: <20160226163004.11964.55387.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160226162554.11964.96983.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20160226163004.11964.55387.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Date: Fri, 26 Feb 2016 22:54:52 +0530
Message-ID: <CAHM4w1kR+ug2aD_AZ_zMMwPODm07yMwahbBT3QKzFeN1WP6j_Q@mail.gmail.com>
Subject: Re: [PATCH v11 2/4] PCI: designware: Add generic dw_pcie_wait_for_link()
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexey.Brodkin@synopsys.com, Arnd Bergmann <arnd@arndb.de>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Vineet.Gupta1@synopsys.com, linux-kernel@vger.kernel.org,
	Carlos Palminha <CARLOS.PALMINHA@synopsys.com>,
	Rob Herring <robh+dt@kernel.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Kumar Gala <galak@codeaurora.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 26, 2016 at 10:00 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> From: Joao Pinto <Joao.Pinto@synopsys.com>
>
> Several DesignWare-based drivers (dra7xx, exynos, imx6, keystone, qcom, and
> spear13xx) had similar loops waiting for the link to come up.
>
> Add a generic dw_pcie_wait_for_link() for use by all these drivers so the
> waiting is done consistently, e.g., always using usleep_range() rather than
> mdelay() and using similar timeouts and retry counts.
>
> Note that this changes the Keystone link training/wait for link strategy,
> so we initiate link training, then wait longer for the link to come up
> before re-initiating link training.
>
> [bhelgaas: changelog, split into its own patch, update pci-keystone.c, pcie-qcom.c]
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

5 retries should be sufficient for keystone, still it would be good to
have a tested-by for it.
Other than that code seems fine to me.

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
