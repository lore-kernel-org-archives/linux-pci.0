Return-Path: <SRS0=ZGzV=2X=ACULAB.COM=David.Laight@kernel.org>
Return-Path: <SRS0=ZGzV=2X=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mason' <slash.tmp@free.fr>, Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci <linux-pci@vger.kernel.org>, linux-usb
	<linux-usb@vger.kernel.org>, Rob Herring <robh@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier
	<marc.zyngier@arm.com>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
	Phuong Nguyen <phuong_nguyen@sigmadesigns.com>, Shawn Lin
	<shawn.lin@rock-chips.com>, Robin Murphy <robin.murphy@arm.com>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@kernel.org>
Subject: RE: Neophyte questions about PCIe
Date: Tue, 14 Mar 2017 10:23:53 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFB0422@AcuExch.aculab.com>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
 <9ba05c2c-57ef-b2c0-6a7c-457c392d98b5@free.fr>
 <df517167-d692-38a8-9c8f-a1112c7f578d@free.fr>
 <c0a353cb-aa1f-25db-eccd-7a1618e655b3@free.fr>
 <20170313214024.GD8232@bhelgaas-glaptop.roam.corp.google.com>
 <826d0a3f-753f-0330-5792-e11beb78d6bf@free.fr>
In-Reply-To: <826d0a3f-753f-0330-5792-e11beb78d6bf@free.fr>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

From: Mason
> Sent: 13 March 2017 21:58
...
> I'd like to push support for this PCIe controller upstream.
>=20
> Is the code I posted on the right track?
> Maybe I can post a RFC patch tomorrow?

I think you need to resolve the problem of config space (and IO) cycles
before the driver can be deemed usable.

	David
