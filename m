Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [GIT PULL] PCI fixes for v4.15
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Peter Grayson <jpgrayson@gmail.com>,
        Catalin Marinas <catalin.marinas@gmail.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>
References: <20180123195644.GA92112@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFxFp_rjSviLUEH-uZ1U=x_g-xiAFKoEQqOOxZQs4xV11A@mail.gmail.com>
 <20180124004603.GH5317@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFwpmqZUnD=3U23c-r89XmyncoXQzK7+b8AyuQ9+soC19g@mail.gmail.com>
 <20180124162027.GI5317@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFzLwPDYz2dEM_X8Ase7+tLJDGU=ChasesP0ZGii4-D7Ow@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <56549a5e-e752-68eb-4f60-f6bb6b21284e@amd.com>
Date: Wed, 24 Jan 2018 18:27:01 +0100
MIME-Version: 1.0
In-Reply-To: <CA+55aFzLwPDYz2dEM_X8Ase7+tLJDGU=ChasesP0ZGii4-D7Ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 24.01.2018 um 17:40 schrieb Linus Torvalds:
> On Wed, Jan 24, 2018 at 8:20 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> Bjorn, maybe you can send Catalin an example mbox?
>> Attaching the one I used above.
> Heh. That's a mess. It has
>
>      Content-Type: text/plain; charset=UTF-8
>
> but then the name in the body is actually Latin1-encoded if I read it correctly.

Yes, looks like it.

> Git will auto-convert invalid utf-8 by assuming it is latin1, so it
> all ends up working, but Christian did something wrong in his mailer
> too.

The mailer I used was just "git send-email" and I just confirmed with 
hexdump that my .gitconfig contains the name in utf-8.

And when I use "git format-patch" the resulting file contains the name 
in utf-8 as well.

So, no idea when that got translated to latin1.

Regards,
Christian.
