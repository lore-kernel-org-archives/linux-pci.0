Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:37529 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934793Ab3DJR1Q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Apr 2013 13:27:16 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so384716pde.9
        for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2013 10:27:16 -0700 (PDT)
Date: Wed, 10 Apr 2013 10:27:13 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Veaceslav Falico <vfalico@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	rusty@rustcorp.com.au, bhelgaas@google.com
Subject: Re: [PATCH] module: add kset_obj_exists() and use it
Message-ID: <20130410172713.GB1881@kroah.com>
References: <1365506529-8396-1-git-send-email-vfalico@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365506529-8396-1-git-send-email-vfalico@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 09, 2013 at 01:22:09PM +0200, Veaceslav Falico wrote:
> Add a new function, kset_obj_exists(), which is identical to
> kset_find_obj() but doesn't take a reference to the kobject
> found and only returns bool if found/not found.
> 
> The main purpose would be to avoid the possible race scenario,
> when we could get the reference in between the kref_put() and
> kobject_release() functions (i.e. kref_put() already ran,
> refcount became 0, but the kobject_release() function still
> didn't run, and we try to get via kobject_get() and thus ending
> up with a released kobject). It can be triggered, for example,
> by running insmod/rmmod bonding in parallel, which ends up in
> a race between kset_obj_find() in mod_sysfs_init() and rmmod's
> mod_sysfs_fini()/kobject_put().

As Rusty points out, this isn't a kobject issue that can be solved with
a new api call, but rather, the user of the kobject code needs to be
fixed, with something like his proposed patch instead.

So, because of this, I can't take this patch, sorry.

greg k-h
