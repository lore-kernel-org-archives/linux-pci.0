Return-Path: <SRS0=+EjW=US=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108E5C43613
	for <linux-pci@archiver.kernel.org>; Wed, 19 Jun 2019 21:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11A72084A
	for <linux-pci@archiver.kernel.org>; Wed, 19 Jun 2019 21:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfFSV0l (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Jun 2019 17:26:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40350 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfFSV0l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 17:26:41 -0400
Received: from localhost (unknown [144.121.20.163])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4CD7B1475D2CD;
        Wed, 19 Jun 2019 14:26:40 -0700 (PDT)
Date:   Wed, 19 Jun 2019 17:26:39 -0400 (EDT)
Message-Id: <20190619.172639.2296773807837656357.davem@davemloft.net>
To:     hkallweit1@gmail.com
Cc:     bhelgaas@google.com, nic_swsd@realtek.com,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] PCI: let pci_disable_link_state propagate
 errors
From:   David Miller <davem@davemloft.net>
In-Reply-To: <5ea56278-05e2-794f-5f66-23343e72164c@gmail.com>
References: <5ea56278-05e2-794f-5f66-23343e72164c@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Jun 2019 14:26:40 -0700 (PDT)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Tue, 18 Jun 2019 23:12:56 +0200

> Drivers like r8169 rely on pci_disable_link_state() having disabled
> certain ASPM link states. If OS can't control ASPM then
> pci_disable_link_state() turns into a no-op w/o informing the caller.
> The driver therefore may falsely assume the respective ASPM link
> states are disabled. Let pci_disable_link_state() propagate errors
> to the caller, enabling the caller to react accordingly.
> 
> I'd propose to let this series go through the netdev tree if the PCI
> core extension is acked by the PCI people.

Bjorn et al., please look at patch #1 and ACK/NACK

Thank you.
