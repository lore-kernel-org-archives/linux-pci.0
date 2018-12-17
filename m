Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9620C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C41320675
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S8UdykSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeLQRfu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:35:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeLQRfu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Dec 2018 12:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JmBmThrp855oOtumKAAjqsJEcOKvJL8IthTlNgmmRsI=; b=S8UdykSusuB8NWUm7zK4FEJth
        600mTxEKqdPjkgY5cL4D8Uiy7xJGksiMZHXnEHfLFnEkzb6RHGlWqftWKOtjfEfR1oLDGXjM57p6O
        b0H0oyvg3Pj4gBCkB8+RJuwoiS3X5DlGaA4UjZG0Ar/bUhsblR+uATnN3r9Quxge/HD4mQ083TJqF
        wltiJA//ueGWYT6xPFIv8JdGp+mPKtKBy9WJh/MExxs10iL3pOMaDAOgb0LVd+LFr6HsB5SuwNrw3
        FsSDN7zK4cmXLG0+bwJ2Qw1krVvB72FY2QW2Q9Rm1DfQrcHX632Rrti4V2gMwukJ5cE7qYZorWmqU
        kbyIB8ong==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYwny-0002XH-AC; Mon, 17 Dec 2018 17:35:46 +0000
Date:   Mon, 17 Dec 2018 09:35:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] s390/pci: handle function enumeration after sriov
 enablement
Message-ID: <20181217173546.GA4106@infradead.org>
References: <20181212215453.GJ99796@google.com>
 <20181213175428.87520-2-sebott@linux.ibm.com>
 <20181214131245.GB2606@infradead.org>
 <20181214131802.GA13950@infradead.org>
 <alpine.LFD.2.21.1812171806330.28490@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1812171806330.28490@schleppi>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 17, 2018 at 06:30:18PM +0100, Sebastian Ott wrote:
> Something like this:
> https://lore.kernel.org/linux-pci/20181212215453.GJ99796@google.com/T/#m649d86ea3c65f669c74d048f89afbaf473876ac3

No, I literally meant a flag to skip the work.  Think about it: there
is a standard way to probe VFs, which comes from what is defined in the
PCIe spec itself.  It just turns out s390 for some weird reason decides
to already let the VFs show up basically like PFs.  There really should
be no reason to branch out into per-arch code here as there really
isn't much to do on a per-arch level.  More just a quirk for the
firmware is buggy and already reports the VFs to us, so skip the
probing.
