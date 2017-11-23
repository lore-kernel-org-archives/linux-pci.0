Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21376 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751326AbdKWHmm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Nov 2017 02:42:42 -0500
Message-ID: <1511422959.4641.5.camel@linux.intel.com>
Subject: Re: [PATCH 09/30] drm/i915: deprecate pci_get_bus_and_slot()
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        timur@codeaurora.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Date: Thu, 23 Nov 2017 09:42:39 +0200
In-Reply-To: <4541eaef-745a-e78f-e61d-1c7c207b551e@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
         <1511328675-21981-10-git-send-email-okaya@codeaurora.org>
         <1511337146.4512.6.camel@linux.intel.com>
         <4541eaef-745a-e78f-e61d-1c7c207b551e@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2017-11-22 at 11:28 -0500, Sinan Kaya wrote:
> On 11/22/2017 2:52 AM, Joonas Lahtinen wrote:
> > Dropping the extra mailing lists and Dave, this is a rather trivial thing.
> > 
> > On Wed, 2017-11-22 at 00:30 -0500, Sinan Kaya wrote:
> > > pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> > > where a PCI device is present. This restricts the device drivers to be
> > > reused for other domain numbers.
> > > 
> > > Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
> > > extract the domain number. Other places, use the actual domain number from
> > > the device.
> > > 
> > > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> > 
> > <SNIP>
> > 
> > > +++ b/drivers/gpu/drm/i915/i915_drv.c
> > > @@ -419,7 +419,9 @@ static int i915_getparam(struct drm_device *dev, void *data,
> > >  
> > >  static int i915_get_bridge_dev(struct drm_i915_private *dev_priv)
> > >  {
> > > -	dev_priv->bridge_dev = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
> > > +	uint16_t devfn = PCI_DEVFN(0, 0)
> > 
> > The would have to be "unsigned int" according to the function
> > signature.
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

A quick run of 'git grep "PCI_DEVFN" | egrep "(uint|u)(16|32)"' vs.
'git grep "PCI_DEVFN" | grep "unsigned"' didn't indicate that. And
following the function signature would be the thing to do, unless there
is some compelling reason not to.

But it's not really relevant as a variable is not needed.

> > > +
> > > +	dev_priv->bridge_dev = pci_get_domain_bus_and_slot(0, 0, devfn);
> > 
> > But the most straightforward change is to simply convert to:
> > 
> > 	dev_priv->bridge_dev = pci_get_domain_bus_and_slot(0, 0,
> > 							   PCI_DEVFN(0, 0));
> > 
> > Can you please resend like that.
> 
> I did this at the beginning and but, I hit a checkpatch problem with
> more than 80 characters. That's why, I moved the devfn value assignment
> to a different line.

It is not longer than 80 characters when you break line before the
PCI_DEVFN like I proposed. Or you can break it after the "=", too,
either way works fine.

Regards, Joonas
-- 
Joonas Lahtinen
Open Source Technology Center
Intel Corporation
