MIME-Version: 1.0
Reply-To: bjorn@helgaas.com
In-Reply-To: <CABhMZUXh=X5k1DQhUcaXD4t9GWfXms80xWV7sAh0ZXD8YK794g@mail.gmail.com>
References: <1491225304-3559-1-git-send-email-jnair@caviumnetworks.com>
	<20170411134407.GB31773@bhelgaas-glaptop.roam.corp.google.com>
	<CABhMZUXNhKSQALAHP1CBNfWMuw0J0XQ2rzusP4WR_HHH9ox5Yw@mail.gmail.com>
	<CABhMZUXh=X5k1DQhUcaXD4t9GWfXms80xWV7sAh0ZXD8YK794g@mail.gmail.com>
Date: Tue, 11 Apr 2017 09:23:23 -0500
Message-ID: <CABhMZUWRMOikdH=YrEyRCQ6fnY3RDAszOGYBFiB0v1a8Ywmx1w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Handle Cavium ThunderX2 PCI topology quirk
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	Alex Williamson <alex.williamson@redhat.com>, Jon Masters <jcm@redhat.com>,
	David Daney <david.daney@cavium.com>, linux-arm-kernel@lists.infradead.org,
	Jayachandran C <jnair@caviumnetworks.com>
Content-Type: multipart/alternative; boundary=001a114101869e3284054ce4d5f1
List-ID: <linux-pci.vger.kernel.org>

--001a114101869e3284054ce4d5f1
Content-Type: text/plain; charset=UTF-8

On Apr 11, 2017 8:48 AM, "Bjorn Helgaas" <helgaas@kernel.org> wrote:

[+cc David]

I forgot to mention that I'm also hoping for an ack from David, since
he's listed as the maintainer of the ThunderX drivers.


Never mind this, Jon pointed out that ThunderX2 is different than
ThunderX.  Sorry for the noise, David.

On Mon, Apr 03, 2017 at 01:15:02PM +0000, Jayachandran C wrote:
> Hi Bjorn, Alex,
>
> Sending this again (with a trivial fix to author name), please review.
> Updated summary below:
>
> Here is v4 of the patchset to handle the PCIe topology quirk of Cavium
> ThunderX2 systems (previously known as Broadcom Vulcan).
>
> The earlier discussions on this can be seen at:
> http://www.spinics.net/lists/linux-pci/msg51001.html
> https://patchwork.ozlabs.org/patch/582633/ and
> https://lists.linuxfoundation.org/pipermail/iommu/2016-June/017681.html
>
> The earlier discussion on this patchset ended with a suggestion that it
> may be possible to fix up this quirk by handling the issue in the
> function argument of pci_for_each_dma_alias(). But at that point we did
> not have the codebase to make the changes since the full ACPI and OF code
> for SMMU and GIC ITS was not upstream.
>
> Now that the changes are upstream, I tried to fix it in both the SMMU
> and the GIC ITS code based on this suggestion, the changes needed are at:
>  https://github.com/jchandra-cavm/linux/commits/rid-xlate-fixup
>
> The problems with this approach are:
>  - of the 14 uses of pci_for_each_dma_alias in the function in the kernel
>    tree, I have to fixup 6 callers (which is all but one ofthe callers
>    outside x86)
>  - 4 of these can be reasonably handled (please see the github repo
above),
>    but the calls in drivers/irqchip/irq-gic-v3-its-pci-msi.c and
>    drivers/iommu/iommu.c cannot be reasonably fixed up.
>  - Even without the 2 above two changes I can get it to work for now.
>    But pci_for_each_dma_alias does not work as expected on this platform
>    and we have to be aware of that for all future uses of the function.
>
> For now, I have ruled out the approach, and I have rebased the earlier
> patch on to 4.11-rc and submitting again for review. The changes are:
>
> v3->v4:
>  - new address of author
>
> v2>v3:
>  - changed device flag name from PCI_DEV_FLAGS_DMA_ALIAS_ROOT to
>    PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT
>  - updated commit message to make the quirk clearer.
>
> Let me know your comments and suggestions.
>
> Thanks,
> JC.
>
>
> Jayachandran C (2):
>   PCI: Add device flag PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT
>   PCI: quirks: Fix ThunderX2 dma alias handling
>
>  drivers/pci/quirks.c | 14 ++++++++++++++
>  drivers/pci/search.c |  4 ++++
>  include/linux/pci.h  |  2 ++
>  3 files changed, 20 insertions(+)
>
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--001a114101869e3284054ce4d5f1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Apr 11, 2017 8:48 AM, &quot;Bjorn Helgaas&quot; &lt;<a href=3D=
"mailto:helgaas@kernel.org">helgaas@kernel.org</a>&gt; wrote:<br type=3D"at=
tribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">[+cc David]<br>
<br>
I forgot to mention that I&#39;m also hoping for an ack from David, since<b=
r>
he&#39;s listed as the maintainer of the ThunderX drivers.</blockquote></di=
v></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Never mind this=
, Jon pointed out that ThunderX2 is different than ThunderX.=C2=A0 Sorry fo=
r the noise, David.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div=
 class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<div class=3D"elided-text">
