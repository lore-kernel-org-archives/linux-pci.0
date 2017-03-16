Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752468AbdCPM2W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Mar 2017 08:28:22 -0400
Subject: Re: [RFC PATCH v2 14/32] x86: mm: Provide support to use memblock
 when spliting large pages
To: Brijesh Singh <brijesh.singh@amd.com>, simon.guinot@sequanux.org,
        linux-efi@vger.kernel.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
        matt@codeblueprint.co.uk, linux-pci@vger.kernel.org,
        linus.walleij@linaro.org, gary.hook@amd.com, linux-mm@kvack.org,
        paul.gortmaker@windriver.com, hpa@zytor.com, cl@linux.com,
        dan.j.williams@intel.com, aarcange@redhat.com,
        sfr@canb.auug.org.au, andriy.shevchenko@linux.intel.com,
        herbert@gondor.apana.org.au, bhe@redhat.com, xemul@parallels.com,
        joro@8bytes.org, x86@kernel.org, peterz@infradead.org,
        piotr.luc@intel.com, mingo@redhat.com, msalter@redhat.com,
        ross.zwisler@linux.intel.com, bp@suse.de, dyoung@redhat.com,
        thomas.lendacky@amd.com, jroedel@suse.de, keescook@chromium.org,
        arnd@arndb.de, toshi.kani@hpe.com, mathieu.desnoyers@efficios.com,
        luto@kernel.org, devel@linuxdriverproject.org, bhelgaas@google.com,
        tglx@linutronix.de, mchehab@kernel.org, iamjoonsoo.kim@lge.com,
        labbott@fedoraproject.org, tony.luck@intel.com,
        alexandre.bounine@idt.com, kuleshovmail@gmail.com,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org, mst@redhat.com,
        linux-crypto@vger.kernel.org, tj@kernel.org,
        akpm@linux-foundation.org, davem@davemloft.net
References: <148846752022.2349.13667498174822419498.stgit@brijesh-build-machine>
 <148846771545.2349.9373586041426414252.stgit@brijesh-build-machine>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55f528b7-da06-2506-2cd0-56b9493347f0@redhat.com>
Date: Thu, 16 Mar 2017 13:28:01 +0100
MIME-Version: 1.0
In-Reply-To: <148846771545.2349.9373586041426414252.stgit@brijesh-build-machine>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 02/03/2017 16:15, Brijesh Singh wrote:
> 
>  __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
> -		   struct page *base)
> +		  pte_t *pbase, unsigned long new_pfn)
>  {
> -	pte_t *pbase = (pte_t *)page_address(base);

Just one comment and I'll reply to Boris, I think you can compute pbase 
with pfn_to_kaddr, and avoid adding a new argument.

>  	 */
> -	__set_pmd_pte(kpte, address, mk_pte(base, __pgprot(_KERNPG_TABLE)));
> +	__set_pmd_pte(kpte, address,
> +		native_make_pte((new_pfn << PAGE_SHIFT) + _KERNPG_TABLE));

And this probably is better written as:

	__set_pmd_pte(kpte, address, pfn_pte(new_pfn, __pgprot(_KERNPG_TABLE));

Paolo
