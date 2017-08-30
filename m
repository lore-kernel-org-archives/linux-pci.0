Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 30 Aug 2017 19:14:41 +0200
From: Borislav Petkov <bp@suse.de>
To: "Baicar, Tyler" <tbaicar@codeaurora.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
        rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com,
        james.morse@arm.com, prarit@redhat.com, punit.agrawal@arm.com,
        shiju.jose@huawei.com, andriy.shevchenko@linux.intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] acpi: apei: call into AER handling regardless of severity
Message-ID: <20170830171440.3ynavu5nuchiwxcb@pd.tnic>
References: <1503940314-29526-1-git-send-email-tbaicar@codeaurora.org>
 <20170829082055.u3qpwtgyzxjxfvup@pd.tnic>
 <9abb2e99-44be-3315-47d9-2689b6c76d79@codeaurora.org>
 <20170829221932.ojkvr4y6s76hcpkj@pd.tnic>
 <0fb1fe1b-207a-93fe-4ac6-b886451e488e@codeaurora.org>
 <20170830101617.3m266q7xuew6ctxl@pd.tnic>
 <b630fa5e-c24b-06f4-47da-bed53161e0b7@codeaurora.org>
 <20170830151601.ro5qt5272e2msevp@pd.tnic>
 <af5dc902-faca-a7a1-6781-95ff82d5d8fd@codeaurora.org>
 <a074792e-ad43-d4f5-6f99-8fcf8349c7ad@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <a074792e-ad43-d4f5-6f99-8fcf8349c7ad@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 30, 2017 at 09:42:08AM -0600, Baicar, Tyler wrote:
> I think with my two patches we will have the desired functionality:
> 
> GHES_SEV_CORRECTABLE -> AER_CORRECTABLE -> Print AER info, but do not call
> do_recovery
> 
> GHES_SEV_RECOVERABLE -> AER_NONFATAL -> Print AER info and do_recovery
> 
> GHES_RECOVERABLE and CPER_SEC_RESET -> AER_FATAL -> Print AER info and
> do_recover

Right, so I'd like to you create a separate function ghes_do_proc_aer()
or ghes_handle_aer() or so and carve out all the code inside #ifdef
CONFIG_ACPI_APEI_PCIEAER into it, add your two changes to the patch and
slap a big fat comment above the new function explaining *why* we're
doing what we're doing and how we're mapping all the severities to AER
severity in order to do recovery and/or only to print the error.

So that it is known and people can see in the future why we're doing
this and what the logic has been and what kind of policy we're chasing
and so on and so on...

Ok?

Thanks.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
