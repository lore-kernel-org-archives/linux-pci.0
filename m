Return-Path: <SRS0=Jw/T=XQ=redhat.com=jcm@kernel.org>
Return-Path: <SRS0=Jw/T=XQ=redhat.com=jcm@kernel.org>
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe
 controller
To: Mark Salter <msalter@redhat.com>, Duc Dang <dhdang@apm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <1480549373-2123-1-git-send-email-dhdang@apm.com>
 <1480604901.4751.17.camel@redhat.com>
Cc: Rafael Wysocki <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann
 <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, patches <patches@apm.com>
From: Jon Masters <jcm@redhat.com>
Message-ID: <f4b949c0-f992-b0fb-5f23-f71cb1f9713e@redhat.com>
Date: Thu, 1 Dec 2016 14:17:04 -0500
MIME-Version: 1.0
In-Reply-To: <1480604901.4751.17.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 12/01/2016 10:08 AM, Mark Salter wrote:
> On Wed, 2016-11-30 at 15:42 -0800, Duc Dang wrote:

>> +static int xgene_v1_pcie_ecam_init(struct pci_config_window *cfg)
>> +{
>> +	struct acpi_device *adev = to_acpi_device(cfg->parent);
>> +	struct acpi_pci_root *root = acpi_driver_data(adev);
>> +	struct device *dev = cfg->parent;
>> +	struct xgene_pcie_port *port;
>> +	struct resource *csr;
>> +
>> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>> +	if (!port)
>> +		return -ENOMEM;
>> +
>> +	csr = &xgene_v1_csr_res[root->segment];
> 
> This hard-coded assumption that segment N uses controller N breaks
> for m400 where segment 0 is using controller 3.

This seems very fragile. So in addition to Bjorn's comment about not
trusting firmware provided data for the segment offset in the CSR list,
you will want to also determine the controller from the ACPI tree. The
existing code walks the ACPI hierarchy and finds the CSR that way.
Obviously, the goal is to avoid that in the latest incarnation, but you
could still determine which controller matches a given device.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
