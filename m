Return-Path: <SRS0=pTTB=Y7=google.com=rajatja@kernel.org>
Return-Path: <SRS0=pTTB=Y7=google.com=rajatja@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170117144128.GB22776@bhelgaas-glaptop.roam.corp.google.com>
References: <7B6A2AE64F40F245AE81F245059F0C3651381A56@ALA-MBA.corp.ad.wrs.com> <20170117144128.GB22776@bhelgaas-glaptop.roam.corp.google.com>
From: Rajat Jain <rajatja@google.com>
Date: Tue, 17 Jan 2017 10:47:26 -0800
Message-ID: <CACK8Z6Fsory5iBV_PBoRX5je8Wf6f3_tzbQ=50GTkkg+dwEzaw@mail.gmail.com>
Subject: Re: Hotplugging PCI device with large BAR
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Richard, Joseph" <Joseph.Richard@windriver.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a114dad66ac305705464ebddc
List-ID: <linux-pci.vger.kernel.org>

--001a114dad66ac305705464ebddc
Content-Type: text/plain; charset=UTF-8

On Tue, Jan 17, 2017 at 6:41 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Jan 16, 2017 at 11:29:26PM +0000, Richard, Joseph wrote:
> > Hello,
> > I am trying to hotplug a device with a large BAR to a KVM guest, but it
> is failing to map the memory for the BAR.
> >
> > From dmesg, here is the output when hotplugging the device, with the
> failure on BAR 2:
> > [  891.614017] ACPI: \_SB_.PCI0.S60_: ACPI_NOTIFY_DEVICE_CHECK event
> > [  891.614036] ACPI: \_SB_.PCI0.S60_: Device check in hotplug_event()
> > [  891.614100] pci 0000:00:0c.0: [1af4:1110] type 00 class 0x050000
> > [  891.614277] pci 0000:00:0c.0: reg 0x10: [mem 0x00000000-0x00000fff]
> > [  891.614391] pci 0000:00:0c.0: reg 0x14: [mem 0x00000000-0x00000fff]
> > [  891.614557] pci 0000:00:0c.0: reg 0x18: [mem 0x00000000-0x7fffffff
> 64bit pref]
> > [  891.614670] pci 0000:00:0c.0: reg 0x20: [mem 0x00000000-0x000fffff
> pref]
> > [  891.614780] pci 0000:00:0c.0: reg 0x24: [mem 0x00000000-0x000fffff
> pref]
> > [  891.615277] pci 0000:00:0c.0: BAR 2: no space for [mem size
> 0x80000000 64bit pref]
> > [  891.615279] pci 0000:00:0c.0: BAR 2: failed to assign [mem size
> 0x80000000 64bit pref]
> > [  891.615281] pci 0000:00:0c.0: BAR 4: assigned [mem
> 0xc0300000-0xc03fffff pref]
> > [  891.617759] pci 0000:00:0c.0: BAR 5: assigned [mem
> 0xc0400000-0xc04fffff pref]
> > [  891.620473] pci 0000:00:0c.0: BAR 0: assigned [mem
> 0xc0202000-0xc0202fff]
> > [  891.623148] pci 0000:00:0c.0: BAR 1: assigned [mem
> 0xc0203000-0xc0203fff]
> >
> > When the node is rebooted, the allocation gets fixed.
> > Also, when a similar device has previously been removed, it can allocate
> the memory that has previously been used for that device to this device, so
> allocation will succeed
> > Note, this is on a guest that has 9.8GB of RAM.  The same result was
> also observed on guests with lower amounts of RAM.
>
> This is a weakness of the PCI core -- we don't deal well with resource
> allocation issues.
>
> To really see what's going on we would need to see more of the dmesg
> (preferably the entire log), which would show the available address
> space.
>
> In this case, the device (00:0c.0) is on a root bus, so it's a
> question of what the host bridge windows are and how space is
> assigned to the other devices on the root bus.
>

The way this was dealt in one of my previous orgs, was to change the BIOS
to "reserve" enough memory space at the ports where we know the platform
would need later (due to anticipated hot-pluggable devices).


