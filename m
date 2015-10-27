Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 27 Oct 2015 09:41:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org,
	catalin.marinas@arm.com, will.deacon@arm.com,
	hanjun.guo@linaro.org, thomas.lendacky@amd.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jeremy Linton <jeremy.linton@arm.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH V4 1/8] acpi: Honor ACPI _CCA attribute setting
Message-ID: <20151027144123.GC8660@localhost>
References: <1445442731-28819-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1445442731-28819-2-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445442731-28819-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From "git log --oneline include/acpi/acpi_bus.h", I see the convention is
to capitalize "ACPI:" in the summary (also applies to other patches in this
series).

On Wed, Oct 21, 2015 at 08:52:04AM -0700, Suravee Suthikulpanit wrote:
> From: Jeremy Linton <jeremy.linton@arm.com>
> 
> ACPI configurations can now mark devices as noncoherent,
> support that choice.
> 
> NOTE: This is required to support USB on ARM Juno Development Board.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> ---
>  include/acpi/acpi_bus.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
