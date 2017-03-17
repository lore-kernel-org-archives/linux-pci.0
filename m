Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38625 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750898AbdCQK4b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Mar 2017 06:56:31 -0400
Date: Fri, 17 Mar 2017 11:56:10 +0100
From: Borislav Petkov <bp@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>, simon.guinot@sequanux.org,
        linux-efi@vger.kernel.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
        matt@codeblueprint.co.uk, linux-pci@vger.kernel.org,
        linus.walleij@linaro.org, gary.hook@amd.com, linux-mm@kvack.org,
        paul.gortmaker@windriver.com, hpa@zytor.com, cl@linux.com,
        dan.j.williams@intel.com, aarcange@redhat.com,
        sfr@canb.auug.org.au, andriy.shevchenko@linux.intel.com,
        herbert@gondor.apana.org.au, bhe@redhat.com, xemul@parallels.com,
        joro@8bytes.org, x86@kernel.org, peterz@infradead.org,
        piotr.luc@intel.com, mingo@redhat.com, msalter@redhat.com,
        ross.zwisler@linux.intel.com, dyoung@redhat.com,
        thomas.lendacky@amd.com, jroedel@suse.de, keescook@chromium.org,
        arnd@arndb.de, toshi.kani@hpe.com, mathieu.desnoyers@efficios.com,
        luto@kernel.org, devel@linuxdriverproject.org, bhelgaas@google.com,
        tglx@linutronix.de, mchehab@kernel.org
Subject: Re: [RFC PATCH v2 14/32] x86: mm: Provide support to use memblock
 when spliting large pages
Message-ID: <20170317105610.musvo4baokgssvye@pd.tnic>
References: <148846752022.2349.13667498174822419498.stgit@brijesh-build-machine>
 <148846771545.2349.9373586041426414252.stgit@brijesh-build-machine>
 <20170310110657.hophlog2juw5hpzz@pd.tnic>
 <cb6a9a56-2c52-d98d-3ff6-3b61d0e5875e@amd.com>
 <20170316182836.tyvxoeq56thtc4pd@pd.tnic>
 <ec134379-6a48-905c-26e4-f6f2738814dc@redhat.com>
 <20170317101737.icdois7sdmtutt6b@pd.tnic>
 <b6f9f46c-58c4-a19c-4955-2d07bd411443@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <b6f9f46c-58c4-a19c-4955-2d07bd411443@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 17, 2017 at 11:47:16AM +0100, Paolo Bonzini wrote:
> Theoretically or practically?

In the sense, it needs to be tried first to see how ugly it can get.

> It only looks at the E820 map, doesn't it?  Why does it have to do
> anything with percpu memory areas?

That's irrelevant. What we want to do is take what's in init_mm.pgd and
modify it. And use the facilities in arch/x86/mm/init_{32,64}.c because
they already know about early/late pagetable pages allocation and they
deal with the kernel pagetable anyway.

And *not* teach pageattr.c about memblock because that can be misused,
as tglx pointed out on IRC.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
