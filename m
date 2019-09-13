Return-Path: <SRS0=4oL5=XI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F911C49ED7
	for <linux-pci@archiver.kernel.org>; Fri, 13 Sep 2019 04:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7330F20CC7
	for <linux-pci@archiver.kernel.org>; Fri, 13 Sep 2019 04:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568349623;
	bh=H6VpVaBqt3qPw43onWcAfq6Al0MJqMj+w0EYezX7H4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y5rxcJXum0c8Q6ombCo7bpCtwhfVinA0RPXTctoK7vmNBNV5sq9ab24C37B8lQJ/b
	 uxPpsNiZo1zdV5GJY1GFjGeFJtmjAIJ5iQSqN0ym8FbC3Fh5ySI2gMTVezMXkQXo3G
	 Ur5TeFkYVhBuLL3nZtGYrrU7CoMiiptNirmzxJlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfIMEkW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 13 Sep 2019 00:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfIMEkW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Sep 2019 00:40:22 -0400
Received: from localhost (unknown [84.241.200.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 107102084F;
        Fri, 13 Sep 2019 04:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568349622;
        bh=H6VpVaBqt3qPw43onWcAfq6Al0MJqMj+w0EYezX7H4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uo/RS+OZ8FKJ/rzDA5bMe3WwmMokIaZeri4eVf8R2Nc0UfML0Zf2JUQYDPv/U4y3X
         xUrhXy3d/JpUxpAiX/DYlpMBwFimsgeOMsfsFBheV8YL3TV5LJbLFhOk1296CPtxHv
         lKqX8rpCKY9xIlSqFVarTcqLTpYMNMWs/hHtGLhg=
Date:   Fri, 13 Sep 2019 05:40:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Megha Dey <megha.dey@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pci@vger.kernel.org, maz@kernel.org, bhelgaas@google.com,
        rafael@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        alex.williamson@redhat.com, jgg@mellanox.com, ashok.raj@intel.com,
        megha.dey@intel.com, jacob.jun.pan@intel.com
Subject: Re: [RFC V1 1/7] genirq/msi: Differentiate between various MSI based
 interrupts
Message-ID: <20190913044017.GB119695@kroah.com>
References: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
 <1568338328-22458-2-git-send-email-megha.dey@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568338328-22458-2-git-send-email-megha.dey@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 12, 2019 at 06:32:02PM -0700, Megha Dey wrote:
> +enum msi_desc_tags {
> +	IRQ_MSI_TAG_MSI,
> +	IRQ_MSI_TAG_MSIX,
> +	IRQ_MSI_TAG_IMS,
> +	IRQ_MSI_TAG_PLAT,
> +	IRQ_MSI_TAG_FSL,
> +	IRQ_MSI_TAG_SCI,
> +};

What does any of these mean?  Can you please provide comments at the
very least saying what FSL, SCI, IMS and everything else is?

thanks,

greg k-h