>
> Since it works after a reboot, I suspect the BIOS is assigning things
> differently when the device is present at boot-time.  The BIOS may
> also be able to increase the host bridge window sizes.  The dmesg logs
> showing the hotplug and a subsequent reboot would show what's
> happening.
>
> Linux could theoretically do something similar at hotplug-time, but it
> is complicated by the fact that other devices may already be operating
> (and thus difficult to move), and the fact that we don't currently
> have support for changing host bridge windows (and any such support
> would rely on firmware support, i.e., a host bridge _SRS method).
>
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--001a114dad66ac305705464ebddc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Jan 17, 2017 at 6:41 AM, Bjorn Helgaas <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:helgaas@kernel.org" target=3D"_blank">helgaas@kernel.org</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On M=
on, Jan 16, 2017 at 11:29:26PM +0000, Richard, Joseph wrote:<br>
&gt; Hello,<br>
&gt; I am trying to hotplug a device with a large BAR to a KVM guest, but i=
t is failing to map the memory for the BAR.<br>
&gt;<br>
&gt; From dmesg, here is the output when hotplugging the device, with the f=
ailure on BAR 2:<br>
&gt; [=C2=A0 891.614017] ACPI: \_SB_.PCI0.S60_: ACPI_NOTIFY_DEVICE_CHECK ev=
ent<br>
&gt; [=C2=A0 891.614036] ACPI: \_SB_.PCI0.S60_: Device check in hotplug_eve=
nt()<br>
&gt; [=C2=A0 891.614100] pci 0000:00:0c.0: [1af4:1110] type 00 class 0x0500=
00<br>
&gt; [=C2=A0 891.614277] pci 0000:00:0c.0: reg 0x10: [mem 0x00000000-0x0000=
0fff]<br>
&gt; [=C2=A0 891.614391] pci 0000:00:0c.0: reg 0x14: [mem 0x00000000-0x0000=
0fff]<br>
&gt; [=C2=A0 891.614557] pci 0000:00:0c.0: reg 0x18: [mem 0x00000000-0x7fff=
ffff 64bit pref]<br>
&gt; [=C2=A0 891.614670] pci 0000:00:0c.0: reg 0x20: [mem 0x00000000-0x000f=
ffff pref]<br>
&gt; [=C2=A0 891.614780] pci 0000:00:0c.0: reg 0x24: [mem 0x00000000-0x000f=
ffff pref]<br>
&gt; [=C2=A0 891.615277] pci 0000:00:0c.0: BAR 2: no space for [mem size 0x=
80000000 64bit pref]<br>
&gt; [=C2=A0 891.615279] pci 0000:00:0c.0: BAR 2: failed to assign [mem siz=
e 0x80000000 64bit pref]<br>
&gt; [=C2=A0 891.615281] pci 0000:00:0c.0: BAR 4: assigned [mem 0xc0300000-=
0xc03fffff pref]<br>
&gt; [=C2=A0 891.617759] pci 0000:00:0c.0: BAR 5: assigned [mem 0xc0400000-=
0xc04fffff pref]<br>
&gt; [=C2=A0 891.620473] pci 0000:00:0c.0: BAR 0: assigned [mem 0xc0202000-=
0xc0202fff]<br>
&gt; [=C2=A0 891.623148] pci 0000:00:0c.0: BAR 1: assigned [mem 0xc0203000-=
0xc0203fff]<br>
&gt;<br>
&gt; When the node is rebooted, the allocation gets fixed.<br>
&gt; Also, when a similar device has previously been removed, it can alloca=
te the memory that has previously been used for that device to this device,=
 so allocation will succeed<br>
&gt; Note, this is on a guest that has 9.8GB of RAM.=C2=A0 The same result =
was also observed on guests with lower amounts of RAM.<br>
<br>
</span>This is a weakness of the PCI core -- we don&#39;t deal well with re=
source<br>
allocation issues.<br>
<br>
To really see what&#39;s going on we would need to see more of the dmesg<br=
>
(preferably the entire log), which would show the available address<br>
space.<br>
<br>
In this case, the device (00:0c.0) is on a root bus, so it&#39;s a<br>
question of what the host bridge windows are and how space is<br>
assigned to the other devices on the root bus.<br></blockquote><div><br></d=
iv><div>The way this was dealt in one of my previous orgs, was to change th=
e BIOS to &quot;reserve&quot; enough memory space at the ports where we kno=
w the platform would need later (due to anticipated hot-pluggable devices).=
=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Since it works after a reboot, I suspect the BIOS is assigning things<br>
differently when the device is present at boot-time.=C2=A0 The BIOS may<br>
also be able to increase the host bridge window sizes.=C2=A0 The dmesg logs=
<br>
showing the hotplug and a subsequent reboot would show what&#39;s<br>
happening.<br>
<br>
Linux could theoretically do something similar at hotplug-time, but it<br>
is complicated by the fact that other devices may already be operating<br>
(and thus difficult to move), and the fact that we don&#39;t currently<br>
have support for changing host bridge windows (and any such support<br>
would rely on firmware support, i.e., a host bridge _SRS method).<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Bjorn<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5">--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-pci&qu=
ot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<wbr>m=
ajordomo-info.html</a><br>
</div></div></blockquote></div><br></div></div>

--001a114dad66ac305705464ebddc--
