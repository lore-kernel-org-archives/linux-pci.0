Return-Path: <SRS0=NdyI=CS=nvidia.com=vidyas@kernel.org>
Return-Path: <SRS0=NdyI=CS=nvidia.com=vidyas@kernel.org>
Subject: Re: [PATCH V3 0/2] Tegra PCIe end point config space map code
 refactoring
To: <treding@nvidia.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <bhelgaas@google.com>,
	<linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <robh+dt@kernel.org>,
	<devicetree@vger.kernel.org>
References: <1508827489-10842-1-git-send-email-vidyas@nvidia.com>
 <20171024201512.GG21840@bhelgaas-glaptop.roam.corp.google.com>
 <20171106195123.GG31930@bhelgaas-glaptop.roam.corp.google.com>
From: Vidya Sagar <vidyas@nvidia.com>
Message-ID: <2d2ec183-c14c-1eb8-0cd5-fd62d8b36779@nvidia.com>
Date: Mon, 20 Nov 2017 15:57:18 +0530
MIME-Version: 1.0
In-Reply-To: <20171106195123.GG31930@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Thierry, Can you please Ack it so that we can target it for next release?

On Tuesday 07 November 2017 01:21 AM, Bjorn Helgaas wrote:
> On Tue, Oct 24, 2017 at 03:15:12PM -0500, Bjorn Helgaas wrote:
>> On Tue, Oct 24, 2017 at 12:14:47PM +0530, Vidya Sagar wrote:
>>> PCIe host controller in Tegra SoCs has 1GB of aperture available
>>> for mapping end points config space, IO and BARs. In that, currently
>>> 256MB is being reserved for mapping end points configuration space
>>> which leaves less memory space available for mapping end points BARs
>>> on some of the platforms.
>>> This patch series attempts to map only 4K space from 1GB aperture to
>>> access end points configuration space.
>>>
>>> Currently, this change can benefit T20 and T186 in saving (i.e. repurposed
>>> to use for BAR mapping) physical space as well as kernel virtual mapping space,
>>> it saves only kernel virtual address space in T30, T124, T132 and T210.
>>>
>>> NOTE: Since T186 PCIe DT entry is not yet present in main line (it is currently
>>> merged to 'for-4.15/arm64/dt' branch), nothing gets broken with this change for T186.
>>> For older platforms (T20, T30, T124, T132, T210), this change works fine without any
>>> DT modifications
>>>
>>> Testing Done on T124, T210 & T186:
>>>   Enumeration and basic functionality of immediate devices
>>>   Enumeration of devices behind a PCIe switch
>>>   Complete 4K configuration space access
>>>
>>> Vidya Sagar (2):
>>>    PCI: tegra: refactor config space mapping code
>>>    ARM64: tegra: limit PCIe config space mapping to 4K for T186
>>>
>>>   arch/arm64/boot/dts/nvidia/tegra186.dtsi |   8 +-
>>>   drivers/pci/host/pci-tegra.c             | 125 ++++++++++---------------------
>>>   2 files changed, 44 insertions(+), 89 deletions(-)
>> Seems OK to me; waiting for Thierry's ack.
> Dropping for lack of an ack.  Please repost if/when Thierry acks it.
