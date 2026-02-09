Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99EA29B8E8;
	Mon,  9 Feb 2026 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624338; cv=none; b=NAo8XTyw1SZckCvaU9YOQJmh3lIHZza2MKJjDdOSr4262FdocnCAPAqotmgRzQhLAe2O32WIE61TCdWLrqo5obFuidV10jwYSQruFn1bzfJd6MjWFyJZwBguY4196n8hbxMrtaxLJaymRBjK83+BUu8xofPgqQspIiLWfjuhhOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624338; c=relaxed/simple;
	bh=gJEZM15/SVq/PTYSQwo1djPInjZCp/MV4+oWy2cNU2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mYTV3PYzGon/V47hTjv/F2kzUnmIlFTdJhxTbeGWCC3ul5dg6d0hHOvnJtGqRjl5KH/VxIojCbNhBYrdbx7iQF5pd8Phpxg8hw9iWA7mlxxhDx1U18IqHOrdMhc3pRTUWtCyGQi3qkyZtgICfdxFzQp2k1NXpUCw/hfhg9YmsIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NYuODBvX; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NYuODBvX"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f8cgr0GQvz9tsJ;
	Mon,  9 Feb 2026 09:05:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1770624328; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbHNBkkwY0k+eWzEpAzMjoiCidzv7Wk4lVR1JYv1rwQ=;
	b=NYuODBvXHLd6tKopXrDK/WU+YwzAmFE9LRNfaysP424b4UUDZy6rKMHgnFTrKmVMvQU0GS
	axy31E5wDR+HqroTus1ME/gmk6hx/DrpAzWD3J0I5JGRReX3EQx9DAsVwRPxvpFtuZhujt
	WYEyzaXr6s3ftk9yMX1jyoqb7DhPk+4ltJSQUnHrzlp05HlBa6whs8LCS2zapMXbUDsaIh
	0DPTYgKJtyLQSXyz9nZlBMMpkg1aMpBxJZpVqapebwfj9XrotwQ6zbOY4PK/4QN0wI3qJF
	RnYGf3nXXSgX/FXujLbk8u1LtEfL30rLgPXF6dWIeghsUu3Cu3w6No8d4ewmBg==
Message-ID: <5fb5bc0ecbd4f51791b6c330088879588a1518ac.camel@mailbox.org>
Subject: Re: [PATCH] Documentation: PCI: Clarify pci_free_irq_vectors()
 usage for managed devices
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, Philipp Stanner <phasta@kernel.org>
Date: Mon, 09 Feb 2026 09:05:24 +0100
In-Reply-To: <20260206223304.GA99007@bhelgaas>
References: <20260206223304.GA99007@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 4hi17frz46dny1i56wud37ehnk78sqn7
X-MBO-RS-ID: 3ea8944bdcda95a31a9

On Fri, 2026-02-06 at 16:33 -0600, Bjorn Helgaas wrote:
> [+cc Philipp, any comment? would like your ack if possible]

The patch is a good idea and desirable. I think, however, that it
should be a series with a second patch informing about this behavior in
pci_free_irq_vectors() docu, too. I think that more people read
function API documentation than the generated full docs, especially
when hacking something together quickly.

>=20
> On Mon, Jan 26, 2026 at 10:57:13AM +0800, Shawn Lin wrote:
> > Update the msi-howto.rst documentation to clarify that drivers using th=
e
> > resource-managed function pcim_enable_device()
> >=20

pcim_enable_device() can be called a "resource-managed function"
because itself is managed in the sense of it setting up a consequence
for its own actions, which is automatic device-enablement. I.e., after
calling it, calling pci_disable_device() becomes obsolete.

That's, however, not decisive here. What is decisive is that it also
switches those MSI functions into "hybrid mode" so that they suddenly
have side-effects. So pcim_enable_device() does *two* things.

Depending on what you want to achieve with your detailed commit
message, you might want to point that out. Some inspiration might come
from my commits in various drivers. To make it bullet proof, I would
say sth like:

"For legacy reasons, pcim_enable_device() switched several, normally
un-managed, functions into managed mode. Since various cleanups, the
only function affected in such a way by pcim_enable_device() today are
callers of pcim_setup_msi_release(). This behavior is dangerous and
confusing and should be removed from the kernel."

depending on how verbose you want to be. This could be merged with the
below, of course.

> >  must not call pci_free_irq_vectors().
> > This is because such devices have automatic IRQ vector management via p=
cim_msi_release(),
> > which is registered by pci_setup_msi_context() when pdev->is_managed is=
 true.

There is unfortunately also pdev->is_msi_managed in addition to
is_managed.

I think you don't need to hint at the internal implementation in the
commit message =E2=80=93 but a separate patch with a code TODO in pci/msi/m=
si.c
where you point out that this is broken and should be removed sounds
like a good idea to me.

Could also be put on a PCI TODO list if there is one (Bjorn?)

> >=20
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > ---
> >=20
> > =C2=A0Documentation/PCI/msi-howto.rst | 7 +++++--
> > =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-ho=
wto.rst
> > index 667ebe2..dc85f1e 100644
> > --- a/Documentation/PCI/msi-howto.rst
> > +++ b/Documentation/PCI/msi-howto.rst
> > @@ -113,8 +113,11 @@ vectors, use the following function::
> > =C2=A0
> > =C2=A0=C2=A0 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
> > =C2=A0
> > -Any allocated resources should be freed before removing the device usi=
ng
> > -the following function::
> > +If the driver enables the device using the resource-managed function
> > +pcim_enable_device(),

Same, "resource-managed" is not the decisive criterium. I would simply
state "pcim_enable_device() activates automatic management for IRQ
vectors".

(I'm a bit nitty; here it's not that important, but in the commit
message I would address this).


You can keep me on Cc, I can do a review for the next revision.

And thanks for picking this up!

Philipp

> >  the driver shouldn't call pci_free_irq_vectors()
> > +because the IRQ vectors are automatically managed. Otherwise, the driv=
er
> > +should free any allocated IRQ vectors before removing the device using=
 the
> > +following function::
> > =C2=A0
> > =C2=A0=C2=A0 void pci_free_irq_vectors(struct pci_dev *dev);
> > =C2=A0
> > --=20
> > 2.7.4
> >=20

