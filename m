Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC462C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 17:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA7420842
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 17:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA7420842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeIYXht (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:37:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42755 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbeIYXhs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2018 19:37:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so12051309pgp.9;
        Tue, 25 Sep 2018 10:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aU8Y/8mDcaCk6uRU0aOMBAJ7SSRSxdGenG/C818kHl4=;
        b=E/gksXwP97NzsNgMPFBdSsGJnUanVG8Izg7J0ZCOMRsGqvSjnczdNRukxmcX5wNGRu
         AupMww9m8IjqaOKP3oNEely8uRNHD/GSvDCVuI3o6T9oevqq+7LdteyUoCBdRPeywgyM
         f4UfL90XK8Bv0xmzGLO7SR05UZwl+z8tJFbJ/F6qjNM3r4lvK8t9YrnYrgQDKl4dX5JD
         IqpGuJpMdbtfBeZvQjQ4Nbw5p+i3736voazpbEXTeriIb7P1GMIv6+HfyCv7/KGETYSX
         ueq3d3/tB5A57RJDNLTND+d5It2676nR9doezMnrIlBXXnBGbMh3S/kZ09R/mIpcazTJ
         nbDA==
X-Gm-Message-State: ABuFfohkQZXDgkfAkc65Di/cG74F+tsTwywWsLXdGxUPKMuf5v37mGNS
        JHaEE14qXxe9D/oJt/xTsJg=
X-Google-Smtp-Source: ACcGV62BL4T1QFEJbGQ/tica4x+V2G6iRkFyRxPiamzoVd8rITZD4XFmVhO/3TPdYZouZbCtnfEwLQ==
X-Received: by 2002:a62:1655:: with SMTP id 82-v6mr2152095pfw.11.1537896557509;
        Tue, 25 Sep 2018 10:29:17 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h124-v6sm4988061pfg.112.2018.09.25.10.29.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 10:29:16 -0700 (PDT)
Message-ID: <1537896555.11137.22.camel@acm.org>
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
Date:   Tue, 25 Sep 2018 10:29:15 -0700
In-Reply-To: <20180925162231.4354-3-logang@deltatee.com>
References: <20180925162231.4354-1-logang@deltatee.com>
         <20180925162231.4354-3-logang@deltatee.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2018-09-25 at 10:22 -0600, Logan Gunthorpe wrote:
+AD4 +AEAAQA -83,9 +-132,14 +AEAAQA static int pci+AF8-p2pdma+AF8-setup(struct pci+AF8-dev +ACo-pdev)
+AD4  
+AD4  	pdev-+AD4-p2pdma +AD0 p2p+ADs
+AD4  
+AD4 +-	error +AD0 sysfs+AF8-create+AF8-group(+ACY-pdev-+AD4-dev.kobj, +ACY-p2pmem+AF8-group)+ADs
+AD4 +-	if (error)
+AD4 +-		goto out+AF8-pool+AF8-destroy+ADs
+AD4 +-
+AD4  	return 0+ADs
+AD4  
+AD4  out+AF8-pool+AF8-destroy:
+AD4 +-	pdev-+AD4-p2pdma +AD0 NULL+ADs
+AD4  	gen+AF8-pool+AF8-destroy(p2p-+AD4-pool)+ADs
+AD4  out:
+AD4  	devm+AF8-kfree(+ACY-pdev-+AD4-dev, p2p)+ADs

This doesn't look right to me. Shouldn't devm+AF8-remove+AF8-action() be called instead
of devm+AF8-kfree() if sysfs+AF8-create+AF8-group() fails?

Thanks,

Bart.

