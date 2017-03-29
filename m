Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 29 Mar 2017 17:32:53 +0200
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
        tglx@linutronix.de, mchehab@kernel.org, iamjoonsoo.kim@lge.com,
        labbott@fedoraproject.org, tony.luck@intel.com,
        alexandre.bounine@idt.com, kuleshovmail@gmail.com,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org, mst@redhat.com,
        linux-crypto@vger.kernel.org, tj@kernel.org,
        akpm@linux-foundation.org, davem@davemloft.net
Subject: Re: [RFC PATCH v2 16/32] x86: kvm: Provide support to create Guest
 and HV shared per-CPU variables
Message-ID: <20170329153252.kwwyedndwnfgvzcb@pd.tnic>
References: <148846752022.2349.13667498174822419498.stgit@brijesh-build-machine>
 <148846773666.2349.9492983018843773590.stgit@brijesh-build-machine>
 <20170328183931.rqorduu5fnp5r3y2@pd.tnic>
 <9a8723fc-300d-eb76-deb1-cbc8492e9d49@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <9a8723fc-300d-eb76-deb1-cbc8492e9d49@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 29, 2017 at 05:21:13PM +0200, Paolo Bonzini wrote:
> The GHCB would have to be allocated much earlier, possibly even by
> firmware depending on how things will be designed.

How about a statically allocated page like we do with the early
pagetable pages in head_64.S?

> I think it's premature to consider SEV-ES requirements.

My only concern is not to have to redo a lot when SEV-ES gets enabled.
So it would be prudent to design with SEV-ES in the back of our minds.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
