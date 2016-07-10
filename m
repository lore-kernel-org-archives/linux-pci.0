Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d3bc7758-2f97-474e-bd48-19457bda8b1d@leemhuis.info>
References: <CAJZ5v0hDSZGX90hxkACwC0DktD-_Baq=+DDkR7_zv8464iHG-Q@mail.gmail.com>
 <d3bc7758-2f97-474e-bd48-19457bda8b1d@leemhuis.info>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 10 Jul 2016 08:50:05 -0700
Message-ID: <CA+55aFwFxDdHggMJMUPF2D9TEDm6ii+TkDqnbLn4KhOWk6zBLA@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v4.7-rc7
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 10, 2016 at 4:00 AM, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> FYI, it seems these changes lead to a new regression. Quoting
> https://bugzilla.kernel.org/show_bug.cgi?id=121701

I wrote a comment on that, to see if the git issue that kept things
from bisecting into the merge can be worked around. That's a very
surprising error (but it's also not an exact quote of the error, so
who knows..)

             Linus
