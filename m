Return-Path: <SRS0=+XN2=KR=gmail.com=gokuljnpr@kernel.org>
Return-Path: <SRS0=+XN2=KR=gmail.com=gokuljnpr@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180802084657.GA21267@wunner.de>
References: <dac488604766f3dcb948e702210ecc381c4f907b.1533015755.git.lukas@wunner.de>
 <20180801164358.GI2534@lahna.fi.intel.com> <20180801171512.GA28440@wunner.de>
 <20180802072036.GN2534@lahna.fi.intel.com> <CAFP4jM8AYG7hmkC_rYgXAfLoJmkJuW0e1UbgiayGrCPbb_yw8A@mail.gmail.com>
 <20180802084657.GA21267@wunner.de>
From: gokul cg <gokuljnpr@gmail.com>
Date: Thu, 2 Aug 2018 17:58:50 +0530
Message-ID: <CAFP4jM830j4Uh1=5jCfOAkEVOeVyu66N+ym7fVQZTTd9Fa3cPQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Differentiate between surprise and safe removal
To: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Ashok Raj <ashok.raj@intel.com>, Keith Busch <keith.busch@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000001e09e1057272f478"
List-ID: <linux-pci.vger.kernel.org>

--0000000000001e09e1057272f478
Content-Type: text/plain; charset="UTF-8"

Hi Lukas,

>The solution is to acquire a ref on each device in add_error_device():
I will give try and update if it works .

regards,
Gokul
On Thu, Aug 2, 2018 at 2:16 PM, Lukas Wunner <lukas@wunner.de> wrote:

> On Thu, Aug 02, 2018 at 12:59:18PM +0530, gokul cg wrote:
> > I am suspecting a possible race condition in the kernel between PCI
> driver
> > and AER handling.
> >
> > Because of the same kernel panic happens from worker thread which handles
> > bottom half of aer irq.
> >
> > I am seeing this issue when I suddenly power off PCI card which
> > supports/enabled PCIE AER error reporting.
> >
> > While powering off PCI device, AER driver will get AER IRQ for the
> device,
> > from AER IRQ handler, it will cache AER error code and schedule worker
> > thread to handle error.
> >
> > The PCIe device will get removed from PCI tree before worker thread
> > completes its task and kernel panic is  happening when worker thread
> tries
> > to access PCI device's config space.
> >
> > #5 [ffff88027469fc70] general_protection at ffffffff8176cdf2
> >     [exception RIP: pci_bus_read_config_dword+100]
> > #6 [ffff88027469fd50] pci_find_next_ext_capability at ffffffff81345d7b
> > #7 [ffff88027469fd90] pci_find_ext_capability at ffffffff81347225
> > #8 [ffff88027469fda0] get_device_error_info at ffffffff81356c4d
> > #9 [ffff88027469fdd0] aer_isr at ffffffff81357a38
> > #10 [ffff88027469fe28] process_one_work at ffffffff8105d4c0
> > #11 [ffff88027469fe70] worker_thread at ffffffff8105e251
> > #12 [ffff88027469fed0] kthread at ffffffff81064260
> > #13 [ffff88027469ff50] ret_from_fork at ffffffff81773a38
> >
> > I have tested it on kernel 3.10 . But from source i could see that this
> > case is still relevant for latest Linux source .
>
> I'm not really familiar with the AER driver, but the problem is
> actually easy to spot:
>
> find_source_device() walks the hierarchy and saves a pointer to
> pci_dev's in an array.  That array is later traversed and the
> pci_dev's are accessed.
>
> The solution is to acquire a ref on each device in add_error_device():
>
> -       e_info->dev[e_info->error_dev_num] = dev;
> +       e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
>
> Then release the ref aer_process_err_devices() by calling pci_dev_put().
>
> I believe there's an ongoing refactoring of the AER driver and the
> issue may be addressed in the course of it, but as a quick fix for
> an ancient v3.10 kernel, the above should do the trick.
>
> HTH,
>
> Lukas
>

