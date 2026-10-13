Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03370381AF9;
	Tue, 13 Oct 2026 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881349; cv=none; b=HBctRSa1uhpGHVcpi1PDR1ZpIC39zywrA+WyIR9ZF4lGodn55Np8pqo8riYybPvMgXloDyseAsyQQMgQx67RjPDkY1Lgl61Z9B8GwiI1YToWXiwMTFN9Yye7js2QBpDPI4IREL7B61Ivtx+vW9vp9BMw2TsxdFO2Xu9k/fTM3pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881349; c=relaxed/simple;
	bh=LdPn4y1BLlUV9VDo2n9ZTUesl59LlRBiN8rpHd8x9BE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z4+MbxZc3X8Jb0JjfXWJ6qpnxK9VaQP/SBN+G9PcQRrSi+PyxWAYHr6Jf8tGoPBVHLiTMs5tDVxcnXEDf07BfYpD0YduaJyU5tcTKz04sU2+R8tQYEeq6bAbyaftREgiP4Y+2SsU8z6LbTpf7apwTHkHiel+rmwjFHfbgRTPxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kc4/B++H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kc4/B++H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CF91F000FF;
	Tue, 13 Oct 2026 08:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791881347;
	bh=Y9UF6K4FwG4HzIlPjdc5k06+YnLKNQRxH3ezTz2QbNA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Kc4/B++HRNWIQUvH7M3HEap5N0LkC9si7M2oWx5HyOIVIcEhvF9bW0TWnkgByUpID
	 XGN7JqqccjNxoECWV0PZqxAYhUCYTw2MFKHBWW9qQ4pw06qqfYoeLEkdCgrVD6Wz5U
	 m/Xo39x2OWXTEBbMsHGrmmyWUAmklcp+qhhd5Zv/mJBnS1R5jXID83uRzfFvH/IDXJ
	 C9YMh4C93NXhm731BUUSicCrU+ROKC4OPIVnFgQb0TUQOwO/Qe0A56XLcXfBMDeZLt
	 O/7lZvJgYVpT3+yd6rS1tMCFIAlPypZCvGTZbw4ZosFqJxsCmShrIqefgYeskzhaXH
	 Phu4DiZ49fTbw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: sashiko-reviews@lists.linux.dev, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 09/16] tsm: Remove the device from lookup before PCI
 teardown
In-Reply-To: <20261012130109.GK13920@nvidia.com>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-10-aneesh.kumar@kernel.org>
 <sashiko-outbox-163673@kernel.org> <yq5a33ub5lgt.fsf@kernel.org>
 <20261012130109.GK13920@nvidia.com>
Date: Tue, 13 Oct 2026 14:19:03 +0530
Message-ID: <yq5ald82q934.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Mon, Oct 12, 2026 at 02:44:58PM +0530, Aneesh Kumar K.V wrote:
>> sashiko-bot@kernel.org writes:
>> 
>> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> > - [Medium] tsm: race in tsm_register() error path leads to UAF and NULL pointer deref
>> > --
>> >
>> > commit f9b77b7469552ae6078c3a47333908a88eec2474
>> > Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> >
>> > tsm: Remove the device from lookup before PCI teardown
>> >
>> > This commit modifies the teardown flow to remove the TSM device from
>> > lookup before tearing down the PCI state. It also adjusts the setup
>> > flow in tsm_register() to handle PCI registration failures differently.
>> >
>> >> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
>> >> --- a/drivers/virt/coco/tsm-core.c
>> >> +++ b/drivers/virt/coco/tsm-core.c
>> >> @@ -56,26 +56,25 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
>> > [ ... ]
>> >> -static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
>> >> -						 struct pci_tsm_ops *pci_ops)
>> >> +static int tsm_register_pci(struct tsm_dev *tsm_dev, struct pci_tsm_ops *pci_ops)
>> >>  {
>> > [ ... ]
>> >>  	tsm_dev->pci_ops = pci_ops;
>> >>  	rc = pci_tsm_register(tsm_dev);
>> >>  	if (rc) {
>> >> +		tsm_dev->pci_ops = NULL;
>> >
>> > [Severity: Medium]
>> > Does this unprotected write to tsm_dev->pci_ops introduce a race condition?
>> >
>> > If pci_tsm_register() returns an error early (e.g. if a driver incorrectly 
>> > provides both link_ops and devsec_ops, returning -EINVAL before acquiring 
>> > pci_tsm_rwsem), a concurrent userspace write to the connect sysfs attribute 
>> > might trigger connect_store().
>> >
>> > If connect_store() evaluates is_link_tsm() concurrently, this lockless 
>> > assignment to NULL on the error path could cause the compiler to reload the 
>> > pointer after the NULL check. Could this lead to a NULL pointer dereference 
>> > when accessing ->link_ops.probe?
>> >
>> >>  		dev_err(tsm_dev->dev.parent,
>> >>  			"PCI/TSM registration failure: %d\n", rc);
>> >> -		device_unregister(&tsm_dev->dev);
>> >> -		return ERR_PTR(rc);
>> >> +		return rc;
>> >>  	}
>> > [ ... ]
>> >> @@ -96,15 +95,22 @@ struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
>> >>  	if (rc)
>> >>  		return ERR_PTR(rc);
>> >>  
>> >> -	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);
>> >> +	rc = tsm_register_pci(tsm_dev, pci_ops);
>> >> +	if (rc) {
>> >> +		device_del(dev);
>> >
>> > [Severity: Medium]
>> > Can this error path lead to a use-after-free if PCI registration fails?
>> >
>> > Since device_add() is called prior to tsm_register_pci() in tsm_register(), 
>> > the device is already exposed via class_find_device(). If a concurrent 
>> > connect_store() finds the device and proceeds to pci_tsm_connect() before 
>> > this error path cleans it up, it will attach the PCI context to tsm_dev.
>> >
>> > When this error path calls device_del() and returns, the __free(put_tsm_dev) 
>> > guard at the top of tsm_register() will drop the primary reference to 
>> > tsm_dev, freeing its memory.
>> >
>> > Because the attached PCI context stores the pointer without taking an 
>> > additional device reference, wouldn't this leave a dangling pointer in the 
>> > PCI context, resulting in a use-after-free on subsequent accesses?
>> >
>> >> +		return ERR_PTR(rc);
>> >> +	}
>> >> +	return no_free_ptr(tsm_dev);
>> >>  }
>> 
>> 
>> I think this problem already exists upstream. We should delay
>> device_add() until PCI/TSM registration succeeds. The kobject event
>> should also be emitted after device_add(). I will add the fix as a
>> separate patch.
>
> Sigh, trying to do all this stuff through sysfs makes such an
> mess.. Nothing gets to be atomic in sysfs land so..
>
> It looks like this ordering is to ensure that when connect appears on
> the pci device it can immediately be used with the tsm that triggered
> it's creation. I'm not sure this is valuable but I haven't worked out
> how a userspace is even supposed to exist with all these troublesome
> races.
>

