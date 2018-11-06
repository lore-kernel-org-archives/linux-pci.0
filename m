Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD300C0044C
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 00:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D772086B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 00:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXTKwXs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D772086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbeKFJya (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:54:30 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38781 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeKFJy3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Nov 2018 04:54:29 -0500
Received: by mail-ot1-f65.google.com with SMTP id f24so9881817otl.5;
        Mon, 05 Nov 2018 16:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C3QRjl1yEfFzwhXaZ7Xd590E4hClcBAev8/eXeJ3+0g=;
        b=aXTKwXs34CWO9kBROqOQ3DD5II4Z/7w+ok2GWTRL+v83oTD0sYpIb4JTEVxFrGwZZR
         ghOxu1bZ1M8SaokaHVl3lodUV1KoRqGe7XLKeY3Fwe0/EwWA+qLj9YDomr/8Mx+0/gai
         9gnVvNwDOsE+vSa6C0yScJ1Rjs/KQWlgMN1mBy1YxL081pmQYReo0wlmqCARtxrYt2v5
         TMRNFWbDQOSiHP0k4sOXzbWr2iaR3bGlFBw8C2HKxY17OVeJ1Wt1lzvZXbDNz2HyUNOp
         t+rOLC2e6eWeNTicQ4tobzTceoVOqiGfXUUoQmb1tRl2duabXnTG/hMzqGJLI+8pjBhW
         5dQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C3QRjl1yEfFzwhXaZ7Xd590E4hClcBAev8/eXeJ3+0g=;
        b=LtW3PdAbVZwixbYPKNQ2zed4OfaXYX1K1b1yPGmp2Q38KtZqNCHoHWIvmhrR6tK9PK
         sgf4ymlOF9CLA0HP6m2yEirI5vE/xDZCpTAwGuEdSF8EjBeMVLluiRV9R2FmYQ/kjtRJ
         s7B/+nZneeAnKhMA/hWxynIL3r0f9pIkoT9AqaTet7uRhwdwJcHSp8U1zxu1Yzw0p3dh
         X4l+Do+AIImYcYxXLtW7PhodsM7TstbTbOUgJW9h8a9up9JHohYbXjZepb5BQNXa1uSL
         DlZWRAQUKh70W7avmGcU298Vt7QbX4rmKe5RUld1HySDwFSEc2kuwh0qBrLhVFJh0+W5
         iaEA==
X-Gm-Message-State: AGRZ1gKH+jrIDcKS9CVwaaetOvPsszlp63ZFp97fMvTTSiqEi3/1NgMj
        mL3MEQvDZ1Q3XYiCQFsV0CFEYI5y
X-Google-Smtp-Source: AJdET5ekmyOAV2n23XgBoyQsrFrE7VYvk4546OW+NwjMce2SX0VK+boc7OvCpqx8gn3gaJkoFi0Arg==
X-Received: by 2002:a9d:17e8:: with SMTP id j95mr13752470otj.292.1541464324178;
        Mon, 05 Nov 2018 16:32:04 -0800 (PST)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id 111sm46397773otf.51.2018.11.05.16.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 16:32:03 -0800 (PST)
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        linux-kernel@vger.kernel.org
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <3c949cf2-bb7f-6b67-f2cb-9f4859b56cfb@gmail.com>
Date:   Mon, 5 Nov 2018 18:32:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918221501.13112-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ping

On 09/18/2018 05:15 PM, Alexandru Gagniuc wrote:
> When a PCI device is gone, we don't want to send IO to it if we can
> avoid it. We expose functionality via the irq_chip structure. As
> users of that structure may not know about the underlying PCI device,
> it's our responsibility to guard against removed devices.
> 
> .irq_write_msi_msg() is already guarded inside __pci_write_msi_msg().
> .irq_mask/unmask() are not. Guard them for completeness.
> 
> For example, surprise removal of a PCIe device triggers teardown. This
> touches the irq_chips ops some point to disable the interrupts. I/O
> generated here can crash the system on firmware-first machines.
> Not triggering the IO in the first place greatly reduces the
> possibility of the problem occurring.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>   drivers/pci/msi.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index f2ef896464b3..f31058fd2260 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -227,6 +227,9 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
>   {
>   	struct msi_desc *desc = irq_data_get_msi_desc(data);
>   
> +	if (pci_dev_is_disconnected(msi_desc_to_pci_dev(desc)))
> +		return;
> +
>   	if (desc->msi_attrib.is_msix) {
>   		msix_mask_irq(desc, flag);
>   		readl(desc->mask_base);		/* Flush write to device */
> 
