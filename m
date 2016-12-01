Return-Path: <SRS0=hbVC=XQ=apm.com=dhdang@kernel.org>
Return-Path: <SRS0=hbVC=XQ=apm.com=dhdang@kernel.org>
MIME-Version: 1.0
In-Reply-To: <f4b949c0-f992-b0fb-5f23-f71cb1f9713e@redhat.com>
References: <1480549373-2123-1-git-send-email-dhdang@apm.com>
 <1480604901.4751.17.camel@redhat.com> <f4b949c0-f992-b0fb-5f23-f71cb1f9713e@redhat.com>
From: Duc Dang <dhdang@apm.com>
Date: Thu, 1 Dec 2016 11:58:12 -0800
Message-ID: <CADaLNDnZfob-4p5U-estW8mGCDhma_vJqxS3zbDdq8brvokhAA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe controller
To: Jon Masters <jcm@redhat.com>
Cc: Mark Salter <msalter@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Rafael Wysocki <rafael@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomasz Nowicki <tn@semihalf.com>,
	patches <patches@apm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 1, 2016 at 11:17 AM, Jon Masters <jcm@redhat.com> wrote:
> On 12/01/2016 10:08 AM, Mark Salter wrote:
>> On Wed, 2016-11-30 at 15:42 -0800, Duc Dang wrote:
>
>>> +static int xgene_v1_pcie_ecam_init(struct pci_config_window *cfg)
>>> +{
>>> +    struct acpi_device *adev = to_acpi_device(cfg->parent);
>>> +    struct acpi_pci_root *root = acpi_driver_data(adev);
>>> +    struct device *dev = cfg->parent;
>>> +    struct xgene_pcie_port *port;
>>> +    struct resource *csr;
>>> +
>>> +    port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>>> +    if (!port)
>>> +            return -ENOMEM;
>>> +
>>> +    csr = &xgene_v1_csr_res[root->segment];
>>
>> This hard-coded assumption that segment N uses controller N breaks
>> for m400 where segment 0 is using controller 3.

I think the latest firmware released from us a few months back use
segment 3 for PCIe controller 3 in MCFG table.
>
> This seems very fragile. So in addition to Bjorn's comment about not
> trusting firmware provided data for the segment offset in the CSR list,
> you will want to also determine the controller from the ACPI tree. The
> existing code walks the ACPI hierarchy and finds the CSR that way.
> Obviously, the goal is to avoid that in the latest incarnation, but you
> could still determine which controller matches a given device.

Yes, I will look into that more.

>
> Jon.
>
> --
> Computer Architect | Sent from my Fedora powered laptop
>
Regards,
Duc Dang.
