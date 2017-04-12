Return-Path: <SRS0=TEmQ=3U=ti.com=kishon@kernel.org>
Return-Path: <SRS0=TEmQ=3U=ti.com=kishon@kernel.org>
Subject: Re: [GIT PULL] PCI: Support for configurable PCI endpoint
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20170405085243.18123-1-kishon@ti.com>
 <20170410154328.GB13170@bhelgaas-glaptop.roam.corp.google.com>
 <20170411193447.GA14778@bhelgaas-glaptop.roam.corp.google.com>
CC: <devicetree@vger.kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>,
        <linux-doc@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
        Bjorn Helgaas
	<bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e4c7d2af-9d80-b6e0-def9-43254d815e25@ti.com>
Date: Wed, 12 Apr 2017 11:13:41 +0530
MIME-Version: 1.0
In-Reply-To: <20170411193447.GA14778@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Wednesday 12 April 2017 01:04 AM, Bjorn Helgaas wrote:
> On Mon, Apr 10, 2017 at 10:43:28AM -0500, Bjorn Helgaas wrote:
>> On Wed, Apr 05, 2017 at 02:22:20PM +0530, Kishon Vijay Abraham I wrote:
>>> Hi Bjorn,
>>>
>>> Please find the pull request for PCI endpoint support below. I've
>>> also included all the history here.
>>
>> Thanks, I applied these (with v7 of the first patch) to pci/host-designware
>> for v4.12.
> 
> Ok, sorry, I screwed this up.  I think my branch actually had v5, not
> v6.  But I *think* I fixed it.  Here's the diff from my branch to your
> git tree.  Apparently you haven't pushed the v7 patch there, so I
> *think* the diff below is the diff between v6 and v7 of that first
> patch.

I just checked your pci/host-designware branch and it looks correct. Thanks for
sorting this out.

Cheers
Kishon
