Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554304;
	b=bth0Cq5TT5FTTThB5jSqOc7AN0vQk/M+0tEakrmq53Z8do/HyvFstmC/D510+hPYGASY
	 hhdWChGWm1gxPQY1rNEKT29tE/VM26Z3DGL+1zbOgw2pWbwruoBqV6Nhu5J4N4aqVY0bU
	 dgtwNMBM0H74wVcQVma2cgfkBCwtBjbOIkFFQFMTB4uRM0/T5hwBlmgItIOef6NCIJpow
	 80FpuBLoAsxgM3yzQ4oixr7SeMSdUpZwbiuOwJgCZ6agC+0pmnWaXQNGVFM5/qQFBxQo/
	 An9hDRJNuiaQGv9RC14AI9G611uhRvKalq0HutHNgyI11mnqkPbOCOPlPmvuVJpegJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8989DAIhEGp2+SqiqOgHbnDP3tqjvddGwcJYPtRttbc=;
	b=48JdDybBtT72FEDc+cKUBKc3FKsfvdnLjuUYcdYJ24Wp9YdpfA4oTZQk8rUP9kFQMBwg
	 8y0vOz8fmShLrRfWrwXdV0ZBw+N/WaNq324a/WAS+J0UNG1pTMi7lT9y1CdpnxoamC94t
	 5+oVUNsYoZ3UaCarnkBYo62Zxg5s6pzcJ7cpU+5l2hc6nrOxc1sHODimVzc1vxxywHpFP
	 /nBR6uHA/6t3Cu/8lTZPVsgb68NYxmJ6KTyA+2JY3/Kc6RDxkT9D5QJ3XRqpCaEIT9bI0
	 pC2vfowEwVbgf6wA+zZMZoV33+sKZ8Rjo6DovSYQ/HDsBo0wp9tx9tSkZXflNCrmBUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Zk43yelt;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B77D606A31E
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 21:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B77D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Zk43yelt
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2f0afdb97abso150485ad.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 13:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795554304; x=1796159104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8989DAIhEGp2+SqiqOgHbnDP3tqjvddGwcJYPtRttbc=;
        b=Zk43yelt/tm8w8qrnUw/rYu8FoZfnG9Xcmo++SabJlb6abZbjfVjnfXI9XBZw/hv16
         t9J8gTLH1sX5tjg/It/0QBr2WzKZaY4XroMeHNijrqAwKoXlcMeh8MCUjdw4+fKdt+md
         RJ362duEdbPSO3k5gsNh20PW+bipuMnBbFmth+eRATzNg7Dyn1iPORbToeVVtiu2b6AI
         hm4eeLQByAl4SS2/bYpWwJkDm00JSFY4WW83me9on7ZD4LR2C0L+7ip0ebIuUjbEEJKB
         R3YRFTxd2ka1it3eIloE22crT1tiIze58b8gMdGr/dFPC5uLraumWlzqrK3w/8ZePRfc
         zyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554304; x=1796159104;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8989DAIhEGp2+SqiqOgHbnDP3tqjvddGwcJYPtRttbc=;
        b=ooBgUt8YkfsGYVM7WJsi+7HRftV39WxgsKVJFuEH3kaKtIbAx2rZZmUbCAzW0oa0ij
         /dalNZr4Ek4pyHrcnnqxsBhf96zcp+jNFI5XQHuNY5dAg41d06E2OZVYbEq5ZPjgoOu9
         /4j5acBbe8ODvxRaJ9HYDmMEUstVdV8aAbjJuzpNEOFmLzDx0sgjy3M49uioHEDKp4VB
         sHq7LvRaxqUJaf+UMqvUgz+Kp4Zigp32bojfOSA04UOk0rWoUSniHhN9PFP53OuzMJvQ
         QUwKaxGzcKNtyNdIcDFvFgwQuese5W/niSCnZreQQHc0EuUOCNVf5m+9gH5yjSJPTeSt
         Lq4w==
X-Forwarded-Encrypted: i=1; AL+hErGRs15DvsiP56UVNjtVovTyqrjOYcm8y0hNJXrkE7WZIGS4cD9A2EQPtix1wHOraYbMC+7sWIg414Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z97SLB76TweIHEXksC2KCywhgE612XZkM3wGdSftZqSKLSmG5Ii
	IlgV/eFmWgfjAiaRuia3utNWh98grHlfbBkp/uVI5XrzpxSKG66KdlqiLV0Ky8huVA==
