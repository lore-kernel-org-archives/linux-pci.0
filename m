Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48080 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbeHRKqL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Aug 2018 06:46:11 -0400
Message-ID: <9e654e989967e029815fc3b1c7e5f0cbc5d6d6e9.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: poza@codeaurora.org
Cc: Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org
Date: Sat, 18 Aug 2018 17:38:58 +1000
In-Reply-To: <65ec0c5b4682c0f0215114ac09d46cf5@codeaurora.org>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
         <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
         <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
         <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
         <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
         <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
         <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
         <5bd99bcacb772b588771fce62c61a59fdeb167f3.camel@kernel.crashing.org>
         <290750445f084c479963f54dd36af63a@codeaurora.org>
         <05bc3bccb2c6a0cb1696faf20073e567d7a5b8ee.camel@kernel.crashing.org>
         <2894d8df6e44860456377dade9ea5737@codeaurora.org>
         <9c7c60eb765c61d007169c9142fb335b0a4080df.camel@kernel.crashing.org>
         <c00a1ad4ffbf7ccecf3c8d05df4d8d82@codeaurora.org>
         <def1568d0c8ce9a455760da1271724d6e65a3286.camel@kernel.crashing.org>
         <65ec0c5b4682c0f0215114ac09d46cf5@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-08-17 at 15:59 +0530, poza@codeaurora.org wrote:
> 
> The existing design is; framework dictating drivers what it should do 
> rather than driver deciding.
> let me explain.

The AER code design might be but it's not what was documented in
Documentation/PCI/pci-error-recovery.txt before you changed it !

And it's not what about 20 years of doing PCI error recovery before
there even was such a thing as PCIe or AER taught us on powerpc.

The basic idea is that the "action" to be taken to recover is the
"deepest" of all the ones requested by the framework and all the
involved drivers (more than one device could be part of an error
handling "domain" under some circumstances, for example when the
failure originates from a bridge).

What the PCIe spec says is rather uninteresting and can be trusted as
far as policy is concern about as much as you can trust HW to be
compliant with it, that is about zilch.

The only interesting thing to take from the spec is that in the case of
a FATAL error, you *must* at least reset the link. That's it. It
doesn't mean that you shouldn't reset more (PERST for example) and it
doesn't mean that you shouldn't reset the device or link for a
NON_FATAL error either. And even if it did we should ignore it.

There are many reasons why a driver might request a reset. For example,
the error, while non-fatal to the link itself, might still have
triggered a non-recoverable event in the device, either in HW or SW,
and the only safe way out might well be a reset.

