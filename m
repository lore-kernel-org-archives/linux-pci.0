Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34D1C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 16:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C7C20851
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 16:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C7C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbeKTCoD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:44:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:3499 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729865AbeKTCoD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Nov 2018 21:44:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 08:19:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,253,1539673200"; 
   d="scan'208";a="87614176"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 19 Nov 2018 08:19:59 -0800
Date:   Mon, 19 Nov 2018 09:16:42 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Shunyong Yang <shunyong.yang@hxt-semitech.com>
Cc:     bhelgaas@google.com, okaya@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Add HXT quirk for Command Completed
 errata
Message-ID: <20181119161642.GA26595@localhost.localdomain>
References: <bcaf1d5d-23a6-d4e6-08e8-587daf6cca06@kernel.org>
 <5e88860c8426df537c5a5f2d0e6add6df8955a0f.1541574331.git.shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e88860c8426df537c5a5f2d0e6add6df8955a0f.1541574331.git.shunyong.yang@hxt-semitech.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 07, 2018 at 03:25:05PM +0800, Shunyong Yang wrote:
> The HXT SD4800 PCI controller does not set the Command Completed
> bit unless writes to the Slot Command register change "Control"
> bits.
> 
> This patch adds SD4800 to the quirk.
> 
> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 7dd443aea5a5..91db67963aea 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -920,3 +920,5 @@ static void quirk_cmd_compl(struct pci_dev *pdev)
>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0401,
>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_HXT, 0x0401,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);

I guess you're just appending to where this quirk is already defined,
but why are the quirks even in the core driver instead of pci/quirks.c?
