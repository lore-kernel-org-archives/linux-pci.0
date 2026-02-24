Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B54536403A;
	Tue, 24 Feb 2026 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918555; cv=none; b=dvoHFNnb737uXwC8nJugWfWzzXDpzkLt4x0fy6qToviQyN6Y7wyCRumMRlQ+GkhQxdsKVEZM8vguvaOGtHCyEPM80L1VhqdfZQvBB43bBIM6rUwGzrvFhrX0kZg1Rwr5jTihvLjxeeRZSbD7zkDMu9XAN7Xhou0/drytMblGjgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918555; c=relaxed/simple;
	bh=IVfZkoXJxDi6b+zjGc37nGBvxy39t5lfDaYpg5IiQ18=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NPYzo2uD3GlxeKMgQt1jbmj9re9vDlEN215NEjZmT1y5VkSzz1T/eCY5bj7vwNeWf3200ZN8kHx3OcXCm0FCMFlixoNn6lyAtchQdBypV4KHs10gPGz5+6jqc6LBViL45fmCYXFQB3ClAw2r1EWwvIyYX5h6MZ7JJAJfo964Hyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XOak9il8; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XOak9il8"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fKqJj3vndz9v89;
	Tue, 24 Feb 2026 08:35:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1771918549; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IVfZkoXJxDi6b+zjGc37nGBvxy39t5lfDaYpg5IiQ18=;
	b=XOak9il84GKUF25NbeqzG8ijyTJO46bPRWA/EVX9xwga8VKSej2e7A1FFduO6ZBWysxyBs
	a7AKVjfco2hmV1EU3a4iqwneZq3z3ncf1V25NvqZbSxN5fyJxjUtrw6+8bmaHz31PvAQ4k
	k6mXPOSsC6NOe1/HS2dj4GqQHaP4GVQhe1oiFpvq2cNOd2UaUhjYRXtmpQGLZfuNydAb/4
	PEi4AMyaibbpf79ZbyW7Z8MSSJB/U78uhJycIhXZ4W8jpOKRdsfjlfog549l13djxeFIIq
	p3HHqMeZuiii3zThwARvv3f59i2gtea/IQolmJIDMj9KxZzxmapTS5p6QopkEg==
Message-ID: <0fdfb3adf756bc88f3b903c65eaf922d0ca3f9a8.camel@mailbox.org>
Subject: Re: [PATCH 25/37] accel/qaic: Replace pci_alloc_irq_vectors() with
 pcim_alloc_irq_vectors()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Shawn Lin
 <shawn.lin@rock-chips.com>,  Oded Gabbay <ogabbay@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, Bjorn
 Helgaas <bhelgaas@google.com>, Philipp Stanner <phasta@kernel.org>,
 linux-pci@vger.kernel.org
Date: Tue, 24 Feb 2026 08:35:45 +0100
In-Reply-To: <d69a2cc9-15fe-453f-b647-41c5ead7a1c7@oss.qualcomm.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
	 <1771862143-89507-1-git-send-email-shawn.lin@rock-chips.com>
	 <41d7d63f-bcda-4182-9340-54d480473586@oss.qualcomm.com>
	 <6f0932f0-1e08-62a8-eb92-2380bb9f6928@rock-chips.com>
	 <d69a2cc9-15fe-453f-b647-41c5ead7a1c7@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 01de5d21ec9ccf1901d
X-MBO-RS-META: 7a1ugrctpmr8a9s8zuwom5k1ec3jmfq4

On Mon, 2026-02-23 at 09:25 -0700, Jeff Hugo wrote:
> On 2/23/2026 9:15 AM, Shawn Lin wrote:
> > Hi Jeff
> >=20
> > =E5=9C=A8 2026/02/24 =E6=98=9F=E6=9C=9F=E4=BA=8C 0:01, Jeff Hugo =E5=86=
=99=E9=81=93:
> > > On 2/23/2026 8:55 AM, Shawn Lin wrote:
> > > > pcim_enable_device() no longer automatically manages IRQ vectors vi=
a=20
> > > > devres.
> > > > Drivers must now manually call pci_free_irq_vectors() for cleanup.=
=20
> > > > Alternatively,
> > > > pcim_alloc_irq_vectors() should be used.
> > >=20
> > > This seems to break bisect.=C2=A0 Surely you should update drivers be=
fore=20
> > > you go changing behavior.
> >=20
> > Patch 1 introduces pcim_alloc_irq_vectors() and then convert all needed
> > users to it. Then the final patch(37) remove the implict IRQ vector
> > management in pci_alloc_irq_vectors(). So the individual patch for each
> > driver should be safe IMO. And if these patches go via a single
> > tree with acks, it seems unlikely to break bisect.
>=20
> There is a conflict here between the patch description and what you have=
=20
> just described. It seems like the patch description is wrong.
>=20
> The patch says that pcim_enable_device() has already changed behavior,=
=20
> and now drivers are broken and must update.
>=20
> It seems that the description should be updated.

+1, the commit message should state that the driver patches are cleanup
preparations.


P.
