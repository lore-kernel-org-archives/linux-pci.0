Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B418AC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 17:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2B420842
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 17:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2B420842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeIYXeO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:34:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38466 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIYXeO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2018 19:34:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so11692008pfh.5;
        Tue, 25 Sep 2018 10:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2sSn/HGMmACltgsdlKbYnVeSTGAg9t5hmDJQZ4ty18=;
        b=k/VFmvKHTFxCFItI8y7C0C9NwBQHB9K21Q9rqN+zErmhEqB9ZzUXZpiyrtAOFAiLs3
         dr2/4kKZ0xZrgOzhBLhtURlHWfaXN/x6gGsYAmBjQvNaejNgKpMrkYB9bOSioRCfozJV
         ar9JYHd9EkzvWP7CImMWZLiwBuRohocojARZyUjNwGNunGwSGjLUHJ+v9NjKu8/I9AQX
         rzQeph/jfvpqhBIiVNCC5ZTqRhBgWOTc/bqAH49rBckzQTpGiAGm1+YlAGA39J8pqWtT
         oZbRFZgzhUFCLtscB6aichlzzj4NMekYW3Hqs1VV5CyNF1ZeKRBr4ausMB0ZsrBOppiU
         HelA==
X-Gm-Message-State: ABuFfohJivWam0tTGvHJO5+feCUjyqPZl8+4KcBH6UbeOo08LMuRa2rM
        9gHnGUoqKSykT8kL1HAynKE=
X-Google-Smtp-Source: ACcGV62KXv5k1WsqYzTsj5Tbbd/JkaqBJQ27HIJveA9Sz/Wgn9yvIFQ7RR1NWu/g8P5RZls2jcEchA==
X-Received: by 2002:a17:902:bb90:: with SMTP id m16-v6mr2182247pls.254.1537896342465;
        Tue, 25 Sep 2018 10:25:42 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id o21-v6sm4719474pfa.54.2018.09.25.10.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 10:25:41 -0700 (PDT)
Message-ID: <1537896340.11137.19.camel@acm.org>
Subject: Re: [PATCH v7 01/13] PCI/P2PDMA: Support peer-to-peer memory
From:   Bart Van Assche <bvanassche@acm.org>
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jens Axboe <axboe@kernel.dk>
Date:   Tue, 25 Sep 2018 10:25:40 -0700
In-Reply-To: <20180925162231.4354-2-logang@deltatee.com>
References: <20180925162231.4354-1-logang@deltatee.com>
         <20180925162231.4354-2-logang@deltatee.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2018-09-25 at 10:22 -0600, Logan Gunthorpe wrote:
+AD4 +AFs ... +AF0

Hi Logan,

It's great to see this patch series making progress. Unfortunately I didn't
have the time earlier to have a closer look at this patch series. I hope that
you don't mind that I ask a few questions about the implementation?

+AD4 +-static void pci+AF8-p2pdma+AF8-percpu+AF8-kill(void +ACo-data)
+AD4 +-+AHs
+AD4 +-	struct percpu+AF8-ref +ACo-ref +AD0 data+ADs
+AD4 +-
+AD4 +-	if (percpu+AF8-ref+AF8-is+AF8-dying(ref))
+AD4 +-		return+ADs
+AD4 +-
+AD4 +-	percpu+AF8-ref+AF8-kill(ref)+ADs
+AD4 +-+AH0

The percpu+AF8-ref+AF8-is+AF8-dying() test should either be removed or a comment should be
added above it that explains why it is necessary. Is the purpose of that call
perhaps to protect against multiple calls of pci+AF8-p2pdma+AF8-percpu+AF8-kill()? If so,
which mechanism serializes these multiple calls?

+AD4 +-static void pci+AF8-p2pdma+AF8-release(void +ACo-data)
+AD4 +-+AHs
+AD4 +-	struct pci+AF8-dev +ACo-pdev +AD0 data+ADs
+AD4 +-
+AD4 +-	if (+ACE-pdev-+AD4-p2pdma)
+AD4 +-		return+ADs
+AD4 +-
+AD4 +-	wait+AF8-for+AF8-completion(+ACY-pdev-+AD4-p2pdma-+AD4-devmap+AF8-ref+AF8-done)+ADs
+AD4 +-	percpu+AF8-ref+AF8-exit(+ACY-pdev-+AD4-p2pdma-+AD4-devmap+AF8-ref)+ADs
+AD4 +-
+AD4 +-	gen+AF8-pool+AF8-destroy(pdev-+AD4-p2pdma-+AD4-pool)+ADs
+AD4 +-	pdev-+AD4-p2pdma +AD0 NULL+ADs
+AD4 +-+AH0

Which code frees the memory pdev-+AD4-p2pdma points at? Other functions similar to
pci+AF8-p2pdma+AF8-release() call devm+AF8-remove+AF8-action(), e.g. hmm+AF8-devmem+AF8-ref+AF8-exit().

