Return-Path: <SRS0=gDpg=OJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB971C04EB9
	for <linux-pci@archiver.kernel.org>; Fri, 30 Nov 2018 00:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDB020868
	for <linux-pci@archiver.kernel.org>; Fri, 30 Nov 2018 00:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVYGtaRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDB020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbeK3LOk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:14:40 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45829 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3LOk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Nov 2018 06:14:40 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so3387844edb.12
        for <linux-pci@vger.kernel.org>; Thu, 29 Nov 2018 16:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfk0aDQvIwhgeDS+Vj6aBE+N4EJBjIo9SmyfIBxXHxo=;
        b=iVYGtaRhxra9IOBBi6RPOA5BYqPqwQsEqVVgWLL4gbU8NwOpGLzRP4EP/Flv3pHbRB
         q1PrdfKnGRakz6BcKorFqU+nFQDEQofjdsHYDgTPruD4oql4y+vilmDfWOUF1nsCMNKZ
         QnjkP43Ltk6oHK0c1VnaL5ych342YFN9Q7DTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfk0aDQvIwhgeDS+Vj6aBE+N4EJBjIo9SmyfIBxXHxo=;
        b=eutyfy9UMXRtk+lX0eDkU0z2s6KcM7OCQiXF4HdFeQDoGoZH0IEo4kiLTw9c8ubI4N
         VMoHHPQA7HryOXYGOEQwkBPxaMxCJRKkkySohLahzXNIqqS6gPG/MEurTnwu1N7uTIWb
         PBU3yifevuj4UtNsaR6j/ZPCzY0W+9Qxrp6R1+JynZ2mNnR1TfvZYA0VY4rlj79mEyvZ
         E2loC4zHANR+omhS6LemgoLHPjkrkl5cPPhR1BMyzv+IuF2iYt5N0LeytaOwI2oIGfnP
         3o1TQ+wXYSUJw8memqOOAU/+vJAP7GpNluVZ+OjQOjmE0DVI/KcE6QwKPabzR6b5dhgL
         FmlQ==
X-Gm-Message-State: AA+aEWYIBEGJzkQy10xL4kJCMAWoWPXYdHG5Cne9W7o/60LNN4c4yxDr
        /CTM1xjkpfOkl/ttvc9OjH8Rc6hYPi+CNd5laDUVVA==
X-Google-Smtp-Source: AFSGD/U17+NqP17Y120cbtc6KVH27hCs1NpuT8yx4pWxv0lKxS6SHBiPLzFb0zxhWbaCuq2dKgSO+pC/chuXs2xd3x8=
X-Received: by 2002:a05:6402:1299:: with SMTP id w25mr3156037edv.237.1543536439879;
 Thu, 29 Nov 2018 16:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20181129182354.3273-1-lorenzo.pieralisi@arm.com>
In-Reply-To: <20181129182354.3273-1-lorenzo.pieralisi@arm.com>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Fri, 30 Nov 2018 08:06:59 +0800
Message-ID: <CAAQ0ZWQhVwjHAkd-tYe2K+YDZ9-Srzn5tyPA2nQxYf2ZUEY6aQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove Jianguo Sun from Hisilicon STB DWC entry
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 30, 2018 at 2:24 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> Jianguo Sun's email address reported in MAINTAINERS is not active any
> longer, remove it from the DWC Hisilicon STB entry.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
