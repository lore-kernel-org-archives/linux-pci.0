Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160309201750.GA26222@wunner.de>
References: <1457504045-12738-1-git-send-email-airlied@gmail.com>
	<20160309143336.GA26158@wunner.de>
	<CADnq5_MUW00AcYcM4WPREOd8ng9AfggZk6U4YU7j50s6BBeMNQ@mail.gmail.com>
	<20160309201750.GA26222@wunner.de>
Date: Thu, 10 Mar 2016 08:02:13 +1000
Message-ID: <CAPM=9txqnnL9UtjYD22BG2QTXdBndJBP_VRmC-=bDkWb7ddRoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vga_switcheroo: add power support for windows 10 machines.
From: Dave Airlie <airlied@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Alex Deucher <alexdeucher@gmail.com>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Maling list - DRI developers
	<dri-devel@lists.freedesktop.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10 March 2016 at 06:17, Lukas Wunner <lukas@wunner.de> wrote:
> Hi,
>
> On Wed, Mar 09, 2016 at 11:52:33AM -0500, Alex Deucher wrote:
>> On Wed, Mar 9, 2016 at 9:33 AM, Lukas Wunner <lukas@wunner.de> wrote:
>> > On Wed, Mar 09, 2016 at 04:14:04PM +1000, Dave Airlie wrote:
>> >> From: Dave Airlie <airlied@redhat.com>
>> >>
>> >> Windows 10 seems to have standardised power control for the
>> >> optimus/powerxpress laptops using PR3 power resource hooks.
>> >
>> > What happened to the Optimus DSM, does this still work? If not,
>> > echoing OFF to the vgaswitcheroo sysfs file won't power down the
>> > GPU now, right? (If runtime pm is disabled in nouveau.)
>> >
>> If the OS identifies itself as windows 10 or newer when initializing
>> ACPI, the standardized interfaces should be used if they exist.  I'm
>> not sure if there is any explicit policy on the vendor specific ones,
>> but I suspect they are probably broken in that case since I doubt the
>> OEM validates them when the standardized interfaces are available.
>
> The vendor interface (Optimus DSM) must be present, otherwise the call
> to nouveau_is_optimus() in patch [2/2] would return false.
>
> But indeed it seems to not be working, otherwise why would the patches
> be necessary?
>
> My point is that the chosen approach does not square with vga_switcheroo's
> architecture: Normally it's the handler's job to power the GPU up/down.
> If runtime pm is enabled then vga_switcheroo_init_domain_pm_ops()
> activates runtime_suspend/_resume callbacks which ask the handler to
> flip the power switch.
>
> However these two patches add *additional* runtime_suspend/_resume
> callbacks which do not rely on the handler at all. The handler is thus
> useless. This becomes apparent when loading the nouveau module with
> runpm=0: Normally the user is then able to manually power the GPU
> up/down by echoing ON or OFF to the vgaswitcheroo sysfs file. With the
> chosen approach this will likely not work because the handler only knows
> how to invoke the DSM, it doesn't know anything about PR3.
>
> Hence my suggestion to solve this with an additional handler which
> gets used in lieu of the nouveau DSM handler.

I'll think about this a bit more, but really I don't care for vgaswitcheroo
manual power control anymore. It's in debugfs for a reason, it was a stopgap
until we got dynamic power control.

If dynamic power control isn't working for some people we should fix that,
but supporting nouveau.runpm=0 and manual power control is so far down
the list of things I care about.

Dave.
