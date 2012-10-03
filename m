Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56575 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab2JCDKW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 23:10:22 -0400
Received: by pbbrr4 with SMTP id rr4so9395277pbb.19
        for <linux-pci@vger.kernel.org>; Tue, 02 Oct 2012 20:10:22 -0700 (PDT)
Date: Tue, 2 Oct 2012 20:10:18 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Don Dutile <ddutile@redhat.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	davem@davemloft.net
Subject: Re: [RFC] PCI: enable and disable sriov support via sysfs at per
 device level
Message-ID: <20121003031018.GB13391@kroah.com>
References: <1349134020-62152-1-git-send-email-ddutile@redhat.com>
 <CAE9FiQUd=sM3XaMKfJjnJq6mkugL7P=wEjdcMHtGjfe4ooRXUQ@mail.gmail.com>
 <506B4D4C.3080101@redhat.com>
 <20121002203951.GA28663@kroah.com>
 <506B575A.4060304@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <506B575A.4060304@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 02, 2012 at 05:06:34PM -0400, Don Dutile wrote:
> On 10/02/2012 04:39 PM, Greg Kroah-Hartman wrote:
> >On Tue, Oct 02, 2012 at 04:23:40PM -0400, Don Dutile wrote:
> >>Greg: Why not use the above functions?
> >
> >What "above functions"?  You make a lot of calls in the code :)
> >
> >You are creating an attribute group, and then manually walking through
> >it to create/destroy the file?  That's not good, use the in-kernel
> >functions to do that automatically for you.
> >
> >Also, you need to do this _before_ the device shows up to userspace,
> >otherwise you have a race that you just lost with udev and the like.
> >
> >thanks,
> >
> >greg k-h
> 
> So, why is it ok to create the 'reset' file after the device shows up?

It's not, that should be fixed, patches are always welcome.

> Like reset, SRIOV is optional.  The sysfs files are designed to only
> be used by userspace utils to enable/disable VFs after the system is up.
> 
> Or should the design allow a udev rule to be created that if one
> of these new sriov files exists, then perform a set of read-max-vf &
> enable n-vf ops ?

Yes it should.  Never create sysfs files after the device is present in
the system, otherwise userspace never knows about it.

thanks,

greg k-h
