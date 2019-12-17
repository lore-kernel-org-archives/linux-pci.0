Return-Path: <SRS0=ET9P=2H=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF99C43603
	for <linux-pci@archiver.kernel.org>; Tue, 17 Dec 2019 14:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E370224672
	for <linux-pci@archiver.kernel.org>; Tue, 17 Dec 2019 14:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576593077;
	bh=5VfUppQ1jeD0B8W3z2U/PZ/wqjDbBboTOoj2Qsp6Cfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=TqmH23u1ISP41wUZrurjVIhFhVLXiqRGIlI5gYBnZGqRfawDzrUbsP0GU9wT6r5Fp
	 exmaX/blBSrAb4z9ROc6wd1wfcvt/H194bjT/P67AFrS4RLWp9njjDSynVcZ+fwMtH
	 hsJOY9Lo2tzzRU7dtpdR7ZEvVunVdmksQSI5VUt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfLQObQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:31:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbfLQObQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 09:31:16 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AB9F21D7D;
        Tue, 17 Dec 2019 14:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576593075;
        bh=5VfUppQ1jeD0B8W3z2U/PZ/wqjDbBboTOoj2Qsp6Cfc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=0reMdQjRLKDNvRpgkXHzmk/RDkzXG9mkrlzYREgA9CO8KKhu+5BNgru+Y/XhShEvu
         RqY7BYrFsWOwIt/85L4xvcLnMp/mEWFXR3vsDWD0Xuh74N/K7gGbjHoO4om6ecxYkx
         efBwZrFHcO69xztUj3lg4uDu5bS8Dv1T4bk5YVrE=
Date:   Tue, 17 Dec 2019 08:31:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yurii Monakov <monakov.y@gmail.com>
Cc:     linux-pci@vger.kernel.org, m-karicheri2@ti.com,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] PCI: keystone: Fix outbound region mapping
Message-ID: <20191217143113.GA157932@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004154811.GA31397@monakov-y.office.kontur-niirs.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Kishon]

On Fri, Oct 04, 2019 at 06:48:11PM +0300, Yurii Monakov wrote:
> PCIe window memory start address should be incremented by OB_WIN_SIZE
> megabytes (8 MB) instead of plain OB_WIN_SIZE (8).
> 
> Signed-off-by: Yurii Monakov <monakov.y@gmail.com>

I added:

  Fixes: e75043ad9792 ("PCI: keystone: Cleanup outbound window configuration")
  Acked-by: Andrew Murray <andrew.murray@arm.com>
  Cc: stable@vger.kernel.org      # v4.20+

and cc'd Kishon (author of e75043ad9792) and put this on my
pci/host-keystone branch for v5.6.  Lorenzo may pick this up when he
returns.

I'd like the commit message to say what this fixes.  Currently it just
restates the code change, which I can see from the diff.

My *guess* is that previously, we could only access 8MB of MMIO space
and this patch increases that to 8MB * num_viewport.

> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index af677254a072..f19de60ac991 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -422,7 +422,7 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>  				   lower_32_bits(start) | OB_ENABLEN);
>  		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i),
>  				   upper_32_bits(start));
> -		start += OB_WIN_SIZE;
> +		start += OB_WIN_SIZE * SZ_1M;
>  	}
>  
>  	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
> -- 
> 2.17.1
> 
