Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557643;
	b=bMn/OujxRfBLwJNMFVzbM3P7EZtE2eciwWrKM+9LcrCt1DeQfoymJ9AiLO24BPfGqJ+6
	 DlGSrCIpjSXPeY5SNOgxBJ7jkgCdkl3kdDEwB1wrpJTQMl8Z6FX/zIJHMm1JBsauTbRv2
	 8rfDGKDS2BxiutCLgeB0ZxuBzmjOjKX01k/eVyCF83W08I+nUfQjNCS2tW92T7fajQGt8
	 d9cwHhv+9Abc7Ddjh+/eEgkEdjMsI+Gtdpbjxm+xsgxLbQm5w+9v/bipt8rz2CSIjs8Nb
	 4AqB7bacV7vBLgAqaS2Fm9ipBFnswL3RbVLSoIO3vcXZp/KMmL+IntLiNKkE7EQ8ZKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557643;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=EA7eHt/O0bYrcpIzHzTDx2hG19gCRJEI4TFAz5QRzRs=;
	b=cuJOBcM1Ed/m0LWNpHS90U9+e8DTJNsZRyR9N/eV2t2fV/siJyRZe00GCKrUBc2RFkJy
	 rtbX8xdCYm97zGxIb4UzzLAT4ZOkHTyNmlpEpCAH8VrJbBjOlmTLvwMLRI3F0BeTrpDBl
	 l1+JNeWQcSt/iqhsDECCG++gfpd7YDC++tndBIawfxKBaq5YJDiktmN6c0iyji83oj3EF
	 1WDnuv+u2ooSf1OZIyTIpAoiMvWdQ4270NZzz9rBEPtHDkt78UWrLu8VgmFG/QH0wRAxa
	 wMQOJzz9iiThRxHZrAJXMC2a9T23Hu1f4nTb2G3rOMx9G2+sXDuf4sKxAtyH6j9bO4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jZnFtPjb;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461F7606A323
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 22:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 461F7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jZnFtPjb
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2efc4a84e75so217595ad.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 14:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795557642; x=1796162442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EA7eHt/O0bYrcpIzHzTDx2hG19gCRJEI4TFAz5QRzRs=;
        b=jZnFtPjb03VDAoy7LgZlrMly7UoHS6SmHa4pTOwxJ22Wn9lf2V/KFWZjrC56OoBeyA
         vM7mopWtpOTgWrDW2uhp2OLm2tY9AnxSywh3Y1/6xNEepHMzUQTNGt1E6oe79iGkp6kA
         6kxrVK8IWLGGnKpdI0M60ms4CmD2DkdiwiXmajVjsKbFtElFTVmMd5FGuhaeogK8vmOb
         yMMBwYE+WEwrtMakOg0tcnwv7AdXU8qpGR6n3Rcx2MecqDqgQ1i/wjJON1sPGZjxJWO0
         0/z5cXeMQ98bnRA42PAIXEZ6m3EcmPoCTVTfgR8vVMX2YEvZe450aguqz0eTSmgC9/s9
         VW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795557642; x=1796162442;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EA7eHt/O0bYrcpIzHzTDx2hG19gCRJEI4TFAz5QRzRs=;
        b=fph33vRXzBnNJHAKhzxe/Fqvhp9XY/BndTlq0I4XtJ1qiituYYf+bH4PtNazegQ5kg
         zQUFKUWMnAJD3tsc5/+CYMNiGwidC1FZzM8KRcapgdGMfPvhhktT7QhRNfFgLiv/adVf
         M3U+aPLqmxxTC+s6AVtSx05l89Cjx+PRYb5+yoGpTWP4FsVPXe9UaNtLppP8UfssZ/0e
         A4Ke+vINl/CULALE2rDg1eDHl2RQvjMrBel6vt868A/2Py4dNmbD14EEIqvtcnU7R+KA
         sEzYEbmihrUXE+ssJdGd3dUNTgDw1j2KIXm4pqJUVkxgRmdqGW09o9OA4GEbCQgArA3T
         ocUw==
