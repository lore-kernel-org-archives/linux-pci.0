Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402BEC32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 22:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0472A2081D
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 22:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7CtkryR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0472A2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbeKGINc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 03:13:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33367 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeKGINc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Nov 2018 03:13:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id q5-v6so6467422pgv.0;
        Tue, 06 Nov 2018 14:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cuHmjx1A8BF8dQNexdUEp9zvx7UxMxK97ejWXuHgZkQ=;
        b=k7CtkryRJy/GnURiIWSiuLDAu869OaIBLXnw6COdrZdL6AOSVqGdA2IJ+/4vZ+42qf
         0gexWwAaO4QPNZZ2NOIhbhvrMSSZPFHBaLj3wajZ0zroFCcHjEGYbU8CkrGBuwiGU7KR
         V7ZSpHerPEAhmhXuxxZ1E6AACdjL3oG479Tpa4vi+M3HwzsEqxqCALsMhxIoSh0Cxmx+
         3/lslEob+fhDHOSnL5lVrIgMx2YivAtrWsMirWEUpmNVjc6ta7Q4xYMgBCn7z0WqRSSu
         lTn1wtimDeHP7WBg4XYk+Nbx84bQ5ZyuYBEOPAafZ8Oy+GSgZ9ZUCyOPIgV47+zd83E/
         cHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cuHmjx1A8BF8dQNexdUEp9zvx7UxMxK97ejWXuHgZkQ=;
        b=Io89jeByAhdpNcm/zs8kwlJdEbW7iFGvPQc7P9l6PrDHytBmG9spF/PEZva/17TSkh
         EA8dam7qHEmEX+aaZRQD8qai1AXvrwRsMb3PFVgQYoTph66LF5cWiGNhXZ3iQnsPe45m
         DouIdi2GQlYpCW4JRot6WPVgaxCwJ5ZlcoQe7111nJAbjbVloAPJUzesDfEvFf2NCUD3
         bdLiGjKp8GmsHgqKm72z2yVzIqVw09LTrprwFtkLtaST2pKRhMy4PI1sh8x3FAMHwM1k
         41tgHCyY+4Z6lZM6ZJY+PYz+aHk1vEV/7FPGOtsJh9dN2Sfb1EsuR2ROqRPDzoNJE3D0
         GjmA==
X-Gm-Message-State: AGRZ1gLWO/Ue9BlXvy+gECDtaPs0QEMe4tqog0D89r6ueAqshWaaBnhi
        RkNicQMcPEwGYkhaoFaSiJ665Sht
X-Google-Smtp-Source: AJdET5cPDp9KSgn9GjShGeZFerxJ8NcWlurLSf9+79Vk97IxkbvfbKV5DXYtjLdVagMTLoJgnW1IWw==
X-Received: by 2002:a62:c5c6:: with SMTP id j189-v6mr28867356pfg.194.1541544360930;
        Tue, 06 Nov 2018 14:46:00 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m7-v6sm52822823pgq.59.2018.11.06.14.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 14:46:00 -0800 (PST)
Date:   Tue, 6 Nov 2018 14:45:59 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Woods, Brian" <Brian.Woods@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Pu Wen <puwen@hygon.cn>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] hwmon: k10temp: add support for AMD F17h M30h CPUs
Message-ID: <20181106224559.GB29024@roeck-us.net>
References: <20181106200754.60722-1-brian.woods@amd.com>
 <20181106200754.60722-5-brian.woods@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106200754.60722-5-brian.woods@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 06, 2018 at 08:08:21PM +0000, Woods, Brian wrote:
> Add support for AMD family 17h model 30h processors for k10temp.  Model
> 30h is functionally the same as model 01h processors (as far as k10temp
> is concerned), just the PCI device IDs need to be updated.
> 
> Signed-off-by: Brian Woods <brian.woods@amd.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/k10temp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index bc6871c8dd4e..9790f1f5eb98 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -360,6 +360,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(pci, k10temp_id_table);
> -- 
> 2.11.0
> 