On Mon, Apr 03, 2017 at 01:15:02PM +0000, Jayachandran C wrote:<br>
&gt; Hi Bjorn, Alex,<br>
&gt;<br>
&gt; Sending this again (with a trivial fix to author name), please review.=
<br>
&gt; Updated summary below:<br>
&gt;<br>
&gt; Here is v4 of the patchset to handle the PCIe topology quirk of Cavium=
<br>
&gt; ThunderX2 systems (previously known as Broadcom Vulcan).<br>
&gt;<br>
&gt; The earlier discussions on this can be seen at:<br>
&gt; <a href=3D"http://www.spinics.net/lists/linux-pci/msg51001.html" rel=
=3D"noreferrer" target=3D"_blank">http://www.spinics.net/lists/<wbr>linux-p=
ci/msg51001.html</a><br>
&gt; <a href=3D"https://patchwork.ozlabs.org/patch/582633/" rel=3D"noreferr=
er" target=3D"_blank">https://patchwork.ozlabs.org/<wbr>patch/582633/</a> a=
nd<br>
&gt; <a href=3D"https://lists.linuxfoundation.org/pipermail/iommu/2016-June=
/017681.html" rel=3D"noreferrer" target=3D"_blank">https://lists.linuxfound=
ation.<wbr>org/pipermail/iommu/2016-June/<wbr>017681.html</a><br>
&gt;<br>
&gt; The earlier discussion on this patchset ended with a suggestion that i=
t<br>
&gt; may be possible to fix up this quirk by handling the issue in the<br>
&gt; function argument of pci_for_each_dma_alias(). But at that point we di=
d<br>
&gt; not have the codebase to make the changes since the full ACPI and OF c=
ode<br>
&gt; for SMMU and GIC ITS was not upstream.<br>
&gt;<br>
&gt; Now that the changes are upstream, I tried to fix it in both the SMMU<=
br>
&gt; and the GIC ITS code based on this suggestion, the changes needed are =
at:<br>
&gt;=C2=A0 <a href=3D"https://github.com/jchandra-cavm/linux/commits/rid-xl=
ate-fixup" rel=3D"noreferrer" target=3D"_blank">https://github.com/jchandra=
-<wbr>cavm/linux/commits/rid-xlate-<wbr>fixup</a><br>
&gt;<br>
&gt; The problems with this approach are:<br>
&gt;=C2=A0 - of the 14 uses of pci_for_each_dma_alias in the function in th=
e kernel<br>
&gt;=C2=A0 =C2=A0 tree, I have to fixup 6 callers (which is all but one oft=
he callers<br>
&gt;=C2=A0 =C2=A0 outside x86)<br>
&gt;=C2=A0 - 4 of these can be reasonably handled (please see the github re=
po above),<br>
&gt;=C2=A0 =C2=A0 but the calls in drivers/irqchip/irq-gic-v3-<wbr>its-pci-=
msi.c and<br>
&gt;=C2=A0 =C2=A0 drivers/iommu/iommu.c cannot be reasonably fixed up.<br>
&gt;=C2=A0 - Even without the 2 above two changes I can get it to work for =
now.<br>
&gt;=C2=A0 =C2=A0 But pci_for_each_dma_alias does not work as expected on t=
his platform<br>
&gt;=C2=A0 =C2=A0 and we have to be aware of that for all future uses of th=
e function.<br>
&gt;<br>
&gt; For now, I have ruled out the approach, and I have rebased the earlier=
<br>
&gt; patch on to 4.11-rc and submitting again for review. The changes are:<=
br>
&gt;<br>
&gt; v3-&gt;v4:<br>
&gt;=C2=A0 - new address of author<br>
&gt;<br>
&gt; v2&gt;v3:<br>
&gt;=C2=A0 - changed device flag name from PCI_DEV_FLAGS_DMA_ALIAS_ROOT to<=
br>
&gt;=C2=A0 =C2=A0 PCI_DEV_FLAGS_BRIDGE_XLATE_<wbr>ROOT<br>
&gt;=C2=A0 - updated commit message to make the quirk clearer.<br>
&gt;<br>
&gt; Let me know your comments and suggestions.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; JC.<br>
&gt;<br>
&gt;<br>
&gt; Jayachandran C (2):<br>
&gt;=C2=A0 =C2=A0PCI: Add device flag PCI_DEV_FLAGS_BRIDGE_XLATE_<wbr>ROOT<=
br>
&gt;=C2=A0 =C2=A0PCI: quirks: Fix ThunderX2 dma alias handling<br>
&gt;<br>
&gt;=C2=A0 drivers/pci/quirks.c | 14 ++++++++++++++<br>
&gt;=C2=A0 drivers/pci/search.c |=C2=A0 4 ++++<br>
&gt;=C2=A0 include/linux/pci.h=C2=A0 |=C2=A0 2 ++<br>
&gt;=C2=A0 3 files changed, 20 insertions(+)<br>
&gt;<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; linux-arm-kernel mailing list<br>
&gt; <a href=3D"mailto:linux-arm-kernel@lists.infradead.org">linux-arm-kern=
el@lists.<wbr>infradead.org</a><br>
&gt; <a href=3D"http://lists.infradead.org/mailman/listinfo/linux-arm-kerne=
l" rel=3D"noreferrer" target=3D"_blank">http://lists.infradead.org/<wbr>mai=
lman/listinfo/linux-arm-<wbr>kernel</a><br>
<br>
______________________________<wbr>_________________<br>
linux-arm-kernel mailing list<br>
<a href=3D"mailto:linux-arm-kernel@lists.infradead.org">linux-arm-kernel@li=
sts.<wbr>infradead.org</a><br>
<a href=3D"http://lists.infradead.org/mailman/listinfo/linux-arm-kernel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.infradead.org/<wbr>mailman/=
listinfo/linux-arm-<wbr>kernel</a><br>
</div></blockquote></div><br></div></div></div>

--001a114101869e3284054ce4d5f1--
