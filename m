Return-Path: <SRS0=iDPi=YF=gmail.com=tom.leiming@kernel.org>
Return-Path: <SRS0=iDPi=YF=gmail.com=tom.leiming@kernel.org>
MIME-Version: 1.0
In-Reply-To: <0acc4062-cc05-f1b5-7e5d-a06a5f299d97@huawei.com>
References: <1479816529-97410-1-git-send-email-liudongdong3@huawei.com>
 <CACVXFVMidDQO-hj6tivv=t2BGTbDXK5TH9ommLES67qFJpTNBg@mail.gmail.com> <0acc4062-cc05-f1b5-7e5d-a06a5f299d97@huawei.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 22 Dec 2016 20:40:12 +0800
Message-ID: <CACVXFVN0jGq7EDjkH5a4dCWtUpeFKyL4ur2tNX0Sbj6DcUzB-g@mail.gmail.com>
Subject: Re: [PATCH V6 0/2] Add ACPI support for HiSilicon SoCs Host Controllers
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: helgaas@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, tn@semihalf.com,
	wangzhou1@hisilicon.com, Pratyush Anand Thakur <pratyush.anand@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jon Masters <jcm@redhat.com>,
	gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
	Hanjun Guo <hanjun.guo@linaro.org>, linuxarm@huawei.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Hi Dongdong,

On Thu, Dec 22, 2016 at 8:30 PM, Dongdong Liu <liudongdong3@huawei.com> wro=
te:
> Hi Ming
>
> The latest patchset is [PATCH v11 00/15] PCI: ARM64 ECAM quirks
> You can get them from
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git (pci/ecam=
)

OK, thanks, looks it has been in linus tree.

Thanks,
Ming

>
> Thanks
> Dongdong
>
> =E5=9C=A8 2016/12/22 16:31, Ming Lei =E5=86=99=E9=81=93:
>>
>> Hi Dongdong,
>>
>> On Tue, Nov 22, 2016 at 8:08 PM, Dongdong Liu <liudongdong3@huawei.com>
>> wrote:
>>>
>>> This patchset adds ACPI support for the HiSilicon Hip05/Hip06/Hip07 SoC
>>> PCIe controllers.
>>> The two patches respectively:
>>>         - provides the common function acpi_get_rc_resources() for ARM6=
4
>>>           platform.
>>>         - adds the HiSilicon ACPI specific quirks.
>>>
>>> This patchset is based on branch pci/ecam-v6
>>> It can be found here:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git(pci/eca=
m-v6)
>>>
>>> This patchset has been tested on HiSilicon D03 board.
>>> The dmesg log, /proc/iomem, and ACPI table information can be found:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D187961
>>>
>>> v5 -> v6:
>>> - change the config option to CONFIG_PCI_ECAM_QUIRKS.
>>> - fix some commets about acpi_get_rc_resources().
>>
>>
>> Could you post out v7 for fixing conflicts against current linus tree?
>>
>> BTW, I tried to fix the conflicts by myself, but still caues the followi=
ng
>> build failure:
>>
>> [tom@linux-2.6-vm]$make -j4 CROSS_COMPILE=3Daarch64-linux-gnu-
>> ARCH=3Darm64 drivers/pci/host/pcie-hisi-acpi.o
>>   CHK     include/config/kernel.release
>>   CHK     include/generated/uapi/linux/version.h
>>   CHK     include/generated/utsrelease.h
>>   CHK     include/generated/timeconst.h
>>   CHK     include/generated/bounds.h
>>   CHK     include/generated/asm-offsets.h
>>   CALL    scripts/checksyscalls.sh
>>   CC      drivers/pci/host/pcie-hisi-acpi.o
>> In file included from drivers/pci/host/pcie-hisi-acpi.c:16:0:
>> drivers/pci/host/../pci.h:357:18: error: conflicting types for
>> =E2=80=98acpi_get_rc_resources=E2=80=99
>>  struct resource *acpi_get_rc_resources(const char *hid, u16 segment);
>>                   ^
>> drivers/pci/host/../pci.h:352:5: note: previous declaration of
>> =E2=80=98acpi_get_rc_resources=E2=80=99 was here
>>  int acpi_get_rc_resources(struct device *dev, const char *hid, u16
>> segment,
>>      ^
>> scripts/Makefile.build:293: recipe for target
>> 'drivers/pci/host/pcie-hisi-acpi.o' failed
>> make[1]: *** [drivers/pci/host/pcie-hisi-acpi.o] Error 1
>> Makefile:1640: recipe for target 'drivers/pci/host/pcie-hisi-acpi.o'
>> failed
>> make: *** [drivers/pci/host/pcie-hisi-acpi.o] Error 2
>>
>>
>> Thanks,
>> Ming
>>
>>>
>>> v4 -> v5:
>>> - obtain rc base addresses from PNP0C02 at the root of the ACPI
>>>   namespace (under \_SB) instead of from sub-device under the RC.
>>> - merge the rewrited get rc resources code by Tomasz.
>>> - delete unused code.
>>> - drop the PATCH V4 1/2, will rework late as a separate patch.
>>>
>>> v3 -> v4:
>>> - rebase on pci/ecam-v6.
>>> - delete the unnecessary link_up check code.
>>>
>>> v2 -> v3:
>>> - rebase against 4.9-rc1 and add Tomasz quirks V6 pathcset.
>>> - obtain rc base addresses from PNP0C02 as subdevice of PNP0A03 instead
>>> of
>>>   hardcode the addresses.
>>> - modify hisi_pcie_acpi_rd_conf/hisi_pcie_acpi_wr_conf() according to
>>>   Arnd comments.
>>>
>>> v1 -> v2:
>>> - rebase against Tomasz RFC V5 quirk mechanism
>>> - add ACPI support for the HiSilicon Hip07 SoC PCIe controllers.
>>>
>>> Dongdong Liu (2):
>>>   PCI/ACPI: Provide acpi_get_rc_resources() for ARM64 platform
>>>   PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers
>>>
>>>  MAINTAINERS                       |   1 +
>>>  drivers/acpi/pci_mcfg.c           |  13 +++++
>>>  drivers/pci/host/Kconfig          |   7 +++
>>>  drivers/pci/host/Makefile         |   1 +
>>>  drivers/pci/host/pcie-hisi-acpi.c | 119
>>> ++++++++++++++++++++++++++++++++++++++
>>>  drivers/pci/pci-acpi.c            |  69 ++++++++++++++++++++++
>>>  drivers/pci/pci.h                 |   4 ++
>>>  include/linux/pci-ecam.h          |   5 ++
>>>  8 files changed, 219 insertions(+)
>>>  create mode 100644 drivers/pci/host/pcie-hisi-acpi.c
>>>
>>> --
>>> 1.9.1
>>>
>>
>>
>>
>



--=20
Ming Lei
