Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02204C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 14:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC53218A3
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 14:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfDLOmH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:42:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42175 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfDLOmG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 10:42:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so11451710qtc.9;
        Fri, 12 Apr 2019 07:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+2EUgIX8bJUiZT0Ly48kfo4K5EATvNzoEnsiFCe8wng=;
        b=aJxs6fCtav3XaN9hDa6WLmQLJqdqY1NtM6zxgIG9i8357snWqRfBVrzUVCsJ9MJzlt
         XysrH5SKUKrxPD7fpMne8cWNfZnf1xs63k7wYTjw6vhIwe1RLTaWHq3f8OgbXagJoCGN
         pw+xBUESFcBhpvhqDhVtskWrYx2lCumcxHpIOiL5/qKfApcM+Ur+2bO4zaIPRqk4pQfm
         QomFl9FUtnjOEE/Jn8OMmE45VPGzXk47rCNO5WLSz3GJ3N9Zb4+Y38lIi+zNp2LEhuG5
         VnD19PfTI7dlBiOOedb2gYMt0i0aGTje6IDPPOEE3YQX8+RAkOk4I8qSSaU8mFBJvaND
         XYFg==
X-Gm-Message-State: APjAAAUv0o8dEv5fNWwH1q/Czn1HyaE9VobkscTEJYaI8oBN/42zPtGo
        RRN8oUg9oC2d/9dAes5WCgledoljsVrWgzmQUr8=
X-Google-Smtp-Source: APXvYqxtL1T9oxhqs7xy2mCyzK5Jhakc1ma5/OrsB6yYqWDBRDF0GATLsvfLjlk+W5ZPkwlckWbDCT/b5Vtf7Mk4DlY=
X-Received: by 2002:a0c:9ac1:: with SMTP id k1mr48250047qvf.36.1555080125561;
 Fri, 12 Apr 2019 07:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190412095332.41370-1-Zhiqiang.Hou@nxp.com> <20190412095332.41370-5-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190412095332.41370-5-Zhiqiang.Hou@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Apr 2019 16:41:49 +0200
Message-ID: <CAK8P3a1rkBP4Hzy+=j8Ds_MoZU0K1_kh5YA0-ogOAG9TZ5fDNQ@mail.gmail.com>
Subject: Re: [PATCHv5 4/6] PCI: mobiveil: Add PCIe Gen4 RC driver for NXP
 Layerscape SoCs
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +       pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +       if (!pcie)
> +               return -ENOMEM;
> +
> +       mv_pci = devm_kzalloc(dev, sizeof(*mv_pci), GFP_KERNEL);
> +       if (!mv_pci)
> +               return -ENOMEM;
> +

Just fold the two structures into one, and use pci_alloc_host_bridge()
to allocate everything.

     Arnd
