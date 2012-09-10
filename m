Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65456 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757328Ab2IJWze (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 10 Sep 2012 18:55:34 -0400
Date: Tue, 11 Sep 2012 06:55:04 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jirislaby@gmail.com,
	Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 1/1] PCI: fix on-stack pci_device_id's
Message-ID: <20120910225504.GA18038@localhost>
References: <1347305801-7712-1-git-send-email-jslaby@suse.cz>
 <CAErSpo4+zvG-MmQ2V2QNKjx=mX+nLpqZNj5niJkG4f22XqYZNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4+zvG-MmQ2V2QNKjx=mX+nLpqZNj5niJkG4f22XqYZNg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 10, 2012 at 02:44:32PM -0600, Bjorn Helgaas wrote:
> On Mon, Sep 10, 2012 at 1:36 PM, Jiri Slaby <jslaby@suse.cz> wrote:
> > Commit "PCI: Use pci_device_id on stack for pci_get_subsys/class() to
> > avoid kmalloc" changed heap allocations to on-stack variables, but it
> > did not add initialization of other than set members. This causes
> > random failures during bootup wherever pci device is needed to be
> > found. Hence the boot just hangs or panics.
> >
> > This patches fixes it by setting the content of pci_device_id directly
> > in the initializer.
> 
> Nice!  I fixed this already by adding a memset(), but I like your way
> better.  I knew we could initialize members of a structure on the
> stack, but I didn't know C guaranteed that uninitialized members would
> be implicitly initialized also.  But apparently it does:
> 
> http://stackoverflow.com/questions/10828294/c-and-c-partial-initialization-of-automatic-structure

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>

For the record, I proposed the same initializer-style fix in the very
beginning that you didn't realize its beauty until now ;-)

Thanks,
Fengguang
