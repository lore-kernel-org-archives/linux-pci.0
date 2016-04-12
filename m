Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35408 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbcDLEsy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Apr 2016 00:48:54 -0400
Date: Mon, 11 Apr 2016 23:48:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI: PTM preliminary implementation
Message-ID: <20160412044852.GD11361@localhost>
References: <1458705848-26056-1-git-send-email-jonathan.yong@intel.com>
 <1458705848-26056-2-git-send-email-jonathan.yong@intel.com>
 <20160412042331.GA7907@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160412042331.GA7907@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 11, 2016 at 11:23:31PM -0500, Bjorn Helgaas wrote:

> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -671,6 +671,7 @@
> >  #define PCI_EXT_CAP_ID_PMUX	0x1A	/* Protocol Multiplexing */
> >  #define PCI_EXT_CAP_ID_PASID	0x1B	/* Process Address Space ID */
> >  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PASID
> > +#define PCI_EXT_CAP_ID_PTM	0x1f	/* Precision Time Measurement */
> 
> Adjust PCI_EXT_CAP_ID_MAX.

And follow hex capitalization style of existing code.
