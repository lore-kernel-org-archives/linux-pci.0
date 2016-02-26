Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33526 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932177AbcBZR3b (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Feb 2016 12:29:31 -0500
MIME-Version: 1.0
In-Reply-To: <20160226163013.11964.84849.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160226162554.11964.96983.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20160226163013.11964.84849.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Date: Fri, 26 Feb 2016 22:59:30 +0530
Message-ID: <CAHM4w1mH9e+m7sPUFhD81pOBpnypJo=dLQUoeFaL1ZNUsOUd8Q@mail.gmail.com>
Subject: Re: [PATCH v11 3/4] PCI: designware: Add default link up check if
 sub-driver doesn't override
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
> Add a default DesignWare "link_up" test for use when a sub-driver doesn't
> supply its own pcie_host_ops.link_up() method.
>
> [bhelgaas: changelog, split into its own patch]
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

No harm to existing platform, so
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
