Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4D6C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 21:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29930218A2
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 21:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="daQMLvWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfBZVLV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:11:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41586 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbfBZVLR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Feb 2019 16:11:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id n2so15548304wrw.8
        for <linux-pci@vger.kernel.org>; Tue, 26 Feb 2019 13:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqn5xeXHz4o/Av3EPiyID6FO61P3niCXIqush6ZbzRg=;
        b=daQMLvWjgQfTvZQWjCi8VCLIYQnxrOTOf2ZmjT+6z9o8iDF3aPTAOIc/VzJpeRiFVC
         ZQf08kCHnvw4zTZFrWLxEAh4K7hIz/1IXDQZWPiGEI9w0hgW1p6kTn0/Q/NyMwzfF2oW
         eJVjbiVZTY+B98yNec3rb4n7NGq8BalqkFQlpGyX1WNME5cLMMsow3nIbr8GEWXGceUA
         XPQiXQWy5R9UYpmOvDsBBNLQ1aeHUybfZak4tmZN/yC6C7XWtPbQZzqkJIM/RMGJfxAS
         eRrD9zI2zwAh3SqU210pnzfRvJjzQPbwmRvlhdtUTK+uGx5DSp/pkkPeTlf0DQlR75oR
         2trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqn5xeXHz4o/Av3EPiyID6FO61P3niCXIqush6ZbzRg=;
        b=EVBxONSdE7keqphT6bJK0SHP7fDpMCAhCg6mPlI9x4pV6N5gJQ0HzzTbjrTzJGLJeZ
         Fs2zhXzFbEH1/M5mul7RNle3+aICDgbJfWjtLvHWFsETSKRYx38ualukanXb4PPwS4/X
         wfleRySVeF9K24DGFIpqBud403r2JxVNM6q+SypcTxZ6Hv3aN+q/AQ57Dw5ZGsbqoH9K
         aE/uFsypjvyaed6DaBqnT307/MkjhN4ghHT+w6mGvPxv1Rk7pXduy7kCtMvOESasTuba
         5nZdJZQ/izX0xcPwu1Tg84p8/DgMZoKfE5K+Linc7gpFjt//PN7BQ3/Qdt/bweX+AjfK
         UpTQ==
X-Gm-Message-State: AHQUAuaSgwyhq3d/0Kab9XsrcW+FrpLt1IoEWlJZ67GSVUyJ9Pfj/nm9
        3EhR+gCHNhl4hhhg8Milj9s7SazH/6w9bVKC7/x0
X-Google-Smtp-Source: AHgI3IZvuu9p3VLciqyaCFJPQRlVRNK8U7H585OCHKcpRHntMLGc+3l/+g59CTqGzXyruBlLmFUbvviMEA17ynwmz8w=
X-Received: by 2002:adf:e5cc:: with SMTP id a12mr19229338wrn.130.1551215475293;
 Tue, 26 Feb 2019 13:11:15 -0800 (PST)
MIME-Version: 1.0
References: <20190226194806.34fc23b5@xhacker.debian>
In-Reply-To: <20190226194806.34fc23b5@xhacker.debian>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 26 Feb 2019 15:11:03 -0600
Message-ID: <CAErSpo4uC6WMt-RNxn6_XG9Lcy+jA0X2bLF3cpVDWC9Sh6AbaA@mail.gmail.com>
Subject: Re: [PATCH 0/5] PCI: dwc: support remove
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 26, 2019 at 5:55 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> Currently, the PCI dwc host users don't support the remove, but nothing
> prevent us from supporting it. To achieve this goal, we need to ensure
> we can do necessary clean up work.
>
> Jisheng Zhang (5):
>   PCI: dwc: fix dw_pcie_free_msi() if msi_irq is invalid
>   PCI: dwc: free the page for MSI irq in dw_pcie_free_msi()
>   PCI: dwc: free msi in the error code path of dw_pcie_host_init()
>   PCI: dwc: use devm_pci_alloc_host_bridge() to simplify the code
>   PCI: dwc: save root bus for driver remove

If you post a v2 of this series, please:

Capitalize the first word of each subject, e.g., "PCI: dwc: Fix
dw_pcie_free_msi() if msi_irq is invalid"
s/irq/IRQ/
s/msi/MSI/
