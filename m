Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213288;
	b=KLqcm6gLNyhBf4idZZ6TUXakE9gFQXedYkuKFCxtg1WPh6OYXX6XrpgT3WrVmYImYT23
	 x6YANn/jd1mxEVj1bd1X/7nzPxAGO4Fa3sTrLa12wzKDqZkSU8s+RoLDfUvxFZmBXODZN
	 YCnsnsmejLAtCLkLHkEXBNOWNcTBJvPkVAcsTmV1vriar8FjKi4PYhnHXRZMi2BTgOiu9
	 8TDyDQQjfB/UFUqiWR396lV7WQHHFVsbxQdaCheuCVN4tX62973IEmZ9CKl27EzqJb+VG
	 8XBrjrJMUxejCJ8BIxRJ0pM+U7gsvMt8OscztFBj5x6QXE4ZbCq0owK0XLM5H7lYmSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YWAHn2Sutfx4jyhpprq+KziM+rM4UEONRsPYaYW8qwc=;
	b=UJ9hkD3n7HXNUONcNW7bhZx4wmOKiaNLDrFFXj99YZUtt1/l8TmDpaq7731KpaqdH3AO
	 H/76CeBA5VV62VdpIwm7GaPoPuMsFXOgFFadwYZiSkkQgW1/tyBXtf9mFgydAAk8HUCXj
	 vej4MPtOWNKdYGuKklXgE5I+9/zh9JyyoKvVPtIqSbgl/8nQwR4/fVd6HzMZwIe+d3tWQ
	 OxOvl4VVCQ3ohwcKiHwlbbgEDdWHbEDwqEGwkFme+d61VQcJCcmw9MtUGITi3lIZ7/VAJ
	 kEJcyB1Ji/bE8hAuH96hYukYcB/JOnAPm8sIINEm7sBt0GSMhGHxfObekV4Bm8uf5xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yf6DiZlS;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E857606A6BD
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 22:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E857606A6BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yf6DiZlS
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ee254f6eefso23975ad.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 14:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795213281; x=1795818081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YWAHn2Sutfx4jyhpprq+KziM+rM4UEONRsPYaYW8qwc=;
        b=Yf6DiZlSNFO5GLCuQDAESWda3efOZ+ibaIKUvebHR9Ots3v4MJUI7W1R383LBgPssP
         JemDiDFzGhF2EXC2dNnbjkXEdmG8tiZfnzUH/N688CKz+Ac3/Gwltykxrvaa3EDKhRTj
         816ODB0DgIVzcAVJ++EiaZMkbWjndkCiLJIOF/8dZhmVY2+MEWkZcj47mZvmt4B4lBE3
         +ekVzpMJxEKBn6+5mvwrfbPUmacS0toEphyggM9hC2bCrhjbb1inSozdq3vb5n6hJZZ0
         2wu23ClMuJ/AYhbR0sW4ZN7U9MYW22amTmpeLxvnoKXtHxg8unyhrkzmb3perxPOaQ6v
         tvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213281; x=1795818081;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YWAHn2Sutfx4jyhpprq+KziM+rM4UEONRsPYaYW8qwc=;
        b=H8N5WAV8aCB5T+TVPGP13qP0b/PhiZfnDxDmMiSl2jZhAnqxB9kzfLzkX4hNX02N7e
         FP9HPYgJBIY8p2jsBrlACaAkE2DxcgaDUyk8mlBmV5IpQS0rL/OmTvbBrjnRxuMTzvFb
         3rkMwB3WMfvhx2NfGKgQ6ELTbM8hak7M8yUhKRQchEUGzMDmQqCkBKKGZZyNxxYw6h9Y
         y3ZnXkb2/x8N6XMwsuzv2/le3tKoHoFhBPdACijQyyKFk3A4K8rKq57Nv6RvnZLiwIlS
         g5d54DQsVOxfEBaUqYoLeAe7GPnfuR7kVHDIWYDqTHwO16eNvRx1p1dKqGA3llb3I2cV
         1E+g==