X-Gm-Gg: AZFdTZcB65nzfYiXrmv0nbAlqSIBG5scL6ghVcKRJcx0siPieYpv2DVvp/oljQ9msn2
	f31JoWrmwLhk+QPBXwkwLOsREBNsh/BJoxd14jIPZvDqE401xyYLCPTpqKRJQ2XB2q5Nz4gaAPu
	NlwPXB3EJsyU2WqpwIJazrJnztug7W8g6HQbZ4q6GEf8O9m6GeDj5C1FHB8MbSJOKIQt1n8BHbQ
	wrJJaZQO0eZYUwpd2lLeOonmyUTCAFzWi7bfeD8kHA+Fi4pZw/sNRsdY3YIco0Pz1oggahCQwMe
	87rH3ZIh0qiW6kOXR67dmYW9IKQ86dyM8M8LKZz091SVqMvf2uN6HB2SfZdK5u7stOJ1l6uddsb
	+74pxbajkRFso3TQxhysHyBm8UhW/pJ8tp9gPWNtMl8uqobCJmuwSLKNffkeyPWFjYY3EvgHpo5
	O0rUJvQQ2Aow3ETFMojOeL6barNxcx392k5MQNTPlqXrf6zqWTpMk68fx3UJyE4vGVVnMLMaUsl
	ApFyNBeRnKbY+NCtN4nhPck3sVaMW6FqMSSFCvn3gDZyirzaZRSRpSrSDwYurl9qrVe0P3YqMEu
	h1PB3kEc6feL519PoJrwUONiGuKW4cqTzqw6lH1WUc75vVmi+Y4hLqbsuUpCKXML9bTYeCei6UZ
	ogNUm0zNmsc1ju7A8NXvAew==
X-Received: by 2002:a17:903:3887:b0:2e2:d665:6ad8 with SMTP id d9443c01a7336-2f062b6ecb2mr14518045ad.4.1795554303196;
        Tue, 24 Nov 2026 13:05:03 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm25196583a91.1.2026.11.24.13.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:05:00 -0800 (PST)
Date: Tue, 24 Nov 2026 21:04:57 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Anthony Pighin <anthony.pighin@nokia.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>, kvm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Only lock the upstream bridge if the reset may
 need it
Message-ID: <awXedVCoT7M79Rk5@google.com>
References: <20261112235700.2029562-1-skhawaja@google.com>
 <20261118163706.7138d246@shazbot.org>
 <20261119143237.4bf54796@shazbot.org>
 <awC5Ldqmue6DiO44@google.com>
 <20261124084852.661dd7c1@shazbot.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261124084852.661dd7c1@shazbot.org>

