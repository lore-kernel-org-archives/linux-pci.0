Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31409C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 23:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E492184C
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 23:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OxpD0mQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeLRXOt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:14:49 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35465 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeLRXOt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Dec 2018 18:14:49 -0500
Received: by mail-oi1-f195.google.com with SMTP id v6so142753oif.2;
        Tue, 18 Dec 2018 15:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LM+SCpKm1SU1QFp2bGgNH/8e9PzJQO0K0O14ThmeN3w=;
        b=OxpD0mQeuQeGBYU0leEKzPXqYmm4bbtVOTuO+KqCGT1rsd9uGsQXwQAY/VJdiRT46w
         jMa/7G3gHNKgzX+TLge4JHMpygzlsKC7RgAtUo8gcP2C5fM6h4lKNv8ezVbyJHeh1qOR
         zP//bDkR3/jxxGAD6wqgFJFI7CCJVC0CWfb+B7eBduNixQcyphOtZnDXXlSoWC9g8LoM
         G51s88dNk2Uv0rVizGY0hdoO4tE/PhTvw651rYL5PqBezW7fTylEi7anV1dqRbTR1ttu
         ajnNsxOjDWhMHGXm3o6iqmAWXM8SXrU6QNbOP/elQtYPxU3F2wT1wbeG1t1mmE0Mfu2x
         /qZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LM+SCpKm1SU1QFp2bGgNH/8e9PzJQO0K0O14ThmeN3w=;
        b=kfTcnJngHKDm/+c2Fl7s07wqsE3QHIxW2bh1AjB9E/BTr4WBvJ3w4Ukh/oy1GMo7x4
         bzFfRL/8HGZyy2N+fS43W3YCQ2rhAqAb6++hmaOzpynvJRtyxqjsGYq8DsCUE9OkTvgh
         52e/+ZNbXpIr2r5fePHxz1MyuM6/rkh/WtN7aNd2sFu36wRyle+Zyis2hPGP2wNg4h9/
         y168ai1mYZVRaFdPtQVhcFpxDxNv0Na3+1oPiW3zVQed7ghTYJsYC0hBZ/9FPrcLuGEg
         gV+rUsZogDkdBIQLUHpNmsIXhZT279nP+LwJlzjUxUkZdWXPdu+2ExGHdF/FzWkfRmqR
         /IVg==
X-Gm-Message-State: AA+aEWZR1nBKUNIZPygjKDBRd2JVuyAgprp1H3MtcvXC4S9mK7+56XHJ
        /vFI2gXYq1vSp7ObMacEMKqhTwPFqEeRYa7tNc8=
X-Google-Smtp-Source: AFSGD/UYqTj4MR4JR5pzJ+fkoG2pt0w0GjynKLFCNxcIFpA7U8r/WDYWTwbT1b8Rmvj11JB06oFrZ/iSCeCNJcYWpvY=
X-Received: by 2002:aca:58d7:: with SMTP id m206mr9368690oib.140.1545174887971;
 Tue, 18 Dec 2018 15:14:47 -0800 (PST)
MIME-Version: 1.0
References: <1545120286-129258-1-git-send-email-hanjie.lin@amlogic.com> <1545120286-129258-2-git-send-email-hanjie.lin@amlogic.com>
In-Reply-To: <1545120286-129258-2-git-send-email-hanjie.lin@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 19 Dec 2018 00:14:37 +0100
Message-ID: <CAFBinCD1x7jcJJx78yNx87MOmKQ2HuSBeRpDRQE0hyNCwm1JAg@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: PCI: meson: add DT bindings for
 Amlogic Meson PCIe controller
To:     Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yue Wang <yue.wang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob, Hi Hanjie,

(sorry for being late with my question)

On Tue, Dec 18, 2018 at 9:05 AM Hanjie Lin <hanjie.lin@amlogic.com> wrote:
[...]
> +- reg-names: Must be
> +       - "elbi"        External local bus interface registers
> +       - "cfg"         Meson specific registers
> +       - "phy"         Meson PCIE PHY registers
I have learned that there are two PHY register designs:
- AXG only has a PCIe PHY
- G12A has a PHY which supports PCIe and USB 3.0. The PCIe part of
this PHY design is compatible with AXG, but this design also supports
a USB 3.0 port (it's an exclusive choice: either PCIe *or* USB 3.0)

The PCIe controller itself is identical on both, AXG and G12A.
This patch adds support for the AXG PCIe controller and PHY within one
device-tree node.

For G12A I propose to add a separate "phys" property with a phandle to
the "combo" PCIe and USB3.0 PHY - this can be part of a separate patch
though.
I would like to know whether it's OK that for AXG the PCIe PHY is
described in the same device-tree node as the PCIe controller (in
other words: we're not using a "phys" property here)?


Kind Regards
Martin
