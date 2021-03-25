Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5D5C433E1
	for <linux-pci@archiver.kernel.org>; Thu, 25 Mar 2021 10:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D4D61A28
	for <linux-pci@archiver.kernel.org>; Thu, 25 Mar 2021 10:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhCYKRO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Mar 2021 06:17:14 -0400
Received: from foss.arm.com ([217.140.110.172]:45880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhCYKRD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Mar 2021 06:17:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6609613A1;
        Thu, 25 Mar 2021 03:17:02 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EB263F718;
        Thu, 25 Mar 2021 03:16:57 -0700 (PDT)
Date:   Thu, 25 Mar 2021 10:16:55 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/17] mm: add generic __va_function and __pa_function
 macros
Message-ID: <20210325101655.GB36570@C02TD0UTHF1T.local>
References: <20210323203946.2159693-1-samitolvanen@google.com>
 <20210323203946.2159693-4-samitolvanen@google.com>
 <20210324071357.GB2639075@infradead.org>
 <CABCJKufRHCb0sjr1tMGCoVMzV-5dKPPn-t8=+ihNFAgTr2k0DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKufRHCb0sjr1tMGCoVMzV-5dKPPn-t8=+ihNFAgTr2k0DA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 24, 2021 at 08:54:18AM -0700, Sami Tolvanen wrote:
> On Wed, Mar 24, 2021 at 12:14 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Mar 23, 2021 at 01:39:32PM -0700, Sami Tolvanen wrote:
> > > With CONFIG_CFI_CLANG, the compiler replaces function addresses
> > > in instrumented C code with jump table addresses. This means that
> > > __pa_symbol(function) returns the physical address of the jump table
> > > entry instead of the actual function, which may not work as the jump
> > > table code will immediately jump to a virtual address that may not be
> > > mapped.
> > >
> > > To avoid this address space confusion, this change adds generic
> > > definitions for __va_function and __pa_function, which architectures
> > > that support CFI can override. The typical implementation of the
> > > __va_function macro would use inline assembly to take the function
> > > address, which avoids compiler instrumentation.
> >
> > I think these helper are sensible, but shouldn't they have somewhat
> > less arcane names and proper documentation?
> 
> Good point, I'll add comments in the next version. I thought
> __pa_function would be a fairly straightforward replacement for
> __pa_symbol, but I'm fine with renaming these. Any suggestions for
> less arcane names?

I think dropping 'nocfi' into the name would be clear enough. I think
that given the usual fun with {symbol,module,virt}->phys conversions
it's not worth having the __pa_* form, and we can leave the phys
conversion to the caller that knows where the function lives.

How about we just add `function_nocfi()` ?

Callers can then do `__pa_symbol(function_nocfi(foo))` and similar.

Thanks,
Mark.
