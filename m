Return-Path: <roland.singer@desertbit.com>
Return-Path: <roland.singer@desertbit.com>
Subject: Re: Kernel Freeze with American Megatrends BIOS
To: Ilia Mirkin <imirkin@alum.mit.edu>
References: <004c7dbe-2014-c691-29d1-7a45f3b73dfa@desertbit.com>
 <20160829160210.GA24451@localhost>
 <1cca943f-eab4-4054-4a13-31370d7ae057@desertbit.com>
 <20160829190737.GA4053@localhost>
 <a0079ace-3062-4792-5c33-3a5e350daac3@desertbit.com>
 <20160829235403.GA14177@localhost>
 <1d1bfdc2-f23d-9816-e4e3-ae676105dc39@desertbit.com>
 <20160830130634.GA16426@localhost>
 <CACvgo51b4XLz2PwH1dkcK4_FknfZkSUKsFepYz-AGfPr7ux2kA@mail.gmail.com>
 <735da66c-aaf3-8c27-2d59-f62e8c85d3aa@desertbit.com>
 <CACvgo51gNzECupX6R7jwQndH-1rX6MN1kPquuikzJrPk3CeZVA@mail.gmail.com>
 <43ce7a5b-8331-fec2-f598-afcb13ba3785@desertbit.com>
 <CAKb7UviZ0qKp3PRR+iHr+KiOU9Sadeeb6PyydWN-FUL0RzyCPA@mail.gmail.com>
 <1c761bab-f82b-3f43-c4f0-c7a8eff94f25@desertbit.com>
 <CAKb7Uvjzhog27TUPTn5OOqXviyD_z3UV0qvskZDEO8CAB2-i2w@mail.gmail.com>
Cc: Emil Velikov <emil.l.velikov@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Peter Wu <peter@lekensteyn.nl>
From: Roland Singer <roland.singer@desertbit.com>
Message-ID: <ae547108-57bb-11a0-620b-f930ce8bf660@desertbit.com>
Date: Wed, 31 Aug 2016 13:11:54 +0200
MIME-Version: 1.0
In-Reply-To: <CAKb7Uvjzhog27TUPTn5OOqXviyD_z3UV0qvskZDEO8CAB2-i2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Am 30.08.2016 um 20:13 schrieb Ilia Mirkin:
> On Tue, Aug 30, 2016 at 2:02 PM, Roland Singer
> <roland.singer@desertbit.com> wrote:
>> I configured bbswitch to not set any states automatically...
>> So it's possible to obtain and verify the GPU power state.
>>
>> However I removed the bbswitch module and booted with nouveau.
>>
>> Kernel 4.7.2: nouveau switches the discrete GPU off.
>>               I can't trigger the freeze, because bbswitch is missing.
>>               I'll work with the system and see if it will freeze.
>>
>> Kernel 4.8-rc4: nouveau does not care about the power state and
>>                 the discrete GPU is never switched off. I will notice
>>                 this, because the second cooling FAN will stop...
>>                 Same log messages as send before.
> 
> That's surprising. I believe there's an issue with the new logic when
> there's an HDMI audio subdevice. However that only appears if there's
> a cable plugged in, at least in the systems Peter tested. You should
> be able to see whether it's there or not with 'lspci'.
> 
> You can check for sure by looking in the vgaswitcheroo state. It
> should say DynOff when it's powered off.
> 
> Either way, I think using bbswitch + nouveau isn't supported by
> anyone, so if you want to use it that way, you're on your own. (You
> may want to load nouveau with runpm=0 so that nouveau doesn't try to
> manage the GPU suspend stuff.)
> 
>   -ilia
> 

Kernel 4.8-rc4:

While running lspci, following kernel log message was printed on the TTY:

  nouveau: 0000:01:00:0: priv: HUB0: 6013d4 0000573f (1f408200)
  nouveau: 0000:01:00:0: priv: HUB0: 10ecc0 ffffffff (1940822c)

This is my output of lspci:

00:00.0 Host bridge: Intel Corporation Skylake Host Bridge/DRAM Registers (rev 07)
00:01.0 PCI bridge: Intel Corporation Skylake PCIe Controller (x16) (rev 07)
00:02.0 VGA compatible controller: Intel Corporation HD Graphics 530 (rev 06)
00:08.0 System peripheral: Intel Corporation Skylake Gaussian Mixture Model
00:14.0 USB controller: Intel Corporation Sunrise Point-H USB 3.0 xHCI Controller (rev 31)
00:14.2 Signal processing controller: Intel Corporation Sunrise Point-H Thermal subsystem (rev 31)
00:15.0 Signal processing controller: Intel Corporation Sunrise Point-H Serial IO I2C Controller #0 (rev 31)
00:15.1 Signal processing controller: Intel Corporation Sunrise Point-H Serial IO I2C Controller #1 (rev 31)
00:16.0 Communication controller: Intel Corporation Sunrise Point-H CSME HECI #1 (rev 31)
00:1c.0 PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root Port #1 (rev f1)
00:1c.5 PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root Port #6 (rev f1)
00:1d.0 PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root Port #9 (rev f1)
00:1d.4 PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root Port #13 (rev f1)
00:1e.0 Signal processing controller: Intel Corporation Sunrise Point-H Serial IO UART #0 (rev 31)
00:1f.0 ISA bridge: Intel Corporation Sunrise Point-H LPC Controller (rev 31)
00:1f.2 Memory controller: Intel Corporation Sunrise Point-H PMC (rev 31)
00:1f.3 Audio device: Intel Corporation Sunrise Point-H HD Audio (rev 31)
00:1f.4 SMBus: Intel Corporation Sunrise Point-H SMBus (rev 31)
01:00.0 3D controller: NVIDIA Corporation GM204M [GeForce GTX 970M] (rev a1)
3b:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter (rev 32)
3d:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller (rev 01)