On POWER systems, with EEH HW support, we have additional rules that
say that on *any* non-corrected error (and under some circumstances if
corrected errors cross a certain threshold) will isolate the device
completely and the typical recovery from that is a reset (it doesn't
*have* to be but that's what most drivers chose).

This is rules design to prevent propagation of potentially corrupted
data which is considering way more important than QoS of the device.

We should see if we can make some of the AER and EEH code more common,
the first thing would be to take things out of pcie/ since EEH isn't
PCIe specific, and abstract the recovery process from the underlying
architecture hooks to perform things like reset etc...
 
> aer_isr
>      aer_isr_one_error
>           get_device_error_info   >> this checks
>                {
>                  /* Link is still healthy for IO reads */    >> Bjorn 
> this looks like a very strange thing to me, if link is not healthy we 
> are not even going for pcie_do_fatal_recovery()
> 		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS,
> 			&info->status);
> 		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK,
> 			&info->mask);
> 		if (!(info->status & ~info->mask))
> 			return 0;
> 
>                {
>          handle_error_source
>          pcie_do_nonfatal_recovery or pcie_do_fatal_recovery
> 
> now it does not seem to me that driver has some way of knowing if it has 
> to return PCI_ERS_RESULT_CAN_RECOVER ? or PCI_ERS_RESULT_NEED_RESET?

You don't know that. A driver can look at the device state at the
enable_mmio phase and decide that the device is sufficiently sane that
it can continue... or not. A driver could have a policy of always
resetting. Etc...

> let us take an example of storage driver here e.g. NVME
> nvme_error_detected()  relies heavily on pci_channel_state_t which is 
> passed by error framework  (err.c)

So what ? This is one example... the IPR SCSI driver is much more
complex in its error recovery afaik.

> I understand your point of view and original intention of design that 
> let driver dictate whether it wants slot_reset ?

It's both the driver *and* the framework, which ever wants the
"harshest" solution wins. If either wants a reset we do a reset.

> but driver relies on framework to pass that information in order to take 
> decision.

No. Some drivers might. This is by no means the absolute rule. There
are also all other type of errors that aren't covered by the AER
categories that fit in that framework such as iommu errors (at least
for us on powerpc).

> In case of pci_channel_io_frozen  (which is ERR_FATAL), most of the 
> drivers demand link reset.

No, they demand a *device* reset. ie, hot reset or PERST. It's not
about the link. It's about the device.

> but in case of ERR_NONFATAL, the link is supposed to be functional and 
> there is no need for link reset.

It depends whether the error was corrected or not. If it was not
corrected, then something bad did happen and the framework has no way
to know what is the appropriate remediation for a given device.

> and exactly all the PCI based drivers returns 
> PCI_ERS_RESULT_CAN_RECOVER, which is valid.

You are mixing the AER terminology of FATAL/NON_FATAL which is AER
specific and the framework defined channel states, which are
"functional", "frozen" and "permanently dead". These don't necessarily
match 1:1.

> so I think to conclude, you are referring more of your views towards
> pcie_do_fatal_recovery()

Both. But yes, pcie_do_fatal_recovery() should definitely NOT do an
unplug/replug blindly. The whole point of the error handlers was to
allow driver to recover from these things without losing the links to
their respective consumers (such as filesystems for block devices).

> which does
> 
> > remove_devices from the downstream link
> > reset_link()   (Secondary bus reset)
> > re-enumerate.
> 
> and this is what DPC defined, and AER is just following that.

And is completely and utterly broken and useless as a policy.

Again, somebody cared too much about the spec rather than what makes
actual sense in practice.

You should *only* remove devices if the driver doesn't have the
necessary callbacks.

In fact, remove and re-plug device is probably the worst thing you can
do, I don't remember all the details but it's been causing us endless
issues with EEH, which is why as I mentioned, we are looking more
toward an unbind and rebind of the driver, but that's a details.

If the driver has the error callbacks it should participate in the
recovery and NOT be unbound or the device unplugged. That's completely
useless for Linux to do that since it means you cannot recover from an
error on a storage driver.

Ben.

> Regards,
> Oza.
> 
> > 
> > Also because multiple devices, at least on power, can share a domain,
> > we can get into a situation where one device requires a reset, so all
> > will get reset, and their respective drivers need to be notified.
> > 
> > Note: it's not so much about resetting the *link* than about resetting
> > the *device*.
> > 
> > > although
> > > I see following note in the code as well.
> > >                  /*
> > > 		 * TODO: Should call platform-specific
> > > 		 * functions to reset slot before calling
> > > 		 * drivers' slot_reset callbacks?
> > > 		 */
> > 
> > Yup :-)
> > 
> > Cheers,
> > Ben.
> > 
> > > Regards,
> > > Oza.
> > > 
> > > > 
> > > > Also we should do a hot reset at least, not just a link reset.
> > > > 
> > > > >      report_resume()
> > > > > 
> > > > > If you suggest how it is broken, it will help me to understand.
> > > > > probably you might want to point out what are the calls need to be
> > > > > added
> > > > > or removed or differently handled, specially storage point of view.
> > > > 
> > > > 
> > > > > Regards,
> > > > > Oza.
> > > > > 
> > > > > > 
> > > > > > Keep in mind that those callbacks were designed originally for EEH
> > > > > > (which predates AER), and so was the spec written.
> > > > > > 
> > > > > > We don't actually use the AER code on POWER today, so we didn't notice
> > > > > > how broken the implementation was :-)
> > > > > > 
> > > > > > We should fix that.
> > > > > > 
> > > > > > Either we can sort all that out by email, or we should plan some kind
> > > > > > of catch-up, either at Plumbers (provided I can go there) or maybe a
> > > > > > webex call.
> > > > > > 
> > > > > > Cheers,
> > > > > > Ben.
