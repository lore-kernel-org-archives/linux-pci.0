Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A722AC43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 11:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E40E223D0
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 11:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YttAFmvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E40E223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbeKMVL1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:11:27 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43114 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbeKMVL0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Nov 2018 16:11:26 -0500
Received: by mail-io1-f66.google.com with SMTP id t81-v6so8569929iod.10;
        Tue, 13 Nov 2018 03:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7X9I+sSEW/L31dgqKLbg9fJS+e2MQS48lc0SXoFlrZs=;
        b=YttAFmvhDwEhPhlBgprFwtEPieO9LQ1g9PBEPfLWcI2/d0Cv5aI9486gk5tEpSLOwY
         i42paPIb7HRGhgx7eeAyRHZlvxaBIWcB8Or2LmXQQTzlD++aYAJMbPxxfJUJNgTkblVK
         aDtLmto4wSm/Gqqq7ugKc4X1drerFnfZFCZU7aB0o4F0brBtqsaDoF2j0Wp6KiFEVjwJ
         FF8iksUKLPemzNzSh+XHa8UNY4VCm/nCtHIKOUCAAq+7HD7F+KPGS3tLfYzrjsM7xiQI
         qlYP4BH1uuHwW8kzjR6x9LmCwb/CXvfSAPN7COh/lafS9PepJGgYXT18mAYoguBahmKM
         ZZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7X9I+sSEW/L31dgqKLbg9fJS+e2MQS48lc0SXoFlrZs=;
        b=tgdMymJ942Itzq9cESHvQnZCRTmGdUkJ/OubW1wNCyBrpsFWyLhDk57blAW2oeq9dI
         3H2I68qqmW8m9dNzzwRgQoA0JVhKJT7tcQhro79goVx2yYhZjznNnjFCeZ7HzCEkQ8dL
         Kd290oXDn7K5/05+cMgELj3TZoa5xeBDIE5zysQmYpqv1YHxqJCtbwu6fITlpOoNV65x
         wPLn/NaCglM8FwA/pxmeF37AM55lXfMJBG/huAmLTQ4QZhCqsOhI1pkI+/uxPBBsWa8D
         QB0BZLRSdtawqchaHfj8tCnOt2V26iSKn8JW4AEXOdthPGyAgM3QgmDuM9jdTSfjwkjh
         I0Iw==
X-Gm-Message-State: AGRZ1gKd1n9VWdpypSU3V+K/E5XTWt/Y3VyAjQhTY2Ir6O1Eq8DpCdXl
        QzytWWNwLD1a5rqWNxtVD1lM5ZX8Ka9WS+GBm8A=
X-Google-Smtp-Source: AJdET5dBkyqTJBkmH+Bk2CKKFeldBlLIf1OKdEIR/Z28tpwknsKHgu77Qxb2oT80aG+1+WNoP7Dg4Hk+L6/sKK32fLE=
X-Received: by 2002:a6b:d117:: with SMTP id l23-v6mr3636812iob.146.1542107628357;
 Tue, 13 Nov 2018 03:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-5-mika.westerberg@linux.intel.com> <CA+CmpXvZJFk=kYvZybgTtqDWBVP_jSE37tdkQbyGA8U9WOrkoQ@mail.gmail.com>
 <20181113105558.GR2500@lahna.fi.intel.com>
In-Reply-To: <20181113105558.GR2500@lahna.fi.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Tue, 13 Nov 2018 13:13:31 +0200
Message-ID: <CA+CmpXtre+A-sNT0XBWfdkuq9xJ+j34EGZ0nEpahJCSe3Kvg9A@mail.gmail.com>
Subject: Re: [PATCH 4/4] thunderbolt: Export IOMMU based DMA protection
 support to userspace
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org,
        David Woodhouse <dwmw2@infradead.org>,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        jacob.jun.pan@intel.com, Andreas Noever <andreas.noever@gmail.com>,
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

On Tue, Nov 13, 2018 at 12:56 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> > Just one point:
> > Have you considered the option to add this property per (TBT?) device?
>
> No. ;-)
>
> You mean that one device uses security levels and another IOMMU? I don't
> think it is possible without having some sort of table in the IOMMU
> driver telling which devices it needs identity map and which not. Also
> not sure what would be the benefit?

For performance, of course. If some devices are considered safe (maybe a list
communicated by platform firmware), the kernel may decide to configure them to
passthrough the IOMMU (I think I remember there is such an option, but maybe I'm
wrong.)


> > If the kernel may decide to enable/disable the IOMMU or AST per device, maybe
> > it should be on this level.
> > Or maybe the IOMMU decision isn't going to change (it's system-wide) and the AST
> > decision will be communicated per device by a new sysfs attribute anyway, if
> > needed?
>
> Not sure what you mean by "AST"? The IOMMU decision is pretty much
> system-wide.

Sorry, I meant ATS, Address Translation Service, mentioned in patch 3 in this
series, and possibly be enabled for some devices for performance, as mentioned
there.
So if needed, this will be another attribute, and definitely
per-device, isn't it?
