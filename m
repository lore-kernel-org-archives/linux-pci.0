Return-Path: <SRS0=Xauo=5S=oracle.com=james.puthukattukaran@kernel.org>
Return-Path: <SRS0=Xauo=5S=oracle.com=james.puthukattukaran@kernel.org>
Subject: Re: [PATCH v3] PCI: Workaround wrong flags completions for IDT switch
To: Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
References: <20170609231617.20243-1-yinghai@kernel.org>
 <20170612214848.GC28578@bhelgaas-glaptop.roam.corp.google.com>
 <CAE9FiQU_Hfsn-_tJSQ2NbqMV-rtaiFsX1FWfe_fADbd8TnKhBA@mail.gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: james puthukattukaran <james.puthukattukaran@oracle.com>
Message-ID: <8e04aa73-8fe0-d1ac-208b-3f8fa4b04c4b@oracle.com>
Date: Tue, 13 Jun 2017 14:30:55 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQU_Hfsn-_tJSQ2NbqMV-rtaiFsX1FWfe_fADbd8TnKhBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 6/13/2017 1:00 PM, Yinghai Lu wrote:
> On Mon, Jun 12, 2017 at 2:48 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Fri, Jun 09, 2017 at 04:16:17PM -0700, Yinghai Lu wrote:
>>> From: James Puthukattukaran <james.puthukattukaran@oracle.com>
>>>
>>> The IDT switch incorrectly flags an ACS source violation on a read config
>>> request to an end point device on the completion (IDT 89H32H8G3-YC,
>>> errata #36) even though the PCI Express spec states that completions are
>>> never affected by ACS source violation (PCI Spec 3.1, Section 6.12.1.1).
>> Can you include a URL where this erratum is published?  If not, can
>> you include the actual erratum text here?
> Ok.

Here's the errata text
------------------------------------
Item #36 - Downstream port applies ACS Source Validation to Completions
“Section 6.12.1.1" of the PCI Express Base Specification 3.1 states that 
completions are never affected
by ACS Source Validation. However, completions received by a downstream 
port of the PCIe switch from a device that has not yet captured a PCIe 
bus number are incorrectly dropped by ACS source validation by the 
switch downstream port.

Workaround: Issue a CfgWr1 to the downstream device before issuing the 
first CfgRd1 to the device.
This allows the downstream device to capture its bus number; ACS source 
validation no longer stops
completions from being forwarded by the downstream port. It has been 
observed that Microsoft Windows implements this workaround already; 
however, some versions of Linux and other operating systems may not.
--------------------------------------------

>> Have you considered ways to make this patch apply only to the affected
>> IDT switches?  Currently it applies to *all* devices.
> But we need to apply that workaround before we know vendorid/deviceid
> under that root port or downstream port.
>
>> The purpose of the pci_bus_read_dev_vendor_id() path is to support the
>> Configuration Request Retry Status feature (see PCIe r3.1, sec 2.3.2),
>> which works by special handling of config reads of the Vendor ID after
>> a reset.  Normally, that Vendor ID read would be the first access to
>> a device when we enumerate it.
>>
>> This patch adds config reads and writes of the ACS capability *before*
>> the Vendor ID read.  At that point we don't even know whether the
>> device exists.  If it doesn't exist, pci_find_ext_capability() would
>> read 0xffffffff data, and it probably fails reasonably gracefully.
>>
>> But if the device *does* exist, I think this patch breaks the CRS
>> Software Visibility feature.  Without this patch, we try to read
>> Vendor ID, and the device may return a CRS Completion Status.  If CRS
>> visibility is enabled, the root complex may complete the request by
>> returning 0x0001 for the Vendor ID, in which case we sleep and try
>> again later.
>>
>> With this patch, we first try to read the ACS capability.  If the
>> device returns a CRS Completion Status, the root complex is required
>> to reissue the config request.  This is the required behavior
>> regardless of whether CRS Software Visibility is enabled, so I think
>> this effectively disables that feature.
> The workaround (acs reading etc) is applied to root port or downstream port.
> and pci_bus_read_dev_vendor_id() is for reading vendorid of device
> under that root port or downstream port.
>
> Thanks
>
> Yinghai
