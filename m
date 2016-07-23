Return-Path: <munisekharrms@gmail.com>
Return-Path: <munisekharrms@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160722161406.GC20646@localhost>
References: <CAHhAz+j4TK7s9FFqPow40Ve=ZHc+tv8-R8yvfgt5Qxe23PrgAQ@mail.gmail.com>
	<20160722161406.GC20646@localhost>
Date: Sat, 23 Jul 2016 21:12:16 +0530
Message-ID: <CAHhAz+iMcBrAVd-ZP8fJQx8negVE50OHS2ey+zPn=BPwOLMujw@mail.gmail.com>
Subject: Re: Test throughput on PCIe interface
From: Muni Sekhar <munisekharrms@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-kernel@vger.kernel.org,
	Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Content-Type: multipart/alternative; boundary=94eb2c05541847e8b705384f6554
List-ID: <linux-pci.vger.kernel.org>

--94eb2c05541847e8b705384f6554
Content-Type: text/plain; charset=UTF-8

On 22 Jul 2016 21:44, "Bjorn Helgaas" <helgaas@kernel.org> wrote:
>
> [+cc perf folks]
>
> On Fri, Jul 22, 2016 at 05:59:51PM +0530, Muni Sekhar wrote:
> > Hi All,
> >
> >
> > We have xilinx PCIe endpoint with DMA reference block.
> >
> >
> > The DMA-REF block provides a mechanism to DMA(also supports
> > Scatter-Gather DMA) transfer data at the maximum rate between host
> > (CPU) memory and a FIFO in the DMA-REF block.
> >
> >
> > DMA-REF block provides the loopback. The intention is to use this
> > block in production and self-test, to check that the PCIe bus is
> > operating at the expected maximum transfer speed.
> >
> >
> > Does kernel has any standard utilities to test throughput on PCIe
interface?
>
> I know some PCIe controllers devices do have performance monitors, and
> perf might support some of them, but I don't know any details.
>
Hi Bjorn,
Thanks for the reply. I will check the perf code.

Also I am looking for the sample kernel driver code which does DMA and
Scatter-Gather DMA transfers on PCIe endpoint. Reference to any example
kernel code is greatly appreciated.

> Bjorn

--94eb2c05541847e8b705384f6554
Content-Type: text/html; charset=UTF-8

<p dir="ltr"><br>
On 22 Jul 2016 21:44, &quot;Bjorn Helgaas&quot; &lt;<a href="mailto:helgaas@kernel.org">helgaas@kernel.org</a>&gt; wrote:<br>
&gt;<br>
&gt; [+cc perf folks]<br>
&gt;<br>
&gt; On Fri, Jul 22, 2016 at 05:59:51PM +0530, Muni Sekhar wrote:<br>
&gt; &gt; Hi All,<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; We have xilinx PCIe endpoint with DMA reference block.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; The DMA-REF block provides a mechanism to DMA(also supports<br>
&gt; &gt; Scatter-Gather DMA) transfer data at the maximum rate between host<br>
&gt; &gt; (CPU) memory and a FIFO in the DMA-REF block.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; DMA-REF block provides the loopback. The intention is to use this<br>
&gt; &gt; block in production and self-test, to check that the PCIe bus is<br>
&gt; &gt; operating at the expected maximum transfer speed.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Does kernel has any standard utilities to test throughput on PCIe interface?<br>
&gt;<br>
&gt; I know some PCIe controllers devices do have performance monitors, and<br>
&gt; perf might support some of them, but I don&#39;t know any details.<br>
&gt;<br>
Hi Bjorn,<br>
Thanks for the reply. I will check the perf code.</p>
<p dir="ltr">Also I am looking for the sample kernel driver code which does DMA and Scatter-Gather DMA transfers on PCIe endpoint. Reference to any example kernel code is greatly appreciated.</p>
<p dir="ltr">&gt; Bjorn<br>
</p>

--94eb2c05541847e8b705384f6554--
