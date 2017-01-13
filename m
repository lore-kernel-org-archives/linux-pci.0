Return-Path: <SRS0=pELT=Y3=etas.com=mathias.koehrer@kernel.org>
Return-Path: <SRS0=pELT=Y3=etas.com=mathias.koehrer@kernel.org>
From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Matthew Garrett <mjg59@coreos.com>, Julia Cartwright
	<julia@ni.com>, Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: RE: [PATCH] Force to clear ASPM bits if CONFIG_PCIEASPM_PERFORMANCE
 is set
Date: Fri, 13 Jan 2017 08:48:24 +0000
Message-ID: <5826c4eebc0841efb8a5865e4ccd8aad@FE-MBX1012.de.bosch.com>
References: <95e1fc6e84cf42e094d4a8478c37b18e@FE-MBX1012.de.bosch.com>
 <20161208222025.GB6693@bhelgaas-glaptop.roam.corp.google.com>
 <70624f4bf1514e48ae29e84998a81a80@FE-MBX1012.de.bosch.com>
 <20170112205458.GC8312@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170112205458.GC8312@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn
=20
thanks for taking care of this issue.
> The 387d37577fdd *does* say that it mimics the behavior of Windows.
> Is there any chance you could test that, Mathias?
Unfortunately no.  Sorry for that.

Regards

Mathias
