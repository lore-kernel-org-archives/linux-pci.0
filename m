Return-Path: <SRS0=286E=MV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5F7C64EAD
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 14:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FC32064E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 14:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YSQHKunU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FC32064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeJIVZm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:25:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIVZm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Oct 2018 17:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Dy6J4FCb2/CtkL9kr5UgKmkfX4LTogNNOMfbnquEYZU=; b=YSQHKunUBa2qwhcO5/bJeB06Y
        RkX4f58rtAivbzv2iYiP3Xl0XTF4K7o/pv5mocw9DdVJJsfYwaUKsYIK2RfFGrQ8INqeCYUiTKoz+
        GjchRexUdFzXOO51oCoycu2yrRtlZCjtAiPo0kodxBarbeSgN3eOHsPxHorxq/yUAIDLTpAQeaYZO
        z4pk6l4L2vv6wpPpLIYhR+YYhPHJu4XF89To9Fdcv/GjVIQZmp/Ot4WXujTEv9swb281MlREArrjY
        LtjdiAa1qGL8YuqfEQcMQvtubEgBr2NloMKjp5oLBPQj+xazu2bmKdB7Y1lI5juh9f/LmyMLvzGMd
        Yda3rQv0w==;
Received: from 089144207060.atnat0016.highway.bob.at ([89.144.207.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9sgW-00067L-QE; Tue, 09 Oct 2018 14:08:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: PCI DMA compat cleanups
Date:   Tue,  9 Oct 2018 16:08:21 +0200
Message-Id: <20181009140824.18667-1-hch@lst.de>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Start removing a few almost unused bits of the PCI DMA compat wrappers.

