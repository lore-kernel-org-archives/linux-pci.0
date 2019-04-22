Return-Path: <SRS0=L200=SY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A1DC10F11
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 20:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9637B20693
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 20:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555966735;
	bh=VDf135GIuXXsS0cafi55LaABSuHOJNpU/O2q7e1eVWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cjdBVgX9GJpy3N07r28LI5dTHfWO5Q4dgrbN6X+glC/tnx+HTlWZN+Eq8yb6na4Vo
	 7/nTV8obxhAUBn4cqZy+6uUWOoyGNaS2gfi077/iaSGpC17u7YETh79HFlvK0caZ0d
	 SOt+LgcifyHrXmOpa0h/CF2kzLx99TY+mVVAeM88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfDVU6u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfDVU6u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Apr 2019 16:58:50 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D14520693;
        Mon, 22 Apr 2019 20:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555966729;
        bh=VDf135GIuXXsS0cafi55LaABSuHOJNpU/O2q7e1eVWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZC/3q/2NW3aUSlAUSh1QUDXA/ktdXbY6dzl3lHx47x8KsVYGjoNQRJuLULg32XfZ
         Xc+IIwiGrNBd/kK/gfjTy6h2XL/Uv9EiSrF2mGg1kTx6Ufy0JEdaiZWGl8lXCvYil+
         zh2ZXMokJC6raTZ5g9J4mF+Q30JYJWIHa9r0EUEU=
Date:   Mon, 22 Apr 2019 15:58:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] PCI / ACPI: Do not export pci_get_hp_params()
Message-ID: <20190422205845.GM173520@google.com>
References: <20190208162414.3996-1-mr.nuke.me@gmail.com>
 <20190208162414.3996-2-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208162414.3996-2-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 08, 2019 at 10:24:11AM -0600, Alexandru Gagniuc wrote:
> This is only used within drivers/pci, and there is no reason to make
> it available outside of the PCI core.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Applied the whole series to pci/hotplug for v5.2, thanks!

I dropped the "list" member from struct hpx_type3 because it didn't
seem to be used.

> ---
>  drivers/pci/pci-acpi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index e1949f7efd9c..b25e5fa9d1c9 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -366,7 +366,6 @@ int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp)
>  	}
>  	return -ENODEV;
>  }
> -EXPORT_SYMBOL_GPL(pci_get_hp_params);
>  
>  /**
>   * pciehp_is_native - Check whether a hotplug port is handled by the OS
> -- 
> 2.19.2
> 
