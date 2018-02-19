Return-Path: <SRS0=AA+w=FN=intel.com=jani.nikula@kernel.org>
Return-Path: <SRS0=AA+w=FN=intel.com=jani.nikula@kernel.org>
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, "open list\:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3 09/29] drm/i915: deprecate pci_get_bus_and_slot()
In-Reply-To: <20180216145444.GA11014@bhelgaas-glaptop.roam.corp.google.com>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org> <1511801886-6753-10-git-send-email-okaya@codeaurora.org> <20180216145444.GA11014@bhelgaas-glaptop.roam.corp.google.com>
Date: Mon, 19 Feb 2018 11:34:34 +0200
Message-ID: <87bmglb9w5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

On Fri, 16 Feb 2018, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Nov 27, 2017 at 11:57:46AM -0500, Sinan Kaya wrote:
>> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
>> where a PCI device is present. This restricts the device drivers to be
>> reused for other domain numbers.
>> 
>> Getting ready to remove pci_get_bus_and_slot() function in favor of
>> pci_get_domain_bus_and_slot().
>> 
>> Extract the domain number from drm_device and pass it into
>> pci_get_domain_bus_and_slot() function.
>> 
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>
> I don't know what happened to this, and it didn't make it into
> v4.16-rc1.  I applied it to pci/deprecate-get-bus-and-slot for v4.17
> along with the patch that actually removes pci_get_bus_and_slot().

It fell between the cracks as we couldn't apply it before getting a
backmerge on the dependency. Sorry about that.

Ack for merging through your tree.

Thanks,
Jani.


>
>> ---
>>  drivers/gpu/drm/i915/i915_drv.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
>> index 9f45cfe..5a8cb79 100644
>> --- a/drivers/gpu/drm/i915/i915_drv.c
>> +++ b/drivers/gpu/drm/i915/i915_drv.c
>> @@ -419,7 +419,10 @@ static int i915_getparam(struct drm_device *dev, void *data,
>>  
>>  static int i915_get_bridge_dev(struct drm_i915_private *dev_priv)
>>  {
>> -	dev_priv->bridge_dev = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
>> +	int domain = pci_domain_nr(dev_priv->drm.pdev->bus);
>> +
>> +	dev_priv->bridge_dev =
>> +		pci_get_domain_bus_and_slot(domain, 0, PCI_DEVFN(0, 0));
>>  	if (!dev_priv->bridge_dev) {
>>  		DRM_ERROR("bridge device not found\n");
>>  		return -1;
>> -- 
>> 1.9.1
>> 
>> 
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Jani Nikula, Intel Open Source Technology Center