On Tue, Nov 24, 2026 at 08:48:52AM -0700, Alex Williamson wrote:
>On Fri, 20 Nov 2026 22:21:16 +0000
>Samiullah Khawaja <skhawaja@google.com> wrote:
>
>> On Thu, Nov 19, 2026 at 02:32:37PM -0800, Alex Williamson wrote:
>> >On Wed, 18 Nov 2026 16:37:06 -0800
>> >Alex Williamson <alex@shazbot.org> wrote:
>> >
>> >> On Thu, 12 Nov 2026 23:57:00 +0000
>> >> Samiullah Khawaja <skhawaja@google.com> wrote:
>> >>
>> >> > Commit 962ae6892d8b ("vfio/pci: Lock upstream bridge for
>> >> > vfio_pci_core_disable()") makes vfio_pci_core_disable() trylock the
>> >> > upstream bridge before resetting the device, and skips the reset if the
>> >> > trylock fails.
>> >> >
>> >> > All VFs of a PF have the same upstream bridge. Take a device with two
>> >> > VFs, both used by one process. When the process is killed, both VFs can
>> >> > be released at the same time. The first one takes the bridge lock and
>> >> > does its FLR, the second one fails the trylock and is never reset.
>> >> >
>> >> > The bridge lock is only needed for a bus reset, which is done through
>> >> > the bridge. A VF is reset with FLR, and pci_parent_bus_reset() never
>> >> > resets the bus for it because the PF and the other VFs are on the same
>> >> > bus.
>> >> >
>> >> > Add pci_reset_needs_bridge_lock(), which returns true if any reset
>> >> > method enabled for the device is a bus reset, and only lock the bridge
>> >> > in vfio_pci_core_disable() when it does.
>> >> >
>> >> > Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
>> >> > Cc: stable@vger.kernel.org
>> >> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> >> > ---
>> >> > Tested in QEMU with an igb PF behind a PCIe root port, bound to vfio-pci
>> >> > with two VFs. Both VFs are opened through VFIO and then closed from two
>> >> > threads at the same time, counting FLRs with a kprobe on pcie_flr().
>> >> > Without this patch one VF missed its FLR in 50 of 50 rounds, with it
>> >> > both VFs were reset in every round. I will send a VFIO selftest for this
>> >> > separately.
>> >> > ---
>> >> >  drivers/pci/pci.c                | 28 ++++++++++++++++++++++++++++
>> >> >  drivers/vfio/pci/vfio_pci_core.c |  3 ++-
>> >> >  include/linux/pci.h              |  1 +
>> >> >  3 files changed, 31 insertions(+), 1 deletion(-)
>> >> >
>>
>> [snip]
>>
>> >> > +
>> >> > +		if (pci_reset_fn_methods[m].reset_fn == pci_reset_bus_function ||
>> >> > +		    pci_reset_fn_methods[m].reset_fn == cxl_reset_bus_function)
>> >>
>> >> This looks like a maintenance nightmare.  What if instead we did
>> >> something like:
>> >>
>> >> bool pci_parent_bus_reset_possible(struct pci_dev *dev)
>> >> {
>> >> 	struct pci_dev *pdev;
>> >>
>> >> 	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
>> >> 	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
>> >> 		return false;
>> >>
>> >> 	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
>> >> 		if (pdev != dev)
>> >> 			return false;
>> >>
>> >> 	return true;
>> >> }
>> >> EXPORT_SYMBOL_GPL(pci_parent_bus_reset_possible);
>> >>
>> >> static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
>> >> {
>> >> 	if (!pci_parent_bus_reset_possible(dev))
>> >> 		return -ENOTTY;
>> >>
>> >> 	if (probe)
>> >> 		return 0;
>> >>
>> >> 	return pci_bridge_secondary_bus_reset(dev->bus->self);
>> >> }
>> >>
>> >> Where we'd then condition acquiring the bridge lock on whether it's
>> >> even possible for a function scoped reset to perform a bus reset.
>> >>
>> >> It's a bit broader of a test than whether we actually have the necessary
>> >> methods in our reset_fn list, but since we're not locking the reset_fn
>> >> list between test and function-reset, it's also safer.  Thanks,
>> >
>> >After exploring Ionut's patch[1], what I propose above is probably
>> >wrong.  We don't have any guarantees that the sibling topology is
>> >static and this bus-reset-possible function presents it as immutable.
>> >The existing bus-reset function has the same race, but the gap is
>> >smaller, let's not make it bigger.
>> >
>> >There are however immutable properties we can test that cover a fair
>> >number of cases.  For example:
>> >
>> >bool pci_reset_function_needs_bridge_lock(struct pci_dev *dev)
>> >{
>> >	return pci_upstream_bridge(dev) &&
>> >		!(dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET) && !dev->is_virtfn;
>> >}
>> >EXPORT_SYMBOL_GPL(pci_reset_function_needs_bridge_lock);
>> >
>> >We should be able to use this as a condition on whether we acquire the
>> >bridge device lock, in pci_reset_function() and in vfio-pci code.
>> >Thanks,
>>
>> This sounds good and it will also fix the bug that I am seeing.
>>
>> The only caveat is that pci_dev_wait() might fail during VF reset and
>> then it might try to do a bus reset if the VF is behind a pciehp or CXL
>> port. I would prefer to do it only for vfio-pci code as that is where
>> the reset skip issue is. pci_reset_function() takes the lock and
>> serializes the VF reset. Are you ok with doing it just for vfio-pci?
>
>I think the test I'm proposing precludes a bus reset, ie. there is no
>upstream bridge, the device flags prevent it, or we're provided with a
>VF.  It's only those cases where we can't do a bus reset anyway, that
>we can skip the bridge device lock.  I think that means it's useful in
>PCI-core as well as vfio-pci.  Did I miss something?

Yes, the slot reset probe doesn't account for the VFs and will allow
reset of the slot when hotplug is enabled.

I think that is probably a fix that needs to be done orthogonal to this.
I will send a v2 of this by doing the needs_bridge_lock() as you
mentioned above.

>
>I do see that cxl_reset_bus_function() only does a cursory test for
>probe, but then calls pci_reset_bus_function() when it executes, which
>is an inconsistency issue of its own.  Thanks,
>
>Alex

Thanks,
Sami
