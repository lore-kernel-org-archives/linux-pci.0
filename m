Return-Path: <emil.l.velikov@gmail.com>
Return-Path: <emil.l.velikov@gmail.com>
MIME-Version: 1.0
In-Reply-To: <735da66c-aaf3-8c27-2d59-f62e8c85d3aa@desertbit.com>
References: <004c7dbe-2014-c691-29d1-7a45f3b73dfa@desertbit.com>
 <20160829160210.GA24451@localhost> <1cca943f-eab4-4054-4a13-31370d7ae057@desertbit.com>
 <20160829190737.GA4053@localhost> <a0079ace-3062-4792-5c33-3a5e350daac3@desertbit.com>
 <20160829235403.GA14177@localhost> <1d1bfdc2-f23d-9816-e4e3-ae676105dc39@desertbit.com>
 <20160830130634.GA16426@localhost> <CACvgo51b4XLz2PwH1dkcK4_FknfZkSUKsFepYz-AGfPr7ux2kA@mail.gmail.com>
 <735da66c-aaf3-8c27-2d59-f62e8c85d3aa@desertbit.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 30 Aug 2016 16:48:59 +0100
Message-ID: <CACvgo51gNzECupX6R7jwQndH-1rX6MN1kPquuikzJrPk3CeZVA@mail.gmail.com>
Subject: Re: Kernel Freeze with American Megatrends BIOS
To: Roland Singer <roland.singer@desertbit.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	ML dri-devel <dri-devel@lists.freedesktop.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 30 August 2016 at 16:25, Roland Singer <roland.singer@desertbit.com> wrote:
> I tried these scenarios:
>
> 1. Booted the system without the bbswitch module. The nouveau module
>    was loaded and is responsible for the power management of the GPU.
>    The graphical session freezes after some minutes...
>
> 2. Booted the system without bbswitch and with nouveau blacklisted.
>    Manually loaded bbswitch to switch off the discrete GPU.
>    Same freeze after a while or by explicitly obtaining the GPU state.
>
> Is there a possibility to switch off the discrete card without bbswitch?
> If this is possible, then I could test this without nouveau and bbswitch
> at all. If the system hangs, then it is not the video driver nor bbswitch.
>
As Ilia mentioned acpi_call should do it. You can also check with the
nouveau/bbwswitch code to see which ones they use in your case and
bash it manually. It might be that the 'wrong one' gets used thus
things going horribly wrong.

Regards,
Emil
