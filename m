Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33211 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932127AbcCKTqF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Mar 2016 14:46:05 -0500
Date: Fri, 11 Mar 2016 13:46:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>, catalin.marinas@arm.com,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Request for Info: Designware PCIe Root Complex support in ARM64
Message-ID: <20160311194600.GA16257@localhost>
References: <56E2ACF8.6030503@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56E2ACF8.6030503@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Lorenzo]

On Fri, Mar 11, 2016 at 11:33:12AM +0000, Joao Pinto wrote:
> Hi Liviu, Catalin and Bjorn,
> 
> I am currently working on the PCIe Root Complex based on the Designware Core
> (/pci/host/pcie-desigware.c). I have noticed that currently building a solution
> based on the previous for an ARM64 CPU is problematic and demands some tweaking
> in the ARM64 arch (like adding some functions in the pcibios, etc.).

If I understand you correctly, you're saying that pcie-designware.c
doesn't build on arm64.  It would be helpful to know exactly what
problem you're seeing (what kernel version, what config, what the
error are, etc.)

PCI_LAYERSCAPE, PCI_HISI, and PCIE_QCOM can all be enabled on arm64,
and it looks like they all depend on pcie-designware.c.  I can't build
those drivers personally, but I assume they work.

Bjorn
