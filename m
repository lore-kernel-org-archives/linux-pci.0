Return-Path: <SRS0=6jqy=VA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D62C5B57D
	for <linux-pci@archiver.kernel.org>; Wed,  3 Jul 2019 01:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6751420B1F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Jul 2019 01:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562115802;
	bh=HHd7/JqeDyA8cgnz+y55uY+RyTkhNRZ7JSHv+IT51Gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MZeiVq+5ik2sR0xHfY+2dcZAlB2IqtkW2C4cgUAim6HiChDWJAmeEJpUE/J+bkADK
	 MwejCdfGRJPWwfBCwKbY6S/KHem85CbiRf5cjWF1hufMSE2FvqBqHxI1U67eu2MJSl
	 5Y3URO9v0s6lFUjLMUV9wlftdPp+Uo5QUDwhMaQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfGCBDF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGCBDF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jul 2019 21:03:05 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DE7121BF1;
        Tue,  2 Jul 2019 23:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562111178;
        bh=HHd7/JqeDyA8cgnz+y55uY+RyTkhNRZ7JSHv+IT51Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CrIu84spArwVRPyBzpYPsRgnNuSm+lDSIBhd3KtX3SHm9xW7OQsYblD6gEf1Pscxf
         y/k2K0wUqzF65nDFT1nh89HdvzjtV7CzNkbzValklRdVH30+iyOALXAeO19kd8xhCq
         bCyfUwDDdyUUc6TCvECcWPKG41dYIxhnZ2wWQBeQ=
Date:   Tue, 2 Jul 2019 18:46:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pci/proc: Use seq_puts() in show_device()
Message-ID: <20190702234616.GH128603@google.com>
References: <a6b110cb-0d0e-5dc3-9ca1-9041609cf74c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6b110cb-0d0e-5dc3-9ca1-9041609cf74c@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 02, 2019 at 01:26:27PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 2 Jul 2019 13:21:33 +0200
> 
> A string which did not contain a data format specification should be put
> into a sequence. Thus use the corresponding function “seq_puts”.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to pci/misc for v5.3, thanks!

> ---
>  drivers/pci/proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index 445b51db75b0..fe7fe678965b 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -377,7 +377,7 @@ static int show_device(struct seq_file *m, void *v)
>  	}
>  	seq_putc(m, '\t');
>  	if (drv)
> -		seq_printf(m, "%s", drv->name);
> +		seq_puts(m, drv->name);
>  	seq_putc(m, '\n');
>  	return 0;
>  }
> --
> 2.22.0
> 
