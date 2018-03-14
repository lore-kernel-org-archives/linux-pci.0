Return-Path: <SRS0=903h=GE=fireburn.co.uk=mike@kernel.org>
Return-Path: <SRS0=903h=GE=fireburn.co.uk=mike@kernel.org>
MIME-Version: 1.0
References: <20180212105523.15984-1-mika.westerberg@linux.intel.com>
 <CAHbf0-Exsu14dBmmfYy8Tcb4R58eYJKLFPPoM9RkqxHWDkqwXQ@mail.gmail.com>
 <20180212152122.GB75542@bhelgaas-glaptop.roam.corp.google.com>
 <CAHbf0-HffVDu0vxyTrSfgCtJ5rGtu_4HqAoo2sseG3HoE-1djw@mail.gmail.com>
 <20180222131343.GA205018@bhelgaas-glaptop.roam.corp.google.com> <CAHbf0-FUhpmJat5zo4iGNL8zbSVmhkfNDgzTLNdGvj8DJx-ddg@mail.gmail.com>
In-Reply-To: <CAHbf0-FUhpmJat5zo4iGNL8zbSVmhkfNDgzTLNdGvj8DJx-ddg@mail.gmail.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Wed, 14 Mar 2018 01:18:12 +0000
Message-ID: <CAHbf0-H6WAM2Lrv2+VD6tD8ogtJXmd3uv-WvGzXYX8agpc0EBw@mail.gmail.com>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Check presence of slot itself in get_slot_status()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Content-Type: multipart/alternative; boundary="94eb2c0b6b90b8a5200567552625"
List-ID: <linux-pci.vger.kernel.org>

--94eb2c0b6b90b8a5200567552625
Content-Type: text/plain; charset="UTF-8"

Hi

Just another reminder / hint that this hasn't landed in linux-next yet

Regards

Mike

On Fri, 23 Feb 2018 at 10:14 Mike Lothian <mike@fireburn.co.uk> wrote:

> On 22 February 2018 at 13:13, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > Not on your end.  But thanks fo the reminder, and also for the hint
> > that you'd like it in -rc3.  It's not likely to make -rc3 because I
> > like things to at least be in -next for a few days before I ask Linus
> > to pull them.
> >
> > But more importantly, what's the justification for adding this after
> > the merge window?  It doesn't look like a regression or a fix for
> > something we broke in the merge window.  It certainly *could* still be
> > merged for v4.16, but the default target would be v4.17.
> >
> > Bjorn
>
> Hi Bjorn
>
> Apologies, I thought all fixes got into the release candidates rather
> than just regressions
>
> I was hoping the original fix was going to make it into the merge
> window that just passed
>
> I just wanted to make sure the patch doesn't fall through the cracks
>
> I'm carrying this patch locally so it doesn't make too much difference
> to me which route it takes
>
> Thanks again
>
> Mike
>

--94eb2c0b6b90b8a5200567552625
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>Just another reminder / hint that th=
is hasn&#39;t landed in linux-next yet</div><div><br></div><div>Regards</di=
v><div><br></div><div>Mike</div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr">On Fri, 23 Feb 2018 at 10:14 Mike Lothian &lt;<a href=3D"mailto:=
mike@fireburn.co.uk">mike@fireburn.co.uk</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">On 22 February 2018 at 13:13, Bjorn Helgaas &lt;<a hre=
f=3D"mailto:helgaas@kernel.org" target=3D"_blank">helgaas@kernel.org</a>&gt=
; wrote:<br>
&gt;<br>
&gt; Not on your end.=C2=A0 But thanks fo the reminder, and also for the hi=
nt<br>
&gt; that you&#39;d like it in -rc3.=C2=A0 It&#39;s not likely to make -rc3=
 because I<br>
&gt; like things to at least be in -next for a few days before I ask Linus<=
br>
&gt; to pull them.<br>
&gt;<br>
&gt; But more importantly, what&#39;s the justification for adding this aft=
er<br>
&gt; the merge window?=C2=A0 It doesn&#39;t look like a regression or a fix=
 for<br>
&gt; something we broke in the merge window.=C2=A0 It certainly *could* sti=
ll be<br>
&gt; merged for v4.16, but the default target would be v4.17.<br>
&gt;<br>
&gt; Bjorn<br>
<br>
Hi Bjorn<br>
<br>
Apologies, I thought all fixes got into the release candidates rather<br>
than just regressions<br>
<br>
I was hoping the original fix was going to make it into the merge<br>
window that just passed<br>
<br>
I just wanted to make sure the patch doesn&#39;t fall through the cracks<br=
>
<br>
I&#39;m carrying this patch locally so it doesn&#39;t make too much differe=
nce<br>
to me which route it takes<br>
<br>
Thanks again<br>
<br>
Mike<br>
</blockquote></div>

--94eb2c0b6b90b8a5200567552625--
