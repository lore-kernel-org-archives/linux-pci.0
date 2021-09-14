Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735A8C433F5
	for <linux-pci@archiver.kernel.org>; Tue, 14 Sep 2021 19:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4514561056
	for <linux-pci@archiver.kernel.org>; Tue, 14 Sep 2021 19:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhINT2S (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:28:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230390AbhINT2R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Sep 2021 15:28:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A80C4600CD;
        Tue, 14 Sep 2021 19:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631647620;
        bh=ySQjIQWIKIGaSBWbd3/4pxpWVZaPCA8u5sxLZYj6sWM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=d7I44YQo+EuBNjF7O01x6c2XLjQQMr3xdivXeTobXiMQyspjsjTpL8dcRIaiMfcRj
         9Q08LIey9Q7nzbPO6qkg6//ig40WMEcooOciCANzkxbTK25JOuRLx35/X3ao4hx+w0
         01FJIOhev+OmeEFXOn/aAoB9BDvBfYT64NhR5NmNzmtFGvoRmF1Z9ynglHkwfEHU9d
         v+Hi4skJVB9yA6V8gSrMhgIzYfWnH7qit/Jrbn7Ue+lKU4UYtmPT9m/AbN1E5Suptt
         qRhnGtUyMUOO5Dq/tlCriPN88QiwRWdy0VSWARuqXYw3vFJ9RJQvGVNuqVFpzrmZKm
         id7NpqZzwjZFA==
Date:   Tue, 14 Sep 2021 14:26:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jon Derrick <jonathan.derrick@linux.dev>
Subject: Re: [PATCH] MAINTAINERS: Add Nirmal Patel as VMD maintainer
Message-ID: <20210914192658.GA1447240@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909200221.29981-1-jonathan.derrick@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 09, 2021 at 03:02:21PM -0500, Jon Derrick wrote:
> Change my email to my unaffiliated address and move me to reviewer
> status.
> 
> Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Jon Derrick <jonathan.derrick@linux.dev>
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Applied to for-linus for v5.15, thanks!

> ---
> Nirmal will be taking over my position as maintainer
> 
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9f35ada234e3..860a9b3bf5f3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14207,7 +14207,8 @@ F:	Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
>  F:	drivers/pci/controller/pci-ixp4xx.c
>  
>  PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
> -M:	Jonathan Derrick <jonathan.derrick@intel.com>
> +M:	Nirmal Patel <nirmal.patel@linux.intel.com>
> +R:	Jonathan Derrick <jonathan.derrick@linux.dev>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	drivers/pci/controller/vmd.c
> -- 
> 2.26.3
> 
