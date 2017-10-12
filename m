Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:49902 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752697AbdJLOwA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2017 10:52:00 -0400
Received: by mail-vk0-f52.google.com with SMTP id h191so2814273vke.6
        for <linux-pci@vger.kernel.org>; Thu, 12 Oct 2017 07:52:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+Jmh7GOo4K8gpyhQ8kceFtpNuASp89WYi0NR8AaoXncTCAksQ@mail.gmail.com>
References: <1507815262-33294-1-git-send-email-steven.lin1@broadcom.com>
 <CAJieiUjuKtmYDZ5-7UjYkWFJuMGu2gajhziLQKAZLTz6g63f2A@mail.gmail.com> <CA+Jmh7GOo4K8gpyhQ8kceFtpNuASp89WYi0NR8AaoXncTCAksQ@mail.gmail.com>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Thu, 12 Oct 2017 07:51:57 -0700
Message-ID: <CAJieiUiwx+1J9eUvw7woviALNDyFDEJGPfgGjjbph+xBP6xV_g@mail.gmail.com>
Subject: Re: [RFC 0/3] Adding config get/set to devlink
To: Steve Lin <steven.lin1@broadcom.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        linux-pci@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>,
        Andy Gospodarek <gospo@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 12, 2017 at 7:45 AM, Steve Lin <steven.lin1@broadcom.com> wrote:
> Hi Roopa,
>
> The attributes added in this patchset are not really the same type as
> ethtool - these are more device configuration type attributes.  The
> speeds you saw, for example, affect the pre-OS [i.e. PXE boot time]
> configuration for a port, and aren't run-time speed changes on a given
> netdev like ethtool configures.  As Jiri mentioned, I will add some
> comments to better describe each of the attributes.
>
> So I don't think there's much duplication here with ethtool.
>
> That said, there also shouldn't be anything in the patchset that would
> preclude some future migration of ethtool settings to using devlink or
> rtnetlink API.
>

ok, ack, thanks for the clarification. Just trying to find a best
netlink place for future ethtool migration to netlink.
