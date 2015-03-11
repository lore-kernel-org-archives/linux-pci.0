Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:38064 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbbCKUUg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2015 16:20:36 -0400
Received: by qgdz60 with SMTP id z60so13085249qgd.5
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2015 13:20:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1426104871.3643.17.camel@redhat.com>
References: <20150304194711.26766.75450.stgit@gimli.home> <20150304200243.26766.556.stgit@gimli.home>
 <20150306221121.GA14814@google.com> <1426104871.3643.17.camel@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 11 Mar 2015 15:20:15 -0500
Message-ID: <CAErSpo5DH+o6vS0mtjbBmAO+BObXoX4QQ88-7NgHfUFb2a4nmw@mail.gmail.com>
Subject: Re: [PATCH 1/5] vfio-pci: Allow PCI IDs to be specified as module options
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 11, 2015 at 3:14 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Fri, 2015-03-06 at 16:11 -0600, Bjorn Helgaas wrote:
>> On Wed, Mar 04, 2015 at 01:02:43PM -0700, Alex Williamson wrote:
>> > This copies the same support from pci-stub for exactly the same
>> > purpose, enabling a set of PCI IDs to be automatically added to the
>> > driver's dynamic ID table at module load time.  The code here is
>> > pretty simple and both vfio-pci and pci-stub are fairly unique in
>> > being meta drivers, capable of attaching to any device, so there's no
>> > attempt made to generalize the code into pci-core.
>> >
>> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>> > ---
>> >  drivers/vfio/pci/vfio_pci.c |   46 +++++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 46 insertions(+)
>> >
>> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> > index f8a1863..b3bae4c 100644
>> > --- a/drivers/vfio/pci/vfio_pci.c
>> > +++ b/drivers/vfio/pci/vfio_pci.c
>> > @@ -32,6 +32,10 @@
>> >  #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
>> >  #define DRIVER_DESC     "VFIO PCI - User Level meta-driver"
>> >
>> > +static char ids[1024] __initdata;
>> > +module_param_string(ids, ids, sizeof(ids), 0);
>> > +MODULE_PARM_DESC(ids, "Initial PCI IDs to add to the vfio driver, format is \"vendor:device[:subvendor[:subdevice[:class[:class_mask]]]]\" and multiple comma separated entries can be specified");
>> > +
>> >  static bool nointxmask;
>> >  module_param_named(nointxmask, nointxmask, bool, S_IRUGO | S_IWUSR);
>> >  MODULE_PARM_DESC(nointxmask,
>> > @@ -1034,6 +1038,46 @@ static void __exit vfio_pci_cleanup(void)
>> >     vfio_pci_uninit_perm_bits();
>> >  }
>> >
>> > +static void __init vfio_pci_fill_ids(void)
>> > +{
>> > +   char *p, *id;
>> > +   int rc;
>> > +
>> > +   /* no ids passed actually */
>> > +   if (ids[0] == '\0')
>> > +           return;
>> > +
>> > +   /* add ids specified in the module parameter */
>> > +   p = ids;
>> > +   while ((id = strsep(&p, ","))) {
>> > +           unsigned int vendor, device, subvendor = PCI_ANY_ID,
>> > +                   subdevice = PCI_ANY_ID, class = 0, class_mask = 0;
>> > +           int fields;
>> > +
>> > +           if (!strlen(id))
>> > +                   continue;
>> > +
>> > +           fields = sscanf(id, "%x:%x:%x:%x:%x:%x",
>> > +                           &vendor, &device, &subvendor, &subdevice,
>> > +                           &class, &class_mask);
>> > +
>> > +           if (fields < 2) {
>> > +                   pr_warn("vfio-pci: invalid id string \"%s\"\n", id);
>> > +                   continue;
>> > +           }
>> > +
>> > +           pr_info("vfio-pci: add %04X:%04X sub=%04X:%04X cls=%08X/%08X\n",
>>
>> pci_setup_device() uses "[%04x:%04x] ... class %#08x".  Maybe they should
>> be the same, at least as far as using upper/lower case, spelling out
>> "class", and "0x" prefix.  Maybe there's other precedent that you're
>> following and pci_setup_device() is not?
>
> Sorry for not responding to this right away.  The precedent I was
> following is pci_stub_init(), but I don't know that it's any sort of
> canonical reference.  PCI output in dmesg seems pretty consistent in
> using lower case hex, so I agree we should make that change.  I also
> note that the default value for sub IDs is PCI_ANY_ID, which ends up
> getting printed as 8 characters since we don't specify the length.  I'm
> also not a fan of the lack of consistency in printing the ID vs the sub
> ID nor how the line wraps in dmesg w/ timestamps enabled.  What do you
> think about this:
>
> [%04hx:%04hx[%04hx:%04hx]] class %#08x/%08x
>
> Which gives us this and doesn't wrap:
>
> [   92.731809] vfio_pci: add [10de:11fa[ffff:ffff]] class 0x000000/00000000
> [   92.738530] vfio_pci: add [10de:0e0b[ffff:ffff]] class 0x000000/00000000

Looks OK to me.
