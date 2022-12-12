Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C48C4332F
	for <linux-pci@archiver.kernel.org>; Mon, 12 Dec 2022 08:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiLLIqO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Dec 2022 03:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLLIqN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 03:46:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC96DFD5;
        Mon, 12 Dec 2022 00:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mxg+fh7pNzG+kVo8QoQhPU2/hUVVhX3u+IZZMCkcybA=; b=QFtwNfwmTpLHGd/3xxmNtCSJ0r
        qROU/jxGS7Ij5QY1t/9B6FtMH7+XMla6iqD4uOPci4wxrals7fMOZyWIQuIC6c01AMzIrZHvcWDjq
        TmOd2hjgDCpWjr+dpqYWrqKqHW2a3ILuXHEn2De1frl4Nc06Y9vcxCaJ2G2URepKe6oRprvanravj
        fplOeoVWY49aPwFLZ5BfwM1PjYPoLe5hvaj/7ZtT0FAR2nsniovMAAemFllhA4BplYuMnmGsaKbpw
        7tr0+epMoRl7y2TqyOZtOpFr9ZEMo9v9yJ2BjbDTxyOOAe6ZlXGUeU5yJYICH4YwZLT7T1LIga8dH
        4tSlgTxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4eRv-00AWB5-BG; Mon, 12 Dec 2022 08:46:11 +0000
Date:   Mon, 12 Dec 2022 00:46:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3] PCI/portdrv: Allow AER service only for Root Ports &
 RCECs
Message-ID: <Y5bqU0rc44NtYJXl@infradead.org>
References: <20221210002922.1749403-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221210002922.1749403-1-helgaas@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 06:29:22PM -0600, Bjorn Helgaas wrote:
> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +             pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
> +	    dev->aer_cap && pci_aer_available() &&
>  	    (pcie_ports_native || host->native_aer))

Eww, this is really hard to follow.  Can you split this out into
a little helper, that actually documents the decisions based
on some of the wording you have in the current comit message?
