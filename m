Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:35503 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751249AbdKVTur (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Nov 2017 14:50:47 -0500
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Sinan Kaya <okaya@codeaurora.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 09/30] drm/i915: deprecate pci_get_bus_and_slot()
In-Reply-To: <4541eaef-745a-e78f-e61d-1c7c207b551e@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org> <1511328675-21981-10-git-send-email-okaya@codeaurora.org> <1511337146.4512.6.camel@linux.intel.com> <4541eaef-745a-e78f-e61d-1c7c207b551e@codeaurora.org>
Date: Wed, 22 Nov 2017 21:50:42 +0200
Message-ID: <87o9nut7n1.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 22 Nov 2017, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 11/22/2017 2:52 AM, Joonas Lahtinen wrote:
>> Dropping the extra mailing lists and Dave, this is a rather trivial thing.
>> 
>> On Wed, 2017-11-22 at 00:30 -0500, Sinan Kaya wrote:
>>> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
>>> where a PCI device is present. This restricts the device drivers to be
>>> reused for other domain numbers.
>>>
>>> Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
>>> extract the domain number. Other places, use the actual domain number from
>>> the device.
>>>
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> 
>> <SNIP>
>> 
>>> +++ b/drivers/gpu/drm/i915/i915_drv.c
>>> @@ -419,7 +419,9 @@ static int i915_getparam(struct drm_device *dev, void *data,
>>>  
>>>  static int i915_get_bridge_dev(struct drm_i915_private *dev_priv)
>>>  {
>>> -	dev_priv->bridge_dev = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
>>> +	uint16_t devfn = PCI_DEVFN(0, 0)
>> 
>> The would have to be "unsigned int" according to the function
>> signature.
>
> Even though the return value is unsigned int, PCI_DEVFN cannot be bigger
> than 16 bits. 
>
> http://elixir.free-electrons.com/linux/v4.14.1/source/include/uapi/linux/pci.h#L31
>
> /*
>  * The PCI interface treats multi-function devices as independent
>  * devices.  The slot/function address of each device is encoded
>  * in a single byte as follows:
>  *
>  *	7:3 = slot
>  *	2:0 = function
>  */
>
> It is common practice to use u16 for keeping devfn information in the
> kernel.
>
>> 
>>> +
>>> +	dev_priv->bridge_dev = pci_get_domain_bus_and_slot(0, 0, devfn);
>> 
>> But the most straightforward change is to simply convert to:
>> 
>> 	dev_priv->bridge_dev = pci_get_domain_bus_and_slot(0, 0,
>> 							   PCI_DEVFN(0, 0));
>> 
>> Can you please resend like that.
>
> I did this at the beginning and but, I hit a checkpatch problem with
> more than 80 characters. That's why, I moved the devfn value assignment
> to a different line.

Please ignore checkpatch when it makes the code worse. 80 is not a
strict limit.

BR,
Jani.


>
>> 
>> Looks like this is a part of abigger series, so others may prefer
>> latter form too, to avoid the variable.
>> 
>> Regards, Joonas
>> 

-- 
Jani Nikula, Intel Open Source Technology Center
