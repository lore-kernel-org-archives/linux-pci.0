Return-Path: <roland.singer@desertbit.com>
Return-Path: <roland.singer@desertbit.com>
Subject: Re: Kernel Freeze with American Megatrends BIOS
To: Peter Wu <peter@lekensteyn.nl>
References: <004c7dbe-2014-c691-29d1-7a45f3b73dfa@desertbit.com>
 <20160829160210.GA24451@localhost> <20160830195337.GA18805@al>
 <e7318236-9737-518e-c360-398c66220961@desertbit.com>
 <20160831114639.GD19420@al>
 <1b91b281-3c71-f02f-ff27-51957af92275@desertbit.com>
 <20160831123444.GE19420@al>
 <e19456cb-3076-c8f1-c9ec-fbfbd9bb6112@desertbit.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, emil.l.velikov@gmail.com,
 "imirkin@alum.mit.edu >> Ilia Mirkin" <imirkin@alum.mit.edu>
From: Roland Singer <roland.singer@desertbit.com>
Message-ID: <310ac56e-94bf-35de-79c7-29b0b4b6e2a8@desertbit.com>
Date: Wed, 31 Aug 2016 22:06:31 +0200
MIME-Version: 1.0
In-Reply-To: <e19456cb-3076-c8f1-c9ec-fbfbd9bb6112@desertbit.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Here is Peter Wu's reply, which was not send to the mailing list, because
I had to resend my e-mail to him due to a failure...


-------- Forwarded Message --------
Subject: Re: Fwd: Re: Kernel Freeze with American Megatrends BIOS
Date: Wed, 31 Aug 2016 18:08:53 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Roland Singer <roland.singer@desertbit.com>

On Wed, Aug 31, 2016 at 05:56:18PM +0200, Roland Singer wrote:

> > If you look at my notes.txt, you will see that _OFF always executes the
> > same code. PGON differs. When the problem occurs, "Q0L0" somehow always
> > reads back as non-zero and LNKS < 7.
> > 
> 
> Oh you're Lekensteyn ^^

Yes, that's me :) I wrote bbswitch, did the Optimus and PR3 ACPI support
in nouveau so I am fairly certain what happens behind the scenes.

> I don't have LNKS and no while loop after calling LKEN ?!

Yes that is what I said in
https://www.spinics.net/lists/linux-pci/msg53694.html:

"Other affected devices have similar code, differences are small:
No check for LNKS (avoids the infinite loop, but device is still off)"

> >>
> >> I noticed following:
> >>
> >> 1. Blacklist nouveau
> >> 2. Boot to GDM login manager (Wayland)
> >> 3. Switch to TTY with CTRL+ALT+FN2
> >> 4. Load bbswitch
> >> 5. Switch off GPU
> >> 6. run lspci -> no freeze
> >> 7. Switch to GDM
> >> 8. Login to a Wayland session (X11 won't work)
> >> 9. run lspci in a GUI terminal -> system freezes
> > 
> > Is nouveau somehow loaded anyway? All those extra components (X11,
> > Wayland, etc.) are unnecessary to reproduce the core problem. It occurs
> > whenever the device is being resumed (either via DSM/_PS0 or via power
> > resource PG00._ON).
> > 
> 
> Sorry that was nonsense. The steps to reproduce the problem are still valid.
> I didn't wait enough to power it down...
> 
> But whats interesting:
> 
> 1. Blacklist nouveau
> 2. Load bbswitch
> 3. Power off GPU with bbswitch
> 4. Power on GPU with bbswitch
> 5. Run lspci
> 6. Power off GPU with bbswitch
> 7. Run lspci -> freeze
> 
> So setting the GPU power state with bbswitch works as expected.
> Powering it on is also fine. I did this a couple of times.
> But powering it off and letting lspci powering it on, ends in a race.

In some cases I also found that it does always happen at the first try,
but with nouveau it always seem to happen.

> It might be, that lspci does not only power the GPU on, but triggers
> another pci action which causes the race condition.
> Does this have something to do with your quote about the retrain bit?

That is an interesting hypothesis. Even if you invoke `lspci -s01:00.0`
for example, it will always probe for all devices. So maybe interaction
with its parent device (PCI root port 00:02.0) causes issues.

However I also tested without lspci before, and the problem still
exists. You can trigger runtime resume via (as root):

    echo > /sys/bus/pci/0000:01:00.0/power/control on

Set it to "auto" to make it sleep again.
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
