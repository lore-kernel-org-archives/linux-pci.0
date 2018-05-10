Return-Path: <SRS0=EGMn=H5=fredlawl.com=fred@kernel.org>
Return-Path: <SRS0=EGMn=H5=fredlawl.com=fred@kernel.org>
Subject: Re: [PATCH] PCI: Check whether bridges allow access to extended
 config space
To: Gilles Buloz <Gilles.Buloz@kontron.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 "Minghuan.Lian@nxp.com" <Minghuan.Lian@nxp.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sinan Kaya <okaya@codeaurora.org>
References: <20180504200600.GA9529@bhelgaas-glaptop.roam.corp.google.com>
 <20180507215619.GA161390@bhelgaas-glaptop.roam.corp.google.com>
 <5AF2E91E.3030804@kontron.com>
From: Frederick Lawler <fred@fredlawl.com>
Message-ID: <4d54d03c-e450-5ae2-853f-1d4fe4ed3b85@fredlawl.com>
Date: Wed, 9 May 2018 21:44:58 -0500
MIME-Version: 1.0
In-Reply-To: <5AF2E91E.3030804@kontron.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi,

Gilles Buloz wrote:
> Here are full dmesg + lspci -vv + ... for the following cases :
> - 4.17-rc1_probe_failed_without_pcieaspmoff.txt : I get a broken PCI config at most boots, without pcie_aspm=off
> - 4.17-rc1_probe_ok_without_pcieaspmoff.txt : I get a correct PCI config at some boots, even without pcie_aspm=off
> - 4.17-rc1_probe_always_ok_with_pcieaspmoff.txt : I get a correct PCI config at all boots when using pcie_aspm=off
> - 4.1.35_probe_always_ok_without_pcieaspmoff.txt : I get a correct PCI config at all boots when using kernel 4.1.35-rt41 (from NXP
> Yocto BSP), even without pcie_aspm=off
> 
> I noticed these strange things :
> - with 4.17-rc1, without pcie_aspm=off, the kernel is hanging during ~1 second :
>     - before line "ASPM: Could not configure common clock" when PCI config is OK
>     - or before line "bridge configuration invalid ([bus ff-ff]), reconfiguring" when PCI config is NOT OK
>       (the FFs in "[bus ff-ff]" seems side effects of read returning ~0 because device is off)
> - no such hang when pcie_aspm=off is used
> - applying reverse patch for "PCI/ASPM: Don't warn if already in common clock mode"
>     (commit 04875177dbe034055f23960981ecf6fb8ea1d638) does not give more message

I submitted this as a bug here:
https://bugzilla.kernel.org/show_bug.cgi?id=199671

Thanks,
Fred
