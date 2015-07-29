Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADhT+wf2oYVZHn1XAODYJUsxwu03TAzN6ZEQCkSBjU5ruKWCDQ@mail.gmail.com>
References: <1438080345-7233-1-git-send-email-lftan@altera.com>
	<1438080345-7233-5-git-send-email-lftan@altera.com>
	<CADhT+wf2oYVZHn1XAODYJUsxwu03TAzN6ZEQCkSBjU5ruKWCDQ@mail.gmail.com>
Date: Wed, 29 Jul 2015 16:53:57 +0800
Message-ID: <CAFiDJ5-UebtEmj6vQ1Xn-eORDyJWtDVwOWz57XZtpq4GaYjDoQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] pci: altera: Add Altera PCIe MSI driver
From: Ley Foon Tan <lftan@altera.com>
To: Dinh Nguyen <dinh.linux@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	Linux List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 29, 2015 at 1:00 AM, Dinh Nguyen <dinh.linux@gmail.com> wrote:
> On Tue, Jul 28, 2015 at 5:45 AM, Ley Foon Tan <lftan@altera.com> wrote:
>> This patch adds Altera PCIe MSI driver. This soft IP supports configurable
>> number of vectors, which is a dts parameter.
>>
>> Signed-off-by: Ley Foon Tan <lftan@altera.com>
>> ---
>>  drivers/pci/host/Kconfig           |   7 +
>>  drivers/pci/host/Makefile          |   1 +
>>  drivers/pci/host/pcie-altera-msi.c | 318 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 326 insertions(+)
>>  create mode 100644 drivers/pci/host/pcie-altera-msi.c
>>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index af19039..a8b87fd 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -154,4 +154,11 @@ config PCIE_ALTERA
>>           Say Y here if you want to enable PCIe controller support for Altera
>>           SoCFPGA family of SoCs.
>>
>> +config PCIE_ALTERA_MSI
>> +       bool "Altera PCIe MSI feature"
>> +       depends on PCI_MSI && PCIE_ALTERA
>> +       help
>> +         Say Y here if you want PCIe MSI support for the Altera SocFPGA SoC.
>> +         This MSI driver supports Altera MSI to GIC controller IP.
>> +
>
> Couldn't this driver get combined with the pcie-altera driver?
Prefer to separate them, since they are 2 separate IPs.
Theoretically, this MSI driver can work with other PCIe host as well.

Thanks.

Regard
Ley Foon
