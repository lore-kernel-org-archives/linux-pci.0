Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ADCC433E6
	for <linux-pci@archiver.kernel.org>; Mon,  8 Feb 2021 16:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E51264E73
	for <linux-pci@archiver.kernel.org>; Mon,  8 Feb 2021 16:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhBHQKk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Feb 2021 11:10:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234199AbhBHQKc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2021 11:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612800538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2iBB0LyG2KCKP9pDFDKEk0ExuReKwaAb5h/pNk9dGc=;
        b=OO2UnOMOWwN18v8ef4GKqmQ6Q23ms8urDQdfcHAGr+0n7ueKt3H9vpGjaqSh8rATHAUziE
        b9QT2MgnJd7Z273+35OtB6N9qRgKZQViuiKihol0p6IpIMRCpk+nlgHq1BLHe961YYBpuT
        5MgXiTdRqrCYQx0HjV/7zGXcCipsyvM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-KK_dGLDNMXibZp044mdw-Q-1; Mon, 08 Feb 2021 11:08:56 -0500
X-MC-Unique: KK_dGLDNMXibZp044mdw-Q-1
Received: by mail-qk1-f199.google.com with SMTP id r15so3915801qke.5
        for <linux-pci@vger.kernel.org>; Mon, 08 Feb 2021 08:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=P2iBB0LyG2KCKP9pDFDKEk0ExuReKwaAb5h/pNk9dGc=;
        b=PdbwFNld3drNrlMUEOmT5swdkbD5O2OHAHVpuzA0RPa9ydgIq2fIcEqr6FSUxYcmqQ
         nwJFr69oK32/LSzlsoFMkCPf/pLyAE03pBDlV30URpWDZA0HXAmQMdkn3hBbc1TElDp1
         QEaEQHRF28AyosGsAqTCVSK6q9gqsyiP4XotKfspyu3/F1p+jgirr6R4zLcGrNVhJc0Y
         T40NECuNwktyY4ihpoZzRVCBUT5Z5W6EO8wxpwEI2w8PRkAcpjx4WftjMS45aYOAsbUO
         +fi4cImGR+tOX3OcmugTgywI9OeyeCfZ4ikAUHPfgZwaXD8qln7Lj0aMAGMuCN3kxHrq
         nEdQ==
X-Gm-Message-State: AOAM533Cm1xM2hCtPfOHQmu77wfFZlXW2GhGiDGgMinwUXytg9uo1i/E
        HPllfGC8TK0RYIfQernNLv6kSGknardOhcPBwgemJFwMCbUTwdVSYoG8tkP2KWfSsnvsTExKd/I
        vOCSD3Jb/JD+nkuV5Qbt9
X-Received: by 2002:a0c:aed0:: with SMTP id n16mr16979482qvd.22.1612800536406;
        Mon, 08 Feb 2021 08:08:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzC7Ey6ojUTMBsmlqkawNby02wq3KpLAqjGFFWc94NaN2MdU5ifFcD7iOTVHLkJhgrKQ/xW0g==
X-Received: by 2002:a0c:aed0:: with SMTP id n16mr16979456qvd.22.1612800536147;
        Mon, 08 Feb 2021 08:08:56 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h5sm14968213qti.22.2021.02.08.08.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 08:08:55 -0800 (PST)
Subject: Re: [PATCHv2] PCI: Add Silicom Denmark vendor ID
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210208150158.2877414-1-mhu@silicom.dk>
From:   Tom Rix <trix@redhat.com>
Message-ID: <904cf9ee-a7a4-d592-c01a-d994f1df9a55@redhat.com>
Date:   Mon, 8 Feb 2021 08:08:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210208150158.2877414-1-mhu@silicom.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/8/21 7:01 AM, Martin Hundebøll wrote:
> Update pci_ids.h with the vendor ID for Silicom Denmark. The define is
> going to be referenced in driver(s) for FPGA accelerated smart NICs.
>
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
Reviewed-by: Tom Rix <trix@redhat.com>
> ---
>
> Changes since v1:
>  * Align commit message/shortlog with similar changes to pci_ids.h
>
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index f968fcda338e..c119f0eb41b6 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2589,6 +2589,8 @@
>  
>  #define PCI_VENDOR_ID_REDHAT		0x1b36
>  
> +#define PCI_VENDOR_ID_SILICOM_DENMARK	0x1c2c
> +
>  #define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
>  
>  #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8

