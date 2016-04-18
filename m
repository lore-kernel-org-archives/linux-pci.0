Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Jayachandran C <jchandra@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, jiang.liu@linux.intel.com,
	Jon Masters <jcm@redhat.com>, linaro-acpi@lists.linaro.org,
	linux-pci@vger.kernel.org, Liviu.Dudau@arm.com,
	David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, Wangyijing <wangyijing@huawei.com>,
	Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH V6 08/13] PCI: generic, thunder: update to use generic ECAM API
Date: Mon, 18 Apr 2016 16:44:13 +0200
Message-ID: <10639671.xGDtp1R8bk@wuerfel>
In-Reply-To: <5714DB37.7000907@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com> <CAKc_7PWw5VaPxcOpWbonksx6k4W5fe9yO8wBfigXNRkFAYAYEg@mail.gmail.com> <5714DB37.7000907@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 18 April 2016 15:03:51 Tomasz Nowicki wrote:
> On 16.04.2016 16:36, Jayachandran C wrote:
> > On Sat, Apr 16, 2016 at 1:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Saturday 16 April 2016 12:50:13 Jayachandran C wrote:
> > The whole pci-thunder-*.c is to support thunder PCI quirks since the
> > generic OF is handled by pci-host-common.c and generic ECAM is now
> > separated -  duplicating the whole file for ACPI will be bad.
> 
> Yes, it would be too much code duplication. Also, we already know 
> drivers which need quirks.
> 
> We really need to agree on best approach here. Here are requirements 
> which came up (please correct me if misunderstood sth):
> 
> Arnd:
> 1. Initial DT driver should be standalone [Arnd]
> 2. No exported symbols [Arnd]
> 3. Duplicate necessary code to ACPI framework.

Correct.

> JC:
> 1. Adding linker section is wrong.
> 2. Quirks should be exported (pci_thunder_ecam_ops), then no need for 
> adding linker section
> 3. To much duplication to copy code into the ACPI framework.
> 
> My opinion:
> 1. I like linker section because it is easy to maintain and no need to 
> export symbols.
> 2. We need more sophisticated algorithm for matching quirks (DMI is not 
> enough and not only for ThunderX drivers). Of course I am open to any 
> new suggestions.

Agreed.

> 3. To much duplication to copy code into the ACPI framework.
> 
> Thanks in advance for any pointers.

Can you be more specific about what code actually would need to
be duplicated? Anything besides the config space operations?

	Arnd
