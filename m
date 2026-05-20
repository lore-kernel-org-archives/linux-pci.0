Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4632F0C62
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299090; cv=none; b=qqJyRzMMUWyrmnx5Gp1oLfUnxlPLMOM7XJMd4Fb6uGWP8etmfemxW4whcc4tLRd2V+AomQIdxqXCBx8tWVGHJaijREkylzYJU0XpiOV9PL/t4F153PUIIRpmKVU+euS5YrerBDGGkODB2yjGIkMxAY4LwILYdK44nljkk0Sj72I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299090; c=relaxed/simple;
	bh=yFKiKTNTNmcVwHRmxKW0FYWrHxbYZ9DSBLD9NwDFyEA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hUsD+RXfwMqZblQVvgWg/KZHAq0koi8Tzr29oal1wZAIh0jTd+dIsFCMr0TL51muwsz45SYpb4qNoU6KNSlkXnSacT2NijxBfpXZ78kKMA8H5yx8pa6Uf5Z2Q1sL2V21fwLRvYZaVc6PqiWB5/frvwL+89wjLcuRGu+09Cpwxlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=En2XSkFA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="En2XSkFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20FD1F00893;
	Wed, 20 May 2026 17:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779299088;
	bh=Q2SrpfNXg7u8lSrajggFsheR7SnJJ8MYJbWcSIqJNLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=En2XSkFAU73s57J3KLh1cbMDEZLVzM+X8aCp3CAMFnRiV7hc6zOOPwvFYUWerwvvP
	 8km/pEkhiGyJGSMyt2ajdfJ6bOJjGWh06rtdNA8m+alhaHfgS2RPtr/P4cR4PTiwHy
	 BC4wgSfhkaLDljE4YDSIGSZDiFqKMi4i1aWglQTVS6JOkU/40uAbH270XQktVUquMP
	 tfOcOth0ZqdJ+Gy8vFyTjtbVFjgFwvd0vEFxyKtEZc6W0hSCQJerkY3nfMxuItELMI
	 gjj4SrMwqEDyKwKwWQSIpjNy3C74N8hShVvSpc1pNjuPEQ6gExgEDUlNd/EjWUwIDk
	 ZeqVsTSB3mqEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 1/7] PCI: Allow per function PCI slots to fix slot
 reset on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260520171113.1111-2-alifm@linux.ibm.com>
References: <20260520171113.1111-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 17:44:48 +0000
Message-Id: <20260520174448.C20FD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access and double-dereference of `dev->slot` in `pci_dev_=
reset_slot_function()` can lead to a TOCTOU race resulting in a Use-After-F=
ree or NULL pointer dereference.
--

commit 3e69d6bfb3fdb198ceb79bc29354354788895096
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Allow per function PCI slots to fix slot reset on s390

This commit introduces a per_func_slot flag to struct pci_slot to allow
per-function PCI slots for functions managed through a hypervisor, such as =
on
s390. It modifies slot matching logic and pci_dev_reset_slot_function() to
account for this new behavior.

[ ... ]

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc000901..d0c9f0166af5c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
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

[Severity: High]
This is a pre-existing issue, but does this lockless access to dev->slot
introduce a time-of-check to time-of-use race condition?

Because dev->slot is read without holding pci_slot_mutex or device_lock(),
a concurrent hotplug removal could clear dev->slot and free the slot
structure in pci_slot_release() while this code is running.

If the compiler reloads the pointer after the !dev->slot check, or if the
pointer is kept in a register while the memory is freed, could accessing
dev->slot->per_func_slot or dev->slot->hotplug below result in a null point=
er
dereference or use-after-free?

>  		return -ENOTTY;
> =20
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520171113.1111=
-1-alifm@linux.ibm.com?part=3D1
