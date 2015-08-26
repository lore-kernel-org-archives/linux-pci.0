Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: bhelgaas@google.com, lenb@kernel.org, catalin.marinas@arm.com,
	will.deacon@arm.com, hanjun.guo@linaro.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH V2 2/4] ACPI/scan: Clean up acpi_check_dma
Date: Wed, 26 Aug 2015 04:44:20 +0200
Message-ID: <1937405.90E8lxrvy8@vostro.rjw.lan>
In-Reply-To: <55DD1DB7.1020203@amd.com>
References: <1440524009-5359-1-git-send-email-Suravee.Suthikulpanit@amd.com> <1659571.paO1iYcMuM@vostro.rjw.lan> <55DD1DB7.1020203@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 26, 2015 09:00:23 AM Suravee Suthikulpanit wrote:
> Hi Rafael,
> 
> On 8/26/15 06:48, Rafael J. Wysocki wrote:
> 
> >[...]
> > On Wednesday, August 26, 2015 12:33:27 AM Suravee Suthikulpanit wrote:
> >> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> >> index b9657af..55cf916 100644
> >> --- a/drivers/acpi/glue.c
> >> +++ b/drivers/acpi/glue.c
> >> @@ -168,7 +168,7 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
> >>   	struct list_head *physnode_list;
> >>   	unsigned int node_id;
> >>   	int retval = -EINVAL;
> >> -	bool coherent;
> >> +	int coherent;
> >
> > enum, anyone?  With clearly defined values?
> 
> Originally I had defined
> 
> enum acpi_dma_coherency {
> 	ACPI_DMA_NON_COHERENT,
> 	ACPI_DMA_COHERENT,
> 	APCI_DMA_NOT_SUPPORTED = -1,
> };
> 
> Although, this would need to be defined in the include/linux/acpi.h, and 
> will be used also for #ifndef CONFIG_ACPI code to return errors. I was 
> not sure if this would be too much. If this is preferred, I'll add this 
> back in.
> 
> >>
> >>   	if (has_acpi_companion(dev)) {
> >>   		if (acpi_dev) {
> >> @@ -225,7 +225,8 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
> >>   	if (!has_acpi_companion(dev))
> >>   		ACPI_COMPANION_SET(dev, acpi_dev);
> >>
> >> -	if (acpi_check_dma(acpi_dev, &coherent))
> >> +	coherent = acpi_check_dma_coherency(acpi_dev);
> >> +	if (coherent != -1)
> >
> > Like here I'm not sure why -1 is special?
> 
> It's just another value to communicate that DMA is not supported. :)

OK

So maybe use 0/1 for the coherence thing and a proper error code
(-ENOTSUPP seems to be a good candidate) for the "no DMA" case?

Then, if you rename the local variable to something like "ret",
it will be slightly less confusing.

And instead of checking against a specific negative value, you can
simply use "if (stuff < 0)" or "if (stuff >= 0)" to check whether or
not it is supported at all.

Thanks,
Rafael

