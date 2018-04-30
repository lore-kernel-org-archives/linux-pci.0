Return-Path: <SRS0=W8iN=HT=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=W8iN=HT=h08.hostsharing.net=foo00@kernel.org>
Date: Mon, 30 Apr 2018 23:38:26 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>,
	Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038
 (issued 65284 msec ago)
Message-ID: <20180430213826.GA6046@wunner.de>
References: <8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de>
 <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
 <b62c2a8e-fe14-6d7d-147c-0ce3b0c0ab2f@codeaurora.org>
 <20180427211255.GI8199@bhelgaas-glaptop.roam.corp.google.com>
 <20180428005620.GB1675@dhcp-128-65.nay.redhat.com>
 <20180428011845.GC1675@dhcp-128-65.nay.redhat.com>
 <3ebc908fb196168bf0373875ffc5679e@codeaurora.org>
 <d8d134dc-9757-97cd-7a24-cbb21611d6c6@codeaurora.org>
 <20180430211740.GG95643@bhelgaas-glaptop.roam.corp.google.com>
 <7285da70-2c3e-c3b7-62e1-fdbb55a77729@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7285da70-2c3e-c3b7-62e1-fdbb55a77729@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 30, 2018 at 05:27:32PM -0400, Sinan Kaya wrote:
> On 4/30/2018 5:17 PM, Bjorn Helgaas wrote:
> How about remove() only if MSI is disabled? Most root port interrupts
> are MSI based anyhow.

I think the code is perfectly fine as it is and doesn't need to nor
should be modified.  We should just add a quirk for this particular
chipset that it doesn't support Command Completed interrupts (if that's
what's broken).  In the case of Thunderbolt controllers, the first few
had the NoCompl bit set incorrectly in config space and Intel hardware
engineers confirmed the error.  These or similar oddities may occur
with more chipsets, so I propose moving existing quirks to a
separate file, thereby avoiding that they clutter generic code.
The blinkenlights feature added with commit 576243b3f9ea is a similar
quirk that could be moved to a separate pciehp_quirks.c file.

Thanks,

Lukas