X-Forwarded-Encrypted: i=1; AL+hErG1zEj1nSlWc+21k02DWraeF8krGdakwug4nuwe2tCDYROvVmohCW8SKR6MHFEgrqrgXD5kY+hR5fo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ahb16BkBb4wskCkrmP4A2XgZFJpfeSXpScE8ed3+uyAKBrfxj
	PbSs04Wtq0TJg8J2HtDp2wsTpUdMBOfyMjFXkF8r8p2FH/Y7HU/REHj0zCaPOIKweQ==
X-Gm-Gg: AZFdTZd/wAimPaQgwW/W74bzsqbATWRRy9OZ69aQplKn/xo0XMl0QbJyg8pl7MQW/N4
	snJmtYs94PHdKlYViq5C/M7uLZ1xrGw7m7hlZCEqegUX6y6q6Y41tiWovlOEJnUtv9W9MOEqaBT
	rwyn96IzuUgexjS9yRiDPz465vXSHpON7A3BIXnie2VtFqH6zl53kXq0JA2Y7fEz+nqxIROIId3
	zbI0IJYervKIunU8bEGzqAlWBrVRbhfq58KOOzQIlM8DLAWcLoK/mnMs9lnwCNK8ZeYqymc/Hyc
	7h+NZPNQVYfIhBTeN5gndxqCywx5OX0XLPN/5xdPRBARnU56ikhoam5oZOT7q6Rab8xeeK7TNO1
	3nVYgT6A5CyCBCwT3HdxYysM2sXEPQOTwahhU6sHHn21i6DN6enSbbYhjAUnmfdYBNZz9t278/w
	4Q1sjz1OdCxXosJAuPwZ4yPUP3Zx7MHCch/Bs/Ns3AyLHE553clc1DFwHGNawhmnVCPFyOEDPlF
	wLc/vVRmFnymT56H9/SWV99/9rJl3jj5/2bEJmSSPpgG2Dzq2mVJCcl4NMOMWo7Onah4v/Xk5cc
	FVkPWKHPRX+Typ8lQwYFEXnaI65OCVh5Eo0hwfU6C8gyUSGh6kL6D/uINMt9Tk7aRrGpFki64Ks
	gc0c3DPip1SkPJTDRcnJTgk3MErM9kvLMe0zsFAu1i/4=
X-Received: by 2002:a17:903:1444:b0:2d0:1aaf:daec with SMTP id d9443c01a7336-2f0665697d7mr10304545ad.9.1795557641889;
        Tue, 24 Nov 2026 14:00:41 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm24132763a91.4.2026.11.24.14.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 14:00:41 -0800 (PST)
Date: Tue, 24 Nov 2026 22:00:38 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Anthony Pighin <anthony.pighin@nokia.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>, kvm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Only lock the upstream bridge if the reset may
 need it
Message-ID: <awYIlvOacAWrT99b@google.com>
References: <20261112235700.2029562-1-skhawaja@google.com>
 <20261118163706.7138d246@shazbot.org>
 <20261119143237.4bf54796@shazbot.org>
 <awC5Ldqmue6DiO44@google.com>
 <20261124084852.661dd7c1@shazbot.org>
 <awXedVCoT7M79Rk5@google.com>
 <20261124145743.6c253bd2@shazbot.org>
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
In-Reply-To: <20261124145743.6c253bd2@shazbot.org>

