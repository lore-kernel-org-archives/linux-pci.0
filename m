Return-Path: <ndprkm@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP8qiGBz8rC_pGt+r9cbEU3E9CGn=00rajugnDkOiLbRGcOqbQ@mail.gmail.com>
References: <CAP8qiGCNN4xgfDAtQf7H2rpBLJuLyWet0z6rau5WG7kVBj_NTg@mail.gmail.com>
 <20180213184435.GE75542@bhelgaas-glaptop.roam.corp.google.com> <CAP8qiGBz8rC_pGt+r9cbEU3E9CGn=00rajugnDkOiLbRGcOqbQ@mail.gmail.com>
From: Kallol Biswas <ndprkm@gmail.com>
Date: Tue, 20 Feb 2018 22:23:25 -0800
Message-ID: <CAP8qiGBeo6bshCL9jr-qnZ3SsEkv5P24RniVCLtyG_NvKmkhEA@mail.gmail.com>
Subject: Re: enabling multiple MSI vectors for a DS port
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@gmail.com>
Content-Type: multipart/alternative; boundary="001a114d37bafe121f0565b2f6bb"
List-ID: <linux-pci.vger.kernel.org>

--001a114d37bafe121f0565b2f6bb
Content-Type: text/plain; charset="UTF-8"

Hello Bjorn,
                We have worked around the issue by ack'ing dpc interrupt in
irq handler than in worker thread.

Regarding sharing the output of lspci -vv, we are not authorized to send
customer system's detail, otherwise we would be happy to do so.


Anyway, is there a good document on linux PCIe hotplug?



---------------------------------------------
static irqreturn_t dpc_irq(int irq, void *context)
{

struct dpc_dev *dpc = (struct dpc_dev *)context;

struct pci_dev *pdev = dpc->dev->port;

u16 status, source;


pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS, &status);

pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_SOURCE_ID,

&source);

if (!status)

return IRQ_NONE;


dev_info(&dpc->dev->device, "DPC containment event, status:%#06x
source:%#06x\n",

status, source);


if (status & PCI_EXP_DPC_STATUS_TRIGGER) {

          u16 reason = (status >> 1) & 0x3;

         pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,

                   PCI_EXP_DPC_STATUS_INTERRUPT);



         dev_warn(&dpc->dev->device, "DPC %s triggered, remove downstream
devices\n",

         (reason == 0) ? "unmasked uncorrectable error" :

         (reason == 1) ? "ERR_NONFATAL" :

         (reason == 2) ? "ERR_FATAL" : "extended error");

          schedule_work(&dpc->work);

}

return IRQ_HANDLED;



On Tue, Feb 20, 2018 at 10:20 PM, Kallol Biswas <ndprkm@gmail.com> wrote:

> Hello Bjorn,
>                 We have worked around the issue by ack'ing dpc interrupt
> in irq handler than in worker thread.
>
> Regarding sharing the output of lspci -vv, we are not authorized to send
> customer system's detail, otherwise we would be happy to do so.
>
>
> Anyway, is there a good document on linux PCIe hotplug?
>
>
>
> ---------------------------------------------
> static irqreturn_t dpc_irq(int irq, void *context)
> {
>
> struct dpc_dev *dpc = (struct dpc_dev *)context;
>
> struct pci_dev *pdev = dpc->dev->port;
>
> u16 status, source;
>
>
> pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS, &status);
>
> pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_SOURCE_ID,
>
> &source);
>
> if (!status)
>
> return IRQ_NONE;
>
>
> dev_info(&dpc->dev->device, "DPC containment event, status:%#06x
> source:%#06x\n",
>
> status, source);
>
>
> if (status & PCI_EXP_DPC_STATUS_TRIGGER) {
>
>           u16 reason = (status >> 1) & 0x3;
>
>          pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
>
>                    PCI_EXP_DPC_STATUS_INTERRUPT);
>
>
>
>          dev_warn(&dpc->dev->device, "DPC %s triggered, remove downstream
> devices\n",
>
>          (reason == 0) ? "unmasked uncorrectable error" :
>
>          (reason == 1) ? "ERR_NONFATAL" :
>
>          (reason == 2) ? "ERR_FATAL" : "extended error");
>
>           schedule_work(&dpc->work);
>
> }
>
> return IRQ_HANDLED;
>
> On Tue, Feb 13, 2018 at 10:44 AM, Bjorn Helgaas <helgaas@kernel.org>
> wrote:
>
>> Hi Kallol,
>>
>> On Tue, Feb 13, 2018 at 10:21:04AM -0800, Kallol Biswas wrote:
>> > Hi Bjorn,
>> >             I am facing an interrupt generation issue when single MSI
>> > is shared by both dpc and hotplug interrupt.
>> >
>> > The DS port is multi-MSI capable. What I have noticed that if I move
>> > the switch (with DS port) and OS disk to a different system multiple
>> > MSI vectors are allocated and dpc isr and hotplug isr are on different
>> > vectors.
>> >
>> > It seems that BIOS controls allocation of MSI vectors. Is there anyway
>> > to force linux kernel to allocate multiple vectors when port is
>> > capable?
>>
>> BIOS doesn't control the allocation of MSI vectors.  That's done by
>> Linux in pcie_init_service_irqs(), and it depends on many things: what
>> services are supported by Linux (hotplug, PME, AER, DPC), which ones
>> Linux is allowed to use (based on the ACPI _OSC method, so this part
>> can be influenced by the BIOS), etc.
>>
>> If you can share the "lspci -vv" and dmesg output for these two
>> systems, we can probably work out what's going on.
>>
>> Things should *work* even if DPC and hotplug need to share an
>> interrupt.  If that doesn't work, that's a Linux bug that should be
>> fixed.
>>
>> Bjorn
>>
>
>

