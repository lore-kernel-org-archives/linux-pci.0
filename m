Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B03DC4332F
	for <linux-pci@archiver.kernel.org>; Mon, 21 Nov 2022 07:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiKUHJh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Nov 2022 02:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKUHJg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 02:09:36 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DB3175BC
        for <linux-pci@vger.kernel.org>; Sun, 20 Nov 2022 23:09:35 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E204C68AA6; Mon, 21 Nov 2022 08:09:31 +0100 (CET)
Date:   Mon, 21 Nov 2022 08:09:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Zeng Heng <zengheng4@huawei.com>, tglx@linutronix.de,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        liwei391@huawei.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] PCI: fix possible null-pointer dereference about
 devname
Message-ID: <20221121070931.GA23882@lst.de>
References: <20221121020029.3759444-1-zengheng4@huawei.com> <20221121025608.GA72419@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121025608.GA72419@bhelgaas>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 20, 2022 at 08:56:08PM -0600, Bjorn Helgaas wrote:
> [+cc Christoph, 704e8953d3e9 author]

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
