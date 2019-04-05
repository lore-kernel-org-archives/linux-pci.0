Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979F7C282CE
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 21:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650802186A
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 21:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554498816;
	bh=tQBHfo1zQSHRmGi45vMjn4fdzO8w9ilCneck9mf2hLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CGrU9LHdNtZgr4723tqgzGYzZ7LxRdGRfk4FmPkqflnH4NY78hP7FVDUqy36T3BEH
	 x4Fuaa6jdx3LYyGa1aYtg5UUQyuRJzQCKuRAEqjyWxBzGG97A4bsuUqB8I0cwfDJE/
	 uCuAEIuO29GeupMKnXmPnAG3RHo8vr3cs+v9tC1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfDEVNf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbfDEVNf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Apr 2019 17:13:35 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B50682173C;
        Fri,  5 Apr 2019 21:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554498815;
        bh=tQBHfo1zQSHRmGi45vMjn4fdzO8w9ilCneck9mf2hLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eyodfyfSW9CqeUzUJWAZ/M2Wf7tEe80NpqDJFaOINm2ZuFLoLm/XPodi6TbEt6qJS
         CEGOBtLn351zSyvFJyj2smZuMbKm0hphXjlrZo3YzXdUCmm9THnSyVtPyhoPQIn9Ot
         GWXmfuDYf+anSgN9/S38nr9ooS9iVClR0CTwAkqw=
Date:   Fri, 5 Apr 2019 16:13:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add function 1 DMA alias quirk for Marvell 9170
 SATA controller
Message-ID: <20190405211333.GA159318@google.com>
References: <20190405152047.153417-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405152047.153417-1-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 05, 2019 at 04:20:47PM +0100, Andre Przywara wrote:
> There is a Marvell 88SE9170 PCIe SATA controller I found on a board
> here. Some quick testing with the ARM SMMU enabled reveals that it
> suffers from the same requester ID mixup problems as the other Marvell
> chips listed already.
> 
> Add the PCI vendor/device ID to the list of chips which need the
> workaround.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Applied with stable tag to for-linus for v5.1, thanks!

> ---
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index a59ad09ce911..a077f67fe1da 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3877,6 +3877,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9128,
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c14 */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9130,
>  			 quirk_dma_func1_alias);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9170,
> +			 quirk_dma_func1_alias);
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c47 + c57 */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9172,
>  			 quirk_dma_func1_alias);
> -- 
> 2.17.1
> 
