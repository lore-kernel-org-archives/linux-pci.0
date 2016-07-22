Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54772 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbcGVQOK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 22 Jul 2016 12:14:10 -0400
Date: Fri, 22 Jul 2016 11:14:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-pci@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: Test throughput on PCIe interface
Message-ID: <20160722161406.GC20646@localhost>
References: <CAHhAz+j4TK7s9FFqPow40Ve=ZHc+tv8-R8yvfgt5Qxe23PrgAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHhAz+j4TK7s9FFqPow40Ve=ZHc+tv8-R8yvfgt5Qxe23PrgAQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc perf folks]

On Fri, Jul 22, 2016 at 05:59:51PM +0530, Muni Sekhar wrote:
> Hi All,
> 
> 
> We have xilinx PCIe endpoint with DMA reference block.
> 
> 
> The DMA-REF block provides a mechanism to DMA(also supports
> Scatter-Gather DMA) transfer data at the maximum rate between host
> (CPU) memory and a FIFO in the DMA-REF block.
> 
> 
> DMA-REF block provides the loopback. The intention is to use this
> block in production and self-test, to check that the PCIe bus is
> operating at the expected maximum transfer speed.
> 
> 
> Does kernel has any standard utilities to test throughput on PCIe interface?

I know some PCIe controllers devices do have performance monitors, and
perf might support some of them, but I don't know any details.

Bjorn
