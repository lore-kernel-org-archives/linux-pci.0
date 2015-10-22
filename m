Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38567 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964894AbbJVPfB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 22 Oct 2015 11:35:01 -0400
Date: Thu, 22 Oct 2015 10:34:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-pci@vger.kernel.org, pratyush.anand@gmail.com,
	m-karicheri2@ti.com
Subject: Re: [PATCH v4 0/4] PCI: designware: LTSSM #define cleanup
Message-ID: <20151022153455.GA16360@localhost>
References: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <1445504666.3173.20.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445504666.3173.20.camel@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 22, 2015 at 11:04:26AM +0200, Lucas Stach wrote:
> Hi Bjorn,
> 
> Am Mittwoch, den 21.10.2015, 13:42 -0500 schrieb Bjorn Helgaas:
> > This is a revision of Fabio's series:
> > http://lkml.kernel.org/r/1444664808-16445-1-git-send-email-festevam@gmail.com
> > 
> > Lucas, you reviewed the v3 patches, but I fiddled enough with this that I
> > didn't want to blindly carry your review forward.  I don't *think* I
> > changed anything substantive, but I might have missed something.
> > 
> I'm not sure if I like the removal of all the LTSSM state defines, as
> not all reference manuals include them and so I liked to have the header
> as a reference. But if you prefer to not carry unused defines in the
> kernel I won't object strongly to the removal.
> 
> Otherwise the series looks fine, which you may take as a Reviewed-by.

Thanks, Lucas.

OK, I put the rest of the LTSSM #defines back in
drivers/pci/host/pcie-designware.h as a separate patch (below):


commit 25026d3fcff7dd0e139b04cb52436b9c7e0e545e
Author: Fabio Estevam <fabio.estevam@freescale.com>
Date:   Thu Oct 22 10:24:52 2015 -0500

    PCI: designware: Add LTSSM state definitions
    
    Add the rest of the LTSSM state definitions.  These aren't currently used,
    so they're here as documentation.
    
    [bhelgaas: split into separate patch]
    Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index efe5fca..8cb5725 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -22,8 +22,39 @@
 #define MAX_MSI_IRQS			32
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
 
+#define LTSSM_STATE_DETECT_QUIET	0x00
+#define LTSSM_STATE_DETECT_ACT		0x01
+#define LTSSM_STATE_POLL_ACTIVE		0x02
+#define LTSSM_STATE_POLL_COMPLIANCE	0x03
+#define LTSSM_STATE_POLL_CONFIG		0x04
+#define LTSSM_STATE_PRE_DETECT_QUIET	0x05
+#define LTSSM_STATE_DETECT_WAIT		0x06
+#define LTSSM_STATE_CFG_LINKWD_START	0x07
+#define LTSSM_STATE_CFG_LINKWD_ACCEPT	0x08
+#define LTSSM_STATE_CFG_LANENUM_WAIT	0x09
+#define LTSSM_STATE_CFG_LANENUM_ACCEPT	0x0a
+#define LTSSM_STATE_CFG_COMPLETE	0x0b
+#define LTSSM_STATE_CFG_IDLE		0x0c
 #define LTSSM_STATE_RCVRY_LOCK		0x0d
+#define LTSSM_STATE_RCVRY_SPEED		0x0e
+#define LTSSM_STATE_RCVRY_RCVRCFG	0x0f
+#define LTSSM_STATE_RCVRY_IDLE		0x10
 #define LTSSM_STATE_L0			0x11
+#define LTSSM_STATE_L0S			0x12
+#define LTSSM_STATE_L123_SEND_EIDLE	0x13
+#define LTSSM_STATE_L1_IDLE		0x14
+#define LTSSM_STATE_L2_IDLE		0x15
+#define LTSSM_STATE_L2_WAKE		0x16
+#define LTSSM_STATE_DISABLED_ENTRY	0x17
+#define LTSSM_STATE_DISABLED_IDLE	0x18
+#define LTSSM_STATE_DISABLED		0x19
+#define LTSSM_STATE_LPBK_ENTRY		0x1a
+#define LTSSM_STATE_LPBK_ACTIVE		0x1b
+#define LTSSM_STATE_LPBK_EXIT		0x1c
+#define LTSSM_STATE_LPBK_EXIT_TIMEOUT	0x1d
+#define LTSSM_STATE_HOT_RESET_ENTRY	0x1e
+#define LTSSM_STATE_HOT_RESET		0x1f
+
 #define LTSSM_STATE_MASK		0x1f
 
 struct pcie_port {
