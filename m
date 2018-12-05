Return-Path: <SRS0=Hio3=OO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F77C04EB9
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 22:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A369820989
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 22:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544049669;
	bh=QGid9c8fcmYrIrtsqICzM5hBjYULD6bUpSZfRiAxfbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hwUnCrFwZIhmUWGbZUON0x+Gpe0xABMY3KzriDTPndeEJWJ/4x/8vnZmi6lILx8rF
	 GLVspctNSOxl/dYy8k4FWXLjF+1jbSftiNVI0mb5at6yRoiw4Xh1GTRBZzp4F1N70O
	 dJ5Fqgj1l3cDUfoPP7scFmKGi1I3pgTo4ZygjrAE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A369820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeLEWlE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:41:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbeLEWlD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Dec 2018 17:41:03 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A41F320989;
        Wed,  5 Dec 2018 22:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544049662;
        bh=QGid9c8fcmYrIrtsqICzM5hBjYULD6bUpSZfRiAxfbw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Km9S9fCI68QsJOnhn+KUzVDICYMEWArrMxjLPw5f/kmjvSrE5/ti6DikCjDlG7kUp
         A9VWjCZpxN2rDePF2yUBlR4pF49mG/5I7ILMO7q/8HnIeWXABzjUFDhQqKQFDFfymh
         mEkW6kQuBWM+c4jw7sRBAgfToqupfQnpAFdWWaPE=
Received: by mail-qt1-f179.google.com with SMTP id n21so24245503qtl.6;
        Wed, 05 Dec 2018 14:41:02 -0800 (PST)
X-Gm-Message-State: AA+aEWbKXIOKL2H9lABM1LKEc5Ym3LdVkVXyxDZSeb8lJ3RcxMF7PQc6
        4sLJsY7cmahC3Wn8NwTBwTKtkvkSZawmmeMQRg==
X-Google-Smtp-Source: AFSGD/WHSW83dpwigr+NuV+o6CHNMLQLAyGqoHjJfnFqmAlj+oFBfOsqluDu9Oz8k6sLa1sx3CPSydHsOar5BIQYM8E=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr26328965qvl.77.1544049661848;
 Wed, 05 Dec 2018 14:41:01 -0800 (PST)
MIME-Version: 1.0
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com> <20181120092615.11680-23-Zhiqiang.Hou@nxp.com>
 <20181205223843.GA2125@bogus>
In-Reply-To: <20181205223843.GA2125@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Dec 2018 16:40:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLmV65rt46FiMy1Tvox+5LQa=vkFxQwzQUx1toBq-JzfA@mail.gmail.com>
Message-ID: <CAL_JsqLmV65rt46FiMy1Tvox+5LQa=vkFxQwzQUx1toBq-JzfA@mail.gmail.com>
Subject: Re: [PATCHv2 22/25] dt-bindings: pci: Add NXP Layerscape SoCs PCIe
 Gen4 controller
To:     "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Cc:     linux-pci@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Shawn Guo <shawnguo@kernel.org>,
        Yang-Leo Li <leoyang.li@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Minghuan Lian <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 5, 2018 at 4:38 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Nov 20, 2018 at 09:27:51AM +0000, Z.q. Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > Add PCIe Gen4 controller DT bindings of NXP Layerscape SoCs.
> >
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > ---
> > V2:
> >  - Change to use the layerscape-pci.txt for PCIe Gen4 controller
> >    dt-bindings
>
> Sorry someone suggested this, but it seems there's no point in having
> these in the same file. New IP block, do a new file.
>
> >
> >  .../bindings/pci/layerscape-pci.txt           | 57 +++++++++++++++++++
> >  MAINTAINERS                                   |  8 +++
> >  2 files changed, 65 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > index 66df1e81e0b8..3ef8836b6e97 100644
> > --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > @@ -1,4 +1,6 @@
> > +====================================
> >  Freescale Layerscape PCIe controller
> > +====================================
> >
> >  This PCIe host controller is based on the Synopsys DesignWare PCIe IP
> >  and thus inherits all the common properties defined in designware-pcie.txt.
> > @@ -58,3 +60,58 @@ Example:
> >                               <0000 0 0 3 &gic GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> >                               <0000 0 0 4 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
> >       };
> > +
> > +===================================
> > +NXP Layerscape PCIe Gen4 controller
> > +===================================
> > +
> > +This PCIe controller is based on the Mobiveil PCIe IP and thus inherits all
> > +the common properties defined in mobiveil-pcie.txt.
> > +
> > +Required properties:
> > +- compatible: should contain the platform identifier such as:
> > +  "fsl,lx2160a-pcie"
> > +- reg: base addresses and lengths of the PCIe controller register blocks.
> > +  "config_axi_slave": PCIe controller registers
> > +  "csr_axi_slave": Bridge config registers
>
> Wouldn't 'config' and 'csr' be sufficient? And these should be listed
> under reg-names.

NM on the names. I see these are inherited.

Rob
