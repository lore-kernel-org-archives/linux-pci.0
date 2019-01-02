Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A885FC43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 01:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D9C208E3
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 01:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfABBrU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 1 Jan 2019 20:47:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:23487 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbfABBrU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Jan 2019 20:47:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2019 17:47:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,429,1539673200"; 
   d="scan'208";a="130746174"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.90])
  by fmsmga002.fm.intel.com with SMTP; 01 Jan 2019 17:47:17 -0800
Received: by ubuntu (sSMTP sendmail emulation); Wed, 02 Jan 2019 09:47:14 +0800
Message-ID: <1546393634.35646.3.camel@intel.com>
Subject: Re: [PATCH v2 1/2] pci: altera: Add Stratix10 PCIe support
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lftan.linux@gmail.com
Date:   Wed, 02 Jan 2019 09:47:14 +0800
In-Reply-To: <20181231151730.GD159477@google.com>
References: <1546244693-34633-1-git-send-email-ley.foon.tan@intel.com>
         <1546244693-34633-2-git-send-email-ley.foon.tan@intel.com>
         <20181231151730.GD159477@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2018-12-31 at 09:17 -0600, Bjorn Helgaas wrote:
> Run "git log --oneline --follow drivers/pci/controller/pcie-altera.c" 
> and
> make your subject line match in style, phrasing, and capitalization.
> 
> Hint:
> 
>   ............ pci: altera: Add Stratix10 PCIe support
>   ef75369a5b9a PCI: altera: Fix platform_get_irq() error handling
>   bfdbbf0e3c2a PCI: altera: Use size=4 IRQ domain for legacy INTx
>   6ab380957838 PCI: altera: Drop pci_fixup_irqs()
>   9815791319a0 PCI: altera: Convert PCI scan API to
> pci_scan_root_bus_bridge()
>   2a7275a3d867 PCI: altera: Fix TLP_CFG_DW0 for TLP write
> 
> One of these is not like the others.
Okay, will change it.

> 
> On Mon, Dec 31, 2018 at 04:24:52PM +0800, Ley Foon Tan wrote:
> ...
> > 
> > +struct altera_pcie_data {
> > +	int (*tlp_read_pkt)(struct altera_pcie *pcie, u32 *value);
> > +	void (*tlp_write_pkt)(struct altera_pcie *pcie, u32
> > *headers,
> > +			      u32 data, bool align);
> > +	bool (*get_link_status)(struct altera_pcie *pcie);
> > +	int (*rp_read_cfg)(struct altera_pcie *pcie, int where,
> > +			   int size, u32 *value);
> > +	int (*rp_write_cfg)(struct altera_pcie *pcie, u8 bus, int
> > where,
> > +			    int size, u32 value);
> > +	bool s10_flag;		/* Stratix 10 */
> This is OK if you only ever have two programming models (the original
> and Stratix 10).  But if there's a possibility of more, an int model
> type that can be tested with a switch is more extensible.
> 
> Personally I prefer bitfields over bool in structures, but ultimately
> Lorenzo will take this and I don't know whether he has a preference.
> 
> https://lkml.kernel.org/r/CA+55aFxnePDimkVKVtv3gNmRGcwc8KQ5mHYvUxY8sA
> Qg6yvVYg@mail.gmail.com
> https://lkml.kernel.org/r/CA+55aFzKQ6Pj18TB8p4Yr0M4t+S+BsiHH=BJNmn=76
> -NcjTj-g@mail.gmail.com

Yes, you are right. Will change it to something like "version type".

Regards
Ley Foon
