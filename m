Return-Path: <SRS0=XVho=CZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F01C43461
	for <linux-pci@archiver.kernel.org>; Wed, 16 Sep 2020 18:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1CC20936
	for <linux-pci@archiver.kernel.org>; Wed, 16 Sep 2020 18:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600281215;
	bh=4gLbmk/7eaMq8kQdjr9e/cFnlSaDI80VsZ/K37fh5uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UyBW32DmR66TPeVfsjsthQpw4sKVEONvaR+N63oehdiXJf3O4vMgEFChqTAc3jR6Y
	 0RrCqz5FaMkUtuAZlTV8HaK46M9X+wNKJvfq+bRmEPC+NyEC9jgdqnidkBk3Gn/z9S
	 QPJ8M8cRf2TAG6P26GY84r76BZdhp29sNckzwSXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgIPSdR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:33:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39600 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgIPSby (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 14:31:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id n14so4484509pff.6;
        Wed, 16 Sep 2020 11:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6G5lOpVUlHWWGXIZ1jolJG0Sb394B1bYevllH8NK7Gc=;
        b=N7Lc1NaJ8R7N6Y0VeN7vYBYr9KF16GgweSK+M2/iLBAdN0meYXlNTqfLMwvfTg0+Sk
         Bbm9qkMuZS/SLl2TX0pJfBRIDLjDeQrnFjWPjq7ULPMzEoIQ/Dn0VAd8ZZmjihAVoETE
         j7dWSEdx6g72B2s+Qc1RryNvVivm7xIB27rK8ZCPXZpvVCQoCwiZd7WoLXb8UwKufNGZ
         SBJwgLfk+wtPdyhiJfULutPx9Cm4EY9YWmoR2vDRqMySSQoF3BWFTl21+VA1AZ0+t5Ne
         NIgWTl+fD0V89WQHtgVoEKLFmJOR8VCI3TIYmT2MCym48lNKNfKcZd28iiaFv+yDaYTm
         1C0g==
X-Gm-Message-State: AOAM533BvBKBf/BO9+Y89ytUhg1C6pxCbVvFS0qbBxSfUsK/4ue1k4kf
        dhE/UPSLFtLtBWAY1kTDsyXKWHYF5H75
X-Google-Smtp-Source: ABdhPJzSoz+rtnLXZQoJdrYYoga5TX85PXPw9tY0/1eRJt6R8LO9wd1xaTDTXuLVykA3Ex3b8PSz4Q==
X-Received: by 2002:a92:8e42:: with SMTP id k2mr6234382ilh.175.1600269881838;
        Wed, 16 Sep 2020 08:24:41 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o15sm10747097ilc.41.2020.09.16.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 08:24:40 -0700 (PDT)
Received: (nullmailer pid 3994603 invoked by uid 1000);
        Wed, 16 Sep 2020 15:24:38 -0000
Date:   Wed, 16 Sep 2020 09:24:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jquinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 05/10] PCI: brcmstb: Add bcm7278 PERST# support
Message-ID: <20200916152438.GA3991893@bogus>
References: <20200911175232.19016-1-james.quinlan@broadcom.com>
 <20200911175232.19016-6-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911175232.19016-6-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 11, 2020 at 01:52:25PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> The PERST# bit was moved to a different register in 7278-type STB chips.
> In addition, the polarity of the bit was also changed; for other chips
> writing a 1 specified assert; for 7278-type chips, writing a 0 specifies
> assert.  Of course, PERST# is a PCIe asserted-low signal.
> 
> While we are here, also change the bridge_sw_init_set() functions so like
> the perst_set() functions they are chip specific and we no longer rely on
> data wrt chip specific field mask and shift values.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 97 +++++++++++++++++++--------
>  1 file changed, 69 insertions(+), 28 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
