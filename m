Return-Path: <martin.stadtler@linaro.org>
Return-Path: <martin.stadtler@linaro.org>
MIME-Version: 1.0
In-Reply-To: <f606faa9-72f3-3219-02a8-69e948338d2e@redhat.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F767865@lhreml507-mbx> <f606faa9-72f3-3219-02a8-69e948338d2e@redhat.com>
From: Martin Stadtler <martin.stadtler@linaro.org>
Date: Thu, 2 Jun 2016 09:53:11 +0100
Message-ID: <CAKb5QVWSBN=K7cgK4ujWqUe6+SMqEaGckA148krZR4CyUvjqpg@mail.gmail.com>
Subject: Re: [Linaro-acpi] [PATCH V8 0/9] Support for ARM64 ACPI based PCI
 host controller
To: Jon Masters <jcm@redhat.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>, Tomasz Nowicki <tn@semihalf.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"will.deacon@arm.com" <will.deacon@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>, "okaya@codeaurora.org" <okaya@codeaurora.org>,
	"jchandra@broadcom.com" <jchandra@broadcom.com>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dhdang@apm.com" <dhdang@apm.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>, "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>, Wangyijing <wangyijing@huawei.com>,
	"mw@semihalf.com" <mw@semihalf.com>, "andrea.gallo@linaro.org" <andrea.gallo@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/alternative; boundary=001a114c888cba2f28053447bee1
List-ID: <linux-pci.vger.kernel.org>

--001a114c888cba2f28053447bee1
Content-Type: text/plain; charset=UTF-8

On 2 June 2016 at 08:31, Jon Masters <jcm@redhat.com> wrote:

> On 06/01/2016 03:36 AM, Gabriele Paoloni wrote:
>
> > If you agree I think Jon can tell who's the best person to
> > push the quirk RFC (as my understanding is that this mechanism
> > is currently used by some platforms deployed on the market...)
>
> Let me ping Linaro folks to see who has that (quirks) ball. We can
> certainly share the older OEM matching quirks Mark Salter did for
> earlier RHEL(SA) internal versions as a seed for that[0] activity.
>

Both Graeme and Ard are out this week, I'll ask for Al and Hanjun to step
in until they are back.

>
> BUT...I don't think we should block this thread on the quirks. They're
> separate (but important). I see Arnd's reply as well, but nobody else
> has yet chimed in to this thread (and I am about to prod all of the
> vendors to reply to this thread and ACK). Can I ask whether we can't
> just stage v8 as-is for -next at this point? Can Arnd's (or other)
> suggestions be handled as followup patches post-merge please? Bjorn?
>
> Jon.
>
> [0] RHEL(SA) has had three different PCIe enabled ACPI stacks maintained
> independently so far since we need PCIe to boot most of the hundreds of
> v8 systems we have internal to Red Hat - which all have PCI.
>
> --
> Computer Architect | Sent from my Fedora powered laptop
>
> _______________________________________________
> Linaro-acpi mailing list
> Linaro-acpi@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/linaro-acpi
>



-- 

Martin Stadtler
Director, Enterprise Group
Linaro Ltd
mobile: +44.7492180779
IRC: martinst@#linaro on irc.freenode.ne <http://irc.freenode.net/>t

--001a114c888cba2f28053447bee1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 2 June 2016 at 08:31, Jon Masters <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:jcm@redhat.com" target=3D"_blank">jcm@redhat.com</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex"><span class=3D"">On 06/01/2016 03:36 AM=
, Gabriele Paoloni wrote:<br>
<br>
&gt; If you agree I think Jon can tell who&#39;s the best person to<br>
&gt; push the quirk RFC (as my understanding is that this mechanism<br>
&gt; is currently used by some platforms deployed on the market...)<br>
<br>
</span>Let me ping Linaro folks to see who has that (quirks) ball. We can<b=
r>
certainly share the older OEM matching quirks Mark Salter did for<br>
earlier RHEL(SA) internal versions as a seed for that[0] activity.<br></blo=
ckquote><div><br></div><div>Both Graeme and Ard are out this week, I&#39;ll=
 ask for Al and Hanjun to step in until they are back.=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
<br>
BUT...I don&#39;t think we should block this thread on the quirks. They&#39=
;re<br>
separate (but important). I see Arnd&#39;s reply as well, but nobody else<b=
r>
has yet chimed in to this thread (and I am about to prod all of the<br>
vendors to reply to this thread and ACK). Can I ask whether we can&#39;t<br=
>
just stage v8 as-is for -next at this point? Can Arnd&#39;s (or other)<br>
suggestions be handled as followup patches post-merge please? Bjorn?<br>
<br>
Jon.<br>
<br>
[0] RHEL(SA) has had three different PCIe enabled ACPI stacks maintained<br=
>
independently so far since we need PCIe to boot most of the hundreds of<br>
v8 systems we have internal to Red Hat - which all have PCI.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Computer Architect | Sent from my Fedora powered laptop<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
_______________________________________________<br>
Linaro-acpi mailing list<br>
<a href=3D"mailto:Linaro-acpi@lists.linaro.org">Linaro-acpi@lists.linaro.or=
g</a><br>
<a href=3D"https://lists.linaro.org/mailman/listinfo/linaro-acpi" rel=3D"no=
referrer" target=3D"_blank">https://lists.linaro.org/mailman/listinfo/linar=
o-acpi</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><span style=3D"font-si=
ze:12.8000001907349px"><br></span></div><div dir=3D"ltr"><span style=3D"fon=
t-size:12.8000001907349px">Martin Stadtler</span><br style=3D"font-size:12.=
8000001907349px">Director, Enterprise Group<br style=3D"font-size:12.800000=
1907349px"><span style=3D"font-size:12.8000001907349px">Linaro Ltd</span><b=
r style=3D"font-size:12.8000001907349px"><span style=3D"font-size:12.800000=
1907349px">mobile:=C2=A0+44.7492180779</span><br style=3D"font-size:12.8000=
001907349px"><span style=3D"font-size:12.8000001907349px">IRC: martinst@#li=
naro on=C2=A0</span><a href=3D"http://irc.freenode.net/" rel=3D"noreferrer"=
 style=3D"color:rgb(17,85,204);font-size:12.8000001907349px" target=3D"_bla=
nk">irc.freenode.ne</a>t<br></div></div></div></div></div></div>
</div></div>

--001a114c888cba2f28053447bee1--
