Return-Path: <SRS0=YWk+=5Z=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=YWk+=5Z=broadcom.com=oza.oza@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170619223907.GD554@bhelgaas-glaptop.roam.corp.google.com>
References: <1497153938-26074-1-git-send-email-oza.oza@broadcom.com>
 <1497153938-26074-2-git-send-email-oza.oza@broadcom.com> <20170612233039.GC4379@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPchnNBnKmeXvhcWTM0Kzdb4b9mvTKXJsHe4KzJ=kk8M=Q@mail.gmail.com> <20170619223907.GD554@bhelgaas-glaptop.roam.corp.google.com>
From: Oza Oza <oza.oza@broadcom.com>
Date: Tue, 20 Jun 2017 18:14:35 +0530
Message-ID: <CAMSpPPfTA+DWxzZNxL94O-rHQQvp4DOsfMwtNXtLzi2=tHBSOw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: iproc: Retry request when CRS returned from EP
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>, linux-pci <linux-pci@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 20, 2017 at 4:09 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Jun 13, 2017 at 09:58:22AM +0530, Oza Oza wrote:
>> On Tue, Jun 13, 2017 at 5:00 AM, Bjorn Helgaas <helgaas@kernel.org> wrot=
e:
>> > Please wrap your changelogs to use 75 columns.  "git log" indents the
>> > changelog by four spaces, so if your text is 75 wide, it will still
>> > fit without wrapping.
>> >
>> > On Sun, Jun 11, 2017 at 09:35:37AM +0530, Oza Pawandeep wrote:
>> >> For Configuration Requests only, following reset
>> >> it is possible for a device to terminate the request
>> >> but indicate that it is temporarily unable to process
>> >> the Request, but will be able to process the Request
>> >> in the future =E2=80=93 in this case, the Configuration Request
>> >> Retry Status 10 (CRS) Completion Status is used
>> >
>> > How does this relate to the CRS support we already have in the core,
>> > e.g., pci_bus_read_dev_vendor_id()?  It looks like your root complex
>> > already returns 0xffff0001 (CFG_RETRY_STATUS) in some cases.
>> >
>> > Also, per spec (PCIe r3.1, sec 2.3.2), CRS Software Visibility only
>> > affects config reads of the Vendor ID, but you call
>> > iproc_pcie_cfg_retry() for all config offsets.
>>
>> Yes, as per Spec, CRS Software Visibility only affects config read of
>> the Vendor ID.
>> For config write or any other config read the Root must automatically
>> re-issue configuration
>> request again as a new request, and our PCIe RC fails to do so.
>
> OK, if this is a workaround for a hardware defect, let's make that
> explicit in the changelog (and probably a comment in the code, too).
>
> I'm actually not sure the spec *requires* the CRS retries to be done
> directly in hardware, so it's conceivable the hardware could be
> working as designed.  But a comment would go a long way toward making
> this understandable by differentiating it from the generic CRS
> handling in the core.
>
> Bjorn

Sure, I will update the commit message and also will add explicit
comment in the code.

Regards,
Oza.
