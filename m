Return-Path: <SRS0=HN6g=PX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E75BC43387
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 16:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E1920866
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 16:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dIvSzUMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfAOQWt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:22:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36840 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbfAOQWt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jan 2019 11:22:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so1442477pgm.3
        for <linux-pci@vger.kernel.org>; Tue, 15 Jan 2019 08:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3RFyiBr48haMmABLwkD2mTZ68W2vD9ZPJ2aFBP1uwEE=;
        b=dIvSzUMge7Clt1X+VeMLdQ4c7HGx2KZOhWXTEBBtULntes82FCQ8EaPfZaUH4OyIlm
         NXnFxGfIMHRGFg7oHQSpL0Yk6/H7MJkC70VrpvHZigpCtKXhL+GjmmBU1xhxrI/jHHJf
         mILDDz/j1sKibfAhwMBdHMuwT6yNErCe0SVljIKPr3ufZOMvc+m9Ng614hrLsZUjiLE2
         lReIHDC+kxDcq9lciFS8DmXzLPjZVQpor/U7kd0voD2HWXibVhbjwOjvONH/1q3BPMqT
         7KkFQYhglm+mfCshZaBYH1HaiBV9e71hbnuAkb7Ebb4J2zhcb6x++q+RcHeVYAJYNPDK
         I82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3RFyiBr48haMmABLwkD2mTZ68W2vD9ZPJ2aFBP1uwEE=;
        b=GcTjyGk/kruuC0oNk9rVe3zZ2J7+crs6P+wmI8RwuQAVr6Ch4M7HNV0GNxKr51IHF5
         WWkiqkfFtUeryKiO97y4ONju38Q7v/xWsANvtI2VleJ/U7ezzXVs7xAM8XCLv75sCNHv
         qoU2J8CQ/IWLHNpeKlkkpT+T5i1K8gzwDBIk1gnvYgYV90Ztg5kCuFgQHN/o7SWYx5tT
         ex11MJFhqDlmdTXQnCb/UL+cQOjViwlHq9nPYZCmAosGwGK1dCk16xV+4fVFBuyNXxk2
         RFX9M43lHcg/ktP2faQFHmWmjB8inK3EsPw1TsinHpi8+aQeiVvDfvwK/xdkG1its8Nw
         BaoQ==
X-Gm-Message-State: AJcUukfXOxFhxNEhzccw0RVQKZd0fagWPL15it4DcZv7rS5lv3vNVqvG
        Psl8Q4/6kCtDgOc6Gzsq0S7PiQ==
X-Google-Smtp-Source: ALg8bN5BN92wyychkQsC9NlkwYTwj7LISf8qmrNFRYfcsU0YNx62EDfnhbw3aZH13fXJbtSQfLij0Q==
X-Received: by 2002:a63:8ac4:: with SMTP id y187mr4528162pgd.446.1547569368541;
        Tue, 15 Jan 2019 08:22:48 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id n186sm4477583pfn.137.2019.01.15.08.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 08:22:47 -0800 (PST)
Subject: Re: [PATCH] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org
References: <20190103013106.26452-1-ming.lei@redhat.com>
 <20190114232338.GE33971@google.com> <20190115131140.GB28672@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <05cb9e71-e455-a717-c64c-b5242ec38bad@kernel.dk>
Date:   Tue, 15 Jan 2019 09:22:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115131140.GB28672@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/15/19 6:11 AM, Christoph Hellwig wrote:
> On Mon, Jan 14, 2019 at 05:23:39PM -0600, Bjorn Helgaas wrote:
>> Applied to pci/msi for v5.1, thanks!
>>
>> If this is something that should be in v5.0, let me know and include the
>> justification, e.g., something we already merged for v5.0 or regression
>> info, etc, and a Fixes: line, and I'll move it to for-linus.
> 
> I'd be tempted to queues this up for 5.0.  Ming, what is your position?

I think we should - the API was introduced in this series, I think there's
little (to no) reason NOT to fix it for 5.0.

-- 
Jens Axboe

