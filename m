Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD0532692C
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 04:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792124388; cv=none; b=JvYk+LSR/WcMduITpR59W40wMxbDALzgStH6BDGqVq0iSgYqjjp1O5vf5Zo9E++0oWUvfgm66kInFoJX6Z5WwHv7lSNik6tcTa9mnDbRhgUTahALseYrIEgSUbA8+0nKDG5yHQKfFDDIExjVybLoFI8kVeF68v9W9y3D30ednjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792124388; c=relaxed/simple;
	bh=f+ApFUIcRb1kvNrckCSKPPWO8ANPJkSyAmQmzjorPZ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tn6VzF8fpmBn6s3UVghx9lxD3gbTK6/dGb/zhhUmSSPPGY0PGdHtbMOkKjH5fAnTDGi5KuPB7+gt374XG2cDA162k5kJHm44WOvGe7s5zSl2v9U7EzuJlHwlqEQrnnUdAYQMY4fePSX5MkgNaLTupmtCrCJpdk0nXywJMK/ccPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=je+/OyXp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W+toGprT; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="je+/OyXp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+toGprT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0E20A7A011B
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 00:19:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 16 Oct 2026 00:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1792124385; x=1792210785; bh=f+ApFUIcRb1kvNrckCSKPPWO8ANPJkSy
	AmQmzjorPZ0=; b=je+/OyXpbEWPPbYTyHbGOO7Bbf7zLK/zFQJQpnVKpZ+WerN8
	RVDO14yUlE83yKIDw/TiRHUIUcXjZAww9r/5zdnFiCl27TJxcCwxy/XcfBjczDwV
	7qEFOSUGE5KrDbvHkeWKqp9feSJefaLp/qcNfByV+hTK3XHJ4khsS55BJyOjjHY6
	Wf4L/PNUmPMVxQ+t4MCifdR9KhWTsxNGfU94/nZEuQsOlrFm+h8iArbTGRqStBt5
	G2S6LS3JvLxfRXFgQQkVZyOIK37OXxRS75o9BV3w2swzpgB29+D1ngeNjprI6Tpl
	ah10+LATliGrROnKnnWf5U+iFyZn6+89PTKW2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792124385; x=
	1792210785; bh=f+ApFUIcRb1kvNrckCSKPPWO8ANPJkSyAmQmzjorPZ0=; b=W
	+toGprT88SKonGiNROKFoAmytooMxNXbtE5xqrGi8Bwz9ASACfgq+VJXNwzYnCX4
	j8x9gB1NQqXyoMXd9K4QL8A0SlsgRqj6H4+idFXYZ1qY7k1EIK4ViOMUjrfilf8t
	fXEZ27auCxNsL4iUDAPCAePpWXmqwO7EvPKQ6xeSgJZH/bL6aQcW1Lz7jyBkIfcj
	tJMHrglp2j3+kXzkUSDDGEY25tVz18/Ek+/oEQtHxzAHV+alI0JhNTvObwShUUZ9
	qVd6CbRNpLE4a5z0ONrKk1TGerk1S0A5hpbnudSrkzDSf3Z5Nskf7lbxArOxwqZF
	XxLpU+LsyxrC4EI5UH6GQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792124385; d=alistair23.me;
	mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Mn5kWxJCRoyql3HDPnwtUo3cVPfu3/zPO2MTS5t/czSee05
	L8oHZMJIOLM4GRo+LQXUh6VsIK/4+FkNbTFc2S56XcZ90TjiWtIxsL8y0FFq/n81
	2airsSWYhonJS/3wEka0XL61Ze9i9ssbAlp7KZj/bS9EEs3qCLlM1Z5lYABch7b+
	TZfOLAkU7IWHpMlIFEn1/qZb39epVjEk1wX2GUYNcf3gjxiLduXddo9tP3+kBO43
	HsIlctiyJKaAT9+LUP1UckXQAKOFWHmFczLwRZ8XeFfhOqhzoczDy1BNXBKgATVL
	P0Y45vGFny7yzLX5FlTC7dLzOPYiKbYUOjFMNlA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:s7HAxbcwr8sVkizbaWCno9gexIBxUrAJPG0LJvPAfsQ=:f+ApFUIcRb1kvNrckCSKPPWO8ANPJkSyAmQmzjorPZ0=;
X-ME-Sender: <xms:4aXRapMamDTJHe75MWvNHLjiYTdSJal4vmkdkfXCp4Z9Uohx5wdWiQ>
    <xme:4aXRasrQ1pR7VsHEGS8YTI86Vs1xOLprzLJbC6wFqdGTvw0X79lskGwQqkSZkkYL8
    ETiSFGgmH04zYfyQkSJYsJ0s5HtwSWd4EGOlwFpR2-LskKooIKWwkwE>
