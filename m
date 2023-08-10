Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D29C001DB
	for <linux-pci@archiver.kernel.org>; Thu, 10 Aug 2023 07:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjHJHfD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Aug 2023 03:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHJHfC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 03:35:02 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B75110E7;
        Thu, 10 Aug 2023 00:35:01 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 09A4B2800BBE0;
        Thu, 10 Aug 2023 09:34:58 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id F151A2ED8B5; Thu, 10 Aug 2023 09:34:57 +0200 (CEST)
Date:   Thu, 10 Aug 2023 09:34:57 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, alex.williamson@redhat.com,
        christian.koenig@amd.com, kch@nvidia.com,
        gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <20230810073457.GA26246@wunner.de>
References: <20230809232851.1004023-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809232851.1004023-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 09, 2023 at 07:28:51PM -0400, Alistair Francis wrote:
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1226,6 +1227,12 @@ static int pci_create_resource_files(struct pci_dev *pdev)
>  	int i;
>  	int retval;
>  
> +#ifdef CONFIG_PCI_DOE
> +	retval = doe_sysfs_init(pdev);
> +	if (retval)
> +		return retval;
> +#endif
> +

The preferred way to expose PCI sysfs attributes nowadays is to add them
to pci_dev_attr_groups[] and use the ->is_visible callback to check
whether they're applicable to a particular pci_dev.  The alternative
via pci_create_resource_files() has race conditions which I think
still haven't been fixed. Bjorn recommended the ->is_visible approach
in response to the most recent attempt to fix the race:

https://lore.kernel.org/linux-pci/20230427161458.GA249886@bhelgaas/

To avoid (most of) the #ifdefs, you may want to consider adding a
doe-sysfs.c file like I've done for cma in this commit:

https://github.com/l1k/linux/commit/b057e2fb0ee0

Thanks,

Lukas
