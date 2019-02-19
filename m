Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C1FC43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 00:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B8821773
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 00:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550534899;
	bh=X3VBKXBAOBPky4zMsaW1/9QUCbvxNjrOkI1WWSqxC+A=;
	h=From:Subject:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=Jq0qLRyzE6UIBB6joZPUKtYEcpwrDK+cpdDDCSjzFh07WM6kiMeJDGkdSGD2YoHAl
	 jnC1OE9wR1hFjTywix3HB9t+KEBQAN4mowzvKpIt2uPNYquRbuZSRYTjUd/chu6Wgx
	 ID12dPQ9CxGidrkw3l3uLnOy/p4kMmmwueUiV8yc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbfBSAIS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:08:18 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36404 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfBSAIS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Feb 2019 19:08:18 -0500
Received: by mail-yw1-f66.google.com with SMTP id 189so7122094ywi.3;
        Mon, 18 Feb 2019 16:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+OZALxJNBSk1uYmNcQIYHWKfzKTwTGj5CLqfaNJQHZU=;
        b=QVcu14V4Py6k//O+3AFg4ym2eh5wWWw8A+BPAjA+OkZeCwtXyDOPerM7jYmyA8oYef
         r1V8wgHHCI1LOhoi69dlhPCt2MmnI/0MVPmNp/5GIC6OWF1lvAFdWp/fNF4RcPI2DGGh
         DfzmHYMgpB4T1q7FNTxmE/xZ5bcGSzYRuuMe4et0Z2FE1HQtYN5SByjW+8ZSHKAOr5aY
         DrFGA68AhukdVdVIaM+pjef5EEN/aw/JoJWUcakz4a/ihVIhNCn6G0TxHVFT0aH2AVvw
         1tOxVErbqSUHLLWMHbyNokTIWtqOIolTSHtCYpTOf67ZKTGeTHyj2R3W2X8/b62gHoUs
         L3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+OZALxJNBSk1uYmNcQIYHWKfzKTwTGj5CLqfaNJQHZU=;
        b=F/80CZh2bM7L3vKUbfBIg8fKs/rPVslERYe0Rh2HowJNK9eOmFaXBs/CJvmyv0oy8t
         7vDZaS0LYY0yLjjFZGfPN+QgET6fiL/T86S5Bn4ho6HTKQo5lwP8kTfw29yqc3v7J6tU
         YV0qGS0vgo+9KBeAzzb6/xmiGnBs52zrGu7DYbwvoRv5Q8jwniP7/SKwJxLoRJvMPbBw
         /u714onvQr/ZykSUqp5zpn10OR/Yhj3cA45Emsq8/iDdmYZL/j2Itc6nWMuCQSdCCbGO
         0L+NuiJqRUlaAhIBZ4tdxuvTOl7lkqMwNqQNT/hG7ONt8bcrnDSVRezje2Bf8wVbFT6L
         NrqA==
X-Gm-Message-State: AHQUAuZtRdtpEa+yKHXXQaOeafNR15USqq3SKYwVzEhpcUVm5nzJPoGT
        FJ4l42yEkc0BGQAbxvmUlVs=
X-Google-Smtp-Source: AHgI3IYR0aCMca0uXGQ0efyGvYp6NeX7pDhRAQ5efcR8Mg9Q+V0YJtvl9dDXU7TI2BMZt2raMUlsRQ==
X-Received: by 2002:a0d:d4d6:: with SMTP id w205mr14350175ywd.103.1550534897690;
        Mon, 18 Feb 2019 16:08:17 -0800 (PST)
Received: from [192.168.0.111] (cpe-174-109-247-98.nc.res.rr.com. [174.109.247.98])
        by smtp.gmail.com with ESMTPSA id e3sm5913381ywe.33.2019.02.18.16.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 16:08:16 -0800 (PST)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v2] PCI: Fix "try" semantics of bus and slot reset
To:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com, hch@lst.de,
        myron.stowe@redhat.com
References: <155051908423.10656.10601490787034368635.stgit@gimli.home>
Message-ID: <70f40fdb-5a11-4688-c38b-b9372fdc58f5@kernel.org>
Date:   Mon, 18 Feb 2019 19:08:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <155051908423.10656.10601490787034368635.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/18/2019 2:46 PM, Alex Williamson wrote:
> The commit referenced below introduced device locking around save and
> restore of state for each device during a PCI bus "try" reset, making
> it decidely non-"try" and prone to deadlock in the event that a device
> is already locked.  Restore __pci_reset_bus() and __pci_reset_slot()
> to their advertised locking semantics by pushing the save and restore
> functions into the branch where the entire tree is already locked.
> Extend the helper function names with "_locked" and update the comment
> to reflect this calling requirement.
> 
> Fixes: b014e96d1abb ("PCI: Protect pci_error_handlers->reset_notify() usage with device_lock()")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---

Reviewed-by: Sinan Kaya <okaya@kernel.org>
