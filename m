Return-Path: <SRS0=Qg5I=4N=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=Qg5I=4N=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1493890270-1188-1-git-send-email-deathsimple@vodafone.de>
References: <1493890270-1188-1-git-send-email-deathsimple@vodafone.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 7 May 2017 13:50:07 +0300
Message-ID: <CAHp75VcrKTirCH6gHj1DoLzz5JhfzpvVb34M9e5-OQOjO4Mymw@mail.gmail.com>
Subject: Re: Resizeable PCI BAR support v5
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Platform Driver <platform-driver-x86@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 4, 2017 at 12:31 PM, Christian K=C3=B6nig
<deathsimple@vodafone.de> wrote:
> Hi everyone,
>
> this is the fifth incarnation of this set of patches. It enables device
> drivers to resize and most likely also relocate the PCI BAR of devices
> they manage to allow the CPU to access all of the device local memory at =
once.
>
> This is very useful for GFX device drivers where the default PCI BAR is o=
nly
> about 256MB in size for compatibility reasons, but the device easily have
> multiple gigabyte of local memory.
>
> Noteable changed compared to v4:
> 1. Patch #1 is new and a minor cleanup to the PCI code.
> 2. Some more helpers added to patch #2
> 3. We now print a note to syslog before releasing resources.
> 4. Add defines for registers and bits used to add new root hub window.
>
> I've addressed mostly every review comment I've got so far and it looks l=
ike we
> are getting closer to landing this. Any more suggestions/hints how we cou=
ld
> improve the patchset would be very welcome.
>

Thanks for an update.

I'm going to comment individual patches.

Just for the future, please use versioning in the patches themselves
(hint: -vX to git-format-patch).

--=20
With Best Regards,
Andy Shevchenko
