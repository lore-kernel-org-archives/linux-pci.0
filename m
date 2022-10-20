Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EC3C4321E
	for <linux-pci@archiver.kernel.org>; Thu, 20 Oct 2022 08:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJTIeU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Oct 2022 04:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiJTId4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 04:33:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8A518D46B;
        Thu, 20 Oct 2022 01:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=q/+Bmqv8b9biuzMGEpuDESH4tY
        Wa4cylH5Xk8lRs7dKRrTk2SATLFQyTk1ILSbnsVB6UaJrwmyZUGGFNSgkndL1c6sbRB1yNX+7yL9R
        kskzKkktFJRAq4E/hF303BOlaywZXAYmBbJQ7S0CLqVNXypx5sCZ3khgwWRvrOfIYkuxDkrOI9qYQ
        ujKBZN/IL1NtLwZt3RxCWA+10Z12Q6VFvtsnwQfrJAy5Bhm3/rab63PH7f1C3KyeNFylmN5wD2xZo
        gRpnT0TlKEBc0xHHO4HDjqAAxwG2Lq35ybU/C8v3yDaFaTk4UB9YFZhyLZpOwtWIq/D6xqfvQvId9
        qUQa9eLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olQzx-00CG9l-DQ; Thu, 20 Oct 2022 08:33:53 +0000
Date:   Thu, 20 Oct 2022 01:33:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Lukas Wunner <lukas@wunner.de>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] PCI/portdrv: Move private things to portdrv.c
Message-ID: <Y1EH8U9kgEaSjYDf@infradead.org>
References: <20221019204127.44463-1-helgaas@kernel.org>
 <20221019204127.44463-3-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019204127.44463-3-helgaas@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
