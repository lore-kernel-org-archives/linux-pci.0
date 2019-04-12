Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164E9C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 14:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F962186A
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 14:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555077644;
	bh=nijqsap55XUBbZCPEQ18QWXyKoM2eiWnVLRWc9vjpFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PLBUX2Uyg60wOqubE6VL6SKcN3dzfq5K4qAZ+BsbWFtjNXn+o4mQJPoT+ggfoyOkL
	 NN2cZiwMKMq6Y9rtABAibcUlSag13wIXAoLbE3QohVw8qkI6LKfmFbwdwr/VPgKzKA
	 GuNlI4ZNxB43S9p3xXsq0LPSbGBpQkrgc89mSCLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDLOAo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfDLOAo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 10:00:44 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3CBE206BA;
        Fri, 12 Apr 2019 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555077643;
        bh=nijqsap55XUBbZCPEQ18QWXyKoM2eiWnVLRWc9vjpFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UTpFg69Irfxx+z7ULeCgkbr6LWenQJGbARB0olr18CwrekCJQTkNbkgrM3/gVXS0O
         t08W0Tebf8ESHMEbYQx+PXtEKGxRpCaQ0haI4tzur+xvuG8lB3AeuxoPmaN7Q/XSPW
         4QLetd+Vax7ZNZUfJ6CNMFEmjYhJnbMYoA8pmZnQ=
Date:   Fri, 12 Apr 2019 09:00:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCHv5 4/6] PCI: mobiveil: Add PCIe Gen4 RC driver for NXP
 Layerscape SoCs
Message-ID: <20190412140041.GA141472@google.com>
References: <20190412095332.41370-1-Zhiqiang.Hou@nxp.com>
 <20190412095332.41370-5-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190412095332.41370-5-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 12, 2019 at 09:52:50AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This PCIe controller is based on the Mobiveil GPEX IP, which is
> compatible with the PCI Express™ Base Specification, Revision 4.0.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V5:
>  - Corrected the subject.
>  - Corrected 2 typos.
>  - Updated the Copyright and driver description.
>  - Changed to use BIT(x) to define verious functions of register's bits.
>  - Unified the capitalization of error info.
>  - Changed the IRQ handler name to ls_pcie_g4_isr().
>  - Change 'irq' to 'IRQ' in error info.
>  - Trimmed some functions without functionality change.
> 
>  drivers/pci/controller/mobiveil/Kconfig       |  10 +
>  drivers/pci/controller/mobiveil/Makefile      |   1 +

>  .../controller/mobiveil/pci-layerscape-gen4.c | 256 ++++++++++++++++++

I would probably name this "pcie-layerscape-gen4.c" ("pcie" instead of
"pci"), since that's more typical and this really is PCIe-specific.

> +#define PCIE_PF_DBG			0x7fc
> +#define PF_DBG_LTSSM_MASK		0x3f
> +#define PF_DBG_WE			BIT(31)
> +#define PF_DBG_PABR			BIT(27)
> +
> +#define LS_PCIE_G4_LTSSM_L0		0x2d /* L0 state */

Maybe rename this and move it to make it obvious that it's related to
PF_DBG_LTSSM_MASK?

> +		dev_err(dev, "Poll PABRST&PABACT timeout.\n");

No need for punctuation at end of messages.
