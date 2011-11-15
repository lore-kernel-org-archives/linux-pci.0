Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:40295 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515Ab1KOUQr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2011 15:16:47 -0500
Date: Tue, 15 Nov 2011 13:16:46 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Prarit Bhargava <prarit@redhat.com>
Cc: Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	James Paradis <jparadis@redhat.com>, linux-pci@vger.kernel.org,
	mstowe@redhat.com, matthew wilcox <matthew.wilcox@linux.intel.com>,
	jbarnes@virtuousgeek.org
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
Message-ID: <20111115201646.GG4387@parisc-linux.org>
References: <bd3514f0-1a80-45ac-a08e-b327a367b276@zmail15.collab.prod.int.phx2.redhat.com> <4EBD73C8.8070407@redhat.com> <CAErSpo5eZ=4yqnMFpFjTOqGvK6p4mOmsppJbodeGe+vkjfKdbw@mail.gmail.com> <4EBD8714.30401@redhat.com> <4EC12962.2040105@redhat.com> <20111114181418.GE4387@parisc-linux.org> <4EC170E8.4070600@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC170E8.4070600@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 14, 2011 at 02:50:00PM -0500, Prarit Bhargava wrote:
> This only works if there is a single Down bridge connected to a single Down bridge.  What Stratus/NEC has is a single Up bridge (02:00.0) connected to a Up bridge (03:00.0) and a Down bridge (03:01.0), which we know to be illegal in PCIE.  So the scan of the first bridge, 03:00.0 works and no fixup is done.  The code still misses the second bridge, 03:01.0.

I'd forgotten that the Down - Down link was at slot 1; I thought it was
at slot 0.  So this won't help.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
