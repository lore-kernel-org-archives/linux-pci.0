Return-Path: <SRS0=dPij=ET=gmail.com=linus971@kernel.org>
Return-Path: <SRS0=dPij=ET=gmail.com=linus971@kernel.org>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180124162027.GI5317@bhelgaas-glaptop.roam.corp.google.com>
References: <20180123195644.GA92112@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFxFp_rjSviLUEH-uZ1U=x_g-xiAFKoEQqOOxZQs4xV11A@mail.gmail.com>
 <20180124004603.GH5317@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFwpmqZUnD=3U23c-r89XmyncoXQzK7+b8AyuQ9+soC19g@mail.gmail.com> <20180124162027.GI5317@bhelgaas-glaptop.roam.corp.google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2018 08:40:50 -0800
Message-ID: <CA+55aFzLwPDYz2dEM_X8Ase7+tLJDGU=ChasesP0ZGii4-D7Ow@mail.gmail.com>
Subject: Re: [GIT PULL] PCI fixes for v4.15
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Peter Grayson <jpgrayson@gmail.com>, Catalin Marinas <catalin.marinas@gmail.com>,
	linux-pci@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>,
	Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 24, 2018 at 8:20 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> Bjorn, maybe you can send Catalin an example mbox?
>
> Attaching the one I used above.

Heh. That's a mess. It has

    Content-Type: text/plain; charset=UTF-8

but then the name in the body is actually Latin1-encoded if I read it correctly.

Git will auto-convert invalid utf-8 by assuming it is latin1, so it
all ends up working, but Christian did something wrong in his mailer
too.

I suspect that the reason stgit screws up is the quoting of the name:

   From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>

maybe stgit thinks that quoting means "no charset translation".

But I'll leave it to Catalin & co to figure out. The last stgit commit
was just a few days ago, so it seems to be maintained.

Bjorn: it might be worth it trying to the very latest stgit:

    git://repo.or.cz/stgit.git

because there are _some_ locale changes in there.

                 Linus
