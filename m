Return-Path: <SRS0=1R7R=UF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E370EC28D1C
	for <linux-pci@archiver.kernel.org>; Thu,  6 Jun 2019 08:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4E020866
	for <linux-pci@archiver.kernel.org>; Thu,  6 Jun 2019 08:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559811294;
	bh=zMQRRmr97Ya/I/+CQ/BKE8FZwALcCEktLUrFQxpD7Es=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2nBgss2PpWg9sOpiX/LXi/37MXxAz43BsplQn/HC6BXtu6vJrjhQNNil0MB9x1qy1
	 j97Mm2hnSpwY0WenDqB6Bt0CQQL7lUro9wJ9jLmRnC9Cb35r7Wk/RKnKaDjl5YrbJf
	 RsJGMnDIhCWlwCDb44Vpq2vrrs24gxyyrLKPjumw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfFFIyy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:54:54 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45105 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfFFIyy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 04:54:54 -0400
Received: by mail-oi1-f196.google.com with SMTP id m206so1000437oib.12;
        Thu, 06 Jun 2019 01:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnbnhMxsZs4dx92it5UfNw/Rc2l0benHICZRoQ84E/w=;
        b=KkxgDbU3kFm3xFWPR1tfRcfGD4TAsx5rGfeyZRPdXmuc/meThpMpLglxVW9OiGTQ29
         pIv+ZjrEtXM9jdz8f5qsvWb8C3eI9mvAEEm1oUaqarnWunvR0nB83mYeNVtfapeVg6ta
         8l2aSmYuavZv3uGAt01vO9wv/Ei3AD8aGo9y5T95EQJS5fSBfxvrJqW7W6tgi3mcfcFM
         XHlRckknrscxWVAC89efMCNG8tWIXeL2KkiUwQ4YNiRhvPMDg4iHafflSlAMzH9+NWzt
         ZlzGu3Wj7tjfAaWA0Kak3pyBD8wgTTPKGOTPpLbTaydIXdSvA2uUA+rluQOOwKHwgFG2
         Hbyw==
X-Gm-Message-State: APjAAAWspXSoDKtmYjrzrJuG0UiI2jMM+FODZkp268K20RYgVZaN3yvT
        fJtCCgza/UeD4soTU1gBApn3NkDDvANkTyIhxy8h3Q==
X-Google-Smtp-Source: APXvYqzUP6KPESKe0BBP7i26M6tHRBWmHyRKvI03SDZ/5eli3BhHIvvDy2vNWqHe4fo2eqOp3T8aIz10/wCFEg/7okI=
X-Received: by 2002:aca:5b43:: with SMTP id p64mr11113922oib.68.1559811293096;
 Thu, 06 Jun 2019 01:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190605145820.37169-1-mika.westerberg@linux.intel.com> <20190605145820.37169-4-mika.westerberg@linux.intel.com>
In-Reply-To: <20190605145820.37169-4-mika.westerberg@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Jun 2019 10:54:40 +0200
Message-ID: <CAJZ5v0iGu8f6H68082RGDmDCQsmQZNTULLwnb5JzpKA7m1QvVA@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI / ACPI: Handle sibling devices sharing power resources
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 5, 2019 at 4:58 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Intel Ice Lake has an interated Thunderbolt controller which means that

integrated

> the PCIe topology is extended directly from the two root ports (RP0 and
> RP1). Power management is handled by ACPI power resources that are
> shared between the root ports, Thunderbolt controller (NHI) and xHCI
> controller.
>
> The topology with the power resources (marked with []) looks like:
>
>   Host bridge
>       |
>       +- RP0 ---\
>       +- RP1 ---|--+--> [TBT]
>       +- NHI --/   |
>       |            |
>       |            v
>       +- xHCI --> [D3C]
>
> Here TBT and D3C are the shared ACPI power resources. ACPI _PR3() method
> returns either TBT or D3C or both.
>
> Say we runtime suspend first the root ports RP0 and RP1, then NHI. Now
> since the TBT power resource is still on when the root ports are runtime
> suspended their dev->current_state is set to D3hot. When NHI is runtime
> suspended TBT is finally turned off but state of the root ports remain
> to be D3hot.

It looks like this problem will affect all ACPI devices using power
resources and _PR3 in general, so fixing it just for PCI is not
sufficient IMO.

An alternative approach may be to set the state of a device that
dropped its references to power resources listed in _PR3 to D3cold
even though those power resources may be physically "on" at that time.
Everything else (including this patch AFAICS) will be racy this way or
another.