The issue is theoretical and does not arise with a single link TSM
driver. The PCI device's "connect" attribute is added only after
pci_tsm_register() succeeds.

The race can occur when registering a second TSM. The "connect"
attribute already exists, and userspace may try to connect using the new
link driver, for example "tsm1". connect_store() then looks up ID 1 and
can find the new tsm_dev in tsm_class because device_add() has already
completed.

The proposed fix is to reorder registration so that device_add() is
called last.

ie, changes the sequence from:

	rc = dev_set_name(dev, "tsm%d", tsm_dev->id);
	if (rc)
		return ERR_PTR(rc);

	rc = device_add(dev);
	if (rc)
		return ERR_PTR(rc);

	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);

to this.

	rc = dev_set_name(dev, "tsm%d", tsm_dev->id);
	if (rc)
		return ERR_PTR(rc);

	/* Complete PCI registration before exposing the TSM to class lookup. */
	rc = tsm_register_pci(tsm_dev, pci_ops);
	if (rc)
		return ERR_PTR(rc);

	rc = device_add(dev);
	if (rc) {
		if (pci_ops)
			pci_tsm_unregister(tsm_dev);
		return ERR_PTR(rc);
	}

	/* Notify TSM userspace that PCI/TSM operations are now possible. */
	if (pci_ops)
		kobject_uevent(&dev->kobj, KOBJ_CHANGE);


>
> If you swap the order and remove the extra events then userspace can
> see a connect sysfs but no tsm0 device. I think this is possibly
> better as userspace will want to obtain the tsm handle then process
> all the devices affiliated with it. So waiting around for a tsm and
> then knowning that every connect is already there strikes me as easier
> to work with. IDK
>
> The bigger issue here is I have no idea how the userspace is supposed
> to work. When my imagined 'systemd device accept d' starts it will see
> a sytem with no TSM and no connect sysfs.
>
> A tsm may eventually appear when the TSM module gets loaded, eg it
> loads by udev through the smccc bus on CCA.
>
> Or it might need manual module loading because it is a SW DOE based
> tsm.
>
> Or it might never ever appear.
>
> So what is the device-accept-d logic supposed to even look like?
>
> Before touching this we need to come up with a draft
> systemd-device-accept-d shaped thing that does the TSM startup before
> drivers bind. Then we can see fully how it can work. I asked someone
> to start working on this, but I expected there to be a ready story on
> how it should work, not more design work.
>

Agreed. It would be useful to understand the complete expected userspace
flow.

This could also be a manual setup in which the administrator explicitly
marks specific devices for IDE connection?

>
> One possible answer is more TSM stuff has to be built in so we don't
> hotplug the default TSM. Then the userspace simply checks for a TSM,
> if present it connects it, otherwise maybe it thinks about using the
> DOE one just to get an attestation log.
>
> Module auto loading looks troublesome too, if we want to use the SW
> based DOE TSM then how does device-accept-d trigger the module load
> when there isn't even any sysfs?
>

I expect these operations to require manual setup: the administrator
would first unbind the device from its driver, configure IDE, and then
bind it to vfio-pci if the device is to be passed through. Since device
bind and unbind operations are already driven through sysfs, it seems
natural for the connect operation to use sysfs as well?

>
> Once again I'm thinking if the sysfs as a mistake and wondering if it
> works better using a /dev/tsm.. :(
>
> In any event, lets not get everything tangled into everything
> else. This series is about viommu, lets keep track of these other
> issues and keep focusing on viommu..
>
-aneesh
