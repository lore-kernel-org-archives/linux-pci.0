Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261EEC43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 07:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21D5204FD
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 07:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WIXeuHQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbeLSHwz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:52:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeLSHwz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Dec 2018 02:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i+/DxJq3sOUbJe8iCycnn8bNVl0mCXebPDQt4YLc0wQ=; b=WIXeuHQcoboe57FW8DrVcijb6
        hWg5NVsI1Z+BvUFqi3M59dOf0ZGsO9vDqUapReTq6QDsfbem6I97czy2zyFG6PC8NbfDIO7xcoGfR
        ny52tkZMrztqUWsF5KniJISYw3WY4hvwAvZ3Ezn3G6tQOOV9TFF/y1Mgx13p/9rqsSbe1JXrNb3BC
        e/Exv0CWY4saPkoCm1T25WTktOpxW4QlrogQ8jEt1Ysdx0m8CD7s1FPjWJ+jSBWFfgmAIasKz/ED4
        br6kBNw96CUDi4OHGtD4jqGhs2yTrjgZmfQef8UKRcL/DfA/qf+MC6bAXh+rCkQ5dB2NN8FH+WOTM
        nsfw22JRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZWf0-0000Ub-Hp; Wed, 19 Dec 2018 07:52:54 +0000
Date:   Tue, 18 Dec 2018 23:52:54 -0800
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
Subject: Re: [PATCH 2/2] s390/pci: skip VF scanning
Message-ID: <20181219075254.GB1684@infradead.org>
References: <20181217173546.GA4106@infradead.org>
 <20181218101650.23089-2-sebott@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218101650.23089-2-sebott@linux.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 11:16:50AM +0100, Sebastian Ott wrote:
> Set the flag to skip scanning for VFs after SRIOV enablement.
> VF creation will be triggered by the hotplug code.
> 
> Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
