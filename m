Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 7 Jun 2016 18:13:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V8 0/9] Support for ARM64 ACPI based PCI host controller
Message-ID: <20160607231326.GA4759@localhost>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <1464621262-26770-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: rafael@kernel.org, linux-pci@vger.kernel.org, will.deacon@arm.com,
 okaya@codeaurora.org, wangyijing@huawei.com, andrea.gallo@linaro.org,
 Lorenzo.Pieralisi@arm.com, linaro-acpi@lists.linaro.org,
 ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org,
 robert.richter@caviumnetworks.com, liudongdong3@huawei.com,
 catalin.marinas@arm.com, Liviu.Dudau@arm.com, arnd@arndb.de, jcm@redhat.com,
 msalter@redhat.com, cov@codeaurora.org, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com, dhdang@apm.com,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com, hanjun.guo@linaro.org,
 Suravee.Suthikulpanit@amd.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz,

On Mon, May 30, 2016 at 05:14:13PM +0200, Tomasz Nowicki wrote:
> From the functionality point of view this series may be split into the
> following logic parts:
> 1. Export ECAM API and add parent device to pci_config_window
> 2. Add IO resources handling to PCI core code
> 3. Support for generic domain assignment based on ACPI
> 4. New MCFG driver
> 5. Implement ARM64 ACPI based PCI host controller driver under arch/arm64/
> 
> Patches has been built on top of 4.7-rc1 and can be found here:
> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v8)

Trivial comments while I work on the rest:

  - Run "git log --oneline" on the files you change and make sure the
    subject lines match existing style.

  - Always capitalize "PCI" and "ACPI".

  - Use a capitalized verb as the first word after the "PCI: " prefix
    in a changelog subject.

  - Don't add a period at the end of a changelog subject.

  - Wrap changelogs so "git log" output fits in 80 columns.  I use
    "set textwidth=75" in vim.

  - Always use "()" after function names.

  - Don't write "This patch does ..." in a changelog.  It's obvious
    that the context is this patch, so write something like "Update
    users of the header file to use the new name."  I like it when
    there's a little bit of background followed by a short paragraph
    starting with a strong verb that tells me what the patch does.

I usually fix all this sort of stuff silently, but I'm slow and it scales
better if you do it.

Don't bother posting an update until I have a chance to look at the code
itself.  I'm sure (at least, I hope) I'll have more substantive comments
than these :)

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
