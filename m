Return-Path: <SRS0=JtJR=AF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDABC433DF
	for <linux-pci@archiver.kernel.org>; Wed, 24 Jun 2020 20:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E43A20899
	for <linux-pci@archiver.kernel.org>; Wed, 24 Jun 2020 20:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UWquwQhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406577AbgFXUdc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406573AbgFXUdb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 16:33:31 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7895C0613ED
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 13:33:31 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id i6so2461438qkn.22
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tPGFlpm4UBb0TochKjxo1pWDKJKPOqpdcyA67hsa/L0=;
        b=UWquwQhXAU0FVu4xLvS68q0H5KMxmC2ClvghZJMO4mnRx07EpAl76zEcZBzo4oeEr0
         7QXs8i2/+8O4w4SxtWsY3wN7GwxBdmr8ei0LaPar71G/kQf7fHaujWILvZ2kj0I3OQnr
         XU2/mlOZsNQvQSHPQNf0o+Qm3V8oiEUyLdtK1wUmyBN7hxR5xoSfaX9vD6ylX1d8MUtg
         8oc06ZHQnmcIQFLeYAyeQNfJHs0QNV6Vk/mbPBcPZcsZ2TSgTBf3waXZc3e781NAKP/5
         u74kiQ+ly65wZm433U8lBfaxNpuvW2v+K3io3UW/wCh82HySe+7ylz3czOz1zaRbngJk
         H88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tPGFlpm4UBb0TochKjxo1pWDKJKPOqpdcyA67hsa/L0=;
        b=OwxCxEqFBBP02A0tTOpYHXdblTGeyLGRb+pVkpz4ZOBfHnTK8lPBiec+W2EMugn2oN
         dF5Fi68t+NNojqEWNypcgZawI3hhU+D+pySWSo6QjOv7utIyZnYy/sJx/SY0ZcBJZwt1
         q2xpLshI6Fa/aXeWxZXzAo8fpICiS/I9ZumGudHmzYwEsMUvS/rAMPfKBwYQN5MojJtB
         aZQN98U4zalB2X/8+aEA+GXJpjnBMQbpGFZ6bJe/HLBkc08aOE42RhoECr4ctFkeUDdI
         6wXanUnPJrpknNLAWGz7ta5hPq4vLUgOR2XR8mTVoq94xXvfYUHv4Yj4xbY5ECdmBmVN
         YxlA==
X-Gm-Message-State: AOAM533ZoCx1Zun8OnU+HI7vSqsX6ZHElN7Qk4uLRppWev64/19+O1sp
        d5pise9E+PpBCdKKqucQesWBOE1szWJs1Pu2dyY=
X-Google-Smtp-Source: ABdhPJwOmVj5AVipomAFkeyuweymmty039I+YIpShmyF/4KLduyGozlOwEpdaQAyz+L93rzFTlrhSA4YsbqHyVAyM6Y=
X-Received: by 2002:a0c:8482:: with SMTP id m2mr33607693qva.65.1593030810891;
 Wed, 24 Jun 2020 13:33:30 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:56 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-19-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 18/22] arm64: allow LTO_CLANG and THINLTO to be selected
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4a094bedcb2..e1961653964d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -72,6 +72,8 @@ config ARM64
 	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
+	select ARCH_SUPPORTS_LTO_CLANG
+	select ARCH_SUPPORTS_THINLTO
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && (GCC_VERSION >= 50000 || CC_IS_CLANG)
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.27.0.212.ge8ba1cc988-goog

