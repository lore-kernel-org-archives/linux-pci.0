Return-Path: <robh@kernel.org>
Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180518214211.GD41790@bhelgaas-glaptop.roam.corp.google.com>
References: <20180405193154.27897-1-robh@kernel.org> <20180518214211.GD41790@bhelgaas-glaptop.roam.corp.google.com>
From: Rob Herring <robh@kernel.org>
Date: Sat, 19 May 2018 14:22:27 -0500
Message-ID: <CAL_Jsq+83D37Hj5bZ8ZamPnX6AYNd+QvFJEwWK+D=mWQ+QK+=Q@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: improve host drivers compile test coverage
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Scott Branden <scott.branden@broadcom.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 18, 2018 at 4:42 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Hi Rob,
>
> On Thu, Apr 05, 2018 at 02:31:54PM -0500, Rob Herring wrote:
>> Add COMPILE_TEST on driver config options with it. Some ARM drivers
>> still have arch dependencies, so we have to keep those dependent on ARM.
>>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
>> Signed-off-by: Rob Herring <robh@kernel.org>
>
>>  config PCIE_ALTERA
>>       bool "Altera PCIe controller"
>> -     depends on ARM || NIOS2
>> -     depends on OF_PCI
>> +     depends on ARM || NIOS2 || COMPILE_TEST
>
> Did you intend to drop the OF_PCI dependency?

No, that should have been removed when OF_PCI was in commit
4670d610d592 ("PCI: Move OF-related PCI functions into PCI core").

> I see that CONFIG_OF_PCI doesn't exist, so that looks bogus.
>
> But drivers/pci/host/pcie-altera.c still uses
> devm_of_pci_get_host_bridge_resources(), so I think this should probably
> still depend on CONFIG_OF?

There's an empty version so it shouldn't matter.

Rob
