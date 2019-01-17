Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3616C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 14:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7460120856
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 14:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547737180;
	bh=TTq+3ukVouDlvXKwUE+gRDYKa4sJzEnhYZzPDhKf5s4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wMNFyOjEDj43dYZGx1HtGO0nLSYq5AML1qXTZne7Lz7s5/s/5vUG3GCSF71yA8qnm
	 mB77BS9cxLIHAHlqdYhazMiUeLx//kegvN2NXG8GF8jkAcvZyRLtu7jFCzivt03OEQ
	 cVr+4AYDmuv/NHwUfVNpFO6g3XMk0ZcUQHdHzsuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfAQO7k (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:59:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbfAQO7j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jan 2019 09:59:39 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2127A20851;
        Thu, 17 Jan 2019 14:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547737179;
        bh=TTq+3ukVouDlvXKwUE+gRDYKa4sJzEnhYZzPDhKf5s4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tb921DvSiyTtfgRJ8P+tjIxP01bxzQjNfG3cNOxemX+oQhu8NsMjWi+U1GVb6toQe
         IcQWt0e7/94XE7RU7Ct35hMPpYaoRBOdaS6ksvz7KCc2GMttq42XfHfPcWk3VNSU3f
         ezu21zGh9WaRBlSwVIAHP0HHW8viAqi3r5VG/Vag=
Date:   Thu, 17 Jan 2019 08:59:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com,
        devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jork Loeser <jloeser@microsoft.com>
Subject: Re: [PATCH 2/3] PCI: hv: Add vPCI version protocol negotiation
Message-ID: <20190117145937.GE158366@google.com>
References: <1547758038-5255-1-git-send-email-akaher@vmware.com>
 <1547758038-5255-3-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547758038-5255-3-git-send-email-akaher@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 18, 2019 at 02:17:17AM +0530, Ajay Kaher wrote:
> Hyper-V vPCI offers different protocol versions.  Add the infra for
> negotiating the one to use.
> 
> Signed-off-by: Jork Loeser <jloeser@microsoft.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I did not sign off on this, please remove.

> Reviewed-by: K. Y. Srinivasan <kys@microsoft.com>
> Acked-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Ajay Kaher <akaher@vmware.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 72 +++++++++++++++++++++++++++++++------------
>  1 file changed, 53 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 9e44adf..6eed85b 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -65,22 +65,37 @@
>   * major version.
>   */
>  
> -#define PCI_MAKE_VERSION(major, minor) ((u32)(((major) << 16) | (major)))
> +#define PCI_MAKE_VERSION(major, minor) ((u32)(((major) << 16) | (minor)))

This looks like a bug fix that should be in its own patch.
