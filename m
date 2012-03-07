MIME-Version: 1.0
In-Reply-To: <CAE9FiQXsY7Dn5TGtD1ARM_KFdz1V1hJOvYAy6e4msM=i3VfhDg@mail.gmail.com>
References: <1331018040-30725-1-git-send-email-yinghai@kernel.org>
	<1331018040-30725-24-git-send-email-yinghai@kernel.org>
	<CAErSpo5TjhNv1W=PxSPO6qXfhW1Mi4dMp83vj82=O_hFOq1vow@mail.gmail.com>
	<CAE9FiQXsY7Dn5TGtD1ARM_KFdz1V1hJOvYAy6e4msM=i3VfhDg@mail.gmail.com>
Date: Tue, 6 Mar 2012 20:42:33 -0700
Message-ID: <CABhMZUVOE2QJXPoXAdzX0275J+PRT_CFbJAWFtV7gzm_tD7suw@mail.gmail.com>
Subject: Re: [PATCH 23/23] x86, PCI: add pcibios_root_rescan
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=00248c0eec2c2823cd04ba9ef3d1
List-ID: <linux-pci.vger.kernel.org>

--00248c0eec2c2823cd04ba9ef3d1
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Mar 6, 2012 at 5:09 PM, Yinghai Lu <yinghai@kernel.org> wrote:

> On Tue, Mar 6, 2012 at 3:13 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > On Tue, Mar 6, 2012 at 12:14 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> >> need use it to rescan root bus that was not added via acpi probe.
> >>
> >> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> >> ---
> >>  arch/x86/pci/legacy.c |   25 +++++++++++++++++++++++++
> >>  1 files changed, 25 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/x86/pci/legacy.c b/arch/x86/pci/legacy.c
> >> index aab0e41..7a7c78f 100644
> >> --- a/arch/x86/pci/legacy.c
> >> +++ b/arch/x86/pci/legacy.c
> >> @@ -79,3 +79,28 @@ int __init pci_subsys_init(void)
> >>        return 0;
> >>  }
> >>  subsys_initcall(pci_subsys_init);
> >> +
> >> +void __devinit pcibios_root_rescan(void)
> >> +{
> >> +       int busn;
> >> +       struct pci_bus *bus;
> >> +
> >> +       if (pcibios_last_bus <= 0 || pcibios_last_bus > 0xff)
> >> +               return;
> >> +
> >> +       for (busn = 0; busn <= pcibios_last_bus; busn++) {
> >> +               bus = pci_find_bus(0, busn);
> >> +
> >> +               if (bus)
> >> +                       continue;
> >> +
> >> +               bus = __pcibios_scan_specific_bus(busn, false);
> >> +
> >> +               if (!bus)
> >> +                       continue;
> >> +
> >> +               pci_assign_unassigned_bus_resources(bus);
> >> +
> >> +               pci_bus_add_devices(bus);
> >> +       }
> >> +}
> >
> > Do we need it?  I assume we only care about host bridge hotplug via ACPI
> on x86.
>
> my sandbridge system has cpu bus 0x7f, and 0xff in DSDT.
>
> but nehalem and westmere system does not have cpu bus 0xf8, ... 0xff.


I think you're saying that on some machines, the BIOS decided not to expose
host bridges leading to CPU devices, and you want to discover those devices
anyway.  (What's the reason you want to discover them?)

I guess that's OK for now, but I don't like this strategy in general.  The
expectation of BIOS writers is that the OS will discover things using the
ACPI namespace and not go grubbing around outside that.  Sometimes the BIOS
has good reasons to hide things from the OS, e.g., to keep the OS from
tripping over hardware defects, to reduce support calls by preventing users
from making dangerous changes, etc.

Bjorn

--00248c0eec2c2823cd04ba9ef3d1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 6, 2012 at 5:09 PM, Yinghai Lu <span dir=3D"ltr">&lt;<a href=3D=
"mailto:yinghai@kernel.org" target=3D"_blank">yinghai@kernel.org</a>&gt;</s=
pan> wrote:<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div><div>On Tue, Mar 6, 2012 at 3:13 PM, Bjorn Helgaas &lt;<a href=3D"mail=
to:bhelgaas@google.com" target=3D"_blank">bhelgaas@google.com</a>&gt; wrote=
:<br>
&gt; On Tue, Mar 6, 2012 at 12:14 AM, Yinghai Lu &lt;<a href=3D"mailto:ying=
hai@kernel.org" target=3D"_blank">yinghai@kernel.org</a>&gt; wrote:<br>
&gt;&gt; need use it to rescan root bus that was not added via acpi probe.<=
br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Yinghai Lu &lt;<a href=3D"mailto:yinghai@kernel.org=
" target=3D"_blank">yinghai@kernel.org</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =A0arch/x86/pci/legacy.c | =A0 25 +++++++++++++++++++++++++<br>
&gt;&gt; =A01 files changed, 25 insertions(+), 0 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/arch/x86/pci/legacy.c b/arch/x86/pci/legacy.c<br>
&gt;&gt; index aab0e41..7a7c78f 100644<br>
&gt;&gt; --- a/arch/x86/pci/legacy.c<br>
&gt;&gt; +++ b/arch/x86/pci/legacy.c<br>
&gt;&gt; @@ -79,3 +79,28 @@ int __init pci_subsys_init(void)<br>
&gt;&gt; =A0 =A0 =A0 =A0return 0;<br>
&gt;&gt; =A0}<br>
&gt;&gt; =A0subsys_initcall(pci_subsys_init);<br>
&gt;&gt; +<br>
&gt;&gt; +void __devinit pcibios_root_rescan(void)<br>
&gt;&gt; +{<br>
&gt;&gt; + =A0 =A0 =A0 int busn;<br>
&gt;&gt; + =A0 =A0 =A0 struct pci_bus *bus;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 if (pcibios_last_bus &lt;=3D 0 || pcibios_last_bus &=
gt; 0xff)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 for (busn =3D 0; busn &lt;=3D pcibios_last_bus; busn=
++) {<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D pci_find_bus(0, busn);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bus)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D __pcibios_scan_specific_bus(=
busn, false);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bus)<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_assign_unassigned_bus_resources(=
bus);<br>
&gt;&gt; +<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_add_devices(bus);<br>
&gt;&gt; + =A0 =A0 =A0 }<br>
&gt;&gt; +}<br>
&gt;<br>&gt; Do we need it? =A0I assume we only care about host bridge hotp=
lug via ACPI on x86.</div></div><div>
<br>
</div>my sandbridge system has cpu bus 0x7f, and 0xff in DSDT.<br>
<br>
but nehalem and westmere system does not have cpu bus 0xf8, ... 0xff.</bloc=
kquote><div><br></div><div>I think you&#39;re saying that on some machines,=
 the BIOS decided not to expose host bridges leading to CPU devices, and yo=
u want to discover those devices anyway. =A0(What&#39;s the reason you want=
 to discover them?)</div>

<div><br></div><div>I guess that&#39;s OK for now, but I don&#39;t like thi=
s strategy in general. =A0The expectation of BIOS writers is that the OS wi=
ll discover things using the ACPI namespace and not go grubbing around outs=
ide that. =A0Sometimes the BIOS has good reasons to hide things from the OS=
, e.g., to keep the OS from tripping over hardware defects, to reduce suppo=
rt calls by preventing users from making dangerous changes, etc.</div>

<div><br></div><div>Bjorn</div></div>

--00248c0eec2c2823cd04ba9ef3d1--
