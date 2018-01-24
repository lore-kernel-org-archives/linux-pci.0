Return-Path: <SRS0=dPij=ET=gmail.com=linus971@kernel.org>
Return-Path: <SRS0=dPij=ET=gmail.com=linus971@kernel.org>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180124004603.GH5317@bhelgaas-glaptop.roam.corp.google.com>
References: <20180123195644.GA92112@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFxFp_rjSviLUEH-uZ1U=x_g-xiAFKoEQqOOxZQs4xV11A@mail.gmail.com> <20180124004603.GH5317@bhelgaas-glaptop.roam.corp.google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jan 2018 17:04:22 -0800
Message-ID: <CA+55aFwpmqZUnD=3U23c-r89XmyncoXQzK7+b8AyuQ9+soC19g@mail.gmail.com>
Subject: Re: [GIT PULL] PCI fixes for v4.15
To: Bjorn Helgaas <helgaas@kernel.org>, Peter Grayson <jpgrayson@gmail.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-pci@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>,
	Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 23, 2018 at 4:46 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Jan 23, 2018 at 12:49:22PM -0800, Linus Torvalds wrote:
>>
>> I suspect you're editing your mailbox, or you're using some broken
>> mailer setup, or something (using some broken "export" function?),
>> because you're corrupting Christian's name all the time:
>
> I'm not editing my mailbox, but I am using stgit.  The "From:" header
> uses encoded-word syntax for Christian's name, and I think stgit is
> not decoding that when applying the patch.

Ahh. Ok, that would explain it.

> When I save the patch email message from mutt (or gmail, for that
> matter), I see:
>
>   From: "=3D?UTF-8?q?Christian=3D20K=3DC3=3DB6nig?=3D"  ...

Yes. That's the standard locale encoding format for header values
(mainly subject and author), since the

   Content-Type: text/plain; charset=3Dutf-8

only applies to the *body* of the email.

So then the email handling tools have to handle that correctly, and as
you noticed, "git am" does so:

> Applying that patch with "git am" results in the correct
>
>   Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com

But apparently stgit does not:

> Applying the identical patch with "stg import -M" results in
>
>   Author: =3D?UTF-8?q?Christian=3D20K=3DC3=3DB6nig?=3D <ckoenig.leichtzum=
erken@gmail.com>

I'm adding Peter Grayson and Catalin Marinas to the participants,
since they seem to be the main stgit developers.

Presumably there is either a flag for this (which should presumably be
the default). Or if not, maybe stgit can just be fixed?

[ I go off looking at the stgit sources. ]

Oddly, stgit seems to even have a *testcase* for this:

 - t/t1800-import/email-qp:

        From: Inge =3D?utf-8?q?Str=3DC3=3DB6m?=3D <inge@power.com>

and that test-case harkens back to 2006. I wonder why it doesn't seem
to work for you and Christian.

Bjorn, maybe you can send Catalin an example mbox?

             Linus
