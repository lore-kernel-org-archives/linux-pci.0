Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932643AbdDGLdo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Apr 2017 07:33:44 -0400
Date: Fri, 7 Apr 2017 13:33:25 +0200
From: Borislav Petkov <bp@suse.de>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, simon.guinot@sequanux.org,
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
        tglx@linutronix.de, mchehab@kernel.org, iamjoonsoo.kim@lge.com,
        labbott@fedo.suse.de
Subject: Re: [RFC PATCH v2 14/32] x86: mm: Provide support to use memblock
 when spliting large pages
Message-ID: <20170407113325.vykr4g3qdufgt2rd@pd.tnic>
References: <f46ff1e1-1cc7-1907-74a0-e2709fa1e5fb@amd.com>
 <20170406172520.iyjjtz56u3jlnjhq@pd.tnic>
 <ba739600-d468-1f1b-aff6-89c79fd6030b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <ba739600-d468-1f1b-aff6-89c79fd6030b@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 06, 2017 at 01:37:41PM -0500, Brijesh Singh wrote:
> I did thought about prot idea but ran into another corner case which may require
> us changing the signature of phys_pud_init and phys_pmd_init. The paddr_start
> and paddr_end args into kernel_physical_mapping_init() should be aligned on PMD
> level down (see comment [1]). So, if we encounter a case where our address range
> is part of large page but we need to clear only one entry (i.e asked to clear just
> one page into 2M region). In that case, now we need to pass additional arguments
> into kernel_physical_mapping, phys_pud_init and phys_pmd_init to hint the splitting
> code that it should use our prot for specific entries and all other entries will use
> the old_prot.

Ok, but your !4K case:

+               /*
+                * virtual address is part of large page, create the page
+                * table mapping to use smaller pages (4K). The virtual and
+                * physical address must be aligned to PMD level.
+                */
+               kernel_physical_mapping_init(__pa(vaddr & PMD_MASK),
+                                            __pa((vaddr_end & PMD_MASK) + PMD_SIZE),
+                                            0);


would map a 2M page as encrypted by default. What if we want to map a 2M page
frame as ~_PAGE_ENC?

IOW, if you're adding a new interface, it should be generic enough, like
with prot argument.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
