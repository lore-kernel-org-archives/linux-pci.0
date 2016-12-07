Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752156AbcLGWJK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Dec 2016 17:09:10 -0500
Date: Wed, 7 Dec 2016 16:02:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-pci@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: resume path in dra7xx and other DW-based drivers
Message-ID: <20161207220234.GG22129@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon, et al,

Does dra7xx suspend/resume work?  I'm not sure dra7xx_pcie_resume()
and dra7xx_pcie_resume_noirq() restore everything necessary.  For
example, the probe path has this:

  dra7xx_pcie_probe
    dra7xx_add_pcie_port
      dw_pcie_host_init
	dra7xx_pcie_host_init         # .host_init
	  dw_pcie_setup_rc
	    dw_pcie_prog_outbound_atu

so I think it programs the ATU in dw_pcie_setup_rc().  But the resume
path doesn't call dw_pcie_setup_rc(), so I don't see where the ATU
setup would be restored.

Related to this, dra7xx_pcie_resume_noirq() contains phy init and
power-on code that is duplicated in dra7xx_pcie_probe().  It seems
like that ought to be done by a common function instead of being cut
and pasted.

I haven't looked in detail at all the other DW-based drivers; dra7xx
just happens to be first in alphabetical order :)  But I suspect I'd
have the same question about them.

Bjorn
