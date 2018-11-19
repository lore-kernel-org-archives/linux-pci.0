Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E40C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 14:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FB02089F
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 14:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hw0a9Vi2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FB02089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbeKTBDI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:03:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbeKTBDH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Nov 2018 20:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=At/LRceUgeM+WuLHzROM+zGY0dThO8RIcOf7iK4BX1I=; b=Hw0a9Vi2kbX6Ru3XNV08/BDrG
        fSh2Lx5iB/IQgGm3/76mwJYLT8CEblxHWahgxnaBE0v7B+l8FQtk3g7uaRqSGobJSHjnpGk0nEPCL
        Wsynmcs/QWbfDv0Mj2vCNI98hTQZjGXbxpBD1mthi+nL5i+gYs2+DKLPUUjN3oIrc4uuGPaYQFjQD
        U/t27bbCHCQu/iVLKOFf6Nj2UXvfGJjhOhUlrqkW8EUt1p7ZchE7Ijyoliwmk8bbD/BnDEKBhVPSQ
        CfBLqF9P9oIGg15pzL4cH4NwFH20WS1hinAzAO6W/B8DQcuw+zt16yHz0ckxPqoKTg4mPzymAlV9F
        jJ7DuzCGw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOkhq-0007Qe-9T; Mon, 19 Nov 2018 14:39:18 +0000
Date:   Mon, 19 Nov 2018 06:39:18 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        LKP <lkp@01.org>
Subject: Re: [LKP] dad4f140ed [ 7.709376] WARNING:suspicious_RCU_usage
Message-ID: <20181119143918.GB394@bombadil.infradead.org>
References: <20181119010820.GM18977@shao2-debian>
 <20181119011904.GE7861@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119011904.GE7861@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 18, 2018 at 05:19:04PM -0800, Matthew Wilcox wrote:
> On Mon, Nov 19, 2018 at 09:08:20AM +0800, kernel test robot wrote:
> > Greetings,
> > 
> > 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> Umm.  I don't see a 'suspicious RCU usage' message in here.  I see a
> lot of vmalloc warnings ... ?

Never mind, the RCU warnings were in one of the attached dmesg files.
I found the problem; it's in the test-suite and not something that could
lead to any real problems today.

Thanks for the report!
