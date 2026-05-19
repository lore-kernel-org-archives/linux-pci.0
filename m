Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2C367F40
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217297; cv=none; b=sWA8PwqKg4xgtZnmeWSgtC4U4Nu4yeUJbZOqTBnRuwltTaZB4viYG6qxtpssbsKQlZ4ommmlNq/88oomtOgtQO4cNkE7/Fr4q1eT1rSphTV1WVuEkJFVn91nPcOoX/LHbv1+G4T2/mZhphR4HIdB0mlPMPo5kRnjQ/nzKBHAVZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217297; c=relaxed/simple;
	bh=doAQ2L37UVfVZl/K1Tk5Kw3riek8OMX/Sp/RxdTcR4k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=soK3TIZn2vXdvOFbijBLTk9f5yq6aUcJEfOR4K+aC0JnoBTnGWzLAqz3l3AI7RNChpRslF36UWrxlSsYjmK6kMsEygQvDERvwjvDjXyUeLf1tzWNeOCuxtZ4ul5CgGDNlzbq8LX6WMy+1C1TF3dVyLEOGqiia3fAfzlacVIvIdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgqCzK6E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgqCzK6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1135B1F000E9;
	Tue, 19 May 2026 19:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779217296;
	bh=ZxlmbUTE2zMrA8EB90lyQAgMqq0thQBjYwGwSiGVg+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bgqCzK6EivlLWKi9kMzcp7WFFW94jOXMO8MfzGwQbhBQFeP0497CmN0ndqN13nJef
	 PUVsFBV+/f/7Vb3nyHMBlau99EPOSmfEApWwHIaHn3SA7fLGW50Ek+ljFbpmWVbWQt
	 K/hIIpjE4LOo2Jy9RUMFgPIONaxSJdAZC2V3OMfVVvS+WvRWRKcVoo3l3VSssYlcBN
	 3eSbR89MUb9xxeyvw67r5LV7NeXTGc54KkBAen1A6aY3KwppXqSZi1iAQgTK7pFIPg
	 kHK8rzKtKDWqpAOB6HQgtDgrlVZTvBf/tmyD1XUXMTt81F8bb63CCiVOGb/4IiX2eI
	 B7K6jvAgFbG6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Constify slot attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260519-sysfs-const-pci-hotplug-v2-2-16e90346a522@weissschuh.net>
References: <20260519-sysfs-const-pci-hotplug-v2-2-16e90346a522@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 19:01:35 +0000
Message-Id: <20260519190136.1135B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete refactoring: missing constification in arch/s390
--

commit 82806cfff2b8dfa67e34209d23e3b5a4960d5c4f
Author: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

PCI: Constify slot attributes

The attribute struct are never modified, mark them as const.

> PCI: Constify slot attributes
>=20
> The attribute struct are never modified, mark them as const.

[Severity: Medium]
Since the stated intent is to mark the slot attribute structs as const, does
this miss zpci_slot_attr_uid in arch/s390/pci/pci_sysfs.c?

Leaving it out causes zpci_slot_attr_group to continue using the mutable
.attrs array instead of the new .attrs_const member, which leaves the
refactoring incomplete:

arch/s390/pci/pci_sysfs.c:
static struct pci_slot_attribute zpci_slot_attr_uid =3D
...
static struct attribute *zpci_slot_attrs[] =3D {
	&zpci_slot_attr_uid.attr,
...
const struct attribute_group zpci_slot_attr_group =3D {
	.attrs =3D zpci_slot_attrs,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519-sysfs-cons=
t-pci-hotplug-v2-0-16e90346a522@weissschuh.net?part=3D2
