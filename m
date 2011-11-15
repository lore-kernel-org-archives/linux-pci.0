Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:36316 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932535Ab1KOWPM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2011 17:15:12 -0500
Date: Tue, 15 Nov 2011 17:14:59 -0500 (EST)
From: James Paradis <jparadis@redhat.com>
To: Myron Stowe <mstowe@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>,
	Rolf Eike Beer <eike-kernel@sf-tec.de>,
	Matthew Wilcox <matthew@wil.cx>,
	Don Dutile <ddutile@redhat.com>, linux-pci@vger.kernel.org,
	jbarnes@virtuousgeek.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
Message-ID: <c7d5c08c-7fa5-421e-9b01-486dc36f1a79@zmail15.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1321393949.2417.181.camel@zim.stowe>
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> James,
> 
> I think a lot of people are wondering why this is only now coming up
> as
> the patch in question has been upstream for a couple of years.
> 
> While the system has been in the field for awhile - has the I/O
> subsystem that exhibits this issue been there since the introduction
> of
> this type of system -or- is there a new, PCI Express based, I/O
> subsystem now being introduced that can be used with the original
> platform and this is why we are just now seeing the issue?

This system has been available since late 2009, and the I/O subsystem
has not changed since its introduction.  One reason we haven't
seen this problem until now is that RHEL6 (kernel 2.6.32) is the only 
supported Linux operating system for this platform, and this problem
surfaced in 2.6.34.  I found this problem because I recently started 
thinking ahead to RHEL7 and so started trying to work with recent 
Fedora releases.  It looks like from now on I'm going to be banging
on upstream kernels as soon as they come out so we catch this sort of
thing sooner...

--jim
