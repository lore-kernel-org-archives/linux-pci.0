Return-Path: <SRS0=mHad=7K=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE93CC433E0
	for <linux-pci@archiver.kernel.org>; Thu, 28 May 2020 21:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E61120C56
	for <linux-pci@archiver.kernel.org>; Thu, 28 May 2020 21:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDK1L/X4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436720AbgE1Vog (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 May 2020 17:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436581AbgE1Vod (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2020 17:44:33 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C68AC08C5C6
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2020 14:44:33 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u13so784864wml.1
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2020 14:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=u8fU4huY9KX2XErcgjEKYG/K1ac3eIBafh//MDK6A3M=;
        b=vDK1L/X4qZZxF/IyEw+LFEs7ICn6JCT4lckq1PW1GwGnn5Sc2LLf07TY9+jEsVzg0d
         iatpRCmo5O6XMcO/pPhBnOrLUOHThAswMxZ2iFgNmUgDIakzi7OI4h92gmyxgnDXFJIg
         P0UgiNyHwo1MzKcYeq6kHdrl+bJKrctUXJTRaqJE2WHjO7IUIeS5uSPTspUSSqF8mSlz
         NTJsiUFIY+aQpmNT8TLB+pDVwT16nCCzUWikwWSHcnRqK/Cj/jH+FBNDqxkQLsLPsUrz
         ft+Bc5WMRrl8FgAUR5tVIKMXuZv17buOH3RKjgDxXR+gOoQQ7+KWLlZ2qPfPAP6oR4RE
         zr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=u8fU4huY9KX2XErcgjEKYG/K1ac3eIBafh//MDK6A3M=;
        b=LZfobqj1jBLOgpmbD+sPcbJUNZ9CRZG9Hp1/VY1hZ2zVu/CIin0691A3+rFXvWhBx0
         nSV6XQpEY41Q5JNk9zNo55yO2DyDOgEcouUx6Ivqrmd5g84X4/ov8/LxHXM0fjqjmhZi
         5rC5/pPk1tsHgVE/1+PqjfsChEwr6lg4QsxHTYBytzpW/+dGpM0TtzJhzyqZjuyKBWWy
         A994ef66FJJKCltIwj/wz4spoYULhmjxdL1CgmcbjZEEsPGu0oKBqpIFILqczT/ylvCM
         SpOAlR+NrvpOlSx2/2PBzpx4S8bPRSZbezoefsr8gq+0E5ZB8uQOqE3aVF+HXCTp2gA1
         gPZg==
X-Gm-Message-State: AOAM53237KK6ANY8ZA1QQ25/r7aTsWX2wrAvIbJb04vsmMrs9Hd8oUEH
        Wni7iED2hCQFKlucRGSaJr+aroqB
X-Google-Smtp-Source: ABdhPJwbjgjUAJnigT29R6gqANp08il5k3sQHZfQd8rDtg8UyGOvnCxksr7zgxW05/q/OVXjShMffw==
X-Received: by 2002:a7b:c74b:: with SMTP id w11mr5100999wmk.120.1590702271706;
        Thu, 28 May 2020 14:44:31 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f35:d400:593c:f5d:44cf:3de4? (p200300ea8f35d400593c0f5d44cf3de4.dip0.t-ipconnect.de. [2003:ea:8f35:d400:593c:f5d:44cf:3de4])
        by smtp.googlemail.com with ESMTPSA id y5sm7608733wrs.63.2020.05.28.14.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 14:44:31 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Lost PCIe PME after a914ff2d78ce ("PCI/ASPM: Don't select
 CONFIG_PCIEASPM by default")
Message-ID: <2e1ee784-7493-284b-96f9-96b2e0c4b817@gmail.com>
Date:   Thu, 28 May 2020 23:44:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For whatever reason with this change (and losing ASPM control) I also
loose the PCIe PME interrupts. This prevents my network card from
resuming from runtime-suspend.
Reverting the change brings back ASPM control and the PCIe PME irq's.

Affected system is a Zotac MiniPC with a N3450 CPU:
PCI bridge: Intel Corporation Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port A #1 (rev fb)
