Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50059 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610Ab3JXIMK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Oct 2013 04:12:10 -0400
Date: Thu, 24 Oct 2013 09:12:05 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
To: Niilona <niilona@gmail.com>
Cc: linux-pci@vger.kernel.org, libvir-list <libvir-list@redhat.com>
Subject: Re: [libvirt] PATCH: pci-subsystem: ixgbe: SR-IOV: kernel way to
 order driver's virtfn -entries is odd causing libvirt failures.
Message-ID: <20131024081205.GA7503@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAE5WV7OXKGvOCTOyZyK5cOCA2nxpN1WcDdqj9h+pakyhgT2sTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAE5WV7OXKGvOCTOyZyK5cOCA2nxpN1WcDdqj9h+pakyhgT2sTA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 24, 2013 at 09:52:31AM +0300, Niilona wrote:
> Hi.
> 
> As Bjorn Helgaas recommend, this might be the item to discuss in the wider area.
> -----------------------------------
> 
> There is a behavior effecting virtfn -entries in sysfs, when amount of
> them increases over 10.
> Run VM's through LIBVIRT -> QEMU/KVM, this causes :
> - MAC address setting by LIBVIRT disordered ie. setting targeted to wrong VF.
> - VLAN setting by LIBVIRT overall failed
> 
> Basics of this are in "/libvirt-x.x.x/src/util/virpci.c" ; in function below,
> which don't order virtfn entries correctly.
> 
> /*
>  * Returns virtual functions of a physical function
>  */
> int
> virPCIGetVirtualFunctions(const char *sysfs_path,
>                           virPCIDeviceAddressPtr **virtual_functions,
>                           unsigned int *num_virtual_functions)
> {
> 
> But I let you to decide which is best way to fix this, as if every
> application reads "virtfn" entries from PF's directory, they all need
> to sort entries in alphabet. order to avoid this
> influence.
> So personally I did get over this by adding pre-zeroes to names to
> have them in sorted order in PF's directory.

Libvirt has to work correctly with all existing released kernels,
so we have to fix libvirt to deal with ordering correctly. Thus
changing the kernel naming here doesn't really help. We need to
fix libvirt to deal with this.

Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
