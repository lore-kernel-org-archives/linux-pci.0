Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50528C04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 22:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164562146D
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 22:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRcBphgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164562146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbeLCW5e (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:57:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbeLCW5d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 17:57:33 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC70C2145D;
        Mon,  3 Dec 2018 22:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543877852;
        bh=xpUXBn7bisODtn97eXlLbqefPm16ou93J84qDoiuM3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IRcBphgETprKlqhF149iLwCazbPU++sTOoHY1gjzgHuHQOER4n7Gwopbupdtg52FN
         vNf/StcBGKnUukKYyI4BFKJ4uLUowG9LVzPCzTmeHl4VTrVS+dgSkfxAPbf8fGM/vE
         X51qsIfTb2fEJZAkNInT7twUs8X3tS9F1gA2pZws=
Date:   Mon, 3 Dec 2018 16:57:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Hanjie Lin <hanjie.lin@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Rob Herring <robh@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yue Wang <yue.wang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v6 2/2] PCI: amlogic: Add the Amlogic Meson PCIe
 controller driver
Message-ID: <20181203225731.GE207198@google.com>
References: <1542876836-191355-1-git-send-email-hanjie.lin@amlogic.com>
 <1542876836-191355-3-git-send-email-hanjie.lin@amlogic.com>
 <20181203164150.GA11855@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203164150.GA11855@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 03, 2018 at 04:41:50PM +0000, Lorenzo Pieralisi wrote:
> On Thu, Nov 22, 2018 at 04:53:54PM +0800, Hanjie Lin wrote:
> 
> [...]
> 
> > +static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> > +				  u32 *val)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +
> > +	/*
> > +	 * there is a bug of MESON AXG pcie controller that software can not
> > +	 * programe PCI_CLASS_DEVICE register, so we must return a fake right
> > +	 * value to ensure driver could probe successfully.
> > +	 */
> > +	if (where == PCI_CLASS_REVISION) {
> > +		*val = readl(pci->dbi_base + PCI_CLASS_REVISION);
> > +		/* keep revision id */
> > +		*val &= PCI_CLASS_REVISION_MASK;
> > +		*val |= PCI_CLASS_BRIDGE_PCI << 16;
> > +		return PCIBIOS_SUCCESSFUL;
> > +	}
> 
> As I said before, this looks broken. If this code (or other drivers with
> the same broken assumptions, eg dwc/pcie-qcom.c) carries out a, say,
> byte sized config access of eg PCI_CLASS_DEVICE you will get junk out of
> it according to your comment above.
> 
> I would like to pick Bjorn's brain on this to see what we can really do
> to fix this (and other) drivers.

  - Check to see whether you're reading anything in the 32-bit dword at
    offset 0x08.

  - Do the 32-bit readl().

  - Insert the correct Sub-Class and Base Class code (you also throw
    away the Programming Interface; not sure why that is)

  - If you're reading something smaller than 32 bits, mask & shift as
    needed.  pci_bridge_emul_conf_read() does something similar that
    you might be able to copy.

Out of curiosity, what code depends on PCI_CLASS_BRIDGE_PCI?  There
are several places in the kernel that currently depend on it, but I
think several of them *should* be checking dev->hdr_type to identify a
type 1 header instead.

Bjorn