+AD4 +-static int pci+AF8-p2pdma+AF8-setup(struct pci+AF8-dev +ACo-pdev)
+AD4 +-+AHs
+AD4 +-	int error +AD0 -ENOMEM+ADs
+AD4 +-	struct pci+AF8-p2pdma +ACo-p2p+ADs
+AD4 +-
+AD4 +-	p2p +AD0 devm+AF8-kzalloc(+ACY-pdev-+AD4-dev, sizeof(+ACo-p2p), GFP+AF8-KERNEL)+ADs
+AD4 +-	if (+ACE-p2p)
+AD4 +-		return -ENOMEM+ADs
+AD4 +-
+AD4 +-	p2p-+AD4-pool +AD0 gen+AF8-pool+AF8-create(PAGE+AF8-SHIFT, dev+AF8-to+AF8-node(+ACY-pdev-+AD4-dev))+ADs
+AD4 +-	if (+ACE-p2p-+AD4-pool)
+AD4 +-		goto out+ADs
+AD4 +-
+AD4 +-	init+AF8-completion(+ACY-p2p-+AD4-devmap+AF8-ref+AF8-done)+ADs
+AD4 +-	error +AD0 percpu+AF8-ref+AF8-init(+ACY-p2p-+AD4-devmap+AF8-ref,
+AD4 +-			pci+AF8-p2pdma+AF8-percpu+AF8-release, 0, GFP+AF8-KERNEL)+ADs
+AD4 +-	if (error)
+AD4 +-		goto out+AF8-pool+AF8-destroy+ADs
+AD4 +-
+AD4 +-	percpu+AF8-ref+AF8-switch+AF8-to+AF8-atomic+AF8-sync(+ACY-p2p-+AD4-devmap+AF8-ref)+ADs

Why are percpu+AF8-ref+AF8-init() and percpu+AF8-ref+AF8-switch+AF8-to+AF8-atomic+AF8-sync() called
separately instead of passing PERCPU+AF8-REF+AF8-INIT+AF8-ATOMIC to percpu+AF8-ref+AF8-init()?
Would using PERCPU+AF8-REF+AF8-INIT+AF8-ATOMIC eliminate a call+AF8-rcu+AF8-sched() call and
hence make this function faster?

+AD4 +-static struct pci+AF8-dev +ACo-find+AF8-parent+AF8-pci+AF8-dev(struct device +ACo-dev)
+AD4 +-+AHs
+AD4 +-	struct device +ACo-parent+ADs
+AD4 +-
+AD4 +-	dev +AD0 get+AF8-device(dev)+ADs
+AD4 +-
+AD4 +-	while (dev) +AHs
+AD4 +-		if (dev+AF8-is+AF8-pci(dev))
+AD4 +-			return to+AF8-pci+AF8-dev(dev)+ADs
+AD4 +-
+AD4 +-		parent +AD0 get+AF8-device(dev-+AD4-parent)+ADs
+AD4 +-		put+AF8-device(dev)+ADs
+AD4 +-		dev +AD0 parent+ADs
+AD4 +-	+AH0
+AD4 +-
+AD4 +-	return NULL+ADs
+AD4 +-+AH0

The above function increases the reference count of the device it returns a
pointer to. It is a good habit to explain such behavior above the function
definition.

+AD4 +-static void seq+AF8-buf+AF8-print+AF8-bus+AF8-devfn(struct seq+AF8-buf +ACo-buf, struct pci+AF8-dev +ACo-pdev)
+AD4 +-+AHs
+AD4 +-	if (+ACE-buf)
+AD4 +-		return+ADs
+AD4 +-
+AD4 +-	seq+AF8-buf+AF8-printf(buf, +ACIAJQ-s+ADsAIg, pci+AF8-name(pdev))+ADs
+AD4 +-+AH0

NULL checks in functions that print to a seq buffer are unusual. Is it
possible that a NULL pointer gets passed as the first argument to
seq+AF8-buf+AF8-print+AF8-bus+AF8-devfn()?

+AD4 +-struct pci+AF8-p2pdma+AF8-client +AHs
+AD4 +-	struct list+AF8-head list+ADs
+AD4 +-	struct pci+AF8-dev +ACo-client+ADs
+AD4 +-	struct pci+AF8-dev +ACo-provider+ADs
+AD4 +-+AH0AOw

Is there a reason that the peer-to-peer client and server code exist in the
same source file? If not, have you considered to split the p2pdma.c file into
two files - one with the code for devices that provide p2p functionality and
another file with the code that supports p2p users? I think that would make it
easier to follow the code.

+AD4 +-/+ACoAKg
+AD4 +- +ACo pci+AF8-free+AF8-p2pmem - allocate peer-to-peer DMA memory
+AD4 +- +ACo +AEA-pdev: the device the memory was allocated from
+AD4 +- +ACo +AEA-addr: address of the memory that was allocated
+AD4 +- +ACo +AEA-size: number of bytes that was allocated
+AD4 +- +ACo-/
+AD4 +-void pci+AF8-free+AF8-p2pmem(struct pci+AF8-dev +ACo-pdev, void +ACo-addr, size+AF8-t size)
+AD4 +-+AHs
+AD4 +-	gen+AF8-pool+AF8-free(pdev-+AD4-p2pdma-+AD4-pool, (uintptr+AF8-t)addr, size)+ADs
+AD4 +-	percpu+AF8-ref+AF8-put(+ACY-pdev-+AD4-p2pdma-+AD4-devmap+AF8-ref)+ADs
+AD4 +-+AH0
+AD4 +-EXPORT+AF8-SYMBOL+AF8-GPL(pci+AF8-free+AF8-p2pmem)+ADs

Please fix the header of this function - there is a copy-paste error in the
function header.

Thanks,

Bart.

