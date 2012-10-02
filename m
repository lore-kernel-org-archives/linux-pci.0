Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36054 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752814Ab2JBUjx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 16:39:53 -0400
Date: Tue, 2 Oct 2012 13:39:51 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Don Dutile <ddutile@redhat.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	davem@davemloft.net
Subject: Re: [RFC] PCI: enable and disable sriov support via sysfs at per
 device level
Message-ID: <20121002203951.GA28663@kroah.com>
References: <1349134020-62152-1-git-send-email-ddutile@redhat.com>
 <CAE9FiQUd=sM3XaMKfJjnJq6mkugL7P=wEjdcMHtGjfe4ooRXUQ@mail.gmail.com>
 <506B4D4C.3080101@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <506B4D4C.3080101@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 02, 2012 at 04:23:40PM -0400, Don Dutile wrote:
> Greg: Why not use the above functions?

What "above functions"?  You make a lot of calls in the code :)

You are creating an attribute group, and then manually walking through
it to create/destroy the file?  That's not good, use the in-kernel
functions to do that automatically for you.

Also, you need to do this _before_ the device shows up to userspace,
otherwise you have a race that you just lost with udev and the like.

thanks,

greg k-h
