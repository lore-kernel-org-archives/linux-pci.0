Return-Path: <SRS0=0pFK=ES=gmail.com=linus971@kernel.org>
Return-Path: <SRS0=0pFK=ES=gmail.com=linus971@kernel.org>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFxFp_rjSviLUEH-uZ1U=x_g-xiAFKoEQqOOxZQs4xV11A@mail.gmail.com>
References: <20180123195644.GA92112@bhelgaas-glaptop.roam.corp.google.com> <CA+55aFxFp_rjSviLUEH-uZ1U=x_g-xiAFKoEQqOOxZQs4xV11A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jan 2018 12:53:46 -0800
Message-ID: <CA+55aFyF_f-PfknDJOEKsueunppT-ghXYbh9Yu0hrEmL2+E57Q@mail.gmail.com>
Subject: Re: [GIT PULL] PCI fixes for v4.15
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>,
	Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 23, 2018 at 12:49 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Bjorn, I think you need to look at your email habits.

Anyway, it's pulled, but Christian ends up looking odd in the git tree
now. It happened before too, so there's three of them:

  git log --author=ckoenig.leichtzumerken@gmail.com

it's also possible that it's Christian who has some really odd email
setup that triggers this, of course.

This has happened at least once before (we have a

  Author: =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>

in there too from a year ago), but I'm pretty sure git gets this right
and it's some other issue here, because we have a ton of _correct_
UTF-8 author names picked up from emails.

             Linus
