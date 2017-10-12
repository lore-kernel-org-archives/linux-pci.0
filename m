Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:43258 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752834AbdJLOqZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2017 10:46:25 -0400
Received: by mail-pf0-f179.google.com with SMTP id a8so4680834pfc.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Oct 2017 07:46:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171012144032.GG14672@nanopsycho>
References: <1507815262-33294-1-git-send-email-steven.lin1@broadcom.com>
 <CAJieiUjuKtmYDZ5-7UjYkWFJuMGu2gajhziLQKAZLTz6g63f2A@mail.gmail.com> <20171012144032.GG14672@nanopsycho>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Thu, 12 Oct 2017 07:46:24 -0700
Message-ID: <CAJieiUiFmBr72yYP9VNtm0VBTNjJcA6Lj5nHJNBjDBC4moxE2A@mail.gmail.com>
Subject: Re: [RFC 0/3] Adding config get/set to devlink
To: Jiri Pirko <jiri@resnulli.us>
Cc: Steve Lin <steven.lin1@broadcom.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        michael.chan@broadcom.com, linux-pci@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>, gospo@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 12, 2017 at 7:40 AM, Jiri Pirko <jiri@resnulli.us> wrote:
> Thu, Oct 12, 2017 at 04:35:10PM CEST, roopa@cumulusnetworks.com wrote:
>>On Thu, Oct 12, 2017 at 6:34 AM, Steve Lin <steven.lin1@broadcom.com> wrote:
>>> Adds a devlink command for getting & setting device configuration
>>> parameters, and enumerates a bunch of those parameters as devlink
>>> attributes.  Also introduces an attribute that can be set by a
>>> driver to indicate that the config change doesn't take effect
>>> until the next restart (as in the case of the bnxt driver changes
>>> in this patchset, for which all the configuration changes affect NVM
>>> only, and aren't loaded until the next restart.)
>>>
>>> bnxt driver patches make use of these new devlink cmds/attributes.
>>>
>>> Steve Lin (3):
>>>   devlink: Add config parameter get/set operations
>>>   bnxt: Move generic devlink code to new file
>>>   bnxt: Add devlink support for config get/set
>>>
>>
>>Is the goal here to move all ethtool operations to devlink (I saw some
>>attrs related to speed etc). ?.
>>We do need to move ethtool attrs to netlink and devlink is a good
>>place (and of-course leave the current ethtool api around for backward
>>compatibility).
>
> We need to make sure we are not moving things to devlink which don't
> belong there. All options that use "netdev" as a handle should go into
> rtnetlink instead.
>

Any reason you want to keep that restriction ?.
FWIS, devlink is a driver api just like ethtool is.
and ethtool needs to move to netlink soon...and It would be better to
not put the rtnl_lock burden on ethtool driver operations. Instead of
adding yet another driver api, extending devlink seems like a great
fit to me.
