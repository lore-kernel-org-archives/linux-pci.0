Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DAEC43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 15:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3657120823
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 15:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c3IziVFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfCZPkO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:40:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZPkO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2019 11:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ddrELWfaq28r97RSFxEagtPo6/4ffHooEQwWL2M/at4=; b=c3IziVFhqNwPjWfJ6giFbPiiy
        C04feaKppF+4kwo983aGwwNSF9w4Docs/bACZ2juVMlZnKuFdtG0feAhBz84ndd4LRr7LS74vqlo+
        GTnHKStlaQ2iQjgegAP+pJEb2gDS8EtjeK3LbuZOc1sOFG98yWGytS0ecUJBuygwqrzLuqWlMyBA9
        q2YHkM+L+qS43aHS+t2I+V7DTACyRqpizc0pAinXhxZemhcl76V5iuI2XIk1t7yRyhGmwr0+ZZ+zq
        ICaQb8G9qBaW5UOiD+nUaROoO0nxmk6+CA+Cs1U40o9wGQG7beOQge4Hozq7u7IOdOkqMMTXKjAn2
        z3RbfHpAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h8oBQ-0003rn-8Y; Tue, 26 Mar 2019 15:40:12 +0000
Date:   Tue, 26 Mar 2019 08:40:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>, kbuild-all@01.org,
        linux-pci@vger.kernel.org
Subject: Re: [pci:review/pci/resource 8/21] drivers/nvme/host/pci.c:2919:6:
 sparse: symbol 'nvme_rescan_prepare' was not declared. Should it be static?
Message-ID: <20190326154012.GA8171@infradead.org>
References: <201903262317.Xf94y2xJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903262317.Xf94y2xJ%lkp@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please make sure all nvme patches go by the nvme maintainers and have
an ACK, btw.  I've not even seen this patch before.
