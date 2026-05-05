Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC234B697
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016581; cv=none; b=YqvB7zCDU7kCzKvY0DRxF7o5ZmoC4ma11jJmvVkUCi9HhC86m80KAtEe+CCpm5qjCzjYor20wjYeZTwPy/CEtZxfYvSPo42uXbJBOYs0oQikvsviLxVtEoIwuMTGkYClNGEseBgiMUCIm4HV9WBhJF9Luvtzh2wOPUby/g3JMJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016581; c=relaxed/simple;
	bh=K3gL/QqX9XIpzqa2FbgJjpHhstp5sZGQSwwPjxPX41k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ctkCcwAtSIXThLluGTlKlYMJk/aeL1HM9nYaoxqYDy139gleZrTLI5j500VzKP2oReZyeh15IPbLzowBDpxy2Arsp2CXK+PbZZYrEkjaxhmjDy8SLa0l0lbE4pB8ceQwW26v2xlOEpoCtKagO4xONQLGzkJOJhxNex3CRQhkQdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsAAv3sD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsAAv3sD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17138C2BCB4;
	Tue,  5 May 2026 21:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778016581;
	bh=K3gL/QqX9XIpzqa2FbgJjpHhstp5sZGQSwwPjxPX41k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HsAAv3sDybVWQ/4TYLa5BpveuzqRvJBQC5YnWteQ+THMT7clsa6ScRPo3dnh0DQJI
	 IEMlLflOVr9e9PKVojCbCnudyKUCRkcwGL6YsGl1iPLjHIlbFR1B3X9CI4mRVbk7gj
	 ql/YKmp4wKn2vsIsNNswgtrNpnVZY7drd4mQ6oGf0ikSwGfohHcwnckISTnvj8PRjd
	 RhIcKTREL78efpCOX13WMP2rYOjXHE12AOlgY80m2qKm3wIuIuh3nG/SZAMnGuPSJO
	 koDtOtN2v7gefeiGBHuKB6fgtodpOyuSKQWNWJlZGwtpEA9A6O13OKcFYqwWde70KV
	 Oie5ARf1ajiPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 1/7] PCI: Allow per function PCI slots to fix slot
 reset on s390
Reply-To: sashiko@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260505200510.2954-2-alifm@linux.ibm.com>
References: <20260505200510.2954-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 21:29:40 +0000
Message-Id: <20260505212941.17138C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Global enablement of `per_func_slot` on S390 breaks standard PCIe =
hotplug matching and hardware association.
- [High] Lockless read of `dev->slot` in `pci_dev_reset_slot_function()` le=
ads to a Time-Of-Check to Time-Of-Use (TOCTOU) Use-After-Free.
--

commit e4e35148b2442f92d3db17a20a087722c65c043d
Author: Farhan Ali <alifm@linux.ibm.com>
PCI: Allow per function PCI slots to fix slot reset on s390

This commit introduces a per-function PCI slot flag to fix slot resets for
multifunction devices on s390 systems. It updates the PCI slot number field
to a 16-bit integer to accommodate special placeholder and all-devices valu=
es.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc000901..d0c9f0166af5c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -4865,8 +4865,9 @@ static int pci_reset_hotplug_slot(struct hotplug_sl=
ot *hotplug, bool probe)
> =20
>  static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  {
> -	if (dev->multifunction || dev->subordinate || !dev->slot ||
> -	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
> +	if (dev->subordinate || !dev->slot ||
> +	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
> +	    (dev->multifunction && !dev->slot->per_func_slot))

Does this code introduce a time-of-check to time-of-use use-after-free
regression?

When dev->slot is accessed locklessly, it could be freed concurrently if a
hotplug driver module unload invokes pci_destroy_slot() and
pci_slot_release(), which clears dev->slot to NULL under pci_bus_sem and
frees the slot.

Because this function does not hold pci_bus_sem or elevate the slot's
reference count, adding another lockless dereference to
dev->slot->per_func_slot right after the !dev->slot check could access
freed memory if the slot is destroyed in between.

> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 6d5cd37bfb1e7..894d6213ed306 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
[ ... ]
> @@ -72,6 +72,23 @@ static ssize_t cur_speed_read_file(struct pci_slot *sl=
ot, char *buf)
>  	return bus_speed_read(slot->bus->cur_bus_speed, buf);
>  }
> =20
> +static bool pci_dev_matches_slot(struct pci_dev *dev, struct pci_slot *s=
lot)
> +{
> +	if (slot->per_func_slot)
> +		return dev->devfn =3D=3D slot->number;
> +
> +	return slot->number =3D=3D PCI_SLOT_ALL_DEVICES ||
> +		PCI_SLOT(dev->devfn) =3D=3D slot->number;
> +}
> +
> +static bool pci_slot_enabled_per_func(void)
> +{
> +	if (IS_ENABLED(CONFIG_S390))
> +		return true;
> +
> +	return false;
> +}

Does this global enablement cause a regression for standard PCIe hotplug
matching on s390 systems?

By unconditionally returning true on s390, slot->per_func_slot is globally
set to 1 for all hotplug slots created. When per_func_slot is true,
pci_dev_matches_slot() prioritizes an exact match of
dev->devfn =3D=3D slot->number.

However, standard hotplug drivers like pciehp initialize slots using
PCI_SLOT_ALL_DEVICES (now 0xfeff). Since a device's devfn is an 8-bit value,
this will never match, which might completely break pciehp topology on s390
environments such as KVM guests.

Additionally, if generic drivers like shpchp register slots using just the
device number (for example, 5), the strict match will compare devfn to 5
(device 0, function 5) instead of the correct device 5, function 0
(devfn 40). Could this lead to failed associations or cross-device resets?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505200510.2954=
-1-alifm@linux.ibm.com?part=3D1