X-ME-Received: <xmr:4aXRamc2-UyUzvt2fa04ia7gx3_Z8TzEmJoHdyPkQXe7cmQpkHCG1KWqhhPJ_FII1bRigVuxr-ps0KyXnO5qvv0uzHw>
X-ME-Proxy-Cause: dmFkZTE4JY+siRWEbUEyZxn/bikTc85YX18gJaF/DxwlfAL5UanZaEXxj8F6LBoI/lcB+3
    5ELyFD5ar33M9GpKeB18H0GcWas76r29f60U6M6exy1Fa3Hmf8gB7e+9UONOfQP3MucknS
    SbTCenKp9I/sbqaZJe+eusqygqgDQQbUF7HM7w0Rj9QbgAmtUewvTE9xy3uIe+V+DC+JJ7
    /WSPnnovWqkokpl5FSOSc0wnLI3xrfS0ayoaLjr47O9Tush1guqfgyaVryVCfgO86caEgX
    PVsuL9ACg6ds+8JeSUNKsMC76Nq5puny3nOB9kkYgPhFyWuKA9lsIvUOqYVJ9KPoEGdcXU
    tmHGNJ1YY2o8bcUGmXOlanxhqTqBFBlP5XBlqM/Hb1IMKJjH795oxs6qWxg8ATgUS/TbJB
    Er+pxrIrYjueDcAZ7SU7E9VjBnCwMN9i265o4SLdNdvVIhM+tVNedfqfVQQyD0ufX/OOob
    GexVda8h/nOiHfL6hMi5HBUk+RBiel5bcJE7mZCY+i0FEz77FTyauDolDvLr+Ne8XjSfL0
    Ww9Mx/LvQnOebmNjtBsOlWdiLrAFFh39aDimmBn5rsXDoCCfGRc5JktKIwu0UgelS/VLUj
    SxbM+TmUTYol3EcfFavCaMlyXDRgnfGN0YuCmLzS758B5LJOUW8t2FOQAz0g
X-ME-Proxy: <xmx:4aXRaqQTPnjROuOYsjmSZOYwcp0kurF5GrVXElsPBuXgeMKzd5fBqw>
    <xmx:4aXRanYQHr_UyKXVKu6SCPXfVIvYbSMMXmgvpKa-deIJQ3j3T0gL_Q>
    <xmx:4aXRalcByHGOKz2XRMx8AlQxFUjFtZeLYymqcYpAOtMhU5vRJ0-8rQ>
    <xmx:4aXRagJ6HWXR1IdFiKYc4lyX-KSSaJ3lTTtDpYCfjkjkxgtopRoQzA>
    <xmx:4aXRamsFSy62oe1Y_sZZk0BF8OYm2F7bUeSSpqszmhPkQw15n-2NATe7>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 00:19:42 -0400 (EDT)
Message-ID: <84f476a74719089da16a4b7123fc42242bd67ae1.camel@alistair23.me>
Subject: Re: [PATCH] PCI/DOE: Poll briefly for a response before sleeping
From: Alistair <alistair@alistair23.me>
To: Bjorn Helgaas <helgaas@kernel.org>, 
 =?UTF-8?Q?Micha=C5=82_C=C5=82api=C5=84ski?=
	 <mclapinski@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
	 <jic23@kernel.org>
Date: Fri, 16 Oct 2026 14:19:39 +1000
In-Reply-To: <20261015200152.GA1793040@bhelgaas>
References: <20261015200152.GA1793040@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-10-15 at 15:01 -0500, Bjorn Helgaas wrote:
> [+cc Jonathan, Alistair, thread at
> https://lore.kernel.org/all/20260917230323.3701743-1-mclapinski@google.co=
m
> ]
>=20
> On Fri, Sep 18, 2026 at 12:28:21PM -0700, Micha=C5=82 C=C5=82api=C5=84ski=
 wrote:
> > On Fri, Sep 18, 2026 at 7:27=E2=80=AFAM Lukas Wunner <lukas@wunner.de>
> > wrote:
> > >=20
> > > On Fri, Sep 18, 2026 at 01:03:23AM +0200, Michal Clapinski wrote:
> > > > doe_statemachine_work() waits for a response by sleeping
> > > > PCI_DOE_POLL_INTERVAL (PCI_DOE_TIMEOUT / 128) between status
> > > > reads,
> > > > which is 7 ms at HZ=3D1000 and 4 ms at HZ=3D250. Exchanges are
> > > > served from
> > > > the device's local mailbox logic and typically complete within
> > > > tens of
> > > > microseconds, so nearly all of that sleep is wasted. Every DOE-
> > > > capable
> > > > endpoint pays it once per supported feature during enumeration.
> > > >=20
> > > > Poll with usleep_range(20, 50) for the first ~2 ms before
> > > > falling back
> > > > to the jiffies-based wait. On an Intel Emerald Rapids system,
> > > > time spent
> > > > in pci_device_add() for a DOE-capable endpoint drops from 41.8
> > > > ms to
> > > > 14.0 ms.
> > >=20
> > > Polling is just a poor man's replacement for interrupts.=C2=A0 DOE
> > > supports
> > > interrupt-driven transfers but we're not taking advantage of it
> > > so far.
> > >=20
> > > Perhaps you could look into adding that?=C2=A0 It would seem more
> > > worthwhile
> > > than optimizing polling.
> >=20
> > Thanks for the quick response.
> >=20
> > This code runs during PCI device enumeration, before a driver is
> > bound, so the core doesn't really have an interrupt to work with:
> > MSI/MSI-X vectors belong to the driver, and enabling them in the
> > core would collide with its later pci_alloc_irq_vectors(); INTx
> > isn't routed yet either, since dev->irq only becomes valid via
> > acpi_pci_irq_enable() at pci_enable_device() time.
>=20
> Do we have to run the DOE setup code during enumeration at all?=C2=A0

Yeah, I think we do.

We need to probe DOE to know if the device supports CMA, at which point
we need to attest and authenticate the device.

Granted that isn't upstream yet, but in general we will need DOE at
enumeration.

> Maybe
> we can wait until a user that needs DOE functionality comes along?

We don't know who that user is until we know the DOE features is the
issue

Alistair
