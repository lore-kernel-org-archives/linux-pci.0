Return-Path: <SRS0=t3s2=45=ti.com=kishon@kernel.org>
Return-Path: <SRS0=t3s2=45=ti.com=kishon@kernel.org>
Subject: Re: [PATCH] PCI: endpoint: PCI_ENDPOINT should depend on HAS_DMA
To: Bjorn Helgaas <helgaas@kernel.org>,
        Geert Uytterhoeven
	<geert@linux-m68k.org>
References: <1494955268-1262-1-git-send-email-geert@linux-m68k.org>
 <20170522212640.GD19733@bhelgaas-glaptop.roam.corp.google.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        Arnd
 Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c54dfb8a-68ac-dc7b-f9d6-43e1ba391275@ti.com>
Date: Tue, 23 May 2017 12:13:22 +0530
MIME-Version: 1.0
In-Reply-To: <20170522212640.GD19733@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tuesday 23 May 2017 02:56 AM, Bjorn Helgaas wrote:
> On Tue, May 16, 2017 at 07:21:08PM +0200, Geert Uytterhoeven wrote:
>> If NO_DMA=y:
>>
>>     drivers/built-in.o: In function `__pci_epc_create':
>>     (.text+0xef4e): undefined reference to `bad_dma_ops'
>>     drivers/built-in.o: In function `pci_epc_add_epf':
>>     (.text+0xf676): undefined reference to `bad_dma_ops'
>>     drivers/built-in.o: In function `pci_epf_alloc_space':
>>     (.text+0xfa32): undefined reference to `bad_dma_ops'
>>     drivers/built-in.o: In function `pci_epf_free_space':
>>     (.text+0xfac4): undefined reference to `bad_dma_ops'
>>
>> Add a dependency on HAS_DMA to fix this.
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Applied to for-linus for v4.12, thanks!
> 
>> ---
>> Should PCI_ENDPOINT depend on CONFIG_PCI instead?
> 
> I *think* we want HAS_DMA, not CONFIG_PCI, because CONFIG_PCI means we
> want the infrastructure for PCI host bridges, enumerating children of
> the bridges, etc.  I think we want to allow PCI_ENDPOINT without all
> that.
> 
> Kishon?

right. CONFIG_PCI is for enabling the host infrastructure and PCI_ENDPOINT and
CONFIG_PCI should be completely independent of each other.

Thanks
Kishon
