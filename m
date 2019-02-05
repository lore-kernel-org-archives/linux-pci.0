Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE09C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 06:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A7E2176F
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 06:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="q0302VE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfBEGFw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:05:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39571 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfBEGFw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Feb 2019 01:05:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so2281817wmi.4
        for <linux-pci@vger.kernel.org>; Mon, 04 Feb 2019 22:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcZjY5XDE/E9FNQRkXQrr6M7zvi/tvQDKDvX/q8jeBg=;
        b=q0302VE6ZZ4eNwzx+A/WjcR8zgl6JfM1E9Cb7sWFs3EnBG8DlBam36U/zaUIomk+Rn
         PB/UJi6qNDOJeNoxyP5YBBm6F/SKwfXjCV6humG+s32dhAo5O4Sl7rjWXrfNAFmkdcZS
         ah15QIs+ac7BXFU+SI+Ree7g0rLUefx4a1/00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcZjY5XDE/E9FNQRkXQrr6M7zvi/tvQDKDvX/q8jeBg=;
        b=U2du9e1ZQumk93ZCLvnu0kTEH6O07b/h6g6Vvf16wDp4PT51Y4opAy3Ko6kvl0pplb
         9iA1V99ZTTwDL2QxKAp7EzjEyFBYBRvu2smDgz3gkzFMoWVRN15WByBlQ3CqBnwvt2aS
         1kIPo4LanI36tjCJJ3BrSGCU6S9CqRc33APzadGVcz1lJ4AIbLWBwxZBOo8wbsc2X6xi
         gWGERT3B7PrAX12K24eCc+ryVUV2NA82iweQ6WaGtLMusoyTuTSsnM724hpdZUAnXwwm
         jOQqsn7qA/RS0NztJNS8VAhbu8EJ4JN/PqTKLlnRAbcrst84Xrwryq7hDGAWw4X/Ie+6
         SGHg==
X-Gm-Message-State: AHQUAuZ9s9zUk0hW4F2rb2WVWWJ3EUpo3II/U+Q34uMGjpNuxUAbMecF
        ldb5pRdEEYa+BIPmTtU8hSbVgpjH0+vmlLoiw8SAYg==
X-Google-Smtp-Source: AHgI3IZJKwW71eEFV/3N1NOzT6DuLNVD97wOcuHi4aYiIwiKY7zBlO5L43hFAXGP2PhSDNVMebdU2WxBXYVABu5rJ6Y=
X-Received: by 2002:a1c:9e4a:: with SMTP id h71mr2241827wme.82.1549346750647;
 Mon, 04 Feb 2019 22:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-9-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-9-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Tue, 5 Feb 2019 11:38:24 +0530
Message-ID: <CAFZiPx0jgFROcecsa6Q3+HjDY-WL0Msp9DvJTRQp9fP79BGmnQ@mail.gmail.com>
Subject: Re: [PATCHv3 08/27] PCI: mobiveil: use the 1st inbound window for MEM
 inbound transactions
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

Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

On Tue, Jan 29, 2019 at 1:39 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> The inbound windows have different register set with outbound windows.
> This patch change the MEM inbound window to the first one.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index df71c11b4810..e88afc792a5c 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -616,7 +616,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>                            CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
>
>         /* memory inbound translation window */
> -       program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
> +       program_ib_windows(pcie, WIN_NUM_0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
>
>         /* Get the I/O and memory ranges from DT */
>         resource_list_for_each_entry(win, &pcie->resources) {
> --
> 2.17.1
>
