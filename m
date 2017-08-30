Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 30 Aug 2017 12:16:17 +0200
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
Message-ID: <20170830101617.3m266q7xuew6ctxl@pd.tnic>
References: <1503940314-29526-1-git-send-email-tbaicar@codeaurora.org>
 <20170829082055.u3qpwtgyzxjxfvup@pd.tnic>
 <9abb2e99-44be-3315-47d9-2689b6c76d79@codeaurora.org>
 <20170829221932.ojkvr4y6s76hcpkj@pd.tnic>
 <0fb1fe1b-207a-93fe-4ac6-b886451e488e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <0fb1fe1b-207a-93fe-4ac6-b886451e488e@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 29, 2017 at 06:34:49PM -0400, Sinan Kaya wrote:
> The do_recovery function needs to be called for both uncorrectable error
> categories. (#2 and #3 above)

Care to share why exactly that needs to happen?

Because I'm reading this in pcieaer-howto.txt:

"If an error message indicates a non-fatal error, performing link reset
at upstream is not required."

and

"If an error message indicates a fatal error, kernel will broadcast
error_detected(dev, pci_channel_io_frozen) to all drivers within a
hierarchy in question. Then, performing link reset at upstream is
necessary."

Now, pci-error-recovery.txt has link reset as step 3 so I'm assuming
recovery means link reset. And thus, non-fatal AER errors are not
required to do recovery but fatal are.

> How these map to GHES error categories is out of know-how.

        case CPER_SEV_INFORMATIONAL:
                return GHES_SEV_NO;
        case CPER_SEV_CORRECTED:
                return GHES_SEV_CORRECTED;
        case CPER_SEV_RECOVERABLE:
                return GHES_SEV_RECOVERABLE;
        case CPER_SEV_FATAL:
                return GHES_SEV_PANIC;

and

        case CPER_SEV_RECOVERABLE:
                return AER_NONFATAL;
        case CPER_SEV_FATAL:
                return AER_FATAL;
        default:
                return AER_CORRECTABLE;

So I see GHES_SEV_RECOVERABLE -> CPER_SEV_RECOVERABLE -> AER_NONFATAL.

Which means, we've never done error recovery for AER_FATAL errors. Which
we should've been doing in the first place! Unless...

... Error recovery for those fatal errors has been happening down the
other, PCI path:

aer_isr->aer_isr_one_error->...->do_recovery()

Which then makes me look at this contraption in the ghes code:

config ACPI_APEI_PCIEAER
        bool "APEI PCIe AER logging/recovering support"
        depends on ACPI_APEI && PCIEAER
        help
          PCIe AER errors may be reported via APEI firmware first mode.
          Turn on this option to enable the corresponding support.

So this says "may be" reported.

Now the question is, what kind of errors are being reported through here
and what exactly are we expected to do about them? Print them? Or do
more?

Hmmm.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
