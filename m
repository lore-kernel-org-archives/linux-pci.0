Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BB9C43613
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 13:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4E5217D4
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 13:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867478;
	bh=fZX/Ea7Mjkw2SS6Dj9Ri0jUuqrc9UJGeuII7pD0YV+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qSVJByROou5euU/nvjaIDF45mtGZCIvbwLXp8IK4SJC/FqduBxkpUVyU9qla59vAA
	 sPDNfV8jaF7ZqhCfkTmzAtKTriYeVOZiGM4IGjHX2lA7ldxYgzYl7N/DYwkfu0cjrO
	 rPD3Tm1+NbmWu3IE5UL0PQNBCXG6w6CoYI+O9WxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfAGNYh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:24:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbfAGNYg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jan 2019 08:24:36 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 816C421736;
        Mon,  7 Jan 2019 13:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546867475;
        bh=fZX/Ea7Mjkw2SS6Dj9Ri0jUuqrc9UJGeuII7pD0YV+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vh4EG9mLn1VzVQSIbPRoUtTZ/hZjFYOHyyHtOKZJDutQdx4GB74PlVlkI9Yilb+UA
         BFtNwFYRzh6ealnndcOeZKTpG5P65BVs3SSutP4BMZYWKBBF4BUsHqFKTb9mJtC2kM
         u8AyeOeblb5oL8fnb84taWX0rLIv5I0K8sfAjl5o=
Date:   Mon, 7 Jan 2019 07:24:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Koen Vandeputte <koen.vandeputte@ncentric.com>
Cc:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-pci@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
        Robin Leblon <robin.leblon@ncentric.com>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm: cns3xxx: fix writing to wrong PCI registers after
 alignment
Message-ID: <20190107132434.GA113458@google.com>
References: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
 <20181230010625.GC159477@google.com>
 <m336qegfzv.fsf@t19.piap.pl>
 <20181231152918.GE159477@google.com>
 <a7531ef2-d6d0-0a48-1558-23474c97b838@ncentric.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7531ef2-d6d0-0a48-1558-23474c97b838@ncentric.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 07, 2019 at 09:58:42AM +0100, Koen Vandeputte wrote:
> On 31.12.18 16:29, Bjorn Helgaas wrote:
> >    1) The current one that corrects the address alignment error, and
> Is it required to resend this specific patch?

It's easier if you resend this patch along with the other.  When I
suggest changes to a patch, I mark it (and the whole series if it's
part of a series) as "changes requested" in the patchwork patch
tracker.  That means it falls off my to-do list until the resend
happens.

> >    2) A new one that converts cns3xxx_pci_read_config() to use
> >       pci_generic_config_read() instead of pci_generic_config_read32().
> I'll first extensively test non-32b reads later today and will send a patch
> for it

Perfect, thanks!

Bjorn
