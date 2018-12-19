Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A10C43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 07:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C7C204FD
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 07:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kj0xTO4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeLSHwl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:52:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46666 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeLSHwl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Dec 2018 02:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=alsjOs5Is9hevKk0pOwCMLW0cPl6n+3yxxg+/hycS7E=; b=kj0xTO4oHe+M8g2pa81krF3IJ
        VOJZGn2zDwWBNMuwioIPFSY/rRcn6tXExr6oSPHoOsQTc7KnL4dVpc0nAqldp/mo7K9vUEQbPXw3+
        foxWlQRRpZT/WJYgSBpDAEBymRnstHKE1Jri1iz+EjA9VzRo0ASOotshu7oyyVgBbfTSsNTHAnl39
        T6No29B+SpGGYVQox7uZK1aYnz+iqLmXiR2QoDt7NZHLY6Fzq7n+Wg3TtyFIW63wAoAFqWqGzFVw1
        eHqXKWTDKPyYqNCzNOAyTpZE9h6QdFjUHU3jfABvlL2aTEBJ+txzgVV/CshUeG31yuyjsgaiAySIj
        R3dxnhJiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZWei-0000TN-LY; Wed, 19 Dec 2018 07:52:36 +0000
Date:   Tue, 18 Dec 2018 23:52:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] PCI/IOV: provide flag to skip VF scanning
Message-ID: <20181219075236.GA1684@infradead.org>
References: <20181217173546.GA4106@infradead.org>
 <20181218101650.23089-1-sebott@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218101650.23089-1-sebott@linux.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 11:16:49AM +0100, Sebastian Ott wrote:
> Provide a flag to skip scanning for new VFs after SRIOV enablement.
> This can be set by implementations for which the VFs are already
> reported by other means.
> 
> Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
