Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Fri, 11 Nov 2016 11:28:29 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Al Stone <ahs@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christopher Covington <cov@codeaurora.org>,
	Don Dutile <ddutile@redhat.com>,
	Dongdong Liu <liudongdong3@huawei.com>, Duc Dang <dhdang@apm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Graeme Gregory <graeme.gregory@linaro.org>,
	Jon Masters <jcm@redhat.com>, Mark Salter <msalter@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Robert Richter <rrichter@cavium.com>,
	Sinan Kaya <okaya@codeaurora.org>, Tomasz Nowicki <tn@semihalf.com>,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org
Subject: Re: ACPI namespace details for ARM64
Message-ID: <20161111112829.GB13333@red-moon>
References: <20161109220506.GN14322@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161109220506.GN14322@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 09, 2016 at 04:05:06PM -0600, Bjorn Helgaas wrote:

[...]

> ACPI defined a Producer/Consumer bit that was intended to distinguish
> the bridge apertures from the bridge registers [4, 5]. However, BIOSes
> didn't use that bit correctly, and the result is that OSes have to
> assume that everything in a PCI host bridge _CRS is a window. That
> leaves no way to describe the bridge registers in the PNP0A03/PNP0A08
> device itself.

ACPI 6.1 states that in the revision changes 4.0a Apr.2010 (xiii)
"Consumer/Producer bit is ignored (Restored 2.0C change that had
been lost)" and still that bit is marked as valid. If it is not
reliable it should be set as "ignored" in the specs (as it was
on ACPI 2.0C, BTW), as it is it is just a source of confusion.

Thanks again !
Lorenzo
