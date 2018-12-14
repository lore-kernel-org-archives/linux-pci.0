Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04646C67839
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 13:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE2D2233E
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 13:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PpVkUnTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE2D2233E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbeLNNSE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:18:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50276 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbeLNNSD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Dec 2018 08:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5P7oylHujVtaztHCzLdNndYrV4nEGl9rReZYZKNV6M8=; b=PpVkUnTQmY4JT5qA9G1uikSPd
        QZli2qh9LSl4pPCfXIXZnXIGkt72s80ulvHIpOLfF6FN53jGE2hyS2tqXTTzGNbKVm8PaNUm6w9HT
        Fkda8yznylbTY7NZCrKIU6Y38PR2koLbysi5Hrh+6cf0yEXseAU2ETPtwtu0StsZX6YutppWtdkLY
        B9wsNGFFrTgXogi+iA3/mpzhsbteJHDxgjCc0HXbPTdQGwo21fjHHWMaS1pPLTK79DR6VM8PZjpDT
        OHjFmeJ/j4dFUH1pKbpQYrAgnhVNZItFaUwB/KrIN8cjW/Ahwov43vipM+bAva3nOIqwEId9EwBM7
        04LfzYs9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXnLu-0003eF-IV; Fri, 14 Dec 2018 13:18:02 +0000
Date:   Fri, 14 Dec 2018 05:18:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] s390/pci: handle function enumeration after sriov
 enablement
Message-ID: <20181214131802.GA13950@infradead.org>
References: <20181212215453.GJ99796@google.com>
 <20181213175428.87520-2-sebott@linux.ibm.com>
 <20181214131245.GB2606@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214131245.GB2606@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 14, 2018 at 05:12:45AM -0800, Christoph Hellwig wrote:
> On Thu, Dec 13, 2018 at 06:54:28PM +0100, Sebastian Ott wrote:
> > Implement pcibios_sriov_{add|del}_vfs as empty functions. VF
> > creation will be triggered by the hotplug code.
> 
> And instead of having the arch suplply a no-op arch override I
> think it would be better to have the config option just stub it
> out in common code.

Or in fact maybe even a runtime flag in struct pci_dev.  Who knows
if all future s390 PCIe busses will have exactly the same behavior
or if we eventually get the standards compliant behvior back?
