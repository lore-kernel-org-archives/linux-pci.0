Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1303312153520.22069@pobox.suse.cz>
References: <Pine.LNX.4.44L0.1303201319190.1208-100000@iolanthe.rowland.org>
	<alpine.LNX.2.00.1303210018430.16237@pobox.suse.cz>
	<20130321144526.GR9021@phenom.ffwll.local>
	<alpine.LNX.2.00.1303312153520.22069@pobox.suse.cz>
Date: Mon, 1 Apr 2013 20:30:13 +0200
Message-ID: <CAKMK7uFvbbUXZ4NGSWTMiqFEPxX+5CBnJE7t_A35vosxODVR9Q@mail.gmail.com>
Subject: Re: [PATCH] dummy-irq: introduce a dummy IRQ handler driver (was Re:
 gm45 intel gfx can generate non-MSI irq# in MSI mode (was Re: [PATCH]
 drm/i915: stop using GMBUS IRQs on Gen4 chips (was Re: [3.9-rc1] irq 16:
 nobody cared (was [3.9-rc1] very poor interrupt respo))
From: Daniel Vetter <daniel@ffwll.ch>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Harald Arnesen <skogtun.linux@gmail.com>,
	Kernel development list <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Peter Hurley <peter@hurleysoftware.com>,
	Thomas Meyer <thomas@m3y3r.de>,
	Shawn Starr <shawn.starr@rogers.com>,
	USB list <linux-usb@vger.kernel.org>,
	linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Imre Deak <imre.deak@intel.com>,
	Daniel Kurtz <djkurtz@chromium.org>,
	dri-devel@lists.freedesktop.org,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 31, 2013 at 9:55 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Thu, 21 Mar 2013, Daniel Vetter wrote:
>
>> Indeed, this is pretty useful and allowed me to quickly reproduce that
>> phantom irq on my gm45. Thanks to module reloading we can even reset the
>> kernel's irq disabling logic and so test different tricks quickly without
>> rebooting. Really useful.
>
> Daniel,
>
> out of curiosity, have you been able to make some sense of the phantom
> legacy IRQs on GM45 systems, or are we just staying with my original
> bandaid (disabling GMBUS IRQs), declaring GM45 broken in this respect?

I've played around with dummy-irq on my own gm45 and afaict every
gmbus interrupt generates both an msi and a legacy pci interrupt when
msi is enabled. Everything else (= other interrupt sources) seems to
work as expected, and disabling msi also papers over the issue.
There's also scary comments in our gm45 irq handler that we need msi
to paper over some other races.

So I've decided that I don't want to dwell any longer in this
particular dungeon and that your bandaid (of just disabling this mess)
is the real fix.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
