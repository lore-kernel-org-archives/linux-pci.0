Return-Path: <SRS0=mae5=3G=ACULAB.COM=David.Laight@kernel.org>
Return-Path: <SRS0=mae5=3G=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Robin Murphy' <robin.murphy@arm.com>, Mason <slash.tmp@free.fr>
CC: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Bjorn Helgaas
	<helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner
	<tglx@linutronix.de>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Liviu
 Dudau" <liviu.dudau@arm.com>, linux-pci <linux-pci@vger.kernel.org>, Linux
 ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic
	<thibaud_cornic@sigmadesigns.com>, Phuong Nguyen
	<phuong_nguyen@sigmadesigns.com>, LKML <linux-kernel@vger.kernel.org>, DT
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] PCI: Add tango PCIe host bridge support
Date: Wed, 29 Mar 2017 14:38:28 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFC1507@AcuExch.aculab.com>
References: <5309e718-5813-5b79-db57-9d702b50d0f9@sigmadesigns.com>
 <65114e62-7458-b6f7-327c-f07a5096a452@sigmadesigns.com>
 <01516ad9-e187-4bac-7c65-a7a90c576ce2@arm.com>
 <96da696c-141a-3e8d-1fb7-2c024a295f58@free.fr>
 <84a8b26d-7d24-df29-3959-45fce880916d@arm.com>
In-Reply-To: <84a8b26d-7d24-df29-3959-45fce880916d@arm.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

> > For my education, what is the API to send an IPI?
> > And the API to handle an IPI?
>=20
> There are a few ways you could implement some custom cross-call,
> although in this case I think stop_machine() would probably be the most
> appropriate candidate. However, you're right that in general it may not
> actually help enough to be worthwhile - a DSB SY would ensure that
> in-flight transactions have at least been observed by the CPUs and any
> other coherent masters, but for any writes with a memory type allowing
> early acknowledgement (i.e. a Normal or Device mapping of a BAR) that
> doesn't necessarily correlate with them having reached their ultimate
> destination. For a PCI destination in particular, I think the normal way
> to ensure all posted writes have completed would be to read from config
> space; ah...

He almost certainly doesn't need to wait for the cycle to complete,
just long enough for the cycle to have been sent.

	David
