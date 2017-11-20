Return-Path: <SRS0=pnR4=CS=oracle.com=boris.ostrovsky@kernel.org>
Return-Path: <SRS0=pnR4=CS=oracle.com=boris.ostrovsky@kernel.org>
Subject: Re: [PATCH v9 4/5] x86/PCI: Enable a 64bit BAR on AMD Family 15h
 (Models 30h-3fh) Processors v5
To: christian.koenig@amd.com, helgaas@kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
References: <20171018135821.3248-1-deathsimple@vodafone.de>
 <20171018135821.3248-5-deathsimple@vodafone.de>
 <c5ca14bc-3812-ff15-7dd0-e862ce85a348@oracle.com>
 <d81d50e6-c267-fe43-214f-278e57903448@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <26df0a78-8028-e42c-ce50-4cefe612a7e1@oracle.com>
Date: Mon, 20 Nov 2017 11:33:49 -0500
MIME-Version: 1.0
In-Reply-To: <d81d50e6-c267-fe43-214f-278e57903448@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 11/20/2017 11:07 AM, Christian König wrote:
> Am 20.11.2017 um 16:51 schrieb Boris Ostrovsky:
>>
>> (and then it breaks differently as a Xen guest --- we hung on the last
>> pci_read_config_dword(), I haven't looked at this at all yet)
>
> Hui? How does this fix applies to a Xen guest in the first place?
>
> Please provide the output of "lspci -nn" and explain further what is
> your config with Xen.
>
>


This is dom0.

-bash-4.1# lspci -nn
00:00.0 Host bridge [0600]: ATI Technologies Inc RD890 Northbridge only
dual slot (2x16) PCI-e GFX Hydra part [1002:5a10] (rev 02)
00:00.2 Generic system peripheral [0806]: ATI Technologies Inc Device
[1002:5a23]
00:0d.0 PCI bridge [0604]: ATI Technologies Inc RD890 PCI to PCI bridge
(external gfx1 port B) [1002:5a1e]
00:11.0 SATA controller [0106]: ATI Technologies Inc SB700/SB800 SATA
Controller [AHCI mode] [1002:4391]
00:12.0 USB Controller [0c03]: ATI Technologies Inc SB700/SB800 USB
OHCI0 Controller [1002:4397]
00:12.1 USB Controller [0c03]: ATI Technologies Inc SB700 USB OHCI1
Controller [1002:4398]
00:12.2 USB Controller [0c03]: ATI Technologies Inc SB700/SB800 USB EHCI
Controller [1002:4396]
00:13.0 USB Controller [0c03]: ATI Technologies Inc SB700/SB800 USB
OHCI0 Controller [1002:4397]
00:13.1 USB Controller [0c03]: ATI Technologies Inc SB700 USB OHCI1
Controller [1002:4398]
00:13.2 USB Controller [0c03]: ATI Technologies Inc SB700/SB800 USB EHCI
Controller [1002:4396]
00:14.0 SMBus [0c05]: ATI Technologies Inc SBx00 SMBus Controller
[1002:4385] (rev 3d)
00:14.3 ISA bridge [0601]: ATI Technologies Inc SB700/SB800 LPC host
controller [1002:439d]
00:14.4 PCI bridge [0604]: ATI Technologies Inc SBx00 PCI to PCI Bridge
[1002:4384]
00:14.5 USB Controller [0c03]: ATI Technologies Inc SB700/SB800 USB
OHCI2 Controller [1002:4399]
00:18.0 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1600]
00:18.1 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1601]
00:18.2 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1602]
00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1603]
00:18.4 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1604]
00:18.5 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1605]
00:19.0 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1600]
00:19.1 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1601]
00:19.2 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1602]
00:19.3 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1603]
00:19.4 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1604]
00:19.5 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1605]
01:04.0 VGA compatible controller [0300]: Matrox Graphics, Inc. MGA
G200eW WPCM450 [102b:0532] (rev 0a)
02:00.0 Ethernet controller [0200]: Intel Corporation 82576 Gigabit
Network Connection [8086:10c9] (rev 01)
02:00.1 Ethernet controller [0200]: Intel Corporation 82576 Gigabit
Network Connection [8086:10c9] (rev 01)
-bash-4.1#


-boris
