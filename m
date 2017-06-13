Return-Path: <SRS0=Gfpc=5S=gmail.com=yhlu.kernel@kernel.org>
Return-Path: <SRS0=Gfpc=5S=gmail.com=yhlu.kernel@kernel.org>
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <20170612214848.GC28578@bhelgaas-glaptop.roam.corp.google.com>
References: <20170609231617.20243-1-yinghai@kernel.org> <20170612214848.GC28578@bhelgaas-glaptop.roam.corp.google.com>
From: Yinghai Lu <yinghai@kernel.org>
Date: Tue, 13 Jun 2017 10:00:33 -0700
Message-ID: <CAE9FiQU_Hfsn-_tJSQ2NbqMV-rtaiFsX1FWfe_fADbd8TnKhBA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Workaround wrong flags completions for IDT switch
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	James Puthukattukaran <james.puthukattukaran@oracle.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 12, 2017 at 2:48 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Jun 09, 2017 at 04:16:17PM -0700, Yinghai Lu wrote:
>> From: James Puthukattukaran <james.puthukattukaran@oracle.com>
>>
>> The IDT switch incorrectly flags an ACS source violation on a read config
>> request to an end point device on the completion (IDT 89H32H8G3-YC,
>> errata #36) even though the PCI Express spec states that completions are
>> never affected by ACS source violation (PCI Spec 3.1, Section 6.12.1.1).
>
> Can you include a URL where this erratum is published?  If not, can
> you include the actual erratum text here?

Ok.

>
> Have you considered ways to make this patch apply only to the affected
> IDT switches?  Currently it applies to *all* devices.

But we need to apply that workaround before we know vendorid/deviceid
under that root port or downstream port.

>
> The purpose of the pci_bus_read_dev_vendor_id() path is to support the
> Configuration Request Retry Status feature (see PCIe r3.1, sec 2.3.2),
> which works by special handling of config reads of the Vendor ID after
> a reset.  Normally, that Vendor ID read would be the first access to
> a device when we enumerate it.
>
> This patch adds config reads and writes of the ACS capability *before*
> the Vendor ID read.  At that point we don't even know whether the
> device exists.  If it doesn't exist, pci_find_ext_capability() would
> read 0xffffffff data, and it probably fails reasonably gracefully.
>
> But if the device *does* exist, I think this patch breaks the CRS
> Software Visibility feature.  Without this patch, we try to read
> Vendor ID, and the device may return a CRS Completion Status.  If CRS
> visibility is enabled, the root complex may complete the request by
> returning 0x0001 for the Vendor ID, in which case we sleep and try
> again later.
>
> With this patch, we first try to read the ACS capability.  If the
> device returns a CRS Completion Status, the root complex is required
> to reissue the config request.  This is the required behavior
> regardless of whether CRS Software Visibility is enabled, so I think
> this effectively disables that feature.

The workaround (acs reading etc) is applied to root port or downstream port.
and pci_bus_read_dev_vendor_id() is for reading vendorid of device
under that root port or downstream port.

Thanks

Yinghai