--001a114d37bafe121f0565b2f6bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr" style=3D"color:rgb(34,34,34);font-family:=
arial,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;white-space:normal;word-spac=
ing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;tex=
t-decoration-color:initial">Hello Bjorn,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 We have worked around the issue by ack&#39;ing dpc=
 interrupt in irq handler than in worker thread.<div><br></div><div>Regardi=
ng sharing the output of lspci -vv, we are not authorized to send customer =
system&#39;s detail, otherwise we would be happy to do so.</div><div><br></=
div><div><br></div><div>Anyway, is there a good document on linux PCIe hotp=
lug?=C2=A0<br><br><br><br>------------------------------<wbr>--------------=
-<br>static irqreturn_t dpc_irq(int irq, void *context)<br>{<br><br>struct =
dpc_dev *dpc =3D (struct dpc_dev *)context;<br><br>struct pci_dev *pdev =3D=
 dpc-&gt;dev-&gt;port;<br><br>u16 status, source;<br><br><br>pci_read_confi=
g_word(pdev, dpc-&gt;cap_pos + PCI_EXP_DPC_STATUS, &amp;status);<br><br>pci=
_read_config_word(pdev, dpc-&gt;cap_pos + PCI_EXP_DPC_SOURCE_ID,<br><br>&am=
p;source);<br><br>if (!status)<br><br>return IRQ_NONE;<br><br><br>dev_info(=
&amp;dpc-&gt;dev-&gt;device, &quot;DPC containment event, status:%#06x sour=
ce:%#06x\n&quot;,<br><br>status, source);<br><br><br>if (status &amp; PCI_E=
XP_DPC_STATUS_TRIGGER) {<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 reas=
on =3D (status &gt;&gt; 1) &amp; 0x3;<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0<font color=3D"#ff0000">pci_write_config_word(pdev, dpc-&gt;cap_pos +=
 PCI_EXP_DPC_STATUS,<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0PCI_EXP_DPC_STATUS_INTERRUPT)<wbr>;<br></font><br><=
br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_warn(&amp;dpc-&gt;dev-&gt;devi=
ce, &quot;DPC %s triggered, remove downstream devices\n&quot;,<br><br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(reason =3D=3D 0) ? &quot;unmasked uncorrect=
able error&quot; :<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(reason =3D=3D =
1) ? &quot;ERR_NONFATAL&quot; :<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(r=
eason =3D=3D 2) ? &quot;ERR_FATAL&quot; : &quot;extended error&quot;);<br><=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 schedule_work(&amp;dpc-&gt;work);<br>=
<br>}<br><br>return IRQ_HANDLED;</div></div><div class=3D"gmail-HOEnZb" sty=
le=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font=
-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-w=
eight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,=
255);text-decoration-style:initial;text-decoration-color:initial"><div clas=
s=3D"gmail-h5" style=3D"display:block;color:rgb(80,0,80)"><br class=3D"gmai=
l-Apple-interchange-newline"></div></div><br><div class=3D"gmail_extra"><br=
><div class=3D"gmail_quote">On Tue, Feb 20, 2018 at 10:20 PM, Kallol Biswas=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:ndprkm@gmail.com" target=3D"_blank=
">ndprkm@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<div dir=3D"ltr">Hello Bjorn,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 We have worked around the issue by ack&#39;ing dpc interrupt =
in irq handler than in worker thread.<div><br></div><div>Regarding sharing =
the output of lspci -vv, we are not authorized to send customer system&#39;=
s detail, otherwise we would be happy to do so.</div><div><br></div><div><b=
r></div><div>Anyway, is there a good document on linux PCIe hotplug?=C2=A0<=
br><br><br><br>------------------------------<wbr>---------------<br>static=
 irqreturn_t dpc_irq(int irq, void *context)<br>{<br><br>struct dpc_dev *dp=
c =3D (struct dpc_dev *)context;<br><br>struct pci_dev *pdev =3D dpc-&gt;de=
v-&gt;port;<br><br>u16 status, source;<br><br><br>pci_read_config_word(pdev=
, dpc-&gt;cap_pos + PCI_EXP_DPC_STATUS, &amp;status);<br><br>pci_read_confi=
g_word(pdev, dpc-&gt;cap_pos + PCI_EXP_DPC_SOURCE_ID,<br><br>&amp;source);<=
br><br>if (!status)<br><br>return IRQ_NONE;<br><br><br>dev_info(&amp;dpc-&g=
t;dev-&gt;device, &quot;DPC containment event, status:%#06x source:%#06x\n&=
quot;,<br><br>status, source);<br><br><br>if (status &amp; PCI_EXP_DPC_STAT=
US_TRIGGER) {<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 reason =3D (sta=
tus &gt;&gt; 1) &amp; 0x3;<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<font c=
olor=3D"#ff0000">pci_write_config_word(pdev, dpc-&gt;cap_pos + PCI_EXP_DPC_=
STATUS,<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0PCI_EXP_DPC_STATUS_INTERRUPT)<wbr>;<br></font><br><br><br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_warn(&amp;dpc-&gt;dev-&gt;device, &quot;DPC =
%s triggered, remove downstream devices\n&quot;,<br><br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(reason =3D=3D 0) ? &quot;unmasked uncorrectable error&quo=
t; :<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(reason =3D=3D 1) ? &quot;ERR=
_NONFATAL&quot; :<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(reason =3D=3D 2=
) ? &quot;ERR_FATAL&quot; : &quot;extended error&quot;);<br><br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 schedule_work(&amp;dpc-&gt;work);<br><br>}<br><br>=
return IRQ_HANDLED;</div></div><div class=3D"m_-5419959492489506394HOEnZb">=
<div class=3D"m_-5419959492489506394h5"><div class=3D"gmail_extra"><br><div=
 class=3D"gmail_quote">On Tue, Feb 13, 2018 at 10:44 AM, Bjorn Helgaas <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:helgaas@kernel.org" target=3D"_blank">h=
elgaas@kernel.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">H=
i Kallol,<br>
<span><br>
On Tue, Feb 13, 2018 at 10:21:04AM -0800, Kallol Biswas wrote:<br>
&gt; Hi Bjorn,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I am facing an interrup=
t generation issue when single MSI<br>
&gt; is shared by both dpc and hotplug interrupt.<br>
&gt;<br>
&gt; The DS port is multi-MSI capable. What I have noticed that if I move<b=
r>
&gt; the switch (with DS port) and OS disk to a different system multiple<b=
r>
&gt; MSI vectors are allocated and dpc isr and hotplug isr are on different=
<br>
&gt; vectors.<br>
&gt;<br>
&gt; It seems that BIOS controls allocation of MSI vectors. Is there anyway=
<br>
&gt; to force linux kernel to allocate multiple vectors when port is<br>
&gt; capable?<br>
<br>
</span>BIOS doesn&#39;t control the allocation of MSI vectors.=C2=A0 That&#=
39;s done by<br>
Linux in pcie_init_service_irqs(), and it depends on many things: what<br>
services are supported by Linux (hotplug, PME, AER, DPC), which ones<br>
Linux is allowed to use (based on the ACPI _OSC method, so this part<br>
can be influenced by the BIOS), etc.<br>
<br>
If you can share the &quot;lspci -vv&quot; and dmesg output for these two<b=
r>
systems, we can probably work out what&#39;s going on.<br>
<br>
Things should *work* even if DPC and hotplug need to share an<br>
interrupt.=C2=A0 If that doesn&#39;t work, that&#39;s a Linux bug that shou=
ld be<br>
fixed.<br>
<span class=3D"m_-5419959492489506394m_5423980344503870363HOEnZb"><font col=
or=3D"#888888"><br>
Bjorn<br>
</font></span></blockquote></div><br></div>
</div></div></blockquote></div><br></div></div>

--001a114d37bafe121f0565b2f6bb--
