Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hurNUOVDXpJJEJ5dCwWO_Fo+EdzBhXJA7QWmPeY653fQ@mail.gmail.com>
References: <1457504045-12738-1-git-send-email-airlied@gmail.com>
	<CAJZ5v0hurNUOVDXpJJEJ5dCwWO_Fo+EdzBhXJA7QWmPeY653fQ@mail.gmail.com>
Date: Thu, 10 Mar 2016 07:56:41 +1000
Message-ID: <CAPM=9tzAf=464v3uSjert7NVh35EXUG8iy_xEuR36NUMhdJSWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] vga_switcheroo: add power support for windows 10 machines.
From: Dave Airlie <airlied@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9 March 2016 at 23:19, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Mar 9, 2016 at 7:14 AM, Dave Airlie <airlied@gmail.com> wrote:
>> From: Dave Airlie <airlied@redhat.com>
>>
>> Windows 10 seems to have standardised power control for the
>> optimus/powerxpress laptops using PR3 power resource hooks.
>>
>> I'm not sure this is definitely the correct place to be
>> doing this, but it works for me here.
>>
>> The ACPI device for the GPU I have is \_SB_.PCI0.PEG_.VID_
>> but the power resource hooks are on \_SB_.PCI0.PEG_, so
>> this patch creates a new power domain to turn the GPU
>> device parent off using standard ACPI calls.
>>
>> Signed-off-by: Dave Airlie <airlied@redhat.com>
>> ---
>>  drivers/gpu/vga/vga_switcheroo.c | 54 +++++++++++++++++++++++++++++++++++++++-
>>  include/linux/vga_switcheroo.h   |  3 ++-
>>  2 files changed, 55 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
>> index 665ab9f..be32cb2 100644
>> --- a/drivers/gpu/vga/vga_switcheroo.c
>> +++ b/drivers/gpu/vga/vga_switcheroo.c
>> @@ -42,7 +42,7 @@
>>  #include <linux/uaccess.h>
>>  #include <linux/vgaarb.h>
>>  #include <linux/vga_switcheroo.h>
>> -
>> +#include <linux/acpi.h>
>>  /**
>>   * DOC: Overview
>>   *
>> @@ -997,3 +997,55 @@ vga_switcheroo_init_domain_pm_optimus_hdmi_audio(struct device *dev,
>>         return -EINVAL;
>>  }
>>  EXPORT_SYMBOL(vga_switcheroo_init_domain_pm_optimus_hdmi_audio);
>> +
>> +/* With Windows 10 the runtime suspend/resume can use power
>> +   resources on the parent device */
>> +static int vga_acpi_switcheroo_runtime_suspend(struct device *dev)
>> +{
>> +       struct pci_dev *pdev = to_pci_dev(dev);
>> +       int ret;
>> +       struct acpi_device *adev;
>> +
>> +       ret = dev->bus->pm->runtime_suspend(dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = acpi_bus_get_device(ACPI_HANDLE(&pdev->dev), &adev);
>
> You can use ACPI_COMPANION(&pdev->dev) for that.
>
>> +       if (!ret)
>> +               acpi_device_set_power(adev->parent, ACPI_STATE_D3_COLD);
>
> Won't that mess up with the PM of the parent?  Or do we know that the
> parent won't do its own PM?

The parent is always going to be pcieport. It doesn't seem to do any runtime PM,
I do wonder if pcieport should be doing it's own runtime PM handling,
but that is a
larger task than I'm thinking to tackle here. Maybe I should be doing

pci_set_power_state(pdev->bus->self, PCI_D3cold) ? I'm not really sure.

I'm guessing on Windows this all happens automatically.

Dave.
