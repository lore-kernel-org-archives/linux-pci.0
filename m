Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:38601 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbcCKLdT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2016 06:33:19 -0500
To: Liviu Dudau <Liviu.Dudau@arm.com>, <catalin.marinas@arm.com>,
	"Bjorn Helgaas" <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Request for Info: Designware PCIe Root Complex support in ARM64
Message-ID: <56E2ACF8.6030503@synopsys.com>
Date: Fri, 11 Mar 2016 11:33:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Liviu, Catalin and Bjorn,

I am currently working on the PCIe Root Complex based on the Designware Core
(/pci/host/pcie-desigware.c). I have noticed that currently building a solution
based on the previous for an ARM64 CPU is problematic and demands some tweaking
in the ARM64 arch (like adding some functions in the pcibios, etc.).

I would like to know if any specific work is being planned for this matter and
in what I could contribute to make it happen.

Thanks,
Joao Pinto
