Return-Path: <peterz@infradead.org>
Return-Path: <peterz@infradead.org>
Date: Tue, 2 Aug 2016 15:22:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Muni Sekhar <munisekharrms@gmail.com>, linux-pci@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: Test throughput on PCIe interface
Message-ID: <20160802132248.GJ6862@twins.programming.kicks-ass.net>
References: <CAHhAz+j4TK7s9FFqPow40Ve=ZHc+tv8-R8yvfgt5Qxe23PrgAQ@mail.gmail.com>
 <20160722161406.GC20646@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160722161406.GC20646@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 22, 2016 at 11:14:06AM -0500, Bjorn Helgaas wrote:
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
> > Does kernel has any standard utilities to test throughput on PCIe interface?
> 
> I know some PCIe controllers devices do have performance monitors, and
> perf might support some of them, but I don't know any details.

At least some of the Intel Uncore drivers have boxes specific to PCIe
(for instance my IVB-EP has an uncore_r2pcie PMU).

I'm not aware of any endpoint drivers, but it should not be too hard to
create uncore drivers for them.
