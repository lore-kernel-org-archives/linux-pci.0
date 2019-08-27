Return-Path: <SRS0=srx4=WX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6865FC3A5A3
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 23:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA71214DA
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 23:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566948620;
	bh=LsV8QUEhHQEko3PDxpj8+W5exFapUg7lwvX/nFzLuWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1LMH9c3v/3iXeIBUShk+WQVQ8GyDkSr4sO3Nbvbj4jMhFzHF6RpU9Xj2iOI2Het68
	 LdCCYw4dzGKdDd4zYayL19ezUJJQlYDTslyWGVK+T7/9q8Vskb4xSACetx2JcWChSp
	 6GdFfkQHh8EMHA/B9uq2E6xTIdo0ewh32h7Sz8ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfH0XaT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfH0XaT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 19:30:19 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3FB520856;
        Tue, 27 Aug 2019 23:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566948618;
        bh=LsV8QUEhHQEko3PDxpj8+W5exFapUg7lwvX/nFzLuWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mz1S/p6189siRsHcNVccrCwXLN+r4td8xRvM1S3oOZX5RXp2Vk1+uRGwGRUEmSdnV
         ovGZ7ekgtlPB0Czr4CqYgTQwJ+Mmwcz3pDiFp66Faf+HVNNlojZVTncs42q1PtcYkf
         qUJvnpTX1i+Zg3l411MsGV1+Z6T/a65gaBk61gow=
Date:   Tue, 27 Aug 2019 18:30:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] PCI: Move static keyword to the front of declarations in
 pci-bridge-emul.c
Message-ID: <20190827233017.GK9987@google.com>
References: <20190826151436.4672-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826151436.4672-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thomas]

On Mon, Aug 26, 2019 at 05:14:36PM +0200, Krzysztof Wilczynski wrote:
> Move the static keyword to the front of declarations of
> pci_regs_behavior and pcie_cap_regs_behavior, and resolve
> compiler warning that can be seen when building with
> warnings enabled (W=1).

It would be useful to include the compiler warning in the commit log.

I notice there are a few similar occurrences elsewhere in the tree:

  arch/csky/kernel/perf_event.c:const static struct of_device_id csky_pmu_of_device_ids[] = {
  arch/nds32/kernel/perf_event_cpu.c:const static struct of_device_id cpu_pmu_of_device_ids[] = {
  drivers/gpu/drm/msm/dsi/dsi_cfg.c:const static struct msm_dsi_host_cfg_ops msm_dsi_v2_host_ops = {
  drivers/gpu/drm/msm/dsi/dsi_cfg.c:const static struct msm_dsi_host_cfg_ops msm_dsi_6g_host_ops = {
  drivers/gpu/drm/msm/dsi/dsi_cfg.c:const static struct msm_dsi_host_cfg_ops msm_dsi_6g_v2_host_ops = {
  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:const static struct wiphy_iftype_ext_capab he_iftypes_ext_capa[] = {
  fs/unicode/utf8-selftest.c:const static struct {
  fs/unicode/utf8-selftest.c:const static struct {

Those should probably be fixed, too (but in separate patches since
other maintainers would take them).

> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
>  drivers/pci/pci-bridge-emul.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
> index 06083b86d4f4..5fd90105510d 100644
> --- a/drivers/pci/pci-bridge-emul.c
> +++ b/drivers/pci/pci-bridge-emul.c
> @@ -38,7 +38,7 @@ struct pci_bridge_reg_behavior {
>  	u32 rsvd;
>  };
>  
> -const static struct pci_bridge_reg_behavior pci_regs_behavior[] = {
> +static const struct pci_bridge_reg_behavior pci_regs_behavior[] = {
>  	[PCI_VENDOR_ID / 4] = { .ro = ~0 },
>  	[PCI_COMMAND / 4] = {
>  		.rw = (PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
> @@ -173,7 +173,7 @@ const static struct pci_bridge_reg_behavior pci_regs_behavior[] = {
>  	},
>  };
>  
> -const static struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
> +static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
>  	[PCI_CAP_LIST_ID / 4] = {
>  		/*
>  		 * Capability ID, Next Capability Pointer and
> -- 
> 2.22.1
> 
