Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40627 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932153AbdC2POj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Mar 2017 11:14:39 -0400
Date: Wed, 29 Mar 2017 17:14:13 +0200
From: Borislav Petkov <bp@suse.de>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: simon.guinot@sequanux.org, linux-efi@vger.kernel.org,
        kvm@vger.kernel.org, rkrcmar@redhat.com, matt@codeblueprint.co.uk,
        linux-pci@vger.kernel.org, linus.walleij@linaro.org,
        gary.hook@amd.com, linux-mm@kvack.org,
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
        labbott@fedoraproject.org, tony.luck@intel.com,
        alexandre.bounine@idt.com, kuleshovmail@gmail.com,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org, mst@redhat.com,
        linux-crypto@vger.kernel.org, tj@kernel.org, pbonzini@redhat.com,
        akpm@linux-foundation.org, davem@davemloft.net
Subject: Re: [RFC PATCH v2 18/32] kvm: svm: Use the hardware provided GPA
 instead of page walk
Message-ID: <20170329151413.l2on26mdyyskwqlu@pd.tnic>
References: <148846752022.2349.13667498174822419498.stgit@brijesh-build-machine>
 <148846776540.2349.3123530065053870721.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <148846776540.2349.3123530065053870721.stgit@brijesh-build-machine>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 02, 2017 at 10:16:05AM -0500, Brijesh Singh wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> When a guest causes a NPF which requires emulation, KVM sometimes walks
> the guest page tables to translate the GVA to a GPA. This is unnecessary
> most of the time on AMD hardware since the hardware provides the GPA in
> EXITINFO2.
> 
> The only exception cases involve string operations involving rep or
> operations that use two memory locations. With rep, the GPA will only be
> the value of the initial NPF and with dual memory locations we won't know
> which memory address was translated into EXITINFO2.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Reviewed-by: Borislav Petkov <bp@suse.de>

I think I already asked you to remove Revewed-by tags when you have to
change an already reviewed patch in non-trivial manner. Why does this
one still have my Reviewed-by tag?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
