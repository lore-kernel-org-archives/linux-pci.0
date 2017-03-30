Return-Path: <SRS0=nj2g=3H=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=nj2g=3H=free.fr=slash.tmp@kernel.org>
Subject: Re: [PATCH v3 0/2] Tango PCIe controller support
To: linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <5309e718-5813-5b79-db57-9d702b50d0f9@sigmadesigns.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <1561c381-bfa7-6e4d-a016-8ad7293a60ce@free.fr>
Date: Thu, 30 Mar 2017 22:56:58 +0200
MIME-Version: 1.0
In-Reply-To: <5309e718-5813-5b79-db57-9d702b50d0f9@sigmadesigns.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 29/03/2017 13:11, Marc Gonzalez wrote:

>   PCI: Add tango MSI controller support
>   PCI: Add tango PCIe host bridge support

I've run into an issue.

If I boot the system with earlyprintk enabled (as I've
been doing throughout my dev), things work as expected.

But if I boot with earlyprintk disabled, then the system
does not "see" the PCIe board, because reading the vendor
ID returns 0xffffffff.

What we think is happening, is that when earlyprintk is
disabled, the system proceeds much faster through the
various inits, and the PCIe init happens when PCIe
link training has not completed yet.

If that is the case, then it seems I would need to check
the link state in my probe function.

Or would there be some other solution I haven't thought
about?

Regards.