X-Forwarded-Encrypted: i=1; AL+hErHetWFxJj/JwwPtuOVCK5v5uzZFcH1ZpVoW/UkeuG2Jsp4A6C8ho7PiAkU9DaoiaXphDF81YL4rw+0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YKPXbjth4TggK9/nD9VzbeDiPxKfp2Z2ImjLH10lTpcZNoueg
	0NiWlrPCIbIz3TLBpvCr1E5CG1jq93o6uv7bdv+VTnz85TcTfzASTTR3jkO+olai6HBx5AZkvxY
	/FjSlQA==
X-Gm-Gg: AZFdTZdyYRlXpfmvq2BVu4TKvK8LLPoYn3IFybTPgH5Tc6luiP57iNLwH5Z/lUQtH5x
	WLnDPbsWut2g/iGhcGrBwwgvpBOhh70w5z0aFYE4Zq/FmRfZt/jQjc3TcIExexagErrGZ1Y6jsY
	wSaPonho8Ko9u/4S95S7D0oFTFkOG5a/qUJAtHFtrhuLGGiCRtuO0GbDV8BVD21T/CQwTWZn5Ij
	MzTcCZDcJbC5da41DD4iSxnGOlWSFxoYGGMXrs8uB6Sf2Xrmia+RTYpWO6E0vruQm3LmawwrABX
	l+l+YHe6CbdnXzjcij9TQJJ5XRxxaKohNkNCZLHV8LyHZnhJySo8k5UWyQYrZNLdQe9ViiCsmS1
	bGP2XLO7hj/W6KjZVUb5IrLctwm5uS8EgdE2TiG0vbdgGAIs4z5KrC4P5+XHuej2aKWZTzHC7yT
	/IQmLBifUXfTTylyYRYXKmIRr5YYukKtK9W0ujSEhNlTDjq7fkLkA0LKY/Q6IScPVkQs9bEBc72
	OHBP6FxujaGLilxTBtuT3xUlu5xsemtxtvXTRypsiHFzZc81rwjyWG6HiEfcNQ0SdQHAs+Gbz/7
	Vr2to1mVbGjkISoyzKmbkuBMMFkYOOZtkZX1j7dG58puJJavoI8oiSNqAyGr9JcoGD8ZOAjFNG1
	ygatxMe55qBhDCjUw3ykV4w==
X-Received: by 2002:a17:902:f709:b0:2e6:1735:f645 with SMTP id d9443c01a7336-2f062b91bfdmr1318055ad.4.1795213280161;
        Fri, 20 Nov 2026 14:21:20 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a33fsm5793510a91.6.2026.11.20.14.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:21:18 -0800 (PST)
Date: Fri, 20 Nov 2026 22:21:16 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Anthony Pighin <anthony.pighin@nokia.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>, kvm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Only lock the upstream bridge if the reset may
 need it
Message-ID: <awC5Ldqmue6DiO44@google.com>
References: <20261112235700.2029562-1-skhawaja@google.com>
 <20261118163706.7138d246@shazbot.org>
 <20261119143237.4bf54796@shazbot.org>
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
In-Reply-To: <20261119143237.4bf54796@shazbot.org>

