Return-Path: <SRS0=vWBP=BI=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=vWBP=BI=free.fr=slash.tmp@kernel.org>
Subject: Re: [PATCH v2 1/7] PCI: aardvark: fix logic in PCI configuration
 read/write functions
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
 <20170928125838.11887-2-thomas.petazzoni@free-electrons.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Victor Gu <xigu@marvell.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>
From: Mason <slash.tmp@free.fr>
Message-ID: <acc38be2-785b-fdc4-6cb7-e943bc31b620@free.fr>
Date: Mon, 9 Oct 2017 09:59:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170928125838.11887-2-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

[ NB: CC list trimmed ]

On 28/09/2017 14:58, Thomas Petazzoni wrote:

> From: Victor Gu <xigu@marvell.com>
> 
> The PCI configuration space read/write functions were special casing
> the situation where PCI_SLOT(devfn) != 0, and returned
> PCIBIOS_DEVICE_NOT_FOUND in this case.
> 
> However, will this is what is intended for the root bus, it is not

*while* this is what is intended?
