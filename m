Return-Path: <SRS0=y4Wk=RD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6D8C43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 20:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A90F218CD
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 20:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZyJ92Vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfB1Uj1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:39:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39907 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730791AbfB1Uj1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2019 15:39:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id z84so10234099wmg.4
        for <linux-pci@vger.kernel.org>; Thu, 28 Feb 2019 12:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLSydkoLhSobkjMs5N5wtJQOn7A2n7uZ5qgPj6fDVkk=;
        b=eZyJ92VkMeH6O0lNo/WUwM80GatEJuwap13rNnver6kZf5m+6AtueLoyX9QP17MOzp
         3PoUuRE5CBNui2zmDndIPEWlXHUuY7rq4+KQv5jcZ9ZzfIFDQQ+4UZALJW8fE1E4jpos
         mEthJJ+XVJWlObMGMhfcl0TliyNqxp1b7WonIPnwVcN55Egi7+YWmnPUb3lgb4VbC5IV
         u8UllufSo7ZzhctY5ahKwS/ye8o8R3/U/RKUZZDWcf9XVV8M0Lut4u/b0Nu6K+qNSgW9
         n/npO5QrHsg8KvSQWGAz7cYm3V1FnH2QxpDu9ek3gwYaaz4346G12RW21VPh8qsWnlCt
         uTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLSydkoLhSobkjMs5N5wtJQOn7A2n7uZ5qgPj6fDVkk=;
        b=WkL5uEfh++F6E0GgacCp52tTNRPZmnNGp9e7UB4hJI7q8gXlpqwLSN3e50JQDghRF8
         AiARy/a+yGm/xhGJxeCNiM2Kjk8UKMsOf+cTc2hu/wEXw9ZjeAgLhlVI8ofxQ9AFGZZG
         +qi7I7iM42NdomrL8NkY548U8w/OmFW/Wd8qUq9AQnvOKeom/X9HGp5c5zpX/JkkwCDk
         yLQ/4tynJFmJZNyUvFTYhB4qxmeXDY3omCXdFuyad/uLJJ3NH8ORf7wdbtepvG19NIq4
         62W5s1q2krdkcwIhXJFIHoCcT9xP+AlCypwNOdhcSDAaE+zL/VtdCCgGT6QghKrZlpAZ
         8wjg==
X-Gm-Message-State: APjAAAUvC2nCy1EvS5TX99/8b7UPOYn/+7JnC+GQMs7Ih49eyQ6sy//m
        URITaHnQ/R1mDPWEJR09SqJpjZtj6+OuvVrwK0+m
X-Google-Smtp-Source: AHgI3IaJ1/aPPgLrIUJxN4ViSnquoCRECJNKDzPqM4iATJvytLXTbqrz4T9wzcA2v1WqvRucDx705OKMkcEEnoMbVRE=
X-Received: by 2002:a7b:c214:: with SMTP id x20mr943539wmi.62.1551386364766;
 Thu, 28 Feb 2019 12:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20190226070125.22318-1-bjorn.andersson@linaro.org>
In-Reply-To: <20190226070125.22318-1-bjorn.andersson@linaro.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 28 Feb 2019 14:39:13 -0600
Message-ID: <CAErSpo6Tp2_bwjM5bmDG8g8KBiK_vMq0=qg86KNk+5q-ziGfSQ@mail.gmail.com>
Subject: Re: [PATCH] pcie: qcom: Add support for sdm845 PCIe controller
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 26, 2019 at 1:00 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The SDM845 has one Gen2 and one Gen3 controller, add support for these.
>
> Due to lack of hardware only the Gen2 controller has been verified.

Hi Bjorn,

I like your name :)

If you post a v2 for any reason, please update the subject like to:

  PCI: qcom: Add support for sdm845 PCIe controller

That way it matches the existing conventions and "git log --oneline
drivers/pci/controller/dwc/pcie-qcom.c" looks nice.  If there's no
need for a v2, Lorenzo will likely fix that up for you.

Bjorn
