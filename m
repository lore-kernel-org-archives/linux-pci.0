Return-Path: <SRS0=cWhH=CM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7221C433E7
	for <linux-pci@archiver.kernel.org>; Thu,  3 Sep 2020 02:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D5D2078E
	for <linux-pci@archiver.kernel.org>; Thu,  3 Sep 2020 02:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBUm6X2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgICCDC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Sep 2020 22:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgICCDA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Sep 2020 22:03:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F713C061244
        for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2020 19:02:59 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w14so1589648ljj.4
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2020 19:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hhuuiXUXPKShiC2Hls0S5u+97zhlA3Lfy3FSwPZAvg=;
        b=MBUm6X2YTxoMrNEsmsd3ByNMySLkQvEH9s/fpLDT25i27Qzys1GNTUlZM5s8aDj8mo
         EqbWsiYrK41/1h7pE3vshEiq3zac+0m5Iw8AtlZV+UFOB1vMg2K6ukwyT9LBbKbzM4db
         Jgji/OQ9Z8TsGHrNvZMPNEyJ+vni7HtYdMpWBOEyZOlJrqR+TAawkYGdlo7m/Byi6vE/
         fDBMjBCwDFNbgq8DPZI8gscsPu6AT7J0XQoX4jMVhJLBYmRZRnTitm2OxSHEXgBZ567n
         Jtl3jhGFgMBh/7jclUPPjFKYPQpQTHifZNq4BZ7Yt1Gu8T26YPAK76w2QTUHjxYNViIE
         uXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hhuuiXUXPKShiC2Hls0S5u+97zhlA3Lfy3FSwPZAvg=;
        b=t+KI144x8dC0tBEtBD+Lmeo7FXt/k+DYKB4I+ZlmhIWxfUaaLcG/gDyV0X38aUUKq9
         JvoUKIHi917YX9+abpPZaBSlsEbViV5bqMqywPs0gs318SXPn25J67wnE/lvM3Ye/KeW
         aCWq2Q4fAhXMQbnyEVW+tle96qLy2QAzn33u976LbiXlzJcs0pJkkrCoSegaVtJGAZ48
         eBEMTIaUzIHxZ0bAM+F6LVNED6ssABtSWWV5ehhbiVl8TQvr09yL+dIjEVaGGsLzSPpU
         iMJfpxSa6VqRjWCgPU0KcvTgI8wP+TIqo7X0vF0m16m7IqmmaXb0ku9v3zduwOEUM0lQ
         8GNw==
X-Gm-Message-State: AOAM530lfmVqEsoEvT+quYqztNhfBLvlkuRl0N/ULD2Df5L7jSjdkSb9
        43HWNoOTLGQgok2E0v5ZkxGQQlE4w2myYtGrgUs=
X-Google-Smtp-Source: ABdhPJzNoSz8uY8UPgeA6q7FOXakXQ+iiBNWwUG+0sQjrda+2kn2J/WiiHYxLFnj8lC2PzmhToR6/lB1iKnoP7+eT3Y=
X-Received: by 2002:a2e:9047:: with SMTP id n7mr433249ljg.125.1599098578210;
 Wed, 02 Sep 2020 19:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200902173105.38293-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200902173105.38293-1-andriy.shevchenko@linux.intel.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 2 Sep 2020 23:02:46 -0300
Message-ID: <CAOMZO5CMBer5VBWz0ruUUtVM9V4p0bYaTnV_bJnrORzug2=0Aw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] swiotlb: Use %pa to print phys_addr_t variables
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>, x86@kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 2, 2020 at 2:31 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There is an extension to a %p to print phys_addr_t type of variables.
> Use it here.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: dropped bytes replacement (Fabio)

Reviewed-by: Fabio Estevam <festevam@gmail.com>
