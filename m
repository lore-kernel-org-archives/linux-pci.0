Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59135 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933869AbcCNMNO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Mar 2016 08:13:14 -0400
Date: Mon, 14 Mar 2016 12:15:38 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>, catalin.marinas@arm.com,
	linux-pci@vger.kernel.org
Subject: Re: Request for Info: Designware PCIe Root Complex support in ARM64
Message-ID: <20160314121538.GB6629@red-moon>
References: <56E2ACF8.6030503@synopsys.com>
 <20160311194600.GA16257@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160311194600.GA16257@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 11, 2016 at 01:46:00PM -0600, Bjorn Helgaas wrote:
> [+cc Lorenzo]
> 
> On Fri, Mar 11, 2016 at 11:33:12AM +0000, Joao Pinto wrote:
> > Hi Liviu, Catalin and Bjorn,
> > 
> > I am currently working on the PCIe Root Complex based on the Designware Core
> > (/pci/host/pcie-desigware.c). I have noticed that currently building a solution
> > based on the previous for an ARM64 CPU is problematic and demands some tweaking
> > in the ARM64 arch (like adding some functions in the pcibios, etc.).
> 
> If I understand you correctly, you're saying that pcie-designware.c
> doesn't build on arm64.  It would be helpful to know exactly what
> problem you're seeing (what kernel version, what config, what the
> error are, etc.)

Yes, I am not sure I understand what Joao is referring to so I would
be grateful if he can provide us with additional details.

Thanks,
Lorenzo
