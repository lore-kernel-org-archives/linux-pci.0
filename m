Return-Path: <SRS0=Uqbb=DT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A284DC433DF
	for <linux-pci@archiver.kernel.org>; Mon, 12 Oct 2020 08:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A57D2145D
	for <linux-pci@archiver.kernel.org>; Mon, 12 Oct 2020 08:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602491491;
	bh=S0GqfGRh8/Tl7HdVRLMI52r7qak2HNoCB3IVK6Zs4T4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HIXRTYrknP38OpUSv5QKQQqomybMOBV6doa2KUqdY0bidOa9GssX5HlXPCaAu/rXE
	 xRpY8Y1gizwS+GemcDn1hlxbEm9adhinonj7d/IaC2avCCzc3k/dg7ZO9M3/M2pq9y
	 JlI6HTwg3nDFDPT08lnGSzAQy8ZVeoQB3IgAsC0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgJLIba (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Oct 2020 04:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgJLIba (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Oct 2020 04:31:30 -0400
Received: from willie-the-truck (unknown [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E228120714;
        Mon, 12 Oct 2020 08:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602491487;
        bh=S0GqfGRh8/Tl7HdVRLMI52r7qak2HNoCB3IVK6Zs4T4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FAGXtskDnU07QyUMOPdISrDHNwNMMZNEFc9kmIocOb5BS1ggUldHn150u5QE6XaTM
         TVeCby8WdrzZLI+/xIob9CoWuJsvJlykjpSdQ3zHOkkoakk83y4AGlrSMjgHyLWypR
         gQcCEbKimhtCql8PcZKHCdCEuxPXmulvNhE+OJes=
Date:   Mon, 12 Oct 2020 09:31:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v5 25/29] arm64: allow LTO_CLANG and THINLTO to be
 selected
Message-ID: <20201012083116.GA785@willie-the-truck>
References: <20201009161338.657380-1-samitolvanen@google.com>
 <20201009161338.657380-26-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009161338.657380-26-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 09, 2020 at 09:13:34AM -0700, Sami Tolvanen wrote:
> Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index ad522b021f35..7016d193864f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -72,6 +72,8 @@ config ARM64
>  	select ARCH_USE_SYM_ANNOTATIONS
>  	select ARCH_SUPPORTS_MEMORY_FAILURE
>  	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
> +	select ARCH_SUPPORTS_LTO_CLANG
> +	select ARCH_SUPPORTS_THINLTO

Please don't enable this for arm64 until we have the dependency stuff sorted
out. I posted patches [1] for this before, but I think they should be part
of this series as they don't make sense on their own.

Will

[1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=rwonce/read-barrier-depends
