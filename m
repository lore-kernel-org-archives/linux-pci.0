Return-Path: <SRS0=nKW4=7G=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=nKW4=7G=broadcom.com=oza.oza@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170804133753.GD16580@bhelgaas-glaptop.roam.corp.google.com>
References: <1499310582-21193-1-git-send-email-oza.oza@broadcom.com>
 <1499310582-21193-2-git-send-email-oza.oza@broadcom.com> <20170802210455.GF20308@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPcfUFmjg471qmzqQmayNYzfq8Wo7yfHeiEKrj7hkWF=zg@mail.gmail.com>
 <20170803185713.GV20308@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPcbnVefeVVh3HJd1M+8co+4VMj8HU2zmXMv4K5VGcdjVg@mail.gmail.com> <20170804133753.GD16580@bhelgaas-glaptop.roam.corp.google.com>
From: Oza Oza <oza.oza@broadcom.com>
Date: Fri, 4 Aug 2017 19:45:03 +0530
Message-ID: <CAMSpPPfgVvgT4ZGZ0=tu+XQnP7zshQWMKGdYihu2UiShE2awtg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PCI: iproc: Retry request when CRS returned from EP
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>, linux-pci <linux-pci@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 4, 2017 at 7:07 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Aug 04, 2017 at 11:29:29AM +0530, Oza Oza wrote:
>> On Fri, Aug 4, 2017 at 12:27 AM, Bjorn Helgaas <helgaas@kernel.org> wrot=
e:
>> > On Thu, Aug 03, 2017 at 01:50:29PM +0530, Oza Oza wrote:
>> >> On Thu, Aug 3, 2017 at 2:34 AM, Bjorn Helgaas <helgaas@kernel.org> wr=
ote:
>> >> > On Thu, Jul 06, 2017 at 08:39:41AM +0530, Oza Pawandeep wrote:
>
>> >> this is documented in our PCIe core hw manual.
>> >> >>
>> >> 4.7.3.3. Retry Status On Configuration Cycle
>> >> Endpoints are allowed to generate retry status on configuration
>> >> cycles.  In this case, the RC needs to re-issue the request.  The IP
>> >> does not handle this because the number of configuration cycles neede=
d
>> >> will probably be less
>> >> than the total number of non-posted operations needed.   When a retry=
 status
>> >> is received on the User RX interface for a configuration request that
>> >> was sent on the User TX interface, it will be indicated with a
>> >> completion with the CMPL_STATUS field set to 2=3DCRS, and the user wi=
ll
>> >> have to find the address and data values and send a new transaction o=
n
>> >> the User TX interface.
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
>> >> >>
>> >> Broadcom does not sell PCIe core IP, so above information is not
>> >> publicly available in terms of hardware erratum or any similar note.
>> >>
>> >>
>> >> >
>> >> >> As a result of the fact, PCIe RC driver (sw) should take care of C=
RS.
>> >> >> This patch fixes the problem, and attempts to read config space ag=
ain in
>> >> >> case of PCIe code forwarding the CRS back to CPU.
>> >> >> It implements iproc_pcie_config_read which gets called for Stingra=
y,
>> >> >> Otherwise it falls back to PCI generic APIs.
> ...
>
>> >> >> +static int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
>> >> >> +{
>> >> >> +     int timeout =3D CFG_RETRY_STATUS_TIMEOUT_US;
>> >> >> +     unsigned int ret;
>> >> >> +
>> >> >> +     /*
>> >> >> +      * As per PCI spec, CRS Software Visibility only
>> >> >> +      * affects config read of the Vendor ID.
>> >> >> +      * For config write or any other config read the Root must
>> >> >> +      * automatically re-issue configuration request again as a
>> >> >> +      * new request. Iproc based PCIe RC (hw) does not retry
>> >> >> +      * request on its own, so handle it here.
>> >> >> +      */
>> >> >> +     do {
>> >> >> +             ret =3D readl(cfg_data_p);
>> >> >> +             if (ret =3D=3D CFG_RETRY_STATUS)
>> >> >> +                     udelay(1);
>> >> >> +             else
>> >> >> +                     return PCIBIOS_SUCCESSFUL;
>> >> >> +     } while (timeout--);
>> >> >
>> >> > Shouldn't this check *where* in config space we're reading?
>> >> >
>> >> No, we do not require, because with SPDK it was reading BAR space
>> >> which points to MSI-x table.
>> >> what I mean is, it could be anywhere.
>> >
>> > The documentation above says the IP returns data of 0x0001 for *reads
>> > of offset 0*.  Your current code reissues the read if *any* read
>> > anywhere returns data that happens to match CFG_RETRY_STATUS.  That
>> > may be a perfectly valid register value for some device's config
>> > space.  In that case, you do not want to reissue the read and you do
>> > not want to timeout.
>>
>> ok, so the documentation is about PCIe core IP,
>> It is not about the host bridge. (PCI to AXI bridge)
>>
>> PCIe core forwards 0x0001 return code to host bridge, and converts it
>> into 0xffff0001.
>> which is hard wired.
>> we have another HW layer on top of PCIe core which implements lots of
>> logic. (host bridge)
>>
>> I agree with you that, it could be valid data, but our ASIC conveyed
>> that they have chosen the code
>> such that this data is unlikely to be valid.
>
> Hehe.  I think it's more likely that they chose this value because
> it's mentioned in the spec for CRS.  I doubt it has anything to do
> with it being "unlikely".  Or maybe it really is just a coincidence :)
>
> In any event, your documentation says this data is only fabricated for
> reads at offset 0.  So why do you check for it for *all* reads?
>
>> however I have found one case where this data is valid.
>> which is; BAR exposing 64-bit IO memory, which seems legacy and is rare =
as well.
>>
>> however in our next chip revision, ASIC will give us separate CRS
>> register in our host-bridge.
>> We will be retrying on that register instead of this code. but that
>> will be the minor code change.
>
> It would be a lot better if your next chip revision handled CRS in
> hardware.  It's not clear this can be done correctly in software and
> even if it can, you're always going to be the exception, which means
> it's likely to continue to be a source of bugs.
>
>> > The PCIe spec says that if CRS software visibility is enabled and we
>> > get a CRS completion for a config read of the Vendor ID at offset 0,
>> > the read should not be retried, and the read should return 0x0001.
>> > For example, pci_bus_read_dev_vendor_id() should see that 0x0001
>> > value.
>> >
>> > That's not what this code does.  If the readl() returns
>> > CFG_RETRY_STATUS, you do the delay and reissue the read.  You never
>> > return 0x0001 to the caller of pci_bus_read_config_word().
>> >
>>
>> As far as I understand, PCI config access APIs do not check for RETRY.
>> Also caller of them such as __pci_read_base, do not check for retry.
>
> Of course not.  PCIe r3.1, sec 2.3.2, says the CRS status is only
> visible to software if (1) CRS software visibility is enabled and
> (2) we're reading the Vendor ID.  In all other cases, the Root
> Complex must reissue the request, which is invisible to software.
>

yes, agree about spec, but as I mentioned even if CRS software
visibility bit is enabled.
the behavior of both PCIe core and AXI host bridge remains the same.
there is no effect of that bit.

> Bjorn
