Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B6DC10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 13:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF1721850
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554991146;
	bh=UIlNqxvk93zRDvNWk0ZBa+AvDSCtLAEelJmiigQdZdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZV0Dzd12RL/NkFE+lvnKO1WZQ8Hr5gs0K4Og/npinfD7YZvU1JmE1NAihPMW2Ejo5
	 f9IYkRkSRAi7W2qYk0BzCpysnuu0SFoWVyx2kE/TXaRiUQ3bKvokXAjiD3j04NO0zW
	 PUoRgUpsCIxPivBtx+acIvu93rukKhdvSEz4Omnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDKN7G (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfDKN7G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 09:59:06 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C7E32077C;
        Thu, 11 Apr 2019 13:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554991145;
        bh=UIlNqxvk93zRDvNWk0ZBa+AvDSCtLAEelJmiigQdZdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0XS+UMn4sQvtSD6Nrtowp1/UIi5JMJwt0MrOwQcHtiqOL1mB02HqyB+LTL1TIDhL
         zFJy4m/wty5P9kfcOHVvm3SvRW5iQM+EE8ypaaalQ/tAz7QB3F0jxHe3UmF+qykeTi
         uVYA3/U/MX6RVKFzF2aB6TJnrIAXGbFzwa3TuWr8=
Date:   Thu, 11 Apr 2019 08:59:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nikolai Kostrigin <nickel@altlinux.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>
Subject: Re: [PATCH RESEND 1/1] PCI: Add ATS-disable quirk for AMD Radeon R7
 GPUs
Message-ID: <20190411135903.GP256045@google.com>
References: <20190408103725.30426-1-nickel@altlinux.org>
 <20190408103725.30426-2-nickel@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408103725.30426-2-nickel@altlinux.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex, Suravee, Thomas, Felix, Christian]

On Mon, Apr 08, 2019 at 01:37:25PM +0300, Nikolai Kostrigin wrote:
> ATS is broken on this hardware (at least for Stoney Ridge
> based laptop) and causes IOMMU stalls and
> system failure. Disable ATS on these devices to make them
> usable again with IOMMU enabled
> Thanks to Joerg Roedel <jroedel@suse.de> for help.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=194521
> 
> Signed-off-by: Nikolai Kostrigin <nickel@altlinux.org>

I applied this to pci/virtualization for v5.2 with Joerg's ack, a stable
tag, and a note about Alex's suspicion that this may be system-specific and
may also affect other devices.

> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4700d24e5d55..abb2532e16bf 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4876,6 +4876,7 @@ static void quirk_no_ats(struct pci_dev *pdev)
>  
>  /* AMD Stoney platform GPU */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_no_ats);
>  #endif /* CONFIG_PCI_ATS */
>  
>  /* Freescale PCIe doesn't support MSI in RC mode */
> -- 
> 2.21.0
> 
