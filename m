Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E60C64EB8
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 20:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5562098A
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 20:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPNg85G/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5562098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeJEDrW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727536AbeJEDrW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Oct 2018 23:47:22 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A6720854;
        Thu,  4 Oct 2018 20:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538686340;
        bh=b42EPkrt/ZjF3xT+fO10BGM1CbNcYPzjOe5+xKzByjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPNg85G/AmaZ8w7BBSupXoUWet9vkNaOLE5jhe4sMSa9r+tGmUOXXOLJU2S0AJ572
         D5IrUsmrmCbrcoZkG4/pZiMyMdslhzXtDt/CN886TfrcdN5YEHbHoYe1Ik7t/xFiCX
         vLPKGrEMUvD3GGxitW0WsgHS5C/Q8B07sEWwuBpI=
Date:   Thu, 4 Oct 2018 15:52:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI / ACPI: Mark expected switch fall-through
Message-ID: <20181004205219.GJ120535@bhelgaas-glaptop.roam.corp.google.com>
References: <20181004154041.GA28767@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004154041.GA28767@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 04, 2018 at 05:40:41PM +0200, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 1472052 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to pci/misc for v4.20, thanks!

> ---
>  drivers/pci/pci-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 79c8e95..2a4aa64 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -588,6 +588,7 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  			error = -EBUSY;
>  			break;
>  		}
> +		/* Fall through */
>  	case PCI_D0:
>  	case PCI_D1:
>  	case PCI_D2:
> -- 
> 2.7.4
> 
