Return-Path: <SRS0=Fzm5=55=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F74C2BB55
	for <linux-pci@archiver.kernel.org>; Mon, 13 Apr 2020 02:25:52 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC8320705
	for <linux-pci@archiver.kernel.org>; Mon, 13 Apr 2020 02:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="w0uIf91F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC8320705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgDMCZv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 12 Apr 2020 22:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbgDMCZu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Apr 2020 22:25:50 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B967C0A3BE0
        for <linux-pci@vger.kernel.org>; Sun, 12 Apr 2020 19:25:50 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id k9so3776738qvw.7
        for <linux-pci@vger.kernel.org>; Sun, 12 Apr 2020 19:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLj+x96byFyffDU0A8lFpsAuuOuYHgw1Wo0DJ3Rmb4U=;
        b=w0uIf91FCNWhHbh3UiiEIqU5GLIN4KjeF1LtobS4ivZf0c5u0rTsY6ZPgyZ+zzilev
         ImMd68NwGmDUEWq4All40aBR4/xJJGA9PlKMNqUVOC+1Gfzh25zTSfBBFFRl2F3dhOp1
         zgbK9EXVMGFYKuVDfnlm2HJHg2TDaeW2jFccQE3F9YISm9hIo77w4PSvW8tNgkETuP1z
         J6RGGE8ibnlJErxMtLDQCI+kif9GUh67xDIVeO3q6ZVUXKg51Mg2IXQvxBY0MQSSKV3y
         Ct3p8yqbBHt6Mj3qpzqgPC0EaYAZjyB0Goz14QaueOnocm6KsQLj0rR1EXut8geDBV6M
         OJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLj+x96byFyffDU0A8lFpsAuuOuYHgw1Wo0DJ3Rmb4U=;
        b=jgDl5wfNio0y0X3L6ytUVUyKuMlhT8m3SE2srwj/t2FqMfTAnx0cGluBROjwFSt2q1
         SnCvFjW+EusMzIutCsrl7YQAH77l4ZhP4SJCz+Buh908uDR94MNIS5qi8R9kNrd17BnX
         MvDMJbbf0qIIthDlfQRFFM2xI+AoheaRj4BMSdSDHb7ADE2FDUS/GSOfKklZ1k0reYxA
         NUAevtxOShlutF1QSW6DBYpKLa3TCSAQAar9NO30DBeQbJKbzJxZQZmA+pdQ/pw92Zfy
         v6SoUErRjKsL35FrUiLhqLjg0x/40169pnVPKZBA2sSORV+ICc0fr+IGKsjU61yznGrK
         5r7g==
X-Gm-Message-State: AGi0PubKbL9I9EKEtZD91ExnUVaxN2CnIusxf1+g2VAbyIX87e0KtMQC
        trlVjYm4vbFDE4FM+rme7q0vc3w78sRAoPOa1+EQW2Uw9fg=
X-Google-Smtp-Source: APiQypJzdEeNNOJxxgr6xQPpqVjrJhaSOfNK2J8Jm5/TVivdr6+qIY/g1gw4IAS1B7nE4RWo2VoSjNfXilf/zd22O/4=
X-Received: by 2002:a05:6214:1781:: with SMTP id ct1mr15551512qvb.87.1586744749755;
 Sun, 12 Apr 2020 19:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200409191736.6233-1-jonathan.derrick@intel.com>
 <20200409191736.6233-2-jonathan.derrick@intel.com> <09c98569-ed22-8886-3372-f5752334f8af@linux.intel.com>
In-Reply-To: <09c98569-ed22-8886-3372-f5752334f8af@linux.intel.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 13 Apr 2020 10:25:38 +0800
Message-ID: <CAD8Lp45dJ3-t6qqctiP1a=c44PEWZ-L04yv0r0=1Nrvwfouz1w@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: use DMA domain for real DMA devices and subdevices
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 10, 2020 at 9:22 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
> This is caused by the fragile private domain implementation. We are in
> process of removing it by enhancing the iommu subsystem with per-group
> default domain.
>
> https://www.spinics.net/lists/iommu/msg42976.html
>
> So ultimately VMD subdevices should have their own per-device iommu data
> and support per-device dma ops.

Interesting. There's also this patchset you posted:
[PATCH 00/19] [PULL REQUEST] iommu/vt-d: patches for v5.7
https://lists.linuxfoundation.org/pipermail/iommu/2020-April/042967.html
(to be pushed out to 5.8)

In there you have:
> iommu/vt-d: Don't force 32bit devices to uses DMA domain
which seems to clash with the approach being explored in this thread.

And:
> iommu/vt-d: Apply per-device dma_ops
This effectively solves the trip point that caused me to open these
discussions, where intel_map_page() -> iommu_need_mapping() would
incorrectly determine that a intel-iommu DMA mapping was needed for a
PCI subdevice running in identity mode. After this patch, a PCI
subdevice in identity mode uses the default system dma_ops and
completely avoids intel-iommu.

So that solves the issues I was looking at. Jon, you might want to
check if the problems you see are likewise solved for you by these
patches.

I didn't try Joerg's iommu group rework yet as it conflicts with those
patches above.

Daniel
