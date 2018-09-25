Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6565EC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 18:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268FA20833
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 18:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268FA20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeIZAkL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:40:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38973 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeIZAkL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2018 20:40:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85-v6so9103436pge.6;
        Tue, 25 Sep 2018 11:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJNp99YKvB4C1KvbWuHkn+/C4r9dypVuTN/kyAdvvVU=;
        b=MZjZJna+t5PHM7n9XPreAR/9yQbvTqlZZCC0Uf93hiWcN21+YFBDXp5wyxdiWRumXb
         k1GjQ53W/FjC/wJb3ve+YcsVYSho1dyWBBLRhmzYJ/l1uJ3dXqex69hBc7BfCN0hMnBW
         5VxuOK/+bocTXPcIAeFr0EavnPUk70YB+BQcLEZyY+EitIird4xQXzzs8HsFBrKTPcLt
         /mz3gCXSpbAeb0knkxSruSxTQ3nbUmIIOMsF6U6rBD5eKATetKejmimSZRVFzZKzZGa/
         h+Z1DryTOGPpHG86+s3tSyKlVRDanfxh9/B26AjeEsX1NGVg8qG2fYkQhijtY7HJUzR9
         FUyQ==
X-Gm-Message-State: ABuFfojNgRjR/JfyY2XlJqXSboKYStgzrdzkHazCDFX2L9X1A2NYKl98
        wwFIRF/8E03MM3NJgvMmOxI=
X-Google-Smtp-Source: ACcGV63FxpJ9I32EYCG1/ICI3bFd39LI/kp479zxlc8dD83GubQXYbghf9DD9qzDlxYVcSnQGDZ5sA==
X-Received: by 2002:a65:58c3:: with SMTP id e3-v6mr2172967pgu.117.1537900282182;
        Tue, 25 Sep 2018 11:31:22 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z11-v6sm10320054pgz.62.2018.09.25.11.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 11:31:21 -0700 (PDT)
Message-ID: <1537900280.11137.30.camel@acm.org>
Subject: Re: [PATCH v7 02/13] PCI/P2PDMA: Add sysfs group to display p2pmem
 stats
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
Date:   Tue, 25 Sep 2018 11:31:20 -0700
In-Reply-To: <9241a6af-9826-d1ff-c13b-882cb3b6a34a@deltatee.com>
References: <20180925162231.4354-1-logang@deltatee.com>
         <20180925162231.4354-3-logang@deltatee.com>
         <1537896555.11137.22.camel@acm.org>
         <9241a6af-9826-d1ff-c13b-882cb3b6a34a@deltatee.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2018-09-25 at 12:15 -0600, Logan Gunthorpe wrote:
+AD4 On 2018-09-25 11:29 a.m., Bart Van Assche wrote:
+AD4 +AD4 On Tue, 2018-09-25 at 10:22 -0600, Logan Gunthorpe wrote:
+AD4 +AD4 +AD4 +AEAAQA -83,9 +-132,14 +AEAAQA static int pci+AF8-p2pdma+AF8-setup(struct pci+AF8-dev +ACo-pdev)
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4  	pdev-+AD4-p2pdma +AD0 p2p+ADs
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4 +-	error +AD0 sysfs+AF8-create+AF8-group(+ACY-pdev-+AD4-dev.kobj, +ACY-p2pmem+AF8-group)+ADs
+AD4 +AD4 +AD4 +-	if (error)
+AD4 +AD4 +AD4 +-		goto out+AF8-pool+AF8-destroy+ADs
+AD4 +AD4 +AD4 +-
+AD4 +AD4 +AD4  	return 0+ADs
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4  out+AF8-pool+AF8-destroy:
+AD4 +AD4 +AD4 +-	pdev-+AD4-p2pdma +AD0 NULL+ADs
+AD4 +AD4 +AD4  	gen+AF8-pool+AF8-destroy(p2p-+AD4-pool)+ADs
+AD4 +AD4 +AD4  out:
+AD4 +AD4 +AD4  	devm+AF8-kfree(+ACY-pdev-+AD4-dev, p2p)+ADs
+AD4 +AD4 
+AD4 +AD4 This doesn't look right to me. Shouldn't devm+AF8-remove+AF8-action() be called instead
+AD4 +AD4 of devm+AF8-kfree() if sysfs+AF8-create+AF8-group() fails?
+AD4 
+AD4 That makes no sense to me. We are reversing a devm+AF8-kzalloc() not a
+AD4 custom action....

In case what I wrote was not clear: both devm+AF8-kzalloc() and
devm+AF8-add+AF8-action+AF8-or+AF8-reset() have to be reversed if sysfs+AF8-create+AF8-group() fails.
devm+AF8-add+AF8-action+AF8-or+AF8-reset() calls devres+AF8-add(). The latter function adds an
element to the dev-+AD4-devres+AF8-head list. So I think that only calling devm+AF8-kfree()
if sysfs+AF8-create+AF8-group() fails will lead to corruption of the dev-+AD4-devres+AF8-head
list.

Bart.
