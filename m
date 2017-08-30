Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 30 Aug 2017 19:02:06 +0200
From: Borislav Petkov <bp@suse.de>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "Baicar, Tyler" <tbaicar@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>, rjw@rjwysocki.net,
        lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com,
        prarit@redhat.com, punit.agrawal@arm.com, shiju.jose@huawei.com,
        andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] acpi: apei: call into AER handling regardless of severity
Message-ID: <20170830170205.wf7q6hfcw4jhbpmu@pd.tnic>
References: <1503940314-29526-1-git-send-email-tbaicar@codeaurora.org>
 <20170829082055.u3qpwtgyzxjxfvup@pd.tnic>
 <9abb2e99-44be-3315-47d9-2689b6c76d79@codeaurora.org>
 <20170829221932.ojkvr4y6s76hcpkj@pd.tnic>
 <0fb1fe1b-207a-93fe-4ac6-b886451e488e@codeaurora.org>
 <20170830101617.3m266q7xuew6ctxl@pd.tnic>
 <b630fa5e-c24b-06f4-47da-bed53161e0b7@codeaurora.org>
 <20170830151601.ro5qt5272e2msevp@pd.tnic>
 <af5dc902-faca-a7a1-6781-95ff82d5d8fd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <af5dc902-faca-a7a1-6781-95ff82d5d8fd@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 30, 2017 at 11:31:06AM -0400, Sinan Kaya wrote:
> I see. We should probably try to do something only if GHES_SEV_CORRECTED or
> GHES_SEV_RECOVERABLE.
> 
> If somebody wants to crash the system with GHES_SEV_PANIC, there is no point
> in doing additional work.

Makes sense.

Whatever we do, I'd like to have this all nicely documented *why* we're
doing the recovery policy we're doing.

> Sounds good. Do you still want to do PCIe recovery in the case of
> GHES_SEV_PANIC or if some FW returns GHES_SEV_NO?

So I read GHES_SEV_PANIC as: we should panic and stop any processing
whatsoever ASAP in order to avoid further error propagation. So doing
recovery there might *actually* be a bad idea.

GHES_SEV_NO would map to AER_CORRECTABLE and I think that would mean,
print the error to let the user know but no need to recover because no
harm was done.

I *think*.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
