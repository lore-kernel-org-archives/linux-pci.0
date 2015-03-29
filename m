MIME-Version: 1.0
Reply-To: bjorn@helgaas.com
In-Reply-To: <20150327.145016.86183910134380870.davem@davemloft.net>
References: <CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>
	<551495EE.20201@oracle.com>
	<CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>
	<20150327.145016.86183910134380870.davem@davemloft.net>
Date: Sun, 29 Mar 2015 08:30:40 -0500
Message-ID: <CABhMZUVqgsYdT4wn2H8hsrh4f=6hT0G+sg=wwYSt33+jtvBS9A@mail.gmail.com>
Subject: Re: d63e2e1f3df breaks sparc/T5-8
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, yinghai@kernel.org,
	david.ahern@oracle.com, bhelgaas@google.com, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a113c531425054005126d5fb6
List-ID: <linux-pci.vger.kernel.org>

--001a113c531425054005126d5fb6
Content-Type: text/plain; charset=UTF-8

On Mar 27, 2015 3:46 PM, "David Miller" <davem@davemloft.net> wrote:
>
> From: Yinghai Lu <yinghai@kernel.org>
> Date: Fri, 27 Mar 2015 14:01:54 -0700
>
> > On Thu, Mar 26, 2015 at 4:27 PM, David Ahern <david.ahern@oracle.com>
wrote:
> >> On 3/26/15 2:43 PM, Yinghai Lu wrote:
> >>>
> >>> Can you send out boot log with "debug ignore_loglevel"?
> >>
> >>
> >> attached
> >
> > So the kernel config is sparc32 or sparc64 ?
> >
> > pci 0000:06:00.0: reg 0x184: can't handle BAR above 4GB (bus address
> > 0x110204000)
> >
> >
> > only could happen when dma_addr_t is 32bit.
>
> All DMA occurs behind an IOMMU and these IOMMUs only
> support 32-bit addressing, therefore dma_addr_t is
> 32-bit on sparc64.
>
> If you want to represent PCI address in some way, you
> absolutely cannot use dma_addr_t as your data type.

I'm on vacation until April 2, so I can't deal with this until then.

Help me understand the sparc64 situation: are you saying that BAR
addresses, i.e., MMIO transactions from a CPU or a peer-to-peer DMA can be
64 bits, but a DMA to main memory can only be 32 bits?

I assume this would work if we made dma_addr_t 64 bits on sparc64.  What
would be the cost of doing that?

I assume Yinghai is adding a new typedef just for those MMIO addresses.
That would be another solution, but it does add significant complexity.

Bjorn

--001a113c531425054005126d5fb6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Mar 27, 2015 3:46 PM, &quot;David Miller&quot; &lt;<a href=3D"mailto:dav=
em@davemloft.net">davem@davemloft.net</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Yinghai Lu &lt;<a href=3D"mailto:yinghai@kernel.org">yinghai@ker=
nel.org</a>&gt;<br>
&gt; Date: Fri, 27 Mar 2015 14:01:54 -0700<br>
&gt;<br>
&gt; &gt; On Thu, Mar 26, 2015 at 4:27 PM, David Ahern &lt;<a href=3D"mailt=
o:david.ahern@oracle.com">david.ahern@oracle.com</a>&gt; wrote:<br>
&gt; &gt;&gt; On 3/26/15 2:43 PM, Yinghai Lu wrote:<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Can you send out boot log with &quot;debug ignore_logleve=
l&quot;?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; attached<br>
&gt; &gt;<br>
&gt; &gt; So the kernel config is sparc32 or sparc64 ?<br>
&gt; &gt;<br>
&gt; &gt; pci 0000:06:00.0: reg 0x184: can&#39;t handle BAR above 4GB (bus =
address<br>
&gt; &gt; 0x110204000)<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; only could happen when dma_addr_t is 32bit.<br>
&gt;<br>
&gt; All DMA occurs behind an IOMMU and these IOMMUs only<br>
&gt; support 32-bit addressing, therefore dma_addr_t is<br>
&gt; 32-bit on sparc64.<br>
&gt;<br>
&gt; If you want to represent PCI address in some way, you<br>
&gt; absolutely cannot use dma_addr_t as your data type.</p>
<p dir=3D"ltr">I&#39;m on vacation until April 2, so I can&#39;t deal with =
this until then.</p>
<p dir=3D"ltr">Help me understand the sparc64 situation: are you saying tha=
t BAR addresses, i.e., MMIO transactions from a CPU or a peer-to-peer DMA c=
an be 64 bits, but a DMA to main memory can only be 32 bits?</p>
<p dir=3D"ltr">I assume this would work if we made dma_addr_t 64 bits on sp=
arc64.=C2=A0 What would be the cost of doing that?</p>
<p dir=3D"ltr">I assume Yinghai is adding a new typedef just for those MMIO=
 addresses.=C2=A0 That would be another solution, but it does add significa=
nt complexity.</p>
<p dir=3D"ltr">Bjorn</p>

--001a113c531425054005126d5fb6--
