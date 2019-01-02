Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20471C43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 21:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBB121479
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 21:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7hdrt4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfABVxp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:53:45 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37357 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfABVxp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jan 2019 16:53:45 -0500
Received: by mail-qk1-f195.google.com with SMTP id g125so18678571qke.4;
        Wed, 02 Jan 2019 13:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpU9ueJWimRZN5ClORmbPV5vMXo80pKzaKAGizI7NnQ=;
        b=g7hdrt4Syl2G3/8HbeDcQPY4Cv3qr3lv9T6BdqVvR4JyOqVbPPeu21Kfk0r+J5G9RT
         l5tCy87xrEHoemsH8uNo+kv+giZDS5OktVhZA1JOCICUpGvJ57JUi2RwOk4udTT80qMI
         wqUQJlTB3J4chy+1c8rZwzXrSuhkY0ahT0lJZsypDdfQPy5HAghKxcJU8CELTBR+w5It
         scQG/nVsLJy+v4xStnRzAIfI/WAhRYkjzTXXaEmNCZ5uRSejMUazJ0f5ed9ryxs9ShYX
         0/qHgxTQhNpb8s/tukrnSs2dTHuRbjO9YOb21sdTfMjOd6Pq74e5yBSd5ogVJCM/HjKj
         J6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpU9ueJWimRZN5ClORmbPV5vMXo80pKzaKAGizI7NnQ=;
        b=f9iVB4uI6tpXozZDrQJB0wnRJJj/DiqPoCdz9fLsf+8N/YoBQ7YbqU5+02CmIM+aXD
         Z+dA6A8LK36GQFnLI+fiteUehzv6VKxyKkr7+bVqq8ChNfZvX3u0fw8WHMDnt5W0yM6a
         cDvhYI0drulxkQibSBfXUiN9ojQaVoimvkxA744Kri1FqSYu4L1/yVpN31T3HummDvaO
         szRwCXqiVTG2UkPb9COrKl7VoiFG/7iSOWV7jyvlPCnCl8caAQ9O38C0ZH35g2lRUr0u
         t33K9xxau9Bbw1wqMScGHU1X8HLmjLE5WK9q4LD74UIUoyuToK5y0Q+MJobGY/eqigvX
         vz2Q==
X-Gm-Message-State: AJcUukd/KaryKFVPmMpua/FwgYHr+zE9pGJaETiN9+eGAt1EKnNsQt5L
        AchMpkYgitTfKeXL5MDyIBe/fKFYW8uBvdkrT64=
X-Google-Smtp-Source: ALg8bN4N5FwxzflmYfuhrfDpz3T0ttVhqT+g7g5JuoxtMq9w3CYLljkK071Evk7GNOqUflJRgU/vrKVhuYobL4RbAEI=
X-Received: by 2002:a37:8383:: with SMTP id f125mr42244769qkd.49.1546466024135;
 Wed, 02 Jan 2019 13:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20181207190720.18517-1-hch@lst.de> <20181207190720.18517-3-hch@lst.de>
In-Reply-To: <20181207190720.18517-3-hch@lst.de>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Wed, 2 Jan 2019 13:53:33 -0800
Message-ID: <CA+8MBb+9prWYSmp25K-LMUv1_0eekvFqXhoj87CV9zcaXfMDGg@mail.gmail.com>
Subject: Re: [PATCH 02/15] swiotlb: remove dma_mark_clean
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        X86-ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 7, 2018 at 11:08 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Instead of providing a special dma_mark_clean hook just for ia64, switch
> ia64 to use the normal arch_sync_dma_for_cpu hooks instead.
>
> This means that we now also set the PG_arch_1 bit for pages in the
> swiotlb buffer, which isn't stricly needed as we will never execute code
> out of the swiotlb buffer, but otherwise harmless.

ia64 build based on arch/ia64/configs/zx1_defconfig now fails with undefined
symbols arch_dma_alloc and arch_dma_free (used by kernel/dma/direct.c).

This config doesn't define CONFIG_SWIOTLB, so we don't get the
benefit of the routines in arch/ia64/kernel/dma-mapping.c

-Tony
