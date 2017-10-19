Return-Path: <SRS0=zFL7=BS=axis.com=niklas.cassel@kernel.org>
Return-Path: <SRS0=zFL7=BS=axis.com=niklas.cassel@kernel.org>
Subject: Re: [PATCH 08/10] PCI: dwc: artpec6: add support for endpoint mode
To: Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>
CC: Jesper Nilsson <jespern@axis.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Kishon Vijay Abraham I" <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>,
	"Xiaowei Song" <songxiaowei@hisilicon.com>, Peter Robinson
	<pbrobinson@gmail.com>, Tomasz Nowicki <tn@semihalf.com>, Gabriele Paoloni
	<gabriele.paoloni@huawei.com>, Duc Dang <dhdang@apm.com>,
	<linux-arm-kernel@axis.com>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20171013160914.3220-1-niklas.cassel@axis.com>
 <20171013160914.3220-9-niklas.cassel@axis.com>
 <20171016234326.GM25517@bhelgaas-glaptop.roam.corp.google.com>
 <20171019075912.GA10089@infradead.org>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <9a294a12-4f9e-74cf-b7c0-7e45a9ca91f5@axis.com>
Date: Thu, 19 Oct 2017 12:57:33 +0200
MIME-Version: 1.0
In-Reply-To: <20171019075912.GA10089@infradead.org>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On 10/19/2017 09:59 AM, Christoph Hellwig wrote:
> On Mon, Oct 16, 2017 at 06:43:26PM -0500, Bjorn Helgaas wrote:
>> understand it.  I guess the idea is to build pcie-artpec6.o if either
>> CONFIG_PCIE_ARTPEC6_HOST or CONFIG_PCIE_ARTPEC6_EP is set (or both).
>>
>> Is this really the simplest way to express that in Kconfig?  Both the
>> "if PCIE_ARTPEC6" and this ifneq thing are complicated and relatively
>> unusual.
> 
> I thĳnk the right style is to make PCIE_ARTPEC6 a hidden kconfig
> symbol without help text, and then have PCIE_ARTPEC6_HOST and
> PCIE_ARTPEC6_EP select it.
> 

Thanks for the suggestion Christoph!
I will make this change for both pci-dra7xx and pcie-artpec6 in
the next version of the patch series, and then Kishon can ACK/NACK.
