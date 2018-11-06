Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2992C46464
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 02:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A375D2084F
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 02:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A375D2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeKFMR2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:17:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53577 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeKFMR2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Nov 2018 07:17:28 -0500
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1gJrVf-0001Eq-Nd
        for linux-pci@vger.kernel.org; Tue, 06 Nov 2018 02:54:31 +0000
Received: by mail-wr1-f72.google.com with SMTP id u8-v6so9887336wrn.17
        for <linux-pci@vger.kernel.org>; Mon, 05 Nov 2018 18:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xNOsWxgn4zw7OJBbph1j4tCIxnQJdW3RPTNLp9mD2LY=;
        b=gPa9tF0rF8104dC0dk64EBAMs1FthfQhB/weueqhldQ4DPYV0eWfBkTsKO++LZlYtt
         lI8ONhDAkMJcumH55o6fdlDT8H1MufoQPN8DSzg9zFI/SGDO8X+GQiQyuO/nBtbq3LrD
         YpipoexEJo9H4FDMlgUpBLVbpsLPubSsxpvW/TleCM7ZN5enS934xFGSyP+a/6Rz2nJu
         +lAFBugU6BmMqighlj3q13ruFSWqdv50EOyskyP+lL5W+WJClTtfvf6YD9b5iHE1t6yB
         7MOgweKtNnEtIQDPSK5Z9D6j7ffXARIYVOvUEOmrXdvvlR8wWUmf79f8qb4+0GQQ4XNa
         dDpA==
X-Gm-Message-State: AGRZ1gKs/Zs6oeDou1nUIB3HKVvuJBEJeEfBgGEdngZyonLXE5D9reNh
        mGdaWHXJ5UxrvQ2PNLmh0JtgOJ1PaKJ6qOmkh2eH3HdzW7j77aTi+jDS/TyOD9jGPGC07Ppb9Ac
        1F1tbJR2WhD20DTtwLy0Ud3kKsiqj4IbPPKX7JsfJ1HR0s67ezUt90g==
X-Received: by 2002:a5d:6b0f:: with SMTP id v15-v6mr20460192wrw.53.1541472871360;
        Mon, 05 Nov 2018 18:54:31 -0800 (PST)
X-Google-Smtp-Source: AJdET5eiYFU3pSmIs2QfY9hakAGEnNfW2xuqIJn+ML+ruevMsJnxkmz7AGv7JZuK/cMJoblBhKMDoXBUjD7Z5MfJHkw=
X-Received: by 2002:a5d:6b0f:: with SMTP id v15-v6mr20460178wrw.53.1541472871067;
 Mon, 05 Nov 2018 18:54:31 -0800 (PST)
MIME-Version: 1.0
References: <20181106020402.21120-1-acelan.kao@canonical.com>
 <20181106020402.21120-2-acelan.kao@canonical.com> <733fc135-dfef-f70e-b854-3ad553c67e9b@kernel.org>
In-Reply-To: <733fc135-dfef-f70e-b854-3ad553c67e9b@kernel.org>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Tue, 6 Nov 2018 10:54:19 +0800
Message-ID: <CAFv23QnZcwgfKX-i-_ekB=0XbCQ5uNkdFXupNC=-DQwKJP5B9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: add quirk to not call disable function when suspending
To:     okaya@kernel.org
Cc:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-nvme@lists.infradead.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Right, should replace it with SK_HYNIX.
I'll prepare v2 patch for that.
Sinan Kaya <okaya@kernel.org> 於 2018年11月6日 週二 上午10:24寫道：
>
> On 11/5/2018 6:04 PM, AceLan Kao wrote:
> > +     { PCI_DEVICE(0x1c5c, 0x1527),   /* Sk Hynix */
> > +             .driver_data = NVME_QUIRK_NO_DISABLE, },
>
> Now that you added PCI_VENDOR_ID_SK_HYNIX to pci_ids.h, you
> could use PCI_VENDOR_ID_SK_HYNIX above instead of 0x1c5c.