On Tue, Nov 24, 2026 at 02:57:43PM -0700, Alex Williamson wrote:
>On Tue, 24 Nov 2026 21:04:57 +0000
>Samiullah Khawaja <skhawaja@google.com> wrote:
>
>> On Tue, Nov 24, 2026 at 08:48:52AM -0700, Alex Williamson wrote:
>> >On Fri, 20 Nov 2026 22:21:16 +0000
>> >Samiullah Khawaja <skhawaja@google.com> wrote:
>> >
>> >> On Thu, Nov 19, 2026 at 02:32:37PM -0800, Alex Williamson wrote:
>> >> >On Wed, 18 Nov 2026 16:37:06 -0800
>> >> >Alex Williamson <alex@shazbot.org> wrote:
>> >> >
>> >> >> On Thu, 12 Nov 2026 23:57:00 +0000
>> >> >> Samiullah Khawaja <skhawaja@google.com> wrote:
>> >> >>
>> >> >> > Commit 962ae6892d8b ("vfio/pci: Lock upstream bridge for
>> >> >> > vfio_pci_core_disable()") makes vfio_pci_core_disable() trylock the
>> >> >> > upstream bridge before resetting the device, and skips the reset if the
>> >> >> > trylock fails.
>> >> >> >
>> >> >> > All VFs of a PF have the same upstream bridge. Take a device with two
>> >> >> > VFs, both used by one process. When the process is killed, both VFs can
>> >> >> > be released at the same time. The first one takes the bridge lock and
>> >> >> > does its FLR, the second one fails the trylock and is never reset.
>> >> >> >
>> >> >> > The bridge lock is only needed for a bus reset, which is done through
>> >> >> > the bridge. A VF is reset with FLR, and pci_parent_bus_reset() never
>> >> >> > resets the bus for it because the PF and the other VFs are on the same
>> >> >> > bus.
>> >> >> >
>> >> >> > Add pci_reset_needs_bridge_lock(), which returns true if any reset
>> >> >> > method enabled for the device is a bus reset, and only lock the bridge
>> >> >> > in vfio_pci_core_disable() when it does.
>> >> >> >
>> >> >> > Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
>> >> >> > Cc: stable@vger.kernel.org
>> >> >> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> >> >> > ---
>> >> >> > Tested in QEMU with an igb PF behind a PCIe root port, bound to vfio-pci
>> >> >> > with two VFs. Both VFs are opened through VFIO and then closed from two
>> >> >> > threads at the same time, counting FLRs with a kprobe on pcie_flr().
>> >> >> > Without this patch one VF missed its FLR in 50 of 50 rounds, with it
>> >> >> > both VFs were reset in every round. I will send a VFIO selftest for this
>> >> >> > separately.
>> >> >> > ---
>> >> >> >  drivers/pci/pci.c                | 28 ++++++++++++++++++++++++++++
>> >> >> >  drivers/vfio/pci/vfio_pci_core.c |  3 ++-
>> >> >> >  include/linux/pci.h              |  1 +
>> >> >> >  3 files changed, 31 insertions(+), 1 deletion(-)
>> >> >> >
>> >>

[snip]

>> >I think the test I'm proposing precludes a bus reset, ie. there is no
>> >upstream bridge, the device flags prevent it, or we're provided with a
>> >VF.  It's only those cases where we can't do a bus reset anyway, that
>> >we can skip the bridge device lock.  I think that means it's useful in
>> >PCI-core as well as vfio-pci.  Did I miss something?
>>
>> Yes, the slot reset probe doesn't account for the VFs and will allow
>> reset of the slot when hotplug is enabled.
>>
>> I think that is probably a fix that needs to be done orthogonal to this.
>> I will send a v2 of this by doing the needs_bridge_lock() as you
>> mentioned above.
>
>Yes, there might be a latent bug in the slot reset path.  I know s390
>has some weird per-VF slot reset, but they set the per_func_slot flag.
>The test in pci_dev_reset_slot_function() probably needs to account for
>both VFs and multifunction devices as:
>
>	((dev->multifunction || dev->is_virtfn) &&
>	 !dev->slot->per_func_slot)

Yes, that is exactly the fix I am thinking about. Let me send this one
also separately.
>
>As you suggest though, that's a separate fix.  Thanks,
>
>Alex
