Return-Path: <SRS0=PrTz=YX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3E4CA9EC6
	for <linux-pci@archiver.kernel.org>; Wed, 30 Oct 2019 20:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FCC20874
	for <linux-pci@archiver.kernel.org>; Wed, 30 Oct 2019 20:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572468057;
	bh=uDzTuuW0eeNiIMtkt7NpH65MPpTxQGR0fvDGgA3VMI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=jxRmlg8LbvIvYOhVW1QTRFD6dRlVwgHFZB1Jx7KqVOsbYPJfsnmmGkxO7zzM2HcsU
	 f7F5YAzmnhE1FLRtpSG5j2NoGxxBNF6Gy3JG6Z3Bt7tu7U2K52wVDp4FPiNCXy/o0t
	 SUeHvpAfbgx/s56xgOQWsWZ2jga3tn+uDlKOu0L0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfJ3Uk4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Oct 2019 16:40:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfJ3Uk4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Oct 2019 16:40:56 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C21A2080F;
        Wed, 30 Oct 2019 20:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572468055;
        bh=uDzTuuW0eeNiIMtkt7NpH65MPpTxQGR0fvDGgA3VMI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UqNGd+ZTUpJFhDMfv4SJi/+Ag6YQuDIuqGDEH2hEJ1sXl1QquoHjHNRJcjOJgXZe5
         cODQTCGliDN5izuvmxmqSeQlF77MS6TQqon4dFGAVw+hm+hNfjQ5yWp4VLP03VwqtJ
         0mBFRh1OclJ7C8JEuD5pTRYODL2gC/iQGKnT5HhE=
Date:   Wed, 30 Oct 2019 15:40:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, axboe@kernel.dk,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI: pci_ids: Add Loongson IDs
Message-ID: <20191030204054.GA247856@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030135347.3636-2-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please pay attention to the "git log --oneline
include/linux/pci_ids.h" output and make yours match, e.g.,

  PCI: Add Loongson Vendor and Device IDs

On Wed, Oct 30, 2019 at 09:53:43PM +0800, Jiaxun Yang wrote:
> Add Loongson device IDs that will be used by drivers later.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

With that change,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci_ids.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 21a572469a4e..75f3336116eb 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -148,6 +148,10 @@
>  
>  /* Vendors and devices.  Sort key: vendor first, device next. */
>  
> +#define PCI_VENDOR_ID_LOONGSON		0x0014
> +#define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
> +#define PCI_DEVICE_ID_LOONGSON_AHCI	0x7a08
> +
>  #define PCI_VENDOR_ID_TTTECH		0x0357
>  #define PCI_DEVICE_ID_TTTECH_MC322	0x000a
>  
> -- 
> 2.23.0
> 
