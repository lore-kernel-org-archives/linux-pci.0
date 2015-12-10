Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] PCI/AER: enable SERR# forwarding for bridges and
 switches
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1449074998-9664-1-git-send-email-okaya@codeaurora.org>
 <20151204210622.GI20125@localhost>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, izumi.taku@jp.fujitsu.com, jcm@redhat.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5669E073.4000801@codeaurora.org>
Date: Thu, 10 Dec 2015 15:28:35 -0500
MIME-Version: 1.0
In-Reply-To: <20151204210622.GI20125@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 12/4/2015 4:06 PM, Bjorn Helgaas wrote:
> I'm sitting on this for the moment because if you have _HPP, it seems
> like that should be enough to get SERR# forwarding turned on, and if
> it's not, I'd like to understand why.  So no hurry, but I'm waiting on
> your investigation.
> 
> Bjorn

Here is the overall summary after my investigation.

It looks like the kernel covers the hotplug use case. This patch is
needed for systems without hotplug support and when the firmware is not
setting up the SERR.

after boot

/# dmesg | grep hpp

[    3.115227] pci 0004:01:00.0: program_hpp_type0:1376
[    3.128870] pci 0004:01:00.0: program_hpp_type0:1378 pci_cmd |=
PCI_COMMAND_SERR
[    3.149597] pci 0004:01:00.0: program_hpp_type0:1391 pci_bctl |=
PCI_BRIDGE_CTL_SERR
[    3.191601] pci 0004:02:08.0: program_hpp_type0:1376
[    3.191611] pci 0004:02:08.0: program_hpp_type0:1378 pci_cmd |=
PCI_COMMAND_SERR
[    3.206630] pci 0004:02:08.0: program_hpp_type0:1391 pci_bctl |=
PCI_BRIDGE_CTL_SERR
[    3.253760] pci 0004:03:00.0: program_hpp_type0:1376
[    3.267335] pci 0004:03:00.0: program_hpp_type0:1378 pci_cmd |=
PCI_COMMAND_SERR
[    3.288046] pci 0004:03:00.0: program_hpp_type0:1391 pci_bctl |=
PCI_BRIDGE_CTL_SERR
[    3.355296] pci 0004:04:00.0: program_hpp_type0:1376
[    3.355306] pci 0004:04:00.0: program_hpp_type0:1378 pci_cmd |=
PCI_COMMAND_SERR
[    3.370334] pci 0004:04:00.0: program_hpp_type0:1391 pci_bctl |=
PCI_BRIDGE_CTL_SERR

/ # lspci
00:00.0 Class 0604: 17cb:0400
01:00.0 Class 0604: 10b5:8732
02:08.0 Class 0604: 10b5:8732
03:00.0 Class 0604: 10b5:8732
04:00.0 Class 0604: 10b5:8732
/ #


Without hpp in ACPI table, SERR is not enabled.

/# dmesg | grep type0
/#

Power up with HPP after boot.

[    3.129325]_pci_0004:01:00.0:_program_hpp_type0:1376
[    3.143286] pci 0004:01:00.0: program_hpp_type0:1378 pci_cmd |=
PCI_COMMAND_SERR
[    3.164016] pci 0004:01:00.0: program_hpp_type0:1391 pci_bctl |=
PCI_BRIDGE_CTL_SERR
[    3.206019] pci 0004:02:08.0: program_hpp_type0:1376
[    3.206028] pci 0004:02:08.0: program_hpp_type0:1378 pci_cmd |=
PCI_COMMAND_SERR
[    3.220609] pci 0004:02:08.0: program_hpp_type0:1391 pci_bctl |=
PCI_BRIDGE_CTL_SERR
[    3.267783] pci 0004:03:00.0: program_hpp_type0:1376
[    3.281420] pci 0004:03:00.0: program_hpp_type0:1378 pci_cmd |=
PCI_COMMAND_SERR
[    3.302197] pci 0004:03:00.0: program_hpp_type0:1391 pci_bctl |=
PCI_BRIDGE_CTL_SERR
[    3.369684] pci 0004:04:00.0: program_hpp_type0:1376
[    3.369694] pci 0004:04:00.0: program_hpp_type0:1378 pci_cmd |=
PCI_COMMAND_SERR
[    3.384080] pci 0004:04:00.0: program_hpp_type0:1391 pci_bctl |=
PCI_BRIDGE_CTL_SERR

hotplug eject

hotplug insert

[   98.338131] pci 0004:01:00.0: program_hpp_type0:1376
[   98.351813] pci 0004:01:00.0: program_hpp_type0:1378 pci_cmd |=
PCI_COMMAND_SERR
[   98.373147] pci 0004:01:00.0: program_hpp_type0:1391 pci_bctl |=
PCI_BRIDGE_CTL_SERR
[   98.452051] pci 0004:02:08.0: program_hpp_type0:1376
[   98.465772] pci 0004:02:08.0: program_hpp_type0:1378 pci_cmd |=
PCI_COMMAND_SERR
[   98.487142] pci 0004:02:08.0: program_hpp_type0:1391 pci_bctl |=
PCI_BRIDGE_CTL_SERR
[   98.597579] pci 0004:03:00.0: program_hpp_type0:1376
[   98.611290] pci 0004:03:00.0: program_hpp_type0:1378 pci_cmd |=
PCI_COMMAND_SERR
[   98.632181] pci 0004:03:00.0: program_hpp_type0:1391 pci_bctl |=
PCI_BRIDGE_CTL_SERR
[   98.736153] pci 0004:04:00.0: program_hpp_type0:1376
[   98.750437] pci 0004:04:00.0: program_hpp_type0:1378 pci_cmd |=
PCI_COMMAND_SERR
[   98.771202] pci 0004:04:00.0: program_hpp_type0:1391 pci_bctl |=
PCI_BRIDGE_CTL_SERR
/ #



-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
