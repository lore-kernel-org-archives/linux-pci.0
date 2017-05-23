Return-Path: <SRS0=Y20I=45=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=Y20I=45=free.fr=slash.tmp@kernel.org>
Subject: Re: [PATCH v4 0/2] Tango PCIe controller support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
 <20170523171758.GC24431@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <cb5d08d6-bbbe-486f-b721-2eeeb410ab5e@free.fr>
Date: Tue, 23 May 2017 20:07:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170523171758.GC24431@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 23/05/2017 19:17, Bjorn Helgaas wrote:
>
> On Thu, Apr 20, 2017 at 04:24:39PM +0200, Marc Gonzalez wrote:
>
>> This patch was split in two, to ease review of two orthogonal
>> parts (MSI controller and host bridge). NB: the patch is
>> just split in two where host bridge support starts.
> 
> The split is backwards.  The first patch should add basic host bridge
> support that is functional, though lacking MSI support.  The second should
> add the MSI support.

OK, I'll invert the patches.

Note: the bridge does not support legacy interrupts.
Without MSI support, EPs can't interrupt the host.
Is that still considered functional?

Regards.
