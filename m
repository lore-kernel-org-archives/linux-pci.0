Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E5EC43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 16:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C68224E0
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 16:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGg6f+3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C68224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeKMCxZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:53:25 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51612 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeKMCxZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Nov 2018 21:53:25 -0500
Received: by mail-it1-f194.google.com with SMTP id m34-v6so13628328iti.1;
        Mon, 12 Nov 2018 08:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g3aAcVZkUdgrmpGIMCH7ZxaR4fyo0bRUS9BsV8k83H4=;
        b=fGg6f+3v21EyMFVZuxokk8A9DdZMEN9xY6C2TkUM2NCRFaY1IG+Iqaicp7/tIgr8yF
         lW0swmlDqTM5vGSA41Ty3+0ZuO1T9+JgWlc89ABoHlE79nrAdj3tqQGX2a8kvOXDKrhK
         5JCGvI1BCCbhZORxi79kESRsl7GKM13crMuy5SZ6fX24kRNrQzs9agcXPaaXbE3KEYpv
         MBCfCxGZCZNl2vCfKMSn1jFmcj3OASdzwWqRto7erJZe7ZY8NjpOVayKGflKKAvRcxc4
         0athJwcv/ExXX4tqANDFk7iOVK7yk35NG/WQv/r2tU1NxZSXKxbpKK1NFEPdMGLRfmpo
         JPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3aAcVZkUdgrmpGIMCH7ZxaR4fyo0bRUS9BsV8k83H4=;
        b=nsBhCqmM/qGLDxzud6WESR0J64XI90cmfExH998cLQWH2Wlc7UsWkHZUPHg79br9rq
         jhZQ3zHnVO/cPjZWGRCZKrH7abjqvy5GAYfQXusM9KGvVnzww+LsELorzZq7UiVGRI9B
         OaSZJR8/C+34QG8DsO+mSSIQukZsaSORX3gaz2JqjEDRrrySbdBHl0ncDBPiTEkYeaYE
         gNZGnFPazyAFJ27O6bU8tO2NrQiEBKsFHK8VlP/BULyGS4BVLyXoVBLcgdfUiHBXDYGD
         AMU8oaXXnzana+qu9ki94xbN6iVHqUcJn4SpXEzvEwbsSNRyuhRTYVWkOpLWOY6O6kNP
         sRDQ==
X-Gm-Message-State: AGRZ1gIWBkGUIjVzzXD3FA9ppzQ2HtJ+LStmJ6Lgy6xYer2933cQZdyX
        W2xX2kIvae6joeELg7T6LovRqcq587zzuSzJSN0=
X-Google-Smtp-Source: AJdET5eePeQwKjYYiO9xEO2ByS2Jdz+xDr0c9R0xwPtNT4mQ2eGywat7ZltscHjm7CjiUdONaw+h15j02QRMIIVbl+c=
X-Received: by 2002:a24:a0cb:: with SMTP id o194mr377282ite.115.1542041959430;
 Mon, 12 Nov 2018 08:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com> <20181112160628.86620-5-mika.westerberg@linux.intel.com>
In-Reply-To: <20181112160628.86620-5-mika.westerberg@linux.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Mon, 12 Nov 2018 18:59:02 +0200
Message-ID: <CA+CmpXvZJFk=kYvZybgTtqDWBVP_jSE37tdkQbyGA8U9WOrkoQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] thunderbolt: Export IOMMU based DMA protection
 support to userspace
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, ashok.raj@intel.com,
        bhelgaas@google.com, rjw@rjwysocki.net, jacob.jun.pan@intel.com,
        Andreas Noever <andreas.noever@gmail.com>,
        michael.jamet@intel.com, lukas@wunner.de,
        Christian Kellner <ckellner@redhat.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 12, 2018 at 6:06 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Recent systems shipping with Windows 10 version 1803 or later may
> support a feature called Kernel DMA protection [1]. In practice this
> means that Thunderbolt connected devices are placed behind an IOMMU
> during the whole time it is connected (including during boot) making
> Thunderbolt security levels redundant. Some of these systems still have
> Thunderbolt security level set to "user" in order to support OS
> downgrade (the older version of the OS might not support IOMMU based DMA
> protection so connecting a device still relies on user approval then).
>
> Export this information to userspace by introducing a new sysfs
> attribute (iommu_dma_protection). Based on it userspace tools can make
> more accurate decision whether or not authorize the connected device.
>
> In addition update Thunderbolt documentation regarding IOMMU based DMA
> protection.
>
> [1] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

I can't comment on the IOMMU side, but the Thunderbolt side looks good to me.

Just one point:
Have you considered the option to add this property per (TBT?) device?
If the kernel may decide to enable/disable the IOMMU or AST per device, maybe
it should be on this level.
Or maybe the IOMMU decision isn't going to change (it's system-wide) and the AST
decision will be communicated per device by a new sysfs attribute anyway, if
needed?
