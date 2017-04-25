Return-Path: <SRS0=Ov9g=4B=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=Ov9g=4B=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de>
References: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 25 Apr 2017 17:25:25 +0300
Message-ID: <CAHp75Ve5FickRJjba3iCumivRP0dr64n_9Y4tbMY3WGxCuyufA@mail.gmail.com>
Subject: Re: Resizeable PCI BAR support V4
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: helgaas@kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, dri-devel@lists.freedesktop.org,
	Platform Driver <platform-driver-x86@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 25, 2017 at 4:19 PM, Christian K=C3=B6nig
<deathsimple@vodafone.de> wrote:
> Hi everyone,
>
> This is the fourth incarnation of this set of patches.

It would be nice if you put (next time) version of the series in each
patch. Usually it's done quite easy by passing -vX (where X is version
number) to git format-patch.

> It enables device
> drivers to resize and most likely also relocate the PCI BAR of devices
> they manage to allow the CPU to access all of the device local memory at =
once.
>
> This is very useful for GFX device drivers where the default PCI BAR is o=
nly
> about 256MB in size for compatibility reasons, but the device easily have
> multiple gigabyte of local memory.
>
> Some changes since V3:
> 1. A lot of minor style cleanups.
> 2. Make internal  functions for changing BARs directly private to the PCI=
 subsystem.
> 3. Fail if any BAR is still in use when we try to change it.
> 4. Handle intermediate bridges as well.
> 5. Print some more messages when changing something.
>
> Please review and/or comment,

Would look later (perhaps this week),

--=20
With Best Regards,
Andy Shevchenko
