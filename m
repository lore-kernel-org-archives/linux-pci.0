Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05D383984
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 05:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790658465; cv=none; b=N1PrEyc0hbAMnUmqEPT6DKQ1IjrdBA7kYKYgKF8PMF6tFwoaYQMRhDN4B7h1pGzxP+tGHIuRKr/6vHbFcsP4FpGQHMJBxHXJZDWqTayi6z1c8Ia1TMM5ZXetGIkyPZYwFDs46NHEg7wCIwK1Qc7ID/U8INO+dpPzDgcoVPP3Mxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790658465; c=relaxed/simple;
	bh=x0CziyJ1VZizScjT8AdvwpzK4N6gWSJ14QXY850Z7Hk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=erDd3G8Rg5WSmhVeQOucsiK2mqvsgQiUbVBEm5pd8y4AXyfEHBYuXeJQVbZahInbqNYKCB7fiRBWzlZrCORSirQxnkvSyq9pktUj+q12GaD6epc/TOfl4cxYmHnYrzfIzrv9mL6wt7d3dab3L/Tia4bBmG8xJG/sIsUot7DDInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJS55YPw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJS55YPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5981F00893;
	Tue, 29 Sep 2026 05:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790658463;
	bh=tLtVlsbDc9ysfP9kfnSAmIcAjcP+OnyF0vU9LG8wTzk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UJS55YPwDHkKryhQ/rWLp90zkBJRFVTEbo8mLH+18/4/obXlCyZKnZmDHQN5bCkff
	 7fLfNAyLhO1dIgozH2B1YvX2aXgXZ+w/l9JmglWBXM8IuVzM1n8Y/UcIVsYpjDGUMg
	 KTln+vlQ2ks7gGKWuMX9PRm1eJjr8s9c+F5WCPA8JQqTmKJls3G6y1fG9fl27p/jCB
	 WKDWZmgjgUbU4mla+u5HU7CCWwLv/uNZXBTw1L28/8VdorlR29LYWBG29p76OXR7qS
	 hMTrwRKp7g46Y7w4rvQk+9xc7QjAnPy5cMHs7upd+FTq5yH/+hdsaSARyIJhAL3DM7
	 jwHz8OMssHufg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 07/16] genirq/msi: Cache MSI message in
 irq_chip_write_msi_msg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929034510.2023173-8-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-8-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 05:07:43 +0000
Message-Id: <20260929050743.9D5981F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] irq: NULL pointer dereference in irq_chip_write_msi_msg()
--

commit 98ab4cb46e40acf3e5ccb95b4213b5490ae2ff8a
Author: Pranjal Shrivastava <praan@google.com>

genirq/msi: Cache MSI message in irq_chip_write_msi_msg()

Currently, PCI MSI caches the composed MSI message into the MSI descriptor
inside __pci_write_msi_msg(). This patch caches the message directly in
irq_chip_write_msi_msg() so that all hierarchical MSI domains automatically
record the latest message.

> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index fb5f372215bf2..df460a574d800 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -634,6 +634,15 @@ static unsigned int msi_domain_get_hwsize(struct dev=
ice *dev, unsigned int domid
>  static inline void irq_chip_write_msi_msg(struct irq_data *data,
>  					  struct msi_msg *msg)
>  {
> +	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
> +
> +	/*
> +	 * PCI Multi-MSI shares a single descriptor across all vectors and
> +	 * the device stores only the base message. Cache the message of the
> +	 * first interrupt only, so that sub-vectors cannot overwrite it.
> +	 */
> +	if (desc->irq =3D=3D data->irq)

[Severity: Critical]
Does this code cause a NULL pointer dereference for domains without an
msi_desc object?

Looking at irq_chip_write_msi_msg() in kernel/irq/msi.c,
architecture-specific domains like the x86 HPET (hpet_msi_domain_info) and
DMAR (dmar_msi_domain_info) utilize generic MSI domain operations but do not
allocate an msi_desc object for their interrupts.

When an interrupt from these domains is activated or its affinity is update=
d,
calls like msi_domain_activate() or msi_domain_set_affinity() invoke
irq_chip_write_msi_msg().

Because irq_data_get_msi_desc(data) returns NULL for these interrupts,
checking desc->irq unconditionally could lead to a fatal dereference during
boot.

I checked the follow-up patches in the series and it appears a check for
desc is not introduced in any subsequent patch, so this regression remains
present in the final series state.

Should this be updated to check if desc is valid first?

> +		desc->msg =3D *msg;
>  	data->chip->irq_write_msi_msg(data, msg);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034510.2023=
173-1-praan@google.com?part=3D7
