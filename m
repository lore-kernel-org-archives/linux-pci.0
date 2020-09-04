Return-Path: <SRS0=2Jyt=CN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872ADC43461
	for <linux-pci@archiver.kernel.org>; Fri,  4 Sep 2020 19:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4244220684
	for <linux-pci@archiver.kernel.org>; Fri,  4 Sep 2020 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599246628;
	bh=dIWllhVPFVZN0hZPo+9KiCvcHa/Wi3vfqifSVwdjWUg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YONSiljpHcKN+1jcQEj+8vgHHXbYLzXUbTKJzm/Q7qSYEHIowtTPI2Ix2lFp2yQ9y
	 wS+vIBUI1P46HK9IQbYPDDA7uGj4Q01txvkRLW+VlkYvpt0DPU+SefZcmfOjFWx3xK
	 Iy0qa17a8E5krfwIYzI6/V8kwb/kCG0UtDFOfKAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgIDTK1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgIDTKZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Sep 2020 15:10:25 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A633206A5
        for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2020 19:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599246625;
        bh=dIWllhVPFVZN0hZPo+9KiCvcHa/Wi3vfqifSVwdjWUg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FJprIROwkNk5iCnmGTBuoRgg+tfcW/6M3F4YT72iq3sHnmjFHbt7/MTAxFtLjIHIk
         vgqRcmVmRywsMilm9GKM5gslzAshzgH+l7inXtsHdD2UU1pkWgkBnRQBP2ti8rYnFS
         46lEzHrTYNJvm6jNy7M+dr0Cu/3upjiGkhoNIIbw=
Received: by mail-ot1-f53.google.com with SMTP id m12so3871518otr.0
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2020 12:10:25 -0700 (PDT)
X-Gm-Message-State: AOAM531qxEvHW/IuYs5hdfr39YDcU2p8av7P6sjWYWl+Dui/tUDXWfzz
        mPEoTBpl2fj9v2ydMVxcDtXLFiFkn5eIJzDLng==
X-Google-Smtp-Source: ABdhPJzFANIN+WjBp2TV3P9GQVXx/JdiADo5E8VZ7HBs3g0WF0ZFtUe6F7lI/8/lg91zPOCBTfy0Zig/qP2CL1u84wU=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr6196355otp.107.1599246624935;
 Fri, 04 Sep 2020 12:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200904142710.8018-1-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200904142710.8018-1-lorenzo.pieralisi@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 4 Sep 2020 13:10:13 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+m7OXWwhvsdE+Yuaj60_M3BaLWD8f6fJB7wXQE7+V1Lg@mail.gmail.com>
Message-ID: <CAL_Jsq+m7OXWwhvsdE+Yuaj60_M3BaLWD8f6fJB7wXQE7+V1Lg@mail.gmail.com>
Subject: Re: [PATCH] PCI: xilinx-cpm: Remove leftover bridge initialization
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 4, 2020 at 8:27 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> Some fields in the host bridge structure are now initialized
> by default in the PCI/OF core functions therefore their
> initialization in the host controller driver is superfluous.
>
> Remove it.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
