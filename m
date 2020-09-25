Return-Path: <SRS0=DXvE=DC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABB7C4363D
	for <linux-pci@archiver.kernel.org>; Fri, 25 Sep 2020 15:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C3B521D7A
	for <linux-pci@archiver.kernel.org>; Fri, 25 Sep 2020 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601049017;
	bh=iBYGy+tbYNUpVQgkRGaij6TxzblcvQfe+1AExVs5/v8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=m7osR1GUa6guCgzyX/C5b+L2tP9WR7gsCA98ZIXHykjng/h6eEOg8hJpGmAj6X5+d
	 fCS6WFMPR4/9xp4bt8wHEmdZk5pmIgpLkRtHREG7qaDehbRlxFsh7mBBlFmClDwSap
	 HAQtBjzW1f35jQtI0B72vPMebhGOcYofdRlQCpFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgIYPuQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Sep 2020 11:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgIYPuQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 11:50:16 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1026235F9;
        Fri, 25 Sep 2020 15:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601049015;
        bh=iBYGy+tbYNUpVQgkRGaij6TxzblcvQfe+1AExVs5/v8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oOZXjDT/qPp5mqY7lbUO4oXvv98FICCthv1RDhtryOBmy8WnZ0OFPaUzUpRbnrJok
         qzH5O0wg/6LDICIUy0oEbHw5tedvkYnH+nqcBiqDESfnUyw0qEwKF3nCjtChxxztZk
         SqFGhP57wuQs6EBpWt6b8+whK/BSoJDoCM1Zoaoc=
Received: by mail-ot1-f45.google.com with SMTP id u25so2736007otq.6;
        Fri, 25 Sep 2020 08:50:15 -0700 (PDT)
X-Gm-Message-State: AOAM530P2cLSHtktVe/MpBF7+2jpEW2WvVRIITqIuhcvsfPPbDS520Po
        FvyctPUk63ZZggYZ/wHz8Pw0cqG2vkZ/wD1UDg==
X-Google-Smtp-Source: ABdhPJztH4K30cfydlKusTAuCuOWr8oeMK8mWouCzBxXrHq9Ea/e+sJo0VP5Wl+TnrFuVYB6BpqmVNtJtjwQ1CwZxj0=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr742522otp.129.1601049015126;
 Fri, 25 Sep 2020 08:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200925163435.680b8e08@xhacker.debian> <20200925163749.4a45b8fa@xhacker.debian>
In-Reply-To: <20200925163749.4a45b8fa@xhacker.debian>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 25 Sep 2020 09:50:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK-dkETRb1H01D8npiVapuDQO-goyZ1JJz9hjsGq71WuQ@mail.gmail.com>
Message-ID: <CAL_JsqK-dkETRb1H01D8npiVapuDQO-goyZ1JJz9hjsGq71WuQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI
 is disabled
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 25, 2020 at 2:39 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> If MSI is disabled, there's no need to program PCIE_MSI_INTR0_MASK
> and PCIE_MSI_INTR0_ENABLE registers.
>
> Fixes: 7c5925afbc58 ("PCI: dwc: Move MSI IRQs allocation to IRQ domainshierarchical API")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
