Return-Path: <ibmirkin@gmail.com>
Return-Path: <ibmirkin@gmail.com>
MIME-Version: 1.0
Sender: ibmirkin@gmail.com
In-Reply-To: <CAKb7UvhyCVoFXYL74eX3rXtt=V7nOnBGaTPVdcJT37v38jD8oQ@mail.gmail.com>
References: <004c7dbe-2014-c691-29d1-7a45f3b73dfa@desertbit.com>
 <20160829160210.GA24451@localhost> <1cca943f-eab4-4054-4a13-31370d7ae057@desertbit.com>
 <20160829190737.GA4053@localhost> <a0079ace-3062-4792-5c33-3a5e350daac3@desertbit.com>
 <20160829235403.GA14177@localhost> <1d1bfdc2-f23d-9816-e4e3-ae676105dc39@desertbit.com>
 <20160830130634.GA16426@localhost> <CACvgo51b4XLz2PwH1dkcK4_FknfZkSUKsFepYz-AGfPr7ux2kA@mail.gmail.com>
 <735da66c-aaf3-8c27-2d59-f62e8c85d3aa@desertbit.com> <CAKb7UvhyCVoFXYL74eX3rXtt=V7nOnBGaTPVdcJT37v38jD8oQ@mail.gmail.com>
From: Ilia Mirkin <imirkin@alum.mit.edu>
Date: Tue, 30 Aug 2016 11:48:14 -0400
Message-ID: <CAKb7UviJ5syj1PveX1ZeMe5PbVz8V5CyVKWSmQKMUm_dHHQjxA@mail.gmail.com>
Subject: Re: Kernel Freeze with American Megatrends BIOS
To: Roland Singer <roland.singer@desertbit.com>
Cc: Emil Velikov <emil.l.velikov@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	ML dri-devel <dri-devel@lists.freedesktop.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 30, 2016 at 11:44 AM, Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> On Tue, Aug 30, 2016 at 11:25 AM, Roland Singer
> <roland.singer@desertbit.com> wrote:
>> I tried these scenarios:
>>
>> 1. Booted the system without the bbswitch module. The nouveau module
>>    was loaded and is responsible for the power management of the GPU.
>>    The graphical session freezes after some minutes...
>>
>> 2. Booted the system without bbswitch and with nouveau blacklisted.
>>    Manually loaded bbswitch to switch off the discrete GPU.
>>    Same freeze after a while or by explicitly obtaining the GPU state.
>>
>> Is there a possibility to switch off the discrete card without bbswitch?
>> If this is possible, then I could test this without nouveau and bbswitch
>> at all. If the system hangs, then it is not the video driver nor bbswitch.
>
> You can use acpi_call (a random search points to
> https://github.com/mkottman/acpi_call, but I don't know if that's the
> "official" version) - need to find the right method to call, but
> that's basically all it takes to acpi-suspend a gpu.
>
> Separately, there was a recent fix to ... something, including but not
> limited to nouveau, involving hangs on gpu suspend on newer laptops. I
> don't think it's upstream yet. Look for patches from Lukas Wunner.

Er oops. Looks like I misremembered. Patches are from Peter Wu, and at
least one of them is in v4.8-rc1:

commit 692a17dcc2922a91c6bcf11b3321503a3377b1b1
Author: Peter Wu <peter@lekensteyn.nl>
Date:   Fri Jul 15 15:12:18 2016 +0200

    drm/nouveau/acpi: fix lockup with PCIe runtime PM

along with a number of other related patches. It's not clear which
kernel you were trying this with... can you give v4.8-rcN a shot?

  -ilia
