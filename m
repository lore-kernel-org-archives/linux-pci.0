Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6610FC32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 10:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381E32086C
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 10:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381E32086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387818AbeKFTgP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:36:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33758 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387505AbeKFTgP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Nov 2018 14:36:15 -0500
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1gJyKm-0004lT-By
        for linux-pci@vger.kernel.org; Tue, 06 Nov 2018 10:11:44 +0000
Received: by mail-wm1-f72.google.com with SMTP id t130-v6so7355785wmt.3
        for <linux-pci@vger.kernel.org>; Tue, 06 Nov 2018 02:11:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PUui6sP1fLcHKzDuyJuwFHTOJ60QrXWUrQhVips0rJM=;
        b=fr/OtApToJs4KP71SRHL6jwOU0pds/EENdDnvle3q9/7HhNvFxJ6zSI15TD58cObED
         mRVyELjzIw+h453xxI+/wSR68swvduVZmJvHgBfyV6omb6XjlC7CNlAT0azvmSh3Nn65
         6i+IHvl9wwY69izktev/tTqaqzNxZxtYQEhhsof4F2xbiiAZt7pf3ape3OulX4nKtSz2
         UwmB/WIdwHjES4IXnDet3CVzI1cHIC6GWn4Me2jvWualUPm7QCmst34MFPGqHqlxpWVB
         Q5gR0zCj/SWOdh9M90bb9pck1BgqD/eMnCsiSsxom62SJQZb42ksoCJrwDh/yNlJ43rH
         kqPg==
X-Gm-Message-State: AGRZ1gK2SlhATByLrgPx/D/lV45pDA35B8fkTVkY240eL1pw6LwKGRxX
        gyQnYdzv4vZR2qeScEU7e3SViyGKeJlbubxcoHDJ6i6As0Ci0M1b5RDVDOj6IOBPeiQjbA5SyVI
        tE4hRI1lOmz7NjjhuuC9ECBpjNC1g3UT72giIYivQZqxYaK2tzqXm0A==
X-Received: by 2002:a1c:af07:: with SMTP id y7-v6mr1490618wme.12.1541499103637;
        Tue, 06 Nov 2018 02:11:43 -0800 (PST)
X-Google-Smtp-Source: AJdET5dYox34lppnWbbVk8zWcpDCgjzKZPQFfqMXvH9419TO4MDhuu3Kx8/KM140txkvGGFrpqhtGThNXbSZ+/8ttwA=
X-Received: by 2002:a1c:af07:: with SMTP id y7-v6mr1490589wme.12.1541499103239;
 Tue, 06 Nov 2018 02:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20181106020402.21120-1-acelan.kao@canonical.com> <20181106071011.GA23935@infradead.org>
In-Reply-To: <20181106071011.GA23935@infradead.org>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Tue, 6 Nov 2018 18:11:31 +0800
Message-ID: <CAFv23QmK-BPNLcy9UTuYjF=Jv_xOUFj5dTTem9r-dfijb4WQ8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] pci: prevent sk hynix nvme from entering D3
To:     Christoph Hellwig <hch@infradead.org>
Cc:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-nvme@lists.infradead.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, victor.chang@sk.com, james.chen@sk.com,
        Chih-Hsyuan Ho <chih.ho@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Christoph Hellwig <hch@infradead.org> 於 2018年11月6日 週二 下午3:10寫道：
>
> On Tue, Nov 06, 2018 at 10:04:01AM +0800, AceLan Kao wrote:
> > It leads to the power consumption raises to 2.2W during s2idle, while
> > it consumes less than 1W during long idle if put SK hynix nvme to D3
> > and then enter s2idle.
> > >From SK hynix FE, MS Windows doesn't put nvme to D3, and uses its own
> > APST feature to do the power management.
> > To leverage its APST feature during s2idle, we can't disable nvme
> > device while suspending, too.
> >
> > BTW, prevent it from entering D3 will increase the power consumtion around
> > 0.13W ~ 0.15W during short/long idle, and the power consumption during
> > s2idle becomes 0.77W.
>
> Please get this fixed in firmware.  And yes, depending on which Windows
> driver you use Windows might be doing very agressive runtime D3, which
> is parted of Windows modern standby, so it'll trip up there eventually
> as well.
Agree, this is not a good fix for Sk hynix nvme, so Dell is still pushing
Sk hynix to fix it from firmware.
But before the firmware is ready, this is still a issue that need to be fixed in
kernel side, and the new firmware may not be applied on the old nvme
modules.
This list won't keep growing, and we'll keep an eye on the new firmware and
co-work with engineers from Sky hynix to make sure this issue won't happen
again.
