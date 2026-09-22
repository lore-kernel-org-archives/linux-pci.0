Received: from mta1.migadu.com (out-96.mta1.migadu.com [95.215.58.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21445C70B
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113670; cv=none; b=NTszF3FMC3ROUp899pJDoc57IkI2/bmd4pffXZZ1Y092EJjsUS7Rw50Oq2THCmHJTeyD8SxvF2jLF8r7bcEaHUm7Bsz3TOB0K1RPmtjCXPdp9zR0+Tr1Ax5rcJiPHe5B0CQjL/SihepO1RdeLE3PHmz9ISjPy17sEM0dbL5CHJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113670; c=relaxed/simple;
	bh=j978S3kujL0t2IzwtfW4gW4OFjeQsDQ4dfVPJMp9cw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSUby/NE3BdVteLL3Jmpn4UM46KRY6agfx6stiWscAMWtBCyU7dJh/L3UVJPJyGYyhBixg+XcDtIWTzhkRJWVWWqRiXEA8xvrzrNq8qn29HEdChuBIWEF8WCtJFycfDpOmYU9yvSjgnzEH4Yf2ti7RGn3pV9CNXZy908ZluQk2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mvujhRK3; arc=none smtp.client-ip=95.215.58.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mvujhRK3"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=j978S3kujL0t2IzwtfW4gW4OFjeQsDQ4dfVPJMp9cw0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790113658; v=1; x=1790718458;
 b=mvujhRK3HPNWh5jZ1O6mWbwgc5ofxed21gj77WTukikBzLL5PMkjFm9ZNtoKhhu+ze6BQWY9
 S62VL/gheKaPl6qzTKvUmIpaGRvnG4+/Yk5aA9180TL2mN1+7ZAiTJkXbJDW9pMpJjimd9oazka
 4AbRgZbCIhZWTlIX8GqCS3dA=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dcd07712fee43c99;
	Tue, 22 Sep 2026 21:47:38 +0000
X-Mizu-Trace-ID: dcd07712fee43c99
X-Migadu-Flow: FLOW_OUT
Message-ID: <4e893390-ac53-4c50-b2b4-50d415ff3d1f@linux.dev>
Date: Tue, 22 Sep 2026 14:47:31 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] PCI: liveupdate: PCI core support for Live
 Update
To: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
 David Rientjes <rientjes@google.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pranjal Shrivastava <praan@google.com>, Pratyush Yadav
 <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>,
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
References: <20260918200640.887030-1-dmatlack@google.com>
 <079e343d-c6a6-4430-b900-25918197bfad@linux.dev>
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <079e343d-c6a6-4430-b900-25918197bfad@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/9/22 11:54, Zhu Yanjun 写道:
> 在 2026/9/18 13:06, David Matlack 写道:
>> This series can be found on GitHub:
>>
>>    https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v9
>>
>> This series introduces support in the PCI core for Live Update, enabling
>> drivers to preserve PCI devices across a kexec-based kernel update
>> without interrupting the device. This functionality is critical for
>> minimizing downtime in environments where PCI devices (e.g., those
>> assigned to VMs via VFIO) must continue operating or maintain state
>> across a host kernel upgrade.
>>
>> Specifically, this series allows preserved PCI devices to perform
>> uninterrupted memory transactions (DMA) targeting system memory
>> (specifically, preserved memfds) across a Live Update. These devices can
>> be behind a bridge but must not be VFs. Support for P2P and VF
>> preservation will be addressed in future series.
>>
>> Series Overview
>> ---------------
>>
>> This series implements the following to support PCI device preservation
>> across Live Update:
>>
>>    1. Set up a File-Lifecycle-Bound (FLB) handler to track and preserve
>>       PCI-specific state (struct pci_ser) across Live Update using Kexec
>>       Handover (KHO).
>>
>>    2. Add APIs for drivers to register devices for preservation
>>       (outgoing) and for the PCI core to identify preserved devices
>>       during enumeration (incoming)
>>
>>    3. Automatically preserve all upstream bridges for any preserved
>>       endpoint. Use reference counting to ensure bridges remain 
>> preserved
>>       as long as any downstream device is preserved.
>>
>>    4. Guarantee that preserved devices retain the same RequesterID (bus,
>>       device, function) for the duration of their preservation by
>>       inheriting secondary bus numbers, subordinate bus numbers, and ARI
>>       Forwarding Enable on preserved bridges.
>>
>>    5. Guarantee that memory transactions to/from preserved devices are
>>       routed consistently by inheriting Access Control Services (ACS)
>>       flags across a Live Update, from the endpoint up to the root port.
>>
>>    6. Modify the PCI shutdown path to avoid disabling bus mastering on
>>       preserved devices, thereby allowing preserved devices to perform
>>       uninterrupted during kexec for Live Update.
>>
>>    7. Provide comprehensive documentation for the FLB API, device
>>       tracking mechanisms, and the division of responsibilities between
>>       the PCI core, drivers, and userspace.
>>
>> Merge Plan
>> ----------
>>
>> This series will be merged through liveupdate.git, matching the
>> agreed-upon tree in the MAINTAINERS entry for PCI LIVE UPDATE.
>>
>> Testing
>> -------
>>
>> This series was tested in conjunction with v5 of the VFIO PCI driver
>> series:
>>
>> https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/
>>
>> The full set of patches used for testing can be found on GitHub.
>>
>> https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v9-with-vfio
>>
>> Testing was performed using the new VFIO selftests:
>>
>>    - vfio_pci_liveupdate_uapi_test
>>    - vfio_pci_liveupdate_kexec_test
>
> With this vfio_pci_liveupdate_kexec_test based on this patchset v9, I 
> have made tests in my local kvm. It worked as expected.
>
> Yanjun Zhu

The test result with vfio_pci_liveupdate_kexec_test is as below.


1.
insmod 
/lib/modules/7.3.0-rc1-dmabuf+/kernel/drivers/iommu/iommufd/iommufd.ko
insmod /lib/modules/7.3.0-rc1-dmabuf+/kernel/drivers/vfio/vfio.ko
insmod 
/lib/modules/7.3.0-rc1-dmabuf+/kernel/drivers/vfio/vfio_iommu_type1.ko
insmod 
/lib/modules/7.3.0-rc1-dmabuf+/kernel/drivers/vfio/pci/vfio-pci-core.ko
insmod /lib/modules/7.3.0-rc1-dmabuf+/kernel/drivers/vfio/pci/vfio-pci.ko
+ echo "vfio-pci" > /sys/bus/pci/devices/0000:00:04.0/driver_override
+ echo "0000:00:04.0" > /sys/bus/pci/drivers/vfio-pci/bind
Preserving device in session
Preserving memfd of size 0x40100000 in session
# [STAGE 1] Forking persistent child to hold sessions...
# [STAGE 1] Child PID: 1214. Resources are pinned.
# [STAGE 1] You may now perform kexec reboot.

2. kexec reboot

3.
insmod 
/lib/modules/7.3.0-rc1-dmabuf+/kernel/drivers/iommu/iommufd/iommufd.ko
insmod /lib/modules/7.3.0-rc1-dmabuf+/kernel/drivers/vfio/vfio.ko
insmod 
/lib/modules/7.3.0-rc1-dmabuf+/kernel/drivers/vfio/vfio_iommu_type1.ko
insmod 
/lib/modules/7.3.0-rc1-dmabuf+/kernel/drivers/vfio/pci/vfio-pci-core.ko
insmod /lib/modules/7.3.0-rc1-dmabuf+/kernel/drivers/vfio/pci/vfio-pci.ko
+ echo "vfio-pci" > /sys/bus/pci/devices/0000:00:04.0/driver_override
+ echo "0000:00:04.0" > /sys/bus/pci/drivers/vfio-pci/bind
Retrieving memfd from LUO
Finishing the session before retrieving the device (should fail)
Retrieving the device FD from LUO
Finishing the session before binding to iommufd (should fail)
Binding the device to an iommufd and setting it up
Finishing the session

Yanjun Zhu

>
>>
>> Both tests were run in a QEMU-based VM environment (using a single
>> virtio-net PCIe device connected to a root port to exercise bridge
>> support) and on bare metal using an Intel EMR server with 8x Intel DSA
>> PCIe devices and 1x NVMe device.
>>
>> Future Work
>> -----------
>>
>> Following this series, we expect to make further improvements to the PCI
>> core support for Live Update:
>>
>>    - Allow P2P across Live Update by avoiding resizing or moving
>>      preserved device BARs and preserving all upstream bridge windows.
>>
>>    - Support preserving Virtual Functions by preserving SR-IOV
>>      configuration on PFs and enumerating VFs after Live Update.
>>
>> Changelog
>> ---------
>>
>> v9:
>>   - Simplify pci_liveupdate_preserve_bus_numbers() to always return true
>>     if a device was preserved and drop pci_liveupdate_scan_bridge_end()
>>     (Bjorn)
>>   - Add pci_liveupdate_refuse_bus_numbers() to determine when it is safe
>>     for the PCI core to assign bus numbers to unconfigured bridges. This
>>     required moving "Auto-preserve upstream bridges across Live Update"
>>     before "Preserve bus numbers during Live Update" (Bjorn)
>>   - Add "PCI: Save and restore the ACS Control register" so that the ACS
>>     Control register is handled by the normal save/restore path (Bjorn)
>>   - Rename struct pci_liveupdate::was_preserved to was_incoming, to
>>     disambiguate incoming from outgoing preservation (me)
>>   - Log unfinished preserved devices from the incoming FLB rather than
>>     by walking struct pci_dev (Sashiko)
>>   - Document that state handed over by the previous kernel is trusted,
>>     and panic in pci_flb_retrieve() where failures are detected rather
>>     than unwinding into a caller that panics anyway (Sashiko)
>>   - Fall back to programming ACS from scratch when a preserved device 
>> has
>>     no ACS save buffer, since there is nowhere to record the adopted
>>     controls and they would be lost by the first reset (Sashiko)
>>   - Drop Reviewed-by tags from "Preserve bus numbers during Live Update"
>>     and "Adopt ACS controls in incoming preserved devices", both of 
>> which
>>     changed materially since v8
>>   - Extend commit messages and kernel-doc comments to make the FLB code
>>     flow more clear (Bjorn)
>>   - Address various spelling, formatting, and stylistic issues (Bjorn)
>>
>> v8: 
>> https://lore.kernel.org/linux-pci/20260728221007.2098560-1-dmatlack@google.com/
>> v7: 
>> https://lore.kernel.org/linux-pci/20260710212616.1351130-1-dmatlack@google.com/
>> v6: 
>> https://lore.kernel.org/linux-pci/20260522202410.3104264-1-dmatlack@google.com/
>> v5: 
>> https://lore.kernel.org/linux-pci/20260512184846.119396-1-dmatlack@google.com/
>> v4: 
>> https://lore.kernel.org/linux-pci/20260423212316.3431746-1-dmatlack@google.com/
>> v3: 
>> https://lore.kernel.org/kvm/20260323235817.1960573-1-dmatlack@google.com/
>> v2: 
>> https://lore.kernel.org/kvm/20260129212510.967611-1-dmatlack@google.com/
>> v1: 
>> https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/
>> rfc: 
>> https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/
>>
>>
>> David Matlack (13):
>>    PCI: liveupdate: Set up FLB handler for the PCI core
>>    PCI: liveupdate: Track outgoing preserved PCI devices
>>    PCI: liveupdate: Track incoming preserved PCI devices
>>    PCI: liveupdate: Document driver binding responsibilities
>>    PCI: liveupdate: Auto-preserve upstream bridges across Live Update
>>    PCI: liveupdate: Preserve bus numbers during Live Update
>>    PCI: Refactor matching logic for pci_dev_acs_ops
>>    PCI: Save and restore the ACS Control register
>>    PCI: liveupdate: Adopt ACS controls in incoming preserved devices
>>    PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
>>    PCI: liveupdate: Freeze preservation status during shutdown
>>    PCI: liveupdate: Do not disable bus mastering on preserved devices
>>      during kexec
>>    Documentation: PCI: Add documentation for Live Update
>>
>>   Documentation/PCI/index.rst                   |    1 +
>>   Documentation/PCI/liveupdate.rst              |   35 +
>>   .../admin-guide/kernel-parameters.txt         |    7 +-
>>   Documentation/core-api/liveupdate.rst         |    5 +
>>   MAINTAINERS                                   |   15 +
>>   drivers/pci/Kconfig                           |   15 +
>>   drivers/pci/Makefile                          |    1 +
>>   drivers/pci/liveupdate.c                      | 1015 +++++++++++++++++
>>   drivers/pci/liveupdate.h                      |   62 +
>>   drivers/pci/pci-driver.c                      |    9 +-
>>   drivers/pci/pci.c                             |   79 +-
>>   drivers/pci/pci.h                             |    5 +
>>   drivers/pci/probe.c                           |   16 +-
>>   drivers/pci/quirks.c                          |   58 +-
>>   include/linux/kho/abi/pci.h                   |   66 ++
>>   include/linux/pci.h                           |    7 +
>>   include/linux/pci_liveupdate.h                |   72 ++
>>   17 files changed, 1429 insertions(+), 39 deletions(-)
>>   create mode 100644 Documentation/PCI/liveupdate.rst
>>   create mode 100644 drivers/pci/liveupdate.c
>>   create mode 100644 drivers/pci/liveupdate.h
>>   create mode 100644 include/linux/kho/abi/pci.h
>>   create mode 100644 include/linux/pci_liveupdate.h
>>
>>
>> base-commit: 945d61765894dda2f0344de50cb1ade2e51b66fd
>
-- 
Best Regards,
Yanjun.Zhu

