Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:55196 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbdJLTGv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2017 15:06:51 -0400
Date: Thu, 12 Oct 2017 12:06:50 -0700 (PDT)
Message-Id: <20171012.120650.1063812043202847517.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: jiri@resnulli.us, roopa@cumulusnetworks.com,
        steven.lin1@broadcom.com, netdev@vger.kernel.org,
        jiri@mellanox.com, michael.chan@broadcom.com,
        linux-pci@vger.kernel.org, linville@tuxdriver.com,
        gospo@broadcom.com
Subject: Re: [RFC 0/3] Adding config get/set to devlink
From: David Miller <davem@davemloft.net>
In-Reply-To: <24E5DE7C-A401-48BF-BF80-673ACC38FBBE@gmail.com>
References: <CAJieiUiFmBr72yYP9VNtm0VBTNjJcA6Lj5nHJNBjDBC4moxE2A@mail.gmail.com>
        <20171012150419.GI14672@nanopsycho>
        <24E5DE7C-A401-48BF-BF80-673ACC38FBBE@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 12 Oct 2017 08:43:59 -0700

> Once we move ethtool (or however we name its successor) over to
> netlink there is an opportunity for accessing objects that do and do
> not have a netdevice representor today (e.g: management ports on
> switches) with the same interface, and devlink could be used for
> that.

That is an interesting angle for including this in devlink.

I'm not so sure what to do about this.

One suggestion is that devlink is used for getting ethtool stats for
objects lacking netdev representor's, and a new genetlink family is
used for netdev based ethtool.

I think it's important that we don't expand the scope of devlink
beyond what it was originally designed for.
