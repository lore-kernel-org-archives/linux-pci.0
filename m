Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0D3C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 17:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39ED20842
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 17:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39ED20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeIYXmA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:42:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33463 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeIYXmA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2018 19:42:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so8766137pge.0;
        Tue, 25 Sep 2018 10:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93CkPH0+9ZK84C4ZVTEiA210DqPYunLMckKev7kSXTc=;
        b=IGoVDUllSVrd2n+sSSRVMVSmOq1RTwJYvD/Csr8AcxZP71O/6Of9AF+ylGCU8OU7in
         DNP/tqhT1EdGf8iDlyCgbIn46rTv9p5HPQIZGVIYYvWNKhPNqNqeTWgwMeGro0P+r9iY
         sBAyZ28NORP3+xa8st3EDagw/VrtTnJb8Np7avTmM0nX9gLJ7l+oVf/xLIaUKfe21QkY
         pDDoVI2Nxq4k6xqgQASDw4wHUtRL5ZHKWPjJ+qf7KHXZuEVn8+UIO5H7Ev1/EYSrSyMQ
         qQq5OVcw6MgoOx5rsXf9jr6TUpJOoyyHDbkI3JW+6G4LR7D6F6GM1GF86hu0ktKYRUOB
         04Ww==
X-Gm-Message-State: ABuFfog4ylxhh3NWoD7u2K5QugGskb4IuFokUjW0hstySUsONogWQceW
        y1JSNwi6XqlX3sRXulPEnBU=
X-Google-Smtp-Source: ACcGV62MhG7g4R/2h0B4P29/eiGKLp/nbakbpvEqmLJX5cNNYq6sJFxsAjrOSScLwf8yK/O+GEOUmg==
X-Received: by 2002:a63:b23:: with SMTP id 35-v6mr2011075pgl.301.1537896807533;
        Tue, 25 Sep 2018 10:33:27 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id g15-v6sm4933994pfg.98.2018.09.25.10.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 10:33:26 -0700 (PDT)
Message-ID: <1537896805.11137.25.camel@acm.org>
Subject: Re: [PATCH v7 03/13] PCI/P2PDMA: Add PCI p2pmem DMA mappings to
 adjust the bus offset
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
Date:   Tue, 25 Sep 2018 10:33:25 -0700
In-Reply-To: <20180925162231.4354-4-logang@deltatee.com>
References: <20180925162231.4354-1-logang@deltatee.com>
         <20180925162231.4354-4-logang@deltatee.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2018-09-25 at 10:22 -0600, Logan Gunthorpe wrote:
+AD4 +-int pci+AF8-p2pdma+AF8-map+AF8-sg(struct device +ACo-dev, struct scatterlist +ACo-sg, int nents,
+AD4 +-		      enum dma+AF8-data+AF8-direction dir)
+AD4 +-+AHs
+AD4 +-	struct dev+AF8-pagemap +ACo-pgmap+ADs
+AD4 +-	struct scatterlist +ACo-s+ADs
+AD4 +-	phys+AF8-addr+AF8-t paddr+ADs
+AD4 +-	int i+ADs
+AD4 +-
+AD4 +-	/+ACo
+AD4 +-	 +ACo p2pdma mappings are not compatible with devices that use
+AD4 +-	 +ACo dma+AF8-virt+AF8-ops. If the upper layers do the right thing
+AD4 +-	 +ACo this should never happen because it will be prevented
+AD4 +-	 +ACo by the check in pci+AF8-p2pdma+AF8-add+AF8-client()
+AD4 +-	 +ACo-/
+AD4 +-	if (WARN+AF8-ON+AF8-ONCE(IS+AF8-ENABLED(CONFIG+AF8-DMA+AF8-VIRT+AF8-OPS) +ACYAJg
+AD4 +-			 dev-+AD4-dma+AF8-ops +AD0APQ +ACY-dma+AF8-virt+AF8-ops))
+AD4 +-		return 0+ADs

Are you assuming that the compiler will optimize out the dev-+AD4-dma+AF8-ops
+AD0APQ +ACY-dma+AF8-virt+AF8-ops test if CONFIG+AF8-DMA+AF8-VIRT+AF8-OPS+AD0-n such that no reference to the
dma+AF8-virt+AF8-ops symbol appears in the object file? Are you sure all compilers
and compiler versions that are used to build the Linux kernel will do that?

Thanks,

Bart.

