Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AC3F7884;
	Thu, 15 Oct 2026 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094515; cv=none; b=sj6FZqbTqoHPQeGPqkpmbtGvrhA+XXU9NzMHcJMUChjepvJjKzBJLonlnjHL5ZouCcW10qSMKNQcCwcr/MQAQSEA1UhRnYzcMFWDgApij10GL0EBgfgBcfPeAa6sXTVymJqXoOqEHcxEMv/HXkylAKg/XtnByM1DbtLlJGJlN1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094515; c=relaxed/simple;
	bh=nAKhgck4L81EOmTFvy5kmKCUm9PT9sNwkK2+Cbw4EXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Joa4qqd/+ggOh1SvORtYOMH1tXUH20CCqhIynU+T2eLezz5jwYJkb6espFYWR9zPshrimXNahFbtJb9ogkJEbI2VKSnAqzdGEHTwZ6APwMSvwLt7Px3JNhg1PzyZ6Sir8qfLO6M+rPR60WG5oQtCeuRzTQTs6er8NaqWymSUbts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fT+3NDDn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fT+3NDDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEE31F000C4;
	Thu, 15 Oct 2026 20:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792094514;
	bh=2lSINWCexHlR0OD19l9Zcdewoo1/zSmK7IhlAWABMIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=fT+3NDDnbRELpu5wPbtTUqd30ThbQNeAtzbVTzqkKg/bNI8kwX6lbcw/zQRlIt58D
	 iIqf0PwORqwCDYk2IpYKmUMEfoqf6UMZquDCuJJ7w5rp6Fp5TurKBpUD5hvD0zBGuJ
	 0m2fCbLEyB2En38FDG4/43gL+apAjTw1UCJ38nhVwl3YdGjF86n4wYXYjVWJEeAY6I
	 qwUMFx3Xebbp7xSGFlS7Q9l20A60uOxerU5f6FM2KNMQHep8TpC0r9PQunOBDeWv0I
	 WmYkTNpVdumyETE2IfkdewInOgupk044rLl3YlcRELhj+D3u6GTN4d64Yarg+wxwkn
	 OI3cGOY1hxRcg==
Date: Thu, 15 Oct 2026 15:01:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH] PCI/DOE: Poll briefly for a response before sleeping
Message-ID: <20261015200152.GA1793040@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAi7L5cjsUrLbcJtBg1DXo7frjdBY0m5x5tUeR8+btU70HP7tA@mail.gmail.com>

[+cc Jonathan, Alistair, thread at
https://lore.kernel.org/all/20260917230323.3701743-1-mclapinski@google.com]

On Fri, Sep 18, 2026 at 12:28:21PM -0700, Michał Cłapiński wrote:
> On Fri, Sep 18, 2026 at 7:27 AM Lukas Wunner <lukas@wunner.de> wrote:
> >
> > On Fri, Sep 18, 2026 at 01:03:23AM +0200, Michal Clapinski wrote:
> > > doe_statemachine_work() waits for a response by sleeping
> > > PCI_DOE_POLL_INTERVAL (PCI_DOE_TIMEOUT / 128) between status reads,
> > > which is 7 ms at HZ=1000 and 4 ms at HZ=250. Exchanges are served from
> > > the device's local mailbox logic and typically complete within tens of
> > > microseconds, so nearly all of that sleep is wasted. Every DOE-capable
> > > endpoint pays it once per supported feature during enumeration.
> > >
> > > Poll with usleep_range(20, 50) for the first ~2 ms before falling back
> > > to the jiffies-based wait. On an Intel Emerald Rapids system, time spent
> > > in pci_device_add() for a DOE-capable endpoint drops from 41.8 ms to
> > > 14.0 ms.
> >
> > Polling is just a poor man's replacement for interrupts.  DOE supports
> > interrupt-driven transfers but we're not taking advantage of it so far.
> >
> > Perhaps you could look into adding that?  It would seem more worthwhile
> > than optimizing polling.
> 
> Thanks for the quick response.
> 
> This code runs during PCI device enumeration, before a driver is
> bound, so the core doesn't really have an interrupt to work with:
> MSI/MSI-X vectors belong to the driver, and enabling them in the
> core would collide with its later pci_alloc_irq_vectors(); INTx
> isn't routed yet either, since dev->irq only becomes valid via
> acpi_pci_irq_enable() at pci_enable_device() time.

Do we have to run the DOE setup code during enumeration at all?  Maybe
we can wait until a user that needs DOE functionality comes along?
