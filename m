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
Cc: Emil Velikov <emil.l.velikov@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
From: Roland Singer <roland.singer@desertbit.com>
Message-ID: <1c761bab-f82b-3f43-c4f0-c7a8eff94f25@desertbit.com>
Date: Tue, 30 Aug 2016 20:02:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAKb7UviZ0qKp3PRR+iHr+KiOU9Sadeeb6PyydWN-FUL0RzyCPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

I configured bbswitch to not set any states automatically...
So it's possible to obtain and verify the GPU power state.

However I removed the bbswitch module and booted with nouveau.

Kernel 4.7.2: nouveau switches the discrete GPU off.
              I can't trigger the freeze, because bbswitch is missing.
              I'll work with the system and see if it will freeze.

Kernel 4.8-rc4: nouveau does not care about the power state and
                the discrete GPU is never switched off. I will notice
                this, because the second cooling FAN will stop...
                Same log messages as send before.


Am 30.08.2016 um 19:43 schrieb Ilia Mirkin:
> On Tue, Aug 30, 2016 at 1:37 PM, Roland Singer
> <roland.singer@desertbit.com> wrote:
>> My conclusion:
>>
>> 1. Nouveau has couple of problems with GTX 9** M Nvidia GPUs.
>>    I would love to help here.
> 
> nouveau + bbswitch will always end in tears. You're going behind the
> driver's back and messing around with state it believes it is
> managing. What if you just use nouveau and let it auto-power-off the
> GPU like it's designed to, with v4.8-rc?
> 
>   -ilia
> 
