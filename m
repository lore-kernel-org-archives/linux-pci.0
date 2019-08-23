Return-Path: <SRS0=Hfoz=WT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C6CC3A5A2
	for <linux-pci@archiver.kernel.org>; Fri, 23 Aug 2019 21:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C282089E
	for <linux-pci@archiver.kernel.org>; Fri, 23 Aug 2019 21:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaU/nqCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388437AbfHWVaZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Aug 2019 17:30:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54259 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388346AbfHWVaZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Aug 2019 17:30:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id 10so10065813wmp.3
        for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2019 14:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4TX/BCsYLA6n54F0SKBuGWPjzRLgxITMCyGGvoS2eHw=;
        b=ZaU/nqCSPN7BSy4Qb3MYvZDHEAZ5veJENMAPyyIKWVxiDBjC0TVcRnLR7Q7R9yX3t/
         Whoz2er8j8XoIBPvo54U35gfxxSKYQxUdH715p1NnI8DaGJW4zWQ8lnNLk76lUA48zNB
         w7WPg1Dpm3PUQ48ZJEt0UAUqzxia3W1l60AgaodklnYeCSdWsn7VclGSICYUBT//YlMW
         qyc9EY84RWzgFoQ7+EGgw0jt4spwGQhJEyaIEWyKSBuIySoSdySVX04obHMpchbvNiTC
         GRU7F0pl8J9OByPIGZmCG6y5KKj2XtF+mr/qdhBiZ4/XjXg/VtBm55E03vz1vhsEkH4u
         OTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4TX/BCsYLA6n54F0SKBuGWPjzRLgxITMCyGGvoS2eHw=;
        b=W0theSvcNzAeKHQeEOBhUzgpbhwuuT6AjqauHAtMrnal4Rom7NAHKIguioLBhl2vKl
         E/9J8qUtUp9BH2MrN6O04pLkwXQBSoIzh11bczOMpsYReERku5LfXhMA62rFH00AY6uC
         VyBO38h62tx0GzKoR6H2mwc5xg/0nkH+k5ZnNXLkQx9OcLdWrMhNcOJ7SJ/m5QzlDm+B
         /90UAlpUrI8O/yOw0ogBna7yt57a/MdYupVv2CIKGB2WdMzLvvxb16a+9raPKfFnSLtp
         b2a/THVdsm8KTowVQqkKoZ8m4EKOfJX3C2KVBKQO+YF8vlq9J9OsQA3t0ulV5dXToYq/
         VlDg==
X-Gm-Message-State: APjAAAUJiQVZQKFjWZg6DlrHF8/GP5YCNLMAEULFpZG+3nFXpie+vXRq
        gXxoa9BpuriHRiHZh8qZSoF9PicS
X-Google-Smtp-Source: APXvYqxKV3lcn649r9Vv7OgZqAiSmho1qRPxXNd4rYzzcibvvoqLX+dKiMy7EI/GEDWvAQBk1YiH7Q==
X-Received: by 2002:a1c:f106:: with SMTP id p6mr6852121wmh.148.1566595823089;
        Fri, 23 Aug 2019 14:30:23 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f04:7c00:79ba:ea77:a36b:1ec0? (p200300EA8F047C0079BAEA77A36B1EC0.dip0.t-ipconnect.de. [2003:ea:8f04:7c00:79ba:ea77:a36b:1ec0])
        by smtp.googlemail.com with ESMTPSA id l15sm2951850wru.56.2019.08.23.14.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 14:30:22 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] PCI/ASPM: add sysfs attributes for controlling
 ASPM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <9e5ef666-1ef9-709a-cd7a-ca43eeb9e4a4@gmail.com>
Message-ID: <32e53ab5-148c-35df-2ac0-f770edc6ae5d@gmail.com>
Date:   Fri, 23 Aug 2019 23:30:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9e5ef666-1ef9-709a-cd7a-ca43eeb9e4a4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23.08.2019 08:11, Heiner Kallweit wrote:
> Background of this extension is a problem with the r8169 network driver.
> Several combinations of board chipsets and network chip versions have
> problems if ASPM is enabled, therefore we have to disable ASPM per
> default. However especially on notebooks ASPM can provide significant
> power-saving, therefore we want to give users the option to enable
> ASPM. With the new sysfs attributes users can control which ASPM
> link-states are disabled.
> 
> v2:
> - use a dedicated sysfs attribute per link state
> - allow separate control of ASPM and PCI PM L1 sub-states
> 
> v3:
> - patch 3: statically allocate the attribute group
> - patch 3: replace snprintf with printf
> - add patch 4
> 
> Heiner Kallweit (4):
>   PCI/ASPM: add L1 sub-state support to pci_disable_link_state
>   PCI/ASPM: allow to re-enable Clock PM
>   PCI/ASPM: add sysfs attributes for controlling ASPM
>   PCI/ASPM: remove Kconfig option PCIEASPM_DEBUG and related code
> 
>  Documentation/ABI/testing/sysfs-bus-pci |  13 +
>  drivers/pci/pci-sysfs.c                 |   6 +-
>  drivers/pci/pci.h                       |  12 +-
>  drivers/pci/pcie/Kconfig                |   7 -
>  drivers/pci/pcie/aspm.c                 | 300 ++++++++++++++++++------
>  include/linux/pci-aspm.h                |  10 +-
>  6 files changed, 254 insertions(+), 94 deletions(-)
> 
Found a functional error during more testing. Will submit a v4 once fixed.
Please disregard this series.