--0000000000001e09e1057272f478
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0<span style=3D"font-size:small;text-decoration-sty=
le:initial;text-decoration-color:initial;float:none;display:inline">Lukas,<=
/span><div><br></div><div><div>&gt;<span style=3D"font-size:small;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial;float:none;display:inline">The solution is to acquire a ref on ea=
ch device in add_error_device():</span></div><div>I will give try and updat=
e if it works .<br><div class=3D"gmail_extra"><br></div><div class=3D"gmail=
_extra">regards,</div><div class=3D"gmail_extra">Gokul=C2=A0</div><div clas=
s=3D"gmail_extra"><div class=3D"gmail_quote">On Thu, Aug 2, 2018 at 2:16 PM=
, Lukas Wunner <span dir=3D"ltr">&lt;<a href=3D"mailto:lukas@wunner.de" tar=
get=3D"_blank">lukas@wunner.de</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span class=3D"">On Thu, Aug 02, 2018 at 12:59:18PM +0530, go=
kul cg wrote:<br>
&gt; I am suspecting a possible race condition in the kernel between PCI dr=
iver<br>
&gt; and AER handling.<br>
&gt; <br>
&gt; Because of the same kernel panic happens from worker thread which hand=
les<br>
&gt; bottom half of aer irq.<br>
&gt; <br>
&gt; I am seeing this issue when I suddenly power off PCI card which<br>
&gt; supports/enabled PCIE AER error reporting.<br>
&gt; <br>
&gt; While powering off PCI device, AER driver will get AER IRQ for the dev=
ice,<br>
&gt; from AER IRQ handler, it will cache AER error code and schedule worker=
<br>
&gt; thread to handle error.<br>
&gt; <br>
&gt; The PCIe device will get removed from PCI tree before worker thread<br=
>
&gt; completes its task and kernel panic is=C2=A0 happening when worker thr=
ead tries<br>
&gt; to access PCI device&#39;s config space.<br>
&gt; <br>
</span><span class=3D"">&gt; #5 [ffff88027469fc70] general_protection at ff=
ffffff8176cdf2<br>
&gt;=C2=A0 =C2=A0 =C2=A0[exception RIP: pci_bus_read_config_dword+100]<br>
</span><span class=3D"">&gt; #6 [ffff88027469fd50] pci_find_next_ext_capabi=
lity at ffffffff81345d7b<br>
&gt; #7 [ffff88027469fd90] pci_find_ext_capability at ffffffff81347225<br>
&gt; #8 [ffff88027469fda0] get_device_error_info at ffffffff81356c4d<br>
&gt; #9 [ffff88027469fdd0] aer_isr at ffffffff81357a38<br>
&gt; #10 [ffff88027469fe28] process_one_work at ffffffff8105d4c0<br>
&gt; #11 [ffff88027469fe70] worker_thread at ffffffff8105e251<br>
&gt; #12 [ffff88027469fed0] kthread at ffffffff81064260<br>
&gt; #13 [ffff88027469ff50] ret_from_fork at ffffffff81773a38<br>
&gt; <br>
</span><span class=3D"">&gt; I have tested it on kernel 3.10 . But from sou=
rce i could see that this<br>
&gt; case is still relevant for latest Linux source .<br>
<br>
</span>I&#39;m not really familiar with the AER driver, but the problem is<=
br>
actually easy to spot:<br>
<br>
find_source_device() walks the hierarchy and saves a pointer to<br>
pci_dev&#39;s in an array.=C2=A0 That array is later traversed and the<br>
pci_dev&#39;s are accessed.<br>
<br>
The solution is to acquire a ref on each device in add_error_device():<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0e_info-&gt;dev[e_info-&gt;error_dev_<wbr>num] =
=3D dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0e_info-&gt;dev[e_info-&gt;error_dev_<wbr>num] =
=3D pci_dev_get(dev);<br>
<br>
Then release the ref aer_process_err_devices() by calling pci_dev_put().<br=
>
<br>
I believe there&#39;s an ongoing refactoring of the AER driver and the<br>
issue may be addressed in the course of it, but as a quick fix for<br>
an ancient v3.10 kernel, the above should do the trick.<br>
<br>
HTH,<br>
<br>
Lukas<br>
</blockquote></div><br></div></div></div></div>

--0000000000001e09e1057272f478--
