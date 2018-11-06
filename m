Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8B9C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 21:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420DA2086C
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 21:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJcR6OjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420DA2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeKGHTo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:19:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbeKGHTo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 02:19:44 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A1F22083D;
        Tue,  6 Nov 2018 21:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541541145;
        bh=D4VgFYuOd+o38IlJFM18JB5dePFP/Z9mMp2loQa8ooA=;
        h=Subject:From:To:Cc:Date:From;
        b=NJcR6OjWAdAhCqPMt8uIILZmJ/Sv1MpLffIUEw9jrOA45DVY1eSRXb0qa1ylwftf2
         HbMds8Nma1C4Sv1bTNgI74xrqsXOFkxNshwKTmWKM996BYlqOWSBUn8ovsGbmCh9Gg
         QVLp9ksc4GMHcX5rjOozrj2N8CFBHba5l+rzjrL8=
Subject: [PATCH 0/2] lspci: Decode Multicast capability
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     linux-pci@vger.kernel.org
Date:   Tue, 06 Nov 2018 15:52:24 -0600
Message-ID: <154154102296.78911.760432131801074864.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Martin,

Here's some decoding for the Multicast capability and some new capability
names for setpci.  These are based on a42aea906410 ("Add a couple of
missing va_end's").

---

Bjorn Helgaas (2):
      lspci: Decode Multicast Extended Capability
      setpci: Add capability names


 lib/header.h        |   18 ++++
 ls-ecaps.c          |   59 ++++++++++++
 setpci.c            |   25 +++++
 tests/cap-multicast |  257 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 359 insertions(+)
 create mode 100644 tests/cap-multicast
