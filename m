Return-Path: <SRS0=dahA=IM=netronome.com=jakub.kicinski@kernel.org>
Return-Path: <SRS0=dahA=IM=netronome.com=jakub.kicinski@kernel.org>
Date: Thu, 24 May 2018 18:20:15 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, Sathya Perla <sathya.perla@broadcom.com>, Felix
 Manlunas <felix.manlunas@caviumnetworks.com>, alexander.duyck@gmail.com,
 john.fastabend@gmail.com, Jacob Keller <jacob.e.keller@intel.com>, Donald
 Dutile <ddutile@redhat.com>, oss-drivers@netronome.com, Christoph Hellwig
 <hch@infradead.org>
Subject: Re: [PATCH] PCI: allow drivers to limit the number of VFs to 0
Message-ID: <20180524182015.1af7b4c9@cakuba>
In-Reply-To: <20180524235748.GD15320@bhelgaas-glaptop.roam.corp.google.com>
References: <20180402224652.4058-1-jakub.kicinski@netronome.com>
	<20180524235748.GD15320@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn!

On Thu, 24 May 2018 18:57:48 -0500, Bjorn Helgaas wrote:
> On Mon, Apr 02, 2018 at 03:46:52PM -0700, Jakub Kicinski wrote:
> > Some user space depends on enabling sriov_totalvfs number of VFs
> > to not fail, e.g.:
> > 
> > $ cat .../sriov_totalvfs > .../sriov_numvfs
> > 
> > For devices which VF support depends on loaded FW we have the
> > pci_sriov_{g,s}et_totalvfs() API.  However, this API uses 0 as
> > a special "unset" value, meaning drivers can't limit sriov_totalvfs
> > to 0.  Remove the special values completely and simply initialize
> > driver_max_VFs to total_VFs.  Then always use driver_max_VFs.
> > Add a helper for drivers to reset the VF limit back to total.  
> 
> I still can't really make sense out of the changelog.
>
> I think part of the reason it's confusing is because there are two
> things going on:
> 
>   1) You want this:
>   
>        pci_sriov_set_totalvfs(dev, 0);
>        x = pci_sriov_get_totalvfs(dev) 
> 
>      to return 0 instead of total_VFs.  That seems to connect with
>      your subject line.  It means "sriov_totalvfs" in sysfs could be
>      0, but I don't know how that is useful (I'm sure it is; just
>      educate me :))

Let me just quote the bug report that got filed on our internal bug
tracker :)

  When testing Juju Openstack with Ubuntu 18.04, enabling SR-IOV causes
  errors because Juju gets the sriov_totalvfs for SR-IOV-capable device
  then tries to set that as the sriov_numvfs parameter.

  For SR-IOV incapable FW, the sriov_totalvfs parameter should be 0, 
  but it's set to max.  When FW is switched to flower*, the correct 
  sriov_totalvfs value is presented.

* flower is a project name

My understanding is OpenStack uses sriov_totalvfs to determine how many
VFs can be enabled, looks like this is the code:

http://git.openstack.org/cgit/openstack/charm-neutron-openvswitch/tree/hooks/neutron_ovs_utils.py#n464

>   2) You're adding the pci_sriov_reset_totalvfs() interface.  I'm not
>      sure what you intend for this.  Is *every* driver supposed to
>      call it in .remove()?  Could/should this be done in the core
>      somehow instead of depending on every driver?

Good question, I was just thinking yesterday we may want to call it
from the core, but I don't think it's strictly necessary nor always
sufficient (we may reload FW without re-probing).

We have a device which supports different number of VFs based on the FW
loaded.  Some legacy FWs does not inform the driver how many VFs it can
support, because it supports max.  So the flow in our driver is this:

load_fw(dev);
...
max_vfs = ask_fw_for_max_vfs(dev);
if (max_vfs >= 0)
	return pci_sriov_set_totalvfs(dev, max_vfs);
else /* FW didn't tell us, assume max */
	return pci_sriov_reset_totalvfs(dev); 

We also reset the max on device remove, but that's not strictly
necessary.

Other users of pci_sriov_set_totalvfs() always know the value to set
the total to (either always get it from FW or it's a constant).

If you prefer we can work out the correct max for those legacy cases in
the driver as well, although it seemed cleaner to just ask the core,
since it already has total_VFs value handy :)

> I'm also having a hard time connecting your user-space command example
> with the rest of this.  Maybe it will make more sense to me tomorrow
> after some coffee.

OpenStack assumes it will always be able to set sriov_numvfs to
sriov_totalvfs, see this 'if':

http://git.openstack.org/cgit/openstack/charm-neutron-openvswitch/tree/hooks/neutron_ovs_utils.py#n512

I tried to morph that into an concise bash command, but clearly failed.
Sorry about the lack of clarity! :(
