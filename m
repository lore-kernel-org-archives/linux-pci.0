Return-Path: <ray.jui@broadcom.com>
Return-Path: <ray.jui@broadcom.com>
Subject: Re: [PATCH v2 04/12] PCI: iproc: Fix exception with multi-function
 devices
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1477960721-17649-1-git-send-email-ray.jui@broadcom.com>
 <1477960721-17649-5-git-send-email-ray.jui@broadcom.com>
 <20161114215208.GF9868@bhelgaas-glaptop.roam.corp.google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 Alex Barba <alex.barba@broadcom.com>, Oza Oza <oza.oza@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <f5ffb92a-f726-2e00-d6ed-c128a5987e93@broadcom.com>
Date: Mon, 14 Nov 2016 19:39:14 -0800
MIME-Version: 1.0
In-Reply-To: <20161114215208.GF9868@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 11/14/2016 1:52 PM, Bjorn Helgaas wrote:
> On Mon, Oct 31, 2016 at 05:38:33PM -0700, Ray Jui wrote:

[...]

>>  drivers/pci/host/pcie-iproc.c | 58 +++++++++++++++++++++++++++++++++++++++++--
>>  drivers/pci/host/pcie-iproc.h |  3 +++
>>  2 files changed, 59 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
>> index f3b3340..07ec478 100644
>> --- a/drivers/pci/host/pcie-iproc.c
>> +++ b/drivers/pci/host/pcie-iproc.c

[...]

>> +static int iproc_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
>> +				    int where, int size, u32 *val)
>> +{
>> +	int ret;
>> +
>> +	iproc_pcie_apb_err_disable(bus, true);
>> +	ret = pci_generic_config_read32(bus, devfn, where, size, val);
>> +	iproc_pcie_apb_err_disable(bus, false);
> 
> I guess this means that any other APB errors (unrelated to this config
> access, e.g., a driver doing MMIo to a device at the same time the user is
> doing "lspci") that happen to occur during this window will also be
> ignored.
> 

I believe this only disables APB errors caused by unsupported request
generated from PCIe.

Thanks,

Ray