On Thu, Nov 19, 2026 at 02:32:37PM -0800, Alex Williamson wrote:
>On Wed, 18 Nov 2026 16:37:06 -0800
>Alex Williamson <alex@shazbot.org> wrote:
>
>> On Thu, 12 Nov 2026 23:57:00 +0000
>> Samiullah Khawaja <skhawaja@google.com> wrote:
>>
>> > Commit 962ae6892d8b ("vfio/pci: Lock upstream bridge for
>> > vfio_pci_core_disable()") makes vfio_pci_core_disable() trylock the
>> > upstream bridge before resetting the device, and skips the reset if the
>> > trylock fails.
>> >
>> > All VFs of a PF have the same upstream bridge. Take a device with two
>> > VFs, both used by one process. When the process is killed, both VFs can
>> > be released at the same time. The first one takes the bridge lock and
>> > does its FLR, the second one fails the trylock and is never reset.
>> >
>> > The bridge lock is only needed for a bus reset, which is done through
>> > the bridge. A VF is reset with FLR, and pci_parent_bus_reset() never
>> > resets the bus for it because the PF and the other VFs are on the same
>> > bus.
>> >
>> > Add pci_reset_needs_bridge_lock(), which returns true if any reset
>> > method enabled for the device is a bus reset, and only lock the bridge
>> > in vfio_pci_core_disable() when it does.
>> >
>> > Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> > ---
>> > Tested in QEMU with an igb PF behind a PCIe root port, bound to vfio-pci
>> > with two VFs. Both VFs are opened through VFIO and then closed from two
>> > threads at the same time, counting FLRs with a kprobe on pcie_flr().
>> > Without this patch one VF missed its FLR in 50 of 50 rounds, with it
>> > both VFs were reset in every round. I will send a VFIO selftest for this
>> > separately.
>> > ---
>> >  drivers/pci/pci.c                | 28 ++++++++++++++++++++++++++++
>> >  drivers/vfio/pci/vfio_pci_core.c |  3 ++-
>> >  include/linux/pci.h              |  1 +
>> >  3 files changed, 31 insertions(+), 1 deletion(-)
>> >

[snip]

>> > +
>> > +		if (pci_reset_fn_methods[m].reset_fn == pci_reset_bus_function ||
>> > +		    pci_reset_fn_methods[m].reset_fn == cxl_reset_bus_function)
>>
>> This looks like a maintenance nightmare.  What if instead we did
>> something like:
>>
>> bool pci_parent_bus_reset_possible(struct pci_dev *dev)
>> {
>> 	struct pci_dev *pdev;
>>
>> 	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
>> 	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
>> 		return false;
>>
>> 	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
>> 		if (pdev != dev)
>> 			return false;
>>
>> 	return true;
>> }
>> EXPORT_SYMBOL_GPL(pci_parent_bus_reset_possible);
>>
>> static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
>> {
>> 	if (!pci_parent_bus_reset_possible(dev))
>> 		return -ENOTTY;
>>
>> 	if (probe)
>> 		return 0;
>>
>> 	return pci_bridge_secondary_bus_reset(dev->bus->self);
>> }
>>
>> Where we'd then condition acquiring the bridge lock on whether it's
>> even possible for a function scoped reset to perform a bus reset.
>>
>> It's a bit broader of a test than whether we actually have the necessary
>> methods in our reset_fn list, but since we're not locking the reset_fn
>> list between test and function-reset, it's also safer.  Thanks,
>
>After exploring Ionut's patch[1], what I propose above is probably
>wrong.  We don't have any guarantees that the sibling topology is
>static and this bus-reset-possible function presents it as immutable.
>The existing bus-reset function has the same race, but the gap is
>smaller, let's not make it bigger.
>
>There are however immutable properties we can test that cover a fair
>number of cases.  For example:
>
>bool pci_reset_function_needs_bridge_lock(struct pci_dev *dev)
>{
>	return pci_upstream_bridge(dev) &&
>		!(dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET) && !dev->is_virtfn;
>}
>EXPORT_SYMBOL_GPL(pci_reset_function_needs_bridge_lock);
>
>We should be able to use this as a condition on whether we acquire the
>bridge device lock, in pci_reset_function() and in vfio-pci code.
>Thanks,

This sounds good and it will also fix the bug that I am seeing.

The only caveat is that pci_dev_wait() might fail during VF reset and
then it might try to do a bus reset if the VF is behind a pciehp or CXL
port. I would prefer to do it only for vfio-pci code as that is where
the reset skip issue is. pci_reset_function() takes the lock and
serializes the VF reset. Are you ok with doing it just for vfio-pci?

Thanks,
Sami
