Return-Path: <SRS0=BYVQ=BS=bombadil.srs.infradead.org=BATV+a28bd260a4ecf58d2edb+5170+infradead.org+hch@kernel.org>
Return-Path: <SRS0=BYVQ=BS=bombadil.srs.infradead.org=BATV+a28bd260a4ecf58d2edb+5170+infradead.org+hch@kernel.org>
Date: Thu, 19 Oct 2017 00:59:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Niklas Cassel <niklas.cassel@axis.com>,
	Niklas Cassel <niklass@axis.com>, Jesper Nilsson <jespern@axis.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Duc Dang <dhdang@apm.com>, linux-arm-kernel@axis.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] PCI: dwc: artpec6: add support for endpoint mode
Message-ID: <20171019075912.GA10089@infradead.org>
References: <20171013160914.3220-1-niklas.cassel@axis.com>
 <20171013160914.3220-9-niklas.cassel@axis.com>
 <20171016234326.GM25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171016234326.GM25517@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 16, 2017 at 06:43:26PM -0500, Bjorn Helgaas wrote:
> understand it.  I guess the idea is to build pcie-artpec6.o if either
> CONFIG_PCIE_ARTPEC6_HOST or CONFIG_PCIE_ARTPEC6_EP is set (or both).
> 
> Is this really the simplest way to express that in Kconfig?  Both the
> "if PCIE_ARTPEC6" and this ifneq thing are complicated and relatively
> unusual.

I thĳnk the right style is to make PCIE_ARTPEC6 a hidden kconfig
symbol without help text, and then have PCIE_ARTPEC6_HOST and
PCIE_ARTPEC6_EP select it.
