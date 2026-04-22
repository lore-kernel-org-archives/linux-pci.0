Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3047C36C0AB
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776841882; cv=none; b=IIYwjp9CiUAiSz7LPXbGQKXuMowFQQ+DkPpkoCgnc7Ygpn1PSFfFX009wV5KBswzjHHj0gt99tNSbsh4q2h1EWXCrGOhFzjmxbdY6WMqE89sraAb3Y8sVKnqcNeOl9/Xmoqt898USSdlJrX/2oAbVKrazp4D5D6IHkjEVpwqDMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776841882; c=relaxed/simple;
	bh=FCKztHHPrRwKwFmi6IgL0OZ0vw8BFnqNPc8MOCk1CJY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dOqSZmhVm6dnt5fO4KIv7mis4+dEqqQOFEWhAj48Hyt5j5jaj9gtLr/whxnBUgF2Y/ydyVX256PHtcDd6G8Gvec2YteuZcmYbmWiEmcZNn+eK/6QwrQ/WgMh+hb+avZK5VePuc6CH5XgWOiLBN1mxtYc8/BPkZFPl84vD4/RnRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kV28y8qs; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kV28y8qs"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4g0r435Y86z9ty0;
	Wed, 22 Apr 2026 09:11:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776841875; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RmfhNBwa+8iw7/m2w2odHWWyYD5Z0Obf0O6CkCtHanI=;
	b=kV28y8qsjeWXa6Ogd0t+2ekE8XuP41x86Q59Q5yvYAh5P7Y+zrSDX//wyUxUZGW1JCsywZ
	1VKr9LH4nd3OT+JrRl4cDhvorkyidVBAVkKt9vOiE+c1vuO6TqOCMzvLbwp0MKdg3lXhhO
	sWLQkJ5hdhfuHnQ4FMIM6nxYM7YAzL+v4jNQGPCI7rG/wTEBSknojlKI8f2Vz+/txeJgho
	Ov0GfYiirPVkfKVBifqprLIB/+aOnLA/WcQTh4wSihNlS2M+Q1SecXz+oJkFYwyJVWeBLY
	hLPXScX9Pth+qQjMLlnCZi6yx9LH4wFtMko0aujII2JU/SqPKgFD7zjjXVrCQA==
Message-ID: <9dc66010d61670dc5182062ef5f1a932f7374323.camel@mailbox.org>
Subject: Re: [RESEND PATCH v3 0/3] Add Devres managed IRQ vectors allocation
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Kurt Schwemmer
 <kurt.schwemmer@microsemi.com>,  Logan Gunthorpe <logang@deltatee.com>,
 Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org
Date: Wed, 22 Apr 2026 09:11:08 +0200
In-Reply-To: <1776825522-6390-1-git-send-email-shawn.lin@rock-chips.com>
References: <1776825522-6390-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 66b62ac848d6b6fb81c
X-MBO-RS-META: 8yz1m393brjhg3zaoq1riysswp3jjd4q

Hi,

I did receive your first send-out of this v3. In case of doubt it's
possible to check on lore.kernel.org whether it was actually sent out.

On Wed, 2026-04-22 at 10:38 +0800, Shawn Lin wrote:
>=20
> There is a long-standing design issue in the PCI/MSI subsystem where the
> implicit, automatic management of IRQ vectors by the devres framework
> conflicts with explicit driver cleanup, creating ambiguity and potential
> resource management bugs.
>=20
> Historically, pcim_enable_device() not only manages standard PCI resource=
s
> (BARs) via devres
>=20

JFYI, it doesn't do that anymore, since I fully removed that.

What is left though is the weird "plural functions",
pcim_iomap_regions().

I've done some work to also remove them, but it's a lot of work, and
especially the ATA subsystem is relatively difficult to port.

>  but also implicitly triggers automatic IRQ vector management
> when calling pci_alloc_irq_vectors[_affinity], because pcim_enable_device=
()
> sets is_managed flag, thus pcim_msi_release() will register a cleanup act=
ion.
>=20
> This creates an ambiguous ownership model. Many drivers follow a pattern =
of:
> 1. Calling pci_alloc_irq_vectors() to allocate interrupts.
> 2. Also calling pci_free_irq_vectors() in their error paths or remove rou=
tines.
>=20
> When such a driver also uses pcim_enable_device(), the devres framework m=
ay
> attempt to free the IRQ vectors a second time upon device release, leadin=
g to
> a double-free. Analysis of the tree shows this hazardous pattern exists w=
idely,
> while 35 other drivers correctly rely solely on the implicit cleanup.

Also just as an idea: for your removal strategy it's probably a good
idea to carry a list of the problematic drivers along, if that's not
too much work. Once created, you could continuously update it on your
machine, to keep track and later to provide evidence when you finally
remove the API. That "35 other drivers" do it *correctly* isn't really
that useful to know; what's important is to know who might explode.

I did it this way:
https://lore.kernel.org/linux-pci/20250519112959.25487-2-phasta@kernel.org/

That then helps the maintainer to fearlessly merge your final removal,
building trust that the drivers are safe.

>=20
> This series introduces new managed APIs: pcim_alloc_irq_vectors()and
> pcim_alloc_irq_vectors_affinity(). Drivers that wish to have devres-manag=
ed IRQ
> vectors should use these functions. They are currently the same as non-de=
vres
> managed version. In the short term, the series converts two drivers withi=
n the
> PCI subsystem to use the new APIs. The long-term goal is to convert all o=
ther
> drivers which wish to use these managed functions, and finally to remove =
the
> problematic hybrid management pattern from pcim_enable_device() and
> pcim_setup_msi_release() entirely.

10/10

P.

>=20
>=20
> Changes in v3:
> - Rework the commit message and function doc (Philipp)
> - Remove setting is_msi_managed flag from new APIs (Philipp)
>=20
> Changes in v2:
> - Rebase
> - Introduce patches only for PCI subsystem to convert the API
>=20
> Shawn Lin (3):
> =C2=A0 PCI/MSI: Add Devres managed IRQ vectors allocation
> =C2=A0 PCI: switchtec: Replace pci_alloc_irq_vectors() with
> =C2=A0=C2=A0=C2=A0 pcim_alloc_irq_vectors()
> =C2=A0 PCI: vmd: Replace pci_alloc_irq_vectors() with
> =C2=A0=C2=A0=C2=A0 pcim_alloc_irq_vectors()
>=20
> =C2=A0drivers/pci/controller/vmd.c=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0drivers/pci/msi/api.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 47 ++++++++++++++++++++++++++++++++++++++++++
> =C2=A0drivers/pci/switch/switchtec.c |=C2=A0 6 +++---
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 22 ++++++++++++++++++++
> =C2=A04 files changed, 74 insertions(+), 5 deletions(-)
>=20

