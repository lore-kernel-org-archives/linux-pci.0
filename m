Return-Path: <SRS0=V53H=Z4=gmail.com=arndbergmann@kernel.org>
Return-Path: <SRS0=V53H=Z4=gmail.com=arndbergmann@kernel.org>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170215165616.GG19040@bhelgaas-glaptop.roam.corp.google.com>
References: <20170214214355.3101378-1-arnd@arndb.de> <20170215165616.GG19040@bhelgaas-glaptop.roam.corp.google.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Feb 2017 23:01:19 +0100
Message-ID: <CAK8P3a2D8VGuXLxzuJ1D72y0VZRSUeRYRJVCkzBovK686w_rPw@mail.gmail.com>
Subject: Re: [PATCH] PCI: always build pci-host-common on ARM64
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Daney <david.daney@cavium.com>,
	Rob Herring <robh@kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Tomasz Nowicki <tn@semihalf.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Christopher Covington <cov@codeaurora.org>, linux-pci <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 15, 2017 at 5:56 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Feb 14, 2017 at 10:42:56PM +0100, Arnd Bergmann wrote:
>> The Thunder PCI host driver is always built, but it relies on pci_host_common_probe,
>> so we get a link error here:
>>
>> drivers/pci/host/pci-thunder-pem.c: In function 'thunder_pem_probe':
>> drivers/pci/host/pci-thunder-pem.c:412:9: error: implicit declaration of function 'pci_host_common_probe';did you mean 'pci_host_bridge_priv'? [-Werror=implicit-function-declaration]
>>
>> This adds the common file to the existing hack.
>>
>> Fixes: ca5ab37b19df ("PCI: Explain ARM64 ACPI/MCFG quirk Kconfig and build strategy")
>
> I'm puzzled.  ca5ab37b19df doesn't *look* like it changes anything.
>
> thunder_pem_probe() is compiled when CONFIG_PCI_HOST_THUNDER_PEM=y,
> and it calls pci_host_common_probe().
>
> pci_host_common_probe() is in pci-host-common.c, which is compiled
> when CONFIG_PCI_HOST_COMMON=y.  But the declaration below is under
> #ifdef CONFIG_PCI_HOST_GENERIC.  Shouldn't it be under #ifdef
> CONFIG_PCI_HOST_COMMON instead?
>
> It'd be nice to know what actually broke this (if it's not
> ca5ab37b19df) so we can figure out where the fix should be backported.

Right, I misread the commit and got the wrong one. I also ran into a related
problem and will follow up with a new patch that addresses both at once.

Please ignore this version for now.

    Arnd
