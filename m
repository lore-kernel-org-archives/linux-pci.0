Return-Path: <SRS0=kec7=JO=gmail.com=alexdeucher@kernel.org>
Return-Path: <SRS0=kec7=JO=gmail.com=alexdeucher@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180628134221.GC90450@bhelgaas-glaptop.roam.corp.google.com>
References: <20180625210606.2736-1-alexander.deucher@amd.com>
 <20180625210606.2736-2-alexander.deucher@amd.com> <20180628134221.GC90450@bhelgaas-glaptop.roam.corp.google.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Jun 2018 10:19:41 -0400
Message-ID: <CADnq5_OMmcbKsWQ3QfuMKYOxhrZZxOCs4YTN+Pyf7zuy43ypyA@mail.gmail.com>
Subject: Re: [PATCH 1/5] pci: export pcie_get_speed_cap and pcie_get_width_cap
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
	Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>,
	Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 28, 2018 at 9:42 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Jun 25, 2018 at 04:06:02PM -0500, Alex Deucher wrote:
>> So drivers can use them.  This can be used to replace
>> duplicate code in the drm subsystem.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Thanks a lot for doing this!
>
> If you haven't applied these yet, please
>
>   s/pci: export/PCI: Export/
>
> in the subject.


Will fix.  Any objections to taking this via the drm tree?

Thanks,

Alex

>
>> ---
>>  drivers/pci/pci.c   | 2 ++
>>  include/linux/pci.h | 3 +++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 97acba712e4e..22adaf35b136 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5222,6 +5222,7 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
>>
>>       return PCI_SPEED_UNKNOWN;
>>  }
>> +EXPORT_SYMBOL(pcie_get_speed_cap);
>>
>>  /**
>>   * pcie_get_width_cap - query for the PCI device's link width capability
>> @@ -5240,6 +5241,7 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
>>
>>       return PCIE_LNK_WIDTH_UNKNOWN;
>>  }
>> +EXPORT_SYMBOL(pcie_get_width_cap);
>>
>>  /**
>>   * pcie_bandwidth_capable - calculate a PCI device's link bandwidth capability
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 340029b2fb38..6e0c0803b241 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -261,6 +261,9 @@ enum pci_bus_speed {
>>       PCI_SPEED_UNKNOWN               = 0xff,
>>  };
>>
>> +enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
>> +enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
>> +
>>  struct pci_cap_saved_data {
>>       u16             cap_nr;
>>       bool            cap_extended;
>> --
>> 2.13.6
>>
