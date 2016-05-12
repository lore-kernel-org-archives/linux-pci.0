Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 12 May 2016 07:08:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Sinan Kaya <okaya@codeaurora.org>, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>,
	Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>,
	wangyijing@huawei.com,
	Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>,
	Mark Salter <msalter@redhat.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	Jon Masters <jcm@redhat.com>,
	Andrea Gallo <andrea.gallo@linaro.org>,
	Duc Dang <dhdang@apm.com>, jeremy.linton@arm.com,
	liudongdong3@huawei.com, Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH V7 07/11] pci, acpi: Handle ACPI companion assignment.
Message-ID: <20160512120836.GF28812@localhost>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <1462893601-8937-8-git-send-email-tn@semihalf.com>
 <CAJZ5v0hM8WAr9GGku89zKgiVKt6ArHf=9CntRUyBjyMNUvie2A@mail.gmail.com>
 <20160511101101.GA16101@red-moon>
 <CAJZ5v0hgw929W5PjF0PqT+ssiOHd8TeJoSQcz4NUiAovZY2pfQ@mail.gmail.com>
 <20160511224314.GD28812@localhost>
 <57345FDF.4000804@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57345FDF.4000804@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 12, 2016 at 12:50:07PM +0200, Tomasz Nowicki wrote:
> On 12.05.2016 00:43, Bjorn Helgaas wrote:

> >@@ -70,9 +71,11 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
> >  	cfg->res.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> >  	cfg->res.name = "PCI ECAM";
> >
> >-	err = request_resource(&iomem_resource, &cfg->res);
> >-	if (err) {
> >-		dev_err(dev, "request ECAM res %pR failed\n", &cfg->res);
> >+	conflict = request_resource(&iomem_resource, &cfg->res);
> 
> We need request_resource_conflict here then:
> -	conflict = request_resource(&iomem_resource, &cfg->res);
> +	conflict = request_resource_conflict(&iomem_resource, &cfg->res);

Whoops, fixed, thanks!
