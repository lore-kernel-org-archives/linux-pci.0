Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9463C433EF
	for <linux-pci@archiver.kernel.org>; Wed, 20 Apr 2022 06:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiDTGP0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Apr 2022 02:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiDTGPZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 02:15:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD7438BDB;
        Tue, 19 Apr 2022 23:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 933D6617A6;
        Wed, 20 Apr 2022 06:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E02BC385A0;
        Wed, 20 Apr 2022 06:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650435158;
        bh=WVGG7i7RxhHHQNRBovCW+Qms3Ms+pejmIVgG7d9LX8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vEMeLCZ8yxtIx+gu0H1ZQYXS8a3Hrm65sCkfYARo3AODXUQvFZ3vLuh3z2RCmA0Zf
         jrNYXYmtWP3ULBpWGn1j5oKbZAHUt09n0eCqRkHlkVwyqC+rWyZWZy76ATPH+dNUY1
         TxtnOQ9LSEIqwVak9gbsR8dFuQiCi8nPv+SiEzu381USxll3QJXeI0GMRu5vKtwNdu
         HXnTi1U/J6naayNmM32MV9SlhUotrV+CWOL+4kXIJwEfY8sO826Ffc+JH3hN4/WSj2
         Pb4on86uS2oPeGPxhjARLJG5xIezRQvcVaC7CW0oG1iQSbSpLBRQPkUAw/vERQx4//
         aYVn8fwcPGWmw==
Date:   Wed, 20 Apr 2022 09:12:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yinjun Zhang <yinjun.zhang@corigine.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next] PCI: add Corigine vendor ID into pci_ids.h
Message-ID: <Yl+kUqyMUTIadDMz@unreal>
References: <1650362568-11119-1-git-send-email-yinjun.zhang@corigine.com>
 <Yl8w5XK54fB/rx9c@lunn.ch>
 <20220420015952.GB4636@nj-rack01-04.nji.corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420015952.GB4636@nj-rack01-04.nji.corigine.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 20, 2022 at 09:59:52AM +0800, Yinjun Zhang wrote:
> On Wed, Apr 20, 2022 at 12:00:05AM +0200, Andrew Lunn wrote:
> > On Tue, Apr 19, 2022 at 06:02:48PM +0800, Yinjun Zhang wrote:
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: linux-pci@vger.kernel.org
> > > Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
> > > Signed-off-by: Simon Horman <simon.horman@corigine.com>
> > > ---
> > >  include/linux/pci_ids.h | 2 ++
> > 
> > The very top of this file says:
> > 
> >  *      Do not add new entries to this file unless the definitions
> >  *      are shared between multiple drivers.
> > 
> > Please add to the commit messages the two or more drivers which share
> > this definition.
> 
> It will be used by ethernet and infiniband driver as we can see now,
> I'll update the commit message if you think it's a good practice.

Are you going to submit completely separated infiniband driver that has
PCI logic in drivers/infiniband without connection todrivers/net/ethernet ...?

If yes, it is very uncommon in infiniband world.

I would like to see this PCI patch submitted when it is actually used.

Thanks

> 
> > 
> > Thanks
> > 
> >      Andrew
