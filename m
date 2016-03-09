Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160309143336.GA26158@wunner.de>
References: <1457504045-12738-1-git-send-email-airlied@gmail.com>
	<20160309143336.GA26158@wunner.de>
Date: Thu, 10 Mar 2016 08:00:35 +1000
Message-ID: <CAPM=9twnnxvohz+Ao7rSDC0nm+DLOPrOq+hvoTVyb8+w27BFnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vga_switcheroo: add power support for windows 10 machines.
From: Dave Airlie <airlied@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10 March 2016 at 00:33, Lukas Wunner <lukas@wunner.de> wrote:
> Hi Dave,
>
> On Wed, Mar 09, 2016 at 04:14:04PM +1000, Dave Airlie wrote:
>> From: Dave Airlie <airlied@redhat.com>
>>
>> Windows 10 seems to have standardised power control for the
>> optimus/powerxpress laptops using PR3 power resource hooks.
>
> What happened to the Optimus DSM, does this still work? If not,
> echoing OFF to the vgaswitcheroo sysfs file won't power down the
> GPU now, right? (If runtime pm is disabled in nouveau.)

No it doesn't work, hence why I had to go dig through this method. When
you report Windows 2013 ACPI support to the BIOS it disables the PS3 method,
and relies on hitting the PR3 method. Unlike ATPX I couldn't find any
indicator bit
in the optimus DSM to say which method to use. So we get to try both methods.

I've confirmed on my older machine that if there are no PR3 methods, then it
has no effect.

> How about implementing an additional vga_switcheroo handler somewhere
> in drivers/acpi/, which looks for the PR3 hooks and registers with
> vga_switcheroo if found. The ->power_state callback of that handler
> would then invoke acpi_device_set_power().

I've nothing to trigger off when to register in that case. I'm not
sure if the PR3
hooks alone are enough to tell you whether you should be using this method.
The ATPX guys have a bit we need to read to know if we should be using this
method.

>
> In any case this patch should be amended with kerneldoc for
> vga_switcheroo_init_parent_pr3_ops(), I've spent considerable time
> last year to document everything and kindly ask that this water not
> be muddied again. ;-)
>
> One small nit, the headers are sorted alphabetically yet acpi.h is
> added at the end.

I'll add those in v2.

Dave.
