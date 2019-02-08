Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61859C169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9702073D
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="GrBWxcGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfBHM33 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:29:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39054 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfBHM33 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 07:29:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id f16so3197050wmh.4
        for <linux-pci@vger.kernel.org>; Fri, 08 Feb 2019 04:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwlcFdNjaArFQK8VuUiv2qmrcfV52Mv3VLSBRqH+Mus=;
        b=GrBWxcGh8ewr9dq1wYM7qRBn63epekM+GjcGLDYwXEbTlOjwPFJazeRfwVyLG/sopM
         +eZQ7SWw3mK2z6KPrgHLQ6RWDbrM+GEfNCGwdXGDd79pjp5eyz172VUGcuDKqkUhRcuG
         UuTtXCK+XP1fW+VlrUY8GD3kAQf3TWvzk5eJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwlcFdNjaArFQK8VuUiv2qmrcfV52Mv3VLSBRqH+Mus=;
        b=K/LslHee8n3yqsWspxAAHCAgX4EW3G3gu0cvZyaeiOL7Ov6WtZ9iRVch4H3xU0Jv6B
         v1XsKgBc9OvHg+jL2Yy2eg8AYUxUvoxpQ+O0tJ0uDR+rDXN7MkzRagEZTV+9Iv2dhSZI
         FyeKy2h1zP2w4dfL/yb14AcjDa9CWT2Gi+uIhciGfcQtrF/PPAvQJEQtu6L/9srdxdmP
         +CxxTFapLDkGjYzyDSbVEs7OJ3l/T8lNt9MDRAxTzXSwck/YxoJhSpPdAEYqjDFwkuec
         B3wkmOdgmPGzsMSA44ghh+DsUwyxt81DpMi9jbgBb1F311K6HC3eGUQPa+KvQHQsCz2N
         JJ+Q==
X-Gm-Message-State: AHQUAuavgyecvPmSkYa866UJKC1K5GRTlFKS/rptm2qdTzgTVDFgDnZ2
        s3lNiHgDkwOV1lZyWPMraSu4kzbD5xKELpsp6KiTNg==
X-Google-Smtp-Source: AHgI3IYlp7yU0kE+k2KeB3HVZRh00/3Hn72YIVu/3TLBHTsU2a3BbCYbbX3pl+gieVGIbg2sJ54KnXoIANXHeUlI0Mc=
X-Received: by 2002:a7b:c5d1:: with SMTP id n17mr11517169wmk.152.1549628966680;
 Fri, 08 Feb 2019 04:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-16-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-16-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Fri, 8 Feb 2019 18:02:05 +0530
Message-ID: <CAFZiPx1KOCODT90oXd7+p3XwV8ujWae7WZtMbwtv_KDXB7nOKw@mail.gmail.com>
Subject: Re: [PATCHv3 15/27] dt-bindings: pci: mobiveil: change gpio_slave and
 apb_csr to optional
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
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

On Tue, Jan 29, 2019 at 1:40 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Change the "gpio_slave" and "apb_csr" to optional, the "gpio_slave"
> is not used in current code, and "apb_csr" is not used by some
> platforms.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Acked-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  Documentation/devicetree/bindings/pci/mobiveil-pcie.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> index a618d4787dd7..64156993e052 100644
> --- a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> @@ -10,8 +10,10 @@ Required properties:
>         interrupt source. The value must be 1.
>  - compatible: Should contain "mbvl,gpex40-pcie"
>  - reg: Should contain PCIe registers location and length
> +       Mandatory:
>         "config_axi_slave": PCIe controller registers
>         "csr_axi_slave"   : Bridge config registers
> +       Optional:
>         "gpio_slave"      : GPIO registers to control slot power
>         "apb_csr"         : MSI registers
>
> --
> 2.17.1
>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
