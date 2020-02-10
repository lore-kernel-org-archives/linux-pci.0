Return-Path: <SRS0=tm3/=36=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F7EC352A4
	for <linux-pci@archiver.kernel.org>; Mon, 10 Feb 2020 23:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7612082F
	for <linux-pci@archiver.kernel.org>; Mon, 10 Feb 2020 23:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581376882;
	bh=5KjlqCgeH01O+i+H5DAYNe8/x8VySwQHzIa2aaxRFVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=mtQ8YqgTZIqMFbdUozdLWqd8FhkKL/5m/+QhhY/ZHulCGpwD+z9miGuNp4tIYvnF7
	 UUP7kAe893l5hqHYQ7SDrAfGYWMZHgL53dwmJXUcN+XB25RWCb8GiebeqCWNSad+tE
	 /p1DyPvFmhMwmlmO3eHp6bPVJyIucMJDWudMP5WQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJXVV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Feb 2020 18:21:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbgBJXVV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Feb 2020 18:21:21 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88E6B20733;
        Mon, 10 Feb 2020 23:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581376880;
        bh=5KjlqCgeH01O+i+H5DAYNe8/x8VySwQHzIa2aaxRFVo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XAwUr7i+dxxSa0/RvqdM3XJfq+6ShPin4IUCxQl/Xct0glQlzMRIe56bfODmDmHMJ
         QI5QULvia6U8mmt64BKKvLrx8KLRcRfSlnValYZUREW92GW68gIL6oURc4MpGLV56e
         DJOhp3szWvsUszKiQhJjmJojZiTDtBGpqKrF739U=
Date:   Mon, 10 Feb 2020 17:21:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH v2] PCI: pciehp: Make sure pciehp_isr clears interrupt
 events
Message-ID: <20200210232118.GA82108@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200209125543.k7u5y6omptbpmwo6@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 09, 2020 at 01:55:43PM +0100, Lukas Wunner wrote:
> On Tue, Jan 28, 2020 at 06:51:51PM -0600, Bjorn Helgaas wrote:

> > I see that Lukas took a look at this earlier; I'd really like to have
> > his reviewed-by, since he's the expert on this code.
> 
> Hm, should we add an entry for pciehp to MAINTAINERS and list me as R: or M:?

That'd be great.  I would certainly apply a patch like that, but I don't
want to presume by generating it myself.

Bjorn
