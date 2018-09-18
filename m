Return-Path: <SRS0=7uyK=MA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0E3ECE564
	for <linux-pci@archiver.kernel.org>; Tue, 18 Sep 2018 19:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93BD21508
	for <linux-pci@archiver.kernel.org>; Tue, 18 Sep 2018 19:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpZAT5OL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93BD21508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeISAjv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:39:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728721AbeISAjv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Sep 2018 20:39:51 -0400
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com [209.85.216.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0199D2150C;
        Tue, 18 Sep 2018 19:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537297553;
        bh=K9RStsRTczG6OD4E6X240NOaZGSE+ycV/6OIO2Nj59I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GpZAT5OLACc71O243hIDPgVBqiXDMIV/kKb4KtM4eox1lfnYQTRtRalJZdnk3+fuL
         I9EVpEyAPXHAGmAw/XGmS3g3iXKejm6XGYa95LFEFjqPxCkQSfs5u60BTfioZIjVXK
         bZiTLhJ8qzjVvLhKv4Ilz6ONYwl9tVOx8Ao5olSY=
Received: by mail-qt0-f170.google.com with SMTP id t5-v6so2788245qtn.3;
        Tue, 18 Sep 2018 12:05:52 -0700 (PDT)
X-Gm-Message-State: APzg51BaJebAvpyAMtkP5qywJGQgEyg8pd4Ao2vjYxVnSetM3YeOzb9d
        IkPpJLf9gZiFQpV06Ss+vG4pHVUsv7pmel3rog==
X-Google-Smtp-Source: ANB0VdZR4EAwsSGIcEM5q8dDBVNg/m5yfRZq4b86sNWGN727cefetRPuzooTUDtQVqbl96jErF8hKUUVAHyp2eZDDfI=
X-Received: by 2002:ad4:414b:: with SMTP id z11-v6mr22641300qvp.77.1537297552184;
 Tue, 18 Sep 2018 12:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180829183440.13601-1-robh@kernel.org> <20180913145130.GA5756@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180913145130.GA5756@e107981-ln.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Sep 2018 12:05:40 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKoOJigMkiWqoG77+nstr-6=qiAeTePZkSThcfbVAtEQQ@mail.gmail.com>
Message-ID:
 <CAL_JsqKoOJigMkiWqoG77+nstr-6=qiAeTePZkSThcfbVAtEQQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: remove unnecessary check of device_type == pci
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Douglas <adouglas@cadence.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180918190540.fCZLXO-OPmiF5kYThs6WmJSjrS3bYBnvvB_IckDKTOo@z>

On Thu, Sep 13, 2018 at 7:51 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Aug 29, 2018 at 01:34:40PM -0500, Rob Herring wrote:
> > PCI host drivers have already matched on compatible strings, so checking
> > device_type is redundant. Also, device_type is considered deprecated for
> > FDT though we've still been requiring it for PCI hosts as it is useful
> > for finding PCI buses.
>
> Hi Rob,
>
> I have no problem with the patch per-se, I can't parse though the second
> paragraph, in particular what you mean by "useful for finding PCI
> buses".

Device_type is the only generic way we can identify PCI buses which is
useful for dtc for example to do PCI binding checks. Maybe we can use
the node name which is what I'm doing for cpu nodes, but we've been
less consistent about that for PCI.

>
> What about the corresponding dts files ? I suspect we had better leave
> them alone lest we can trigger regressions with new dts and older
> kernels.

Yes. it will take some time before we can remove from dts files. Or
maybe only new ones change.

Rob
