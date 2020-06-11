Return-Path: <SRS0=MbFA=7Y=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77414C433DF
	for <linux-pci@archiver.kernel.org>; Thu, 11 Jun 2020 17:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 494DC20829
	for <linux-pci@archiver.kernel.org>; Thu, 11 Jun 2020 17:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591897303;
	bh=iz9QsGoSr098XOHWPxiA9eVbf8DtfdYDY9GCFCnNGZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=HKpsGW9NB0tYbki6eXCrOVAMMfmibi31hOBshvXHIt9E5Y5te/VajWxBwSi1wWIYX
	 4ObcKmfjQjtKMTyTUji3N7AhREo3Bl3a+3fbkGwlegb4/xdJoraXEZPkDTigsonVSN
	 /lJSn9+QjTFdbBkVHaMr7YHCm7QnnajJY/hhDhms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgFKRlm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgFKRlm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jun 2020 13:41:42 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2776207ED;
        Thu, 11 Jun 2020 17:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591897302;
        bh=iz9QsGoSr098XOHWPxiA9eVbf8DtfdYDY9GCFCnNGZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MHg8BpthG7w9da0+oc9YVpTh5RRyTCfJZQSkIb54QE25CICX8PqSRWv3wl8J7nflH
         4Ecyg6KpoPeiZJ6LZPpwignVqlqyeAki4VK392kedJNhJ5hFHw6LXzzBUTu2gIw6Xj
         qwf3oKzb33tp9qd8op+CkOLz9eKb6VLzTP4V0kLI=
Date:   Thu, 11 Jun 2020 12:41:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [RFC PATCH] PCI: Remove End-End TLP as PASID dependency
Message-ID: <20200611174140.GA1597601@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591762694-9131-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Sinan]

On Wed, Jun 10, 2020 at 12:18:14PM +0800, Zhangfei Gao wrote:
> Some platform devices appear as PCI and have PCI cfg space,
> but are actually on the AMBA bus.
> They can support PASID via smmu stall feature, but does not
> support tlp since they are not real pci devices.
> So remove tlp as a PASID dependency.

When you iterate on this, pay attention to things like:

  - Wrap paragraphs to 75 columns or so, so they fill the whole line
    but don't overflow when "git show" adds 4 spaces.

  - Leave a blank line between paragraphs.

  - Capitalize consistently: "SMMU", "PCI", "TLP".

  - Provide references to relevant spec sections, e.g., for the SMMU
    stall feature.

> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/pci/ats.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 390e92f..8e31278 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -344,9 +344,6 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  	if (WARN_ON(pdev->pasid_enabled))
>  		return -EBUSY;
>  
> -	if (!pdev->eetlp_prefix_path)
> -		return -EINVAL;

No.  This would mean we might enable PASID on actual PCIe devices when
it is not safe to do so, as Jean-Philippe pointed out.

You cannot break actual PCIe devices just to make your non-PCIe device
work.

These devices do not support PASID as defined in the PCIe spec.  They
might support something *like* PASID, and you might be able to make
parts of the PCI core work with them, but you're going to have to deal
with the parts that don't follow the PCIe spec on your own.  That
might be quirks, it might be some sort of AMBA adaptation shim, I
don't know.  But it's not the responsibility of the PCI core to adapt
to them.

>  	if (!pasid)
>  		return -EINVAL;
>  
> -- 
> 2.7.4
> 
