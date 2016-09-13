Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 13 Sep 2016 10:45:31 +0200
From: Borislav Petkov <bp@suse.de>
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        matt.fleming@intel.com, paul.gortmaker@windriver.com,
        zjzhang@codeaurora.org, sudipm.mukherjee@gmail.com, axboe@fb.com,
        izumi.taku@jp.fujitsu.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] Correct AER severity for printing AER information
Message-ID: <20160913084531.GA19076@nazgul.tnic>
References: <1473713845-23613-1-git-send-email-tbaicar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1473713845-23613-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 12, 2016 at 02:57:23PM -0600, Tyler Baicar wrote:
> AER severity handling has two issues that cause the AER information to
> be printed incorrectly. The first issue is that the function to calculate
> the AER severity is called twice in the code path to print the AER
> information. The second issue is that the original call to calculate the
> AER severity expects the CPER severity but is recieving the GHES
> severity.
> 
> Tyler Baicar (2):
>   PCI/AER: Remove duplicate AER severity translation
>   acpi: apei: send correct severity to calculate AER severity
> 
>  drivers/acpi/apei/ghes.c               | 2 +-
>  drivers/pci/pcie/aer/aerdrv_errprint.c | 6 ++----
>  include/linux/aer.h                    | 2 +-
>  3 files changed, 4 insertions(+), 6 deletions(-)

For both:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
--
