Return-Path: <SRS0=Aj16=IG=siemens.com=jan.kiszka@kernel.org>
Return-Path: <SRS0=Aj16=IG=siemens.com=jan.kiszka@kernel.org>
Subject: Re: [pci:next 15/20] drivers/pci/host/pcie-altera.c:496:53: sparse:
 incompatible types for operation (&)
To: Bjorn Helgaas <helgaas@kernel.org>, kbuild test robot <lkp@intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <201805190321.nss6j8Jn%fengguang.wu@intel.com>
 <20180518210332.GC41790@bhelgaas-glaptop.roam.corp.google.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <856d3483-3ce3-fe5c-4013-073bce64e1c7@siemens.com>
Date: Sat, 19 May 2018 10:06:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180518210332.GC41790@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-18 23:03, Bjorn Helgaas wrote:
> On Sat, May 19, 2018 at 03:42:27AM +0800, kbuild test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
>> head:   f8d3ac43d8cd4cfba337a50794c26c7ca89d86ac
>> commit: 927da40afdbd6a5fdd31eab6e9aa655dee1f99a4 [15/20] Merge branch 'lorenzo/pci/host/misc'
>> reproduce:
>>         # apt-get install sparse
>>         git checkout 927da40afdbd6a5fdd31eab6e9aa655dee1f99a4
>>         make ARCH=x86_64 allmodconfig
>>         make C=1 CF=-D__CHECK_ENDIAN__
>>
>>
>> sparse warnings: (new ones prefixed by >>)
>>
>>>> drivers/pci/host/pcie-altera.c:496:53: sparse: incompatible types for operation (&)
> 
> I think I fixed this; it was missing a comma at the end of the first line:
> 
>         err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff
>                                                     &pcie->resources, NULL);
> 
> This error was in the original patch, so I'm not sure if I forgot to push
> the pci/resource branch or if kbuild didn't test it for some reason.
> 
>>    /kbuild/src/sparse/drivers/pci/host/pcie-rockchip-host.c:996:15: sparse: undefined identifier 'devm_of_pci_get_host_bridge_resources'
> 
> I'm confused about this one because pcie-rockchip-host.c doesn't even exist
> in 927da40afdbd, so the steps to reproduce must not be quite right.
> 
> But I'm sure I screwed up a conflict resolution somewhere, so I'll find that,
> too.

No, this should be really just be a missing "," in my original patch
"PCI: Replace dev_node parameter of of_pci_get_host_bridge_resources
with device".

Jan
