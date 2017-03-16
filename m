Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751037AbdCPKRK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Mar 2017 06:17:10 -0400
Date: Thu, 16 Mar 2017 11:16:56 +0100
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
        labbott@fedoraproject.org, tony.luck@intel.com,
        alexandre.bounine@idt.com, kuleshovmail@gmail.com,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org, mst@redhat.com,
        linux-crypto@vger.kernel.org, tj@kernel.org,
        akpm@linux-foundation.org, davem@davemloft.net
Subject: Re: [RFC PATCH v2 12/32] x86: Add early boot support when running
 with SEV active
Message-ID: <20170316101656.dcwgtn4qdtyp5hip@pd.tnic>
References: <148846752022.2349.13667498174822419498.stgit@brijesh-build-machine>
 <148846768878.2349.15757532025749214650.stgit@brijesh-build-machine>
 <20170309140748.tg67yo2jmc5ahck3@pd.tnic>
 <5d62b16f-16ef-1bd7-1551-f0c4c43573f4@redhat.com>
 <20170309162942.jwtb3l33632zhbaz@pd.tnic>
 <1fe1e177-f588-fe5a-dc13-e9fde00e8958@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1fe1e177-f588-fe5a-dc13-e9fde00e8958@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 10, 2017 at 10:35:30AM -0600, Brijesh Singh wrote:
> We could update this patch to use the below logic:
> 
>  * CPUID(0) - Check for AuthenticAMD
>  * CPID(1) - Check if under hypervisor
>  * CPUID(0x80000000) - Check for highest supported leaf
>  * CPUID(0x8000001F).EAX - Check for SME and SEV support
>  * rdmsr (MSR_K8_SYSCFG)[MemEncryptionModeEnc] - Check if SMEE is set

Actually, it is still not clear to me *why* we need to do anything
special wrt SEV in the guest.

Lemme clarify: why can't the guest boot just like a normal Linux on
baremetal and use the SME(!) detection code to set sme_enable and so
on? IOW, I'd like to avoid all those checks whether we're running under
hypervisor and handle all that like we're running on baremetal.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
