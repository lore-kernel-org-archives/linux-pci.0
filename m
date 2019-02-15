Return-Path: <SRS0=N/Da=QW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A80C43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 20:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746A3222D7
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 20:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550260851;
	bh=Q19J4JfetgxmZFjQE5mvU0uM+uP+29DY0pyntujOyqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Urs1sHFU/N0Dt2iafhFuT+IY0U8v77iwBn+fF1TJB5E2DzL83KV7xf2MWIyW5EyKa
	 dneZIFd2N3VYx/qtolNxVlxNGVLHWTO5dg9OTOoqTnO1548oVb/b6ILJqiJ160p/YW
	 U7WtZSIu3tF/7KVYy/dgEVe6jVPWxvcXTXC92Njs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfBOUAv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:00:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfBOUAu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Feb 2019 15:00:50 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4710121B18;
        Fri, 15 Feb 2019 20:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550260849;
        bh=Q19J4JfetgxmZFjQE5mvU0uM+uP+29DY0pyntujOyqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M0txP3ctjc9WyapjrDKPaRYJpP4HtTssFdYPjQoYHEWqhCddvJwaA13SY6LcFAnkv
         fsdqLx9YxXi4ojnOTGgzjjQIygZ9OMKH4lsL59dixeIvGzwiDkI8Km2qp+FkUQGcb9
         fXFjYBMA0DUBTu1kPlMPe1+u1MBZODloaR4ZOqc8=
Date:   Fri, 15 Feb 2019 14:00:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Honghui Zhang <honghui.zhang@mediatek.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org
Subject: Re: [pci:pci/portdrv 1/1] drivers/pci/pcie/portdrv_pci.c:187:9:
 sparse: warning: Initializer entry defined twice
Message-ID: <20190215200045.GS96272@google.com>
References: <201902151544.kWECyQ24%fengguang.wu@intel.com>
 <1550218723.4980.69.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550218723.4980.69.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 15, 2019 at 04:18:43PM +0800, Honghui Zhang wrote:
> On Fri, 2019-02-15 at 15:34 +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/portdrv
> > head:   b4f663e35a545fbdc71b3bbf2df88ef9f124a3fa
> > commit: b4f663e35a545fbdc71b3bbf2df88ef9f124a3fa [1/1] PCI/portdrv: Support PCIe services on subtractive decode bridges
> > reproduce:
> >         # apt-get install sparse
> >         git checkout b4f663e35a545fbdc71b3bbf2df88ef9f124a3fa
> >         make ARCH=x86_64 allmodconfig
> >         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> drivers/pci/pcie/portdrv_pci.c:187:9: sparse: warning: Initializer entry defined twice
> >    drivers/pci/pcie/portdrv_pci.c:189:9: sparse:   also defined here
> > 
> > sparse warnings: (new ones prefixed by >>)
> > 
> >    drivers/pci/pcie/portdrv_pci.c:187:9: sparse: warning: Initializer entry defined twice
> > >> drivers/pci/pcie/portdrv_pci.c:189:9: sparse:   also defined here
> > 
> > vim +187 drivers/pci/pcie/portdrv_pci.c
> > 
> > ^1da177e Linus Torvalds 2005-04-16  181  
> > ^1da177e Linus Torvalds 2005-04-16  182  /*
> > ^1da177e Linus Torvalds 2005-04-16  183   * LINUX Device Driver Model
> > ^1da177e Linus Torvalds 2005-04-16  184   */
> > ^1da177e Linus Torvalds 2005-04-16  185  static const struct pci_device_id port_pci_ids[] = { {
> > ^1da177e Linus Torvalds 2005-04-16  186  	/* handle any PCI-Express port */
> > ^1da177e Linus Torvalds 2005-04-16 @187  	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
> > b4f663e3 Honghui Zhang  2019-02-14  188  	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
> > b4f663e3 Honghui Zhang  2019-02-14 @189  	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0),
> > ^1da177e Linus Torvalds 2005-04-16  190  	}, { /* end: all zeroes */ }
> > ^1da177e Linus Torvalds 2005-04-16  191  };
> > ^1da177e Linus Torvalds 2005-04-16  192  
> > 
> Hi, Bjorn,
> Do you think drop this one, and I send a new version is a good idea? Or
> will you re-consider the first version patch?

The problem was just missing braces.  I replaced it with the following
patches:

commit c89f7f98c971e0cabc819b6c0fe6bf509287b7e0
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Feb 15 13:49:18 2019 -0600

    PCI/portdrv: Use conventional Device ID table formatting
    
    The pci_device_id table was technically correct, but unusually formatted,
    which made adding entries error-prone.  Change the format so it's obvious
    how to add entries.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 0acca3596807..a289e734b9a4 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -182,10 +182,10 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
 /*
  * LINUX Device Driver Model
  */
-static const struct pci_device_id port_pci_ids[] = { {
+static const struct pci_device_id port_pci_ids[] = {
 	/* handle any PCI-Express port */
-	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
-	}, { /* end: all zeroes */ }
+	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
+	{ },
 };
 
 static const struct pci_error_handlers pcie_portdrv_err_handler = {

commit f0cfecea8d1e8e0cd5d5053f9452b3a450f49eb5
Author: Honghui Zhang <honghui.zhang@mediatek.com>
Date:   Thu Feb 14 13:21:17 2019 +0800

    PCI/portdrv: Support PCIe services on subtractive decode bridges
    
    The Class Code for subtractive decode PCI-to-PCI bridge is 060401h; add an
    entry to make portdrv support this type of bridge.  This allows use of PCIe
    services on subtractive decode ports.
    
    Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
    [bhelgaas: add braces surrounding entry]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index a289e734b9a4..99d2abe88d0b 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -185,6 +185,8 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
 static const struct pci_device_id port_pci_ids[] = {
 	/* handle any PCI-Express port */
 	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
+	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
+	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0) },
 	{ },
 };
 
