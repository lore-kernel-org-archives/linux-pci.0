Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9066FC4332F
	for <linux-pci@archiver.kernel.org>; Mon,  6 Nov 2023 06:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjKFGTe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 6 Nov 2023 01:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjKFGTd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 01:19:33 -0500
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAC5B8
        for <linux-pci@vger.kernel.org>; Sun,  5 Nov 2023 22:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1699251569; x=1699510769;
        bh=55sfDxsZO4PfdLhySwE64hXQWYv/aIoszo0K8IU1vYM=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=IE3MNYX9HFtK/mqZMZwf5mqMsu7UDhv3xkGeHcvLuUuH0mQMCz7M5lfPBCS70gDoJ
         /w8PhcmWNAy6YzWsaJCEpUfkLBhhGba0wBX84HhO/YqzlvGBw/4O6vOpymFxshzKCI
         a9RJbbd4JKZx+n6j/N+E33eQv3SAjOyt8UWAmgO5CvpeuxG96arnq2uz9YLzHT6D9f
         8FScyU53qAEoYJ4L51bip7SCuIUvO1KJvAkLjlVNFxi6nfUZijr2PA9xM04qQL+weX
         BdqpfoyMhprodxFyAMq1eRorD67uVw59mbIT4tkXeMmdULyhY7H0b8i6TIrp/3QRjK
         /YRuPAKP0VP2Q==
Date:   Mon, 06 Nov 2023 06:19:23 +0000
To:     "bjorn@helgaas.com" <bjorn@helgaas.com>
From:   Sebastian Manciulea <manciuleas@protonmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: ixgbe driver fails to load due to PCI device probing failure
Message-ID: <VOa9uYkR9REBXPxzK7ORLNV9vsKzEUcdOOkh-ys1C4GjBLc26CUDZmV2MLqSEHBlNOFOPOkPaUcA28Pi9hcNpS-jSA2_Iw6_SNHQureja-I=@protonmail.com>
Feedback-ID: 38625298:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

I have opened a bug report to help with debugging this issue. https://bugzi=
lla.kernel.org/show_bug.cgi?id=3D218107
The full dmesg output is attached there.

Regards,
Sebastian

