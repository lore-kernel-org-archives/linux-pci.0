Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56625 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753436AbcD2ORy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Apr 2016 10:17:54 -0400
Date: Fri, 29 Apr 2016 09:17:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [RFC v4] PCI: PTM Driver
Message-ID: <20160429141750.GB949@localhost>
References: <1461047358-4736-1-git-send-email-jonathan.yong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461047358-4736-1-git-send-email-jonathan.yong@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 19, 2016 at 06:29:17AM +0000, Yong, Jonathan wrote:
> Hello LKML,
> 
> This is a preliminary implementation of the PTM[1] support driver. This driver
> has only been tested against a virtual PCI bus since there are no known
> endpoints utilizing it yet.

What sort of testing is this, exactly?  Is this using a software model
of devices that support PTM?

When will hardware that supports PTM be available to you for testing?
When will it be available on the market?

I'm trying to figure out whether there's any benefit to merging
something before it is useful to anybody.

Bjorn
