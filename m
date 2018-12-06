Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C815C04EB8
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 20:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CE821479
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 20:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544129788;
	bh=wNDitL2LMb3N8cxB50C/TrdMP8V0vf5q+7RxMDbmbPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qHDe1lpjdEG13r488/4l/LyNvyxZi6MM/HNpvTfK0z8G8K7YBeh5rDG7f+s2AwSkv
	 dUfT0aCmqD5vQRIUkh+4YdauEzKN6Zeo054Q56Vi9NkWq5peA0MTmmHLj+UvVKoXPi
	 tXapSrTANGYj6vGwx2TudXUM40wykXpdqVCq+DWk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CE821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbeLFU41 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:56:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:57324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeLFU41 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Dec 2018 15:56:27 -0500
Received: from localhost (unknown [66.115.192.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 767BD2146D;
        Thu,  6 Dec 2018 20:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544129786;
        bh=wNDitL2LMb3N8cxB50C/TrdMP8V0vf5q+7RxMDbmbPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bSJqU4RaSZToICLsfze/CTYp3Pt4kQPXzB1LDzuHWbMRbfvLB/OAr8Pf2RXxbBbVi
         +mket2sS3yafscFXYIHbsb8+FaS5ue004y7EFjl3pig/Fm2mt5+iWdJkwYgcNBYKu4
         KU+OcwEceG1uiO2rVtzNL0uc9Hbqa/FdNzmo+2Cs=
Date:   Thu, 6 Dec 2018 14:56:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add missing include to drivers/pci.h
Message-ID: <20181206205625.GE247703@google.com>
References: <20181128222805.12637-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128222805.12637-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 28, 2018 at 04:28:04PM -0600, Alexandru Gagniuc wrote:
> This files makes use of definitions provided in <linux/pci.h>. This
> only compiles when <linux/pci.h> is included beforehand, and creates
> a nasty include dependency. Instead, just include the correct file.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Applied to pci/misc for v4.21, thanks!

> ---
>  drivers/pci/pci.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 662b7457db23..224d88634115 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -2,6 +2,8 @@
>  #ifndef DRIVERS_PCI_H
>  #define DRIVERS_PCI_H
>  
> +#include <linux/pci.h>
> +
>  #define PCI_FIND_CAP_TTL	48
>  
>  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
> -- 
> 2.17.1
> 
