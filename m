Return-Path: <SRS0=Bcxn=76=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=Bcxn=76=broadcom.com=oza.oza@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170828195402.GK8154@bhelgaas-glaptop.roam.corp.google.com>
References: <1503551066-23212-1-git-send-email-oza.oza@broadcom.com>
 <1503551066-23212-3-git-send-email-oza.oza@broadcom.com> <20170828191708.GJ8154@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPf5LJqvjFdrsR0hXK7oq2n38zCUjEpdmV0m8h6R_oiEXg@mail.gmail.com> <20170828195402.GK8154@bhelgaas-glaptop.roam.corp.google.com>
From: Oza Oza <oza.oza@broadcom.com>
Date: Tue, 29 Aug 2017 02:15:42 +0530
Message-ID: <CAMSpPPddi7sCk6_tDTZZx2SWetmopOgm23QVXNqjOAX=PNp9iA@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] PCI: iproc: retry request when CRS returned from EP
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>, linux-pci <linux-pci@vger.kernel.org>,
	devicetree@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-kernel@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 29, 2017 at 1:24 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Aug 29, 2017 at 01:09:53AM +0530, Oza Oza wrote:
>> On Tue, Aug 29, 2017 at 12:47 AM, Bjorn Helgaas <helgaas@kernel.org> wro=
te:
>> > On Thu, Aug 24, 2017 at 10:34:25AM +0530, Oza Pawandeep wrote:
>> >> PCIe spec r3.1, sec 2.3.2
>> >> If CRS software visibility is not enabled, the RC must reissue the
>> >> config request as a new request.
>> >>
>> >> - If CRS software visibility is enabled,
>> >> - for a config read of Vendor ID, the RC must return 0x0001 data
>> >> - for all other config reads/writes, the RC must reissue the
>> >>   request
>> >>
>> >> iproc PCIe Controller spec:
>> >> 4.7.3.3. Retry Status On Configuration Cycle
>> >> Endpoints are allowed to generate retry status on configuration
>> >> cycles. In this case, the RC needs to re-issue the request. The IP
>> >> does not handle this because the number of configuration cycles neede=
d
>> >> will probably be less than the total number of non-posted operations
>> >> needed.
>> >>
>> >> When a retry status is received on the User RX interface for a
>> >> configuration request that was sent on the User TX interface,
>> >> it will be indicated with a completion with the CMPL_STATUS field set
>> >> to 2=3DCRS, and the user will have to find the address and data value=
s
>> >> and send a new transaction on the User TX interface.
>> >> When the internal configuration space returns a retry status during a
>> >> configuration cycle (user_cscfg =3D 1) on the Command/Status interfac=
e,
>> >> the pcie_cscrs will assert with the pcie_csack signal to indicate the
>> >> CRS status.
>> >> When the CRS Software Visibility Enable register in the Root Control
>> >> register is enabled, the IP will return the data value to 0x0001 for
>> >> the Vendor ID value and 0xffff  (all 1=E2=80=99s) for the rest of the=
 data in
>> >> the request for reads of offset 0 that return with CRS status.  This
>> >> is true for both the User RX Interface and for the Command/Status
>> >> interface.  When CRS Software Visibility is enabled, the CMPL_STATUS
>> >> field of the completion on the User RX Interface will not be 2=3DCRS =
and
>> >> the pcie_cscrs signal will not assert on the Command/Status interface=
.
>> >>
>> >> Per PCIe r3.1, sec 2.3.2, config requests that receive completions
>> >> with Configuration Request Retry Status (CRS) should be reissued by
>> >> the hardware except reads of the Vendor ID when CRS Software
>> >> Visibility is enabled.
>> >>
>> >> This hardware never reissues configuration requests when it receives
>> >> CRS completions.
>> >> Note that, neither PCIe host bridge nor PCIe core re-issues the
>> >> request for any configuration offset.
>> >>
>> >> For config reads, this hardware returns CFG_RETRY_STATUS data when
>> >> it receives a CRS completion for a config read, regardless of the
>> >> address of the read or the CRS Software Visibility Enable bit.
>> >
>> > I can't remember how Stingray handles the CRS Software Visibility Enab=
le
>> > bit.  Is it a read-only zero?  Is it writable?  Does the hardware look=
 at
>> > it all (I think not)?
>>
>> HW doesnt look it at all, it is "dont care" bit.
>
> Sigh, I made the classic mistake of asking more than one question, and
> I guess I'm about to do it again :)  It'll save time if you can answer
> all the questions at once.
>
> Linux enables PCI_EXP_RTCTL_CRSSVE if PCI_EXP_RTCAP says it is
> supported (see pci_enable_crs()).
>
>   - What does PCI_EXP_RTCAP say?
it is rea as set: value :0x1
>
>   - Is PCI_EXP_RTCTL_CRSSVE writable?
yes: it is:
read as 0 and written as 1.
>
> With all the CRS-related work going on, I suspect we may someday want to
> read PCI_EXP_RTCTL_CRSSVE to see if CRS SV is enabled.
>
> Bjorn
