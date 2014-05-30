Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37241 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933855AbaE3VGq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 30 May 2014 17:06:46 -0400
Message-ID: <1401484002.9207.1.camel@ul30vt.home>
Subject: Re: [PATCH 0/4] VFIO Misc fixes
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org
Date: Fri, 30 May 2014 15:06:42 -0600
In-Reply-To: <1400535439.3289.284.camel@ul30vt.home>
References: <1400468470-11262-1-git-send-email-gwshan@linux.vnet.ibm.com>
	 <1400535439.3289.284.camel@ul30vt.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2014-05-19 at 15:37 -0600, Alex Williamson wrote:
> On Mon, 2014-05-19 at 13:01 +1000, Gavin Shan wrote:
> > Changelog
> > =========
> > v1 -> v2:
> >         * Change the comments and commit log in PATCH[4/4] (Alex).
> >         * Export 2 MSI relevant functions (Alex).
> > v2 -> v3:
> > 	* Add missed header file in PATCH[4/4].
> 
> Please specify the version in the Subject for all patches.
> 
> It would probably be a good idea to separate this series.  Patches 2 & 3
> stand on their own.  Send them that way so we can actually get them in.
> Patch 4 is dependent on Patch 1, so send them as a series.

I'm going to go ahead and grab patches 2 & 3 here because I don't want
to see them miss another kernel.  Thanks,

Alex

