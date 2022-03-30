Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA0BC433EF
	for <linux-pci@archiver.kernel.org>; Wed, 30 Mar 2022 19:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiC3Tsq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiC3Tsq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 15:48:46 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BFC49F1E;
        Wed, 30 Mar 2022 12:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=CMbbjnM43Gr802NWsXoCyzXb/ynVAJPf7yl3CMJlxac=; b=Srh+L6VzOXgKRruO0h9JeVufyU
        1Oe6W1eUdtWxeHQ7NcxMcMW5ZmzbarKGeLsWMs97WRo1DaZFW5Rc/B/BYx5KOJ3X4LtxChcPWCHbx
        NSx1RcVB5EUWwM8PlvznBuC1sMd4+R41dE+vbOlyGEnFaIUgth7ThV8KteUUnJyX4RMpRangmQEVo
        v9usJCzAwkyScZywpzCi7c5s8guOT1pI/DKcpm1fSoR2x+f8nwsEfP3YLJ/FA+EY0JoQ+036zk9sM
        pQ/lZrkQBA1zZJZ6DbRbWx5oOX4bWXsYLoPfuSkVmw7V8VEa9XgEkmPwC+ylaKx+6pGqwHPwQVnHq
        ghqXaMXQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nZeHP-00D7gg-Bp; Wed, 30 Mar 2022 13:46:56 -0600
Message-ID: <363307ae-bfc9-9c24-0b1c-39e09663dbb4@deltatee.com>
Date:   Wed, 30 Mar 2022 13:46:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-CA
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Shlomo Pongratz <shlomopongratz@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.maier@eideticom.com, bhelgaas@google.com,
        Shlomo Pongratz <shlomop@pliops.com>
References: <20220330153720.GF1716663@nvidia.com>
 <20220330191017.GA1700536@bhelgaas> <20220330191145.GE2120790@nvidia.com>
 <671cb318-5f4e-4372-d0ef-45be83bdf0b9@deltatee.com>
 <20220330193832.GF2120790@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220330193832.GF2120790@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: jgg@nvidia.com, helgaas@kernel.org, shlomopongratz@gmail.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, andrew.maier@eideticom.com, bhelgaas@google.com, shlomop@pliops.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH V4 1/1] Intel Sky Lake-E host root ports check.
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-03-30 13:38, Jason Gunthorpe wrote:
> On Wed, Mar 30, 2022 at 01:36:25PM -0600, Logan Gunthorpe wrote:
> 
>> Checking simply for PCI_EXP_TYPE_ROOT_PORT instead of a zero devfn is
>> probably a good idea, assuming it works for all existing systems. I'd
>> expect it would be set for all the devices currently allowed.
> 
> I think if we find a PCI ID in the white list as we go up the PCI
> hierarchy we should just declare success?

Well, in older hardware we also have to ensure that the devices are on
the same host bridge. (See REQ_SAME_HOST_BRIDGE). So it's a bit more
complicated than that...
> Does it matter if it is the top of the tree or if it is a root port or
> host bridge? The IDs in this list only exist as part of SOCs, so
> seeing them at all should confirm the whole SOC..

Not sure if that will always hold with multi-socket systems. The code
currently uses pci_find_host_bridge() for each device, then uses
pci_host_bridge_dev() simply to find identifying information about the
host bridge. It doesn't really matter where in the tree things are, but
it would be add for the host bridge not to be at the top, I would have
thought.

Logan
