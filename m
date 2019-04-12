Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FF6C10F14
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 14:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BC520850
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 14:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555078397;
	bh=//6U3zOB83zcmV6AMleUa4433Q/7rVNZydRus7ZPOOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LcA2jez1NTbWJBDw0fPIsWX/k8BjinhqmyEVI+CoB/V7MeyhULfmW5gy6EswtTBpZ
	 MifJFjK6VWC/2sry4sKNDt8r4cGAv24jyWlZ/2LRv9pilD8gUfYxTuuvtBgZPzE/w1
	 L1fa+SA5GMZd4e3TAmcTh0VJIcH8AlAQo+zqtakE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfDLONK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbfDLONK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 10:13:10 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99B2D20850;
        Fri, 12 Apr 2019 14:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555078389;
        bh=//6U3zOB83zcmV6AMleUa4433Q/7rVNZydRus7ZPOOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y5f0PlNreSV5oIrBA6/FvoPnRWXC1mHuxEH4t9SbTKe25uGlVZE2vpsp2B8nVASgt
         dKJgWleFjRriN5adSq4ergev3FHx2FkB3DOe8tjWgHRdFfSI2IKgZFtOAeORz4ijZ/
         Fr7DnVXZMDoCrPZEtBxwUhwgviYjnadNIk9MJ35Q=
Date:   Fri, 12 Apr 2019 09:13:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Make pci_aer_init() when !CONFIG_PCIEAER void too
Message-ID: <20190412141308.GC141472@google.com>
References: <20190412143458.2120118b@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412143458.2120118b@xhacker.debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 12, 2019 at 06:43:06AM +0000, Jisheng Zhang wrote:
> Commit 60ed982a4e78 ("PCI/AER: Move internal declarations to
> drivers/pci/pci.h") makes pci_aer_init() void, but the version when
> !CONFIG_PCIEAER isn't modified accordingly, fix it.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Added a stable tag and applied to pci/aer for v5.2, thanks!

> ---
>  drivers/pci/pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index d994839a3e24..9cb99380c61e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -597,7 +597,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev);
>  void pci_aer_clear_device_status(struct pci_dev *dev);
>  #else
>  static inline void pci_no_aer(void) { }
> -static inline int pci_aer_init(struct pci_dev *d) { return -ENODEV; }
> +static inline void pci_aer_init(struct pci_dev *d) { }
>  static inline void pci_aer_exit(struct pci_dev *d) { }
>  static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline void pci_aer_clear_device_status(struct pci_dev *dev) { }
> -- 
> 2.20.1
> 
