Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9947BC43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 22:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A3B218D9
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 22:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IdH4smVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfBZWmF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:42:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34957 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfBZWmF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Feb 2019 17:42:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id t18so15781814wrx.2
        for <linux-pci@vger.kernel.org>; Tue, 26 Feb 2019 14:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpITyZB4wxpijtZ/zOHmsaypXxucYisbMh699JUoAKc=;
        b=IdH4smVvAMJ9QChWcagr6I8XWdA8kh1PY2XC7SrCQOqgarR8Wz7IKfkbpYnNWtXPYB
         v6Qv8UpJXkH7uDuZqvOHvjmOyvQUv+3aA69tw/zc5UrCQA7IJTUp+tG1AFub11EZmFAG
         ntHuqkL1liKPV8eKoulTjvpEi9rXq0wpP0HhTbyoR0LThC6x0kTRrHiL9LzbCw06Cpob
         QRjfyGwOJrJy+YXSlisKhi19c0Edd1v7SWrLI7XJrxbXoz89wZmO8UQTV8soDrx1EVaN
         QY1mAIrADEG88bGt2AaiuX++TceMSWh19KzC7xzOxB52k77WojYMlsoJtlx3R2SrPaSN
         1U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpITyZB4wxpijtZ/zOHmsaypXxucYisbMh699JUoAKc=;
        b=ogTQ9hb/QHj+ku+T/nCtwsor4W6VplHGdyd8AmQBadbrU7zh3uma2/DfzxOkteTFEa
         hqVDvCYYk4yxff49qi2S7bvgGzZ1edQS3YQN2eCBnfMiXmAKGz1CblOt1GinnPto6DUY
         zWduBM89HvXn6Bz5epWjaUz9oBgmi35nxJVpD4LA5LRWty7GCMjXGCJadCsLD1z+c6uf
         dqyCDhZORTJ79gJUMxKDaAs4ySXUew7ndmwqqpqOEoV7TGYXsuMufSb6xuW+NgrZltyz
         2cYtc4hzbg/EJjtagzav9oM1A8cCwZu9UKJHEaonEo+qzMCg+Spo9HH8ww6I7TZii8KK
         Plmg==
X-Gm-Message-State: APjAAAVxP1Be+5CO5c96Fc1Rv2HEZrdDUMBG4UULmyOit5U3NxQquTqK
        YaBkJIfDdn7hZXxgKEbxNNQ47EcgQkycwjgXYXar
X-Google-Smtp-Source: APXvYqxoCGHEJKPtwGehvCHgLNcy1pD12eV+X822eNqA3rLqcc7jZcxoo1LS7lsmg+jbmUmsQD6liFv5O6exOEDEfMs=
X-Received: by 2002:adf:9b11:: with SMTP id b17mr37652wrc.168.1551220923963;
 Tue, 26 Feb 2019 14:42:03 -0800 (PST)
MIME-Version: 1.0
References: <4d8bf501-e367-917d-c808-d1938edaf007@gmail.com>
In-Reply-To: <4d8bf501-e367-917d-c808-d1938edaf007@gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 26 Feb 2019 16:41:52 -0600
Message-ID: <CAErSpo6h27cSn3aQuH_WPUZ_tGMc4UsLhSo3oRyZ23U5rGb59Q@mail.gmail.com>
Subject: Re: Disabling ASPM L1 sub-states selectively from drivers?
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Heiner,

On Fri, Feb 22, 2019 at 12:16 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> I face the issue that a PCIe network chip misses RX packets if ASPM L1
> sub-states are enabled. It seems that the RX FIFO is too small to buffer
> all incoming packets during ASPM exit latency.
>
> So far pci_disable_link_state() only allows to disable L1 completely.
> Would it make sense to extend this function to allow disabling
> L1 sub-states selectively? Looking at pcie_config_aspm_link() this
> seems to be possible.

We could certainly explore the option of selectively disabling L1 substates.

But before we do that, let's look at a couple things, because there
are some Linux issues in that area, and it's possible we could make a
generic fix that wouldn't require disabling the substates completely.

One problem is the ASPM L1.2 state depends on LTR information, and we
don't support LTR correctly.  There are a couple patches in -next to
fix some problems, but we still don't handle cases where the BIOS
doesn't program the LTR latencies and the LTR_L1.2_Threshold.

Can you open a report at bugzilla.kernel.org and attach the complete
dmesg log (booted with "pci=earlydump") and the "sudo lspci -vvvxx"
output?

Have you figured out which L1 substate specifically causes problems?
If not, maybe we can use setpci to fiddle with things manually and
narrow it down.

Bjorn
