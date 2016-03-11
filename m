Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50070 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710AbcCKLtv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Mar 2016 06:49:51 -0500
Date: Fri, 11 Mar 2016 11:49:48 +0000
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: catalin.marinas@arm.com, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Request for Info: Designware PCIe Root Complex support in ARM64
Message-ID: <20160311114948.GI26304@e106497-lin.cambridge.arm.com>
References: <56E2ACF8.6030503@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <56E2ACF8.6030503@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 11, 2016 at 11:33:12AM +0000, Joao Pinto wrote:
> Hi Liviu, Catalin and Bjorn,

Adding Lorenzo as he has been taking over the PCIe side from me for a while now.

Best regards,
Liviu

> 
> I am currently working on the PCIe Root Complex based on the Designware Core
> (/pci/host/pcie-desigware.c). I have noticed that currently building a solution
> based on the previous for an ARM64 CPU is problematic and demands some tweaking
> in the ARM64 arch (like adding some functions in the pcibios, etc.).
> 
> I would like to know if any specific work is being planned for this matter and
> in what I could contribute to make it happen.
> 
> Thanks,
> Joao Pinto
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
