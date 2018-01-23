Return-Path: <SRS0=0pFK=ES=gmail.com=linus971@kernel.org>
Return-Path: <SRS0=0pFK=ES=gmail.com=linus971@kernel.org>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180123195644.GA92112@bhelgaas-glaptop.roam.corp.google.com>
References: <20180123195644.GA92112@bhelgaas-glaptop.roam.corp.google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jan 2018 12:49:22 -0800
Message-ID: <CA+55aFxFp_rjSviLUEH-uZ1U=x_g-xiAFKoEQqOOxZQs4xV11A@mail.gmail.com>
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

On Tue, Jan 23, 2018 at 11:56 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>   - fix AMD regression due to not re-enabling the big window on resume
>     (Christian K=C3=B6nig)

Bjorn, I think you need to look at your email habits.

I suspect you're editing your mailbox, or you're using some broken
mailer setup, or something (using some broken "export" function?),
because you're corrupting Christian's name all the time:

> =3D?UTF-8?q?Christian=3D20K=3DC3=3DB6nig?=3D (1):
>       x86/PCI: Enable AMD 64-bit window on resume

and I'm pretty sure git gets this right if actually fed a real mbox,
but I suspect that you have some other workflow going on..

            Linus
