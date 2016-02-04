Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:60666 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756432AbcBDSbM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2016 13:31:12 -0500
Subject: Re: [PATCH v8 2/2] add new platform driver for PCI RC
To: Bjorn Helgaas <helgaas@kernel.org>,
	Joao Pinto <Joao.Pinto@synopsys.com>
References: <cover.1454600622.git.jpinto@synopsys.com>
 <c7af1603d4f18d11cb0ccee1c07708a1455ea4ed.1454600622.git.jpinto@synopsys.com>
 <20160204181911.GA2143@localhost>
CC: <Vineet.Gupta1@synopsys.com>, <arnd@arndb.de>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-snps-arc@lists.infradead.org>,
	<CARLOS.PALMINHA@synopsys.com>, <Alexey.Brodkin@synopsys.com>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <56B398E9.3080902@synopsys.com>
Date: Thu, 4 Feb 2016 18:31:05 +0000
MIME-Version: 1.0
In-Reply-To: <20160204181911.GA2143@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2/4/2016 6:19 PM, Bjorn Helgaas wrote:
> On Thu, Feb 04, 2016 at 03:52:10PM +0000, Joao Pinto wrote:
>> This patch adds a new driver that will be the reference platform driver
>> for all PCI RC IP Protoyping Kits based on ARC SDP.
>>
>> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
>> ---
>> Change v7 -> v8 (Bjorn Helgaas and Arnd Bergmann):
>> - driver name was changed from pcie-synopsys to pcie-dw-pltfm
> 
> "pcie-dw-pltfm" seems worse to me.  We have eight existing drivers
> that call dw_pcie_host_init(), and they're all platform_drivers.
> "pcie-dw-pltfm" could apply equally well to any of them.
> 
> I think I see what happened: I wrote "It doesn't seem necessary to me
> to include both 'synopsys' and 'ipk' in the filename and the driver
> name."  I meant that using one of them should be sufficient, not that
> *both* should be removed.
> 
> I don't know the SoC landscape, but from Arnd's comment, it sounds
> like "synopsys" might be too generic because many of the other drivers
> are connected with Synopsys.  I don't know what "ipk" means, but maybe
> that could work.  It's convenient if the name *means* something, and
> if "ipk" stands for "IP Prototyping Kit", that sounds pretty generic.
> Is "haps" or "haps_dx" a name people would associate with this
> hardware?  I guess it'd be nice if the driver name were related to the
> DT compat strings, so "ipk" is better from that perspective.

Synopsys has a product called IP Prototyping Kit which is a bundle of HAPSDX +
PCIE RC IP + drivers + Development Board. This driver was implemented originally
to serve this IPK but it can be used by SoC that use the Synopsys PCIe RC IP.
"ipk" would say that the driver is usable only in the IP Prototyping Kits which
is not 100% true, it is usable in any SoC with Synopsys IP or in limit serve as
a base for specific SoC drivers.
Suggestions: "pcie-dw-soc-agnostic", "pcie-dw-ipk", "pcie-dw-haps-prototyping"

What do you think?

> 
> My pci/host-synopsys branch (which is still published even though I
> removed it from for-linus) contains your v7 series plus some fixes.
> This v8 series lost the fixes.  For example:
> 
>> +static irqreturn_t dw_pltfm_pcie_msi_irq_handler(int irq, void *arg)
>> +{
>> +	struct pcie_port *pp = arg;
>> +
>> +	dw_handle_msi_irq(pp);
>> +
>> +	return dw_handle_msi_irq(pp);
>> +}
> 
> This is a bug.  You should call dw_handle_msi_irq() *once* and return
> the value it returns.  I already fixed this in my pci/host-synopsys
> branch, so you should start with that, and then apply your v7-v8
> changes.

I am going to fetch your repo and get the host/pcie-synopsys to generate the
next patch version.

> 
> Bjorn
> 

