Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40361 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab3JBUl4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Oct 2013 16:41:56 -0400
Date: Wed, 2 Oct 2013 21:41:41 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Veaceslav Falico <vfalico@redhat.com>, linux-pci@vger.kernel.org,
	Neil Horman <nhorman@tuxdriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] msi: free msi_desc entry only after we've released
	the kobject
Message-ID: <20131002204141.GW12758@n2100.arm.linux.org.uk>
References: <1380189591-1368-1-git-send-email-vfalico@redhat.com> <20130928213727.GC32063@redhat.com> <20131001055346.GA4759@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131001055346.GA4759@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 30, 2013 at 10:53:46PM -0700, Bjorn Helgaas wrote:
> I think the current kobject delayed release is too aggressive,

I don't agree with that statement, but the rest of the sentence I do:

> in the
> sense that even after we've released all references, the object can
> still be in sysfs, which causes future creates to fail.  E.g., this
> fails:
> 
>     kset = kset_create_and_add("kobj_test", NULL, NULL);
>     kset_unregister(kset);
>     kset = kset_create_and_add("kobj_test", NULL, NULL);  // FAILS
> 
> when I think it should succeed.  We don't have a way for the caller to
> determine when it's safe to do the second kset_create_and_add().

The reason this happens is that for some reason I can't fathom, the
sysfs cleanup is done when the release function is called, not when
the object is unregistered.

I can see why that's done - it is so that when a kobject is unregistered,
its sysfs entry hangs around until all the children have gone (and hence
its reference count then hits zero.)

> After we release all references, I think it's OK for the kobject
> itself to continue to exist, i.e., we can delay calling t->release().
> But it should be impossible to find a kobject with refcount == 0 via
> sysfs, so we should be able to create a new one with the same name.
> 
> In terms of code, I'm suggesting something like the following:

I think I can give you an ack for this - it looks sensible enough, and
should still have the intended debugging behaviour.  I haven't tested
it though.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks Bjorn.
