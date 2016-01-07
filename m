Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42626 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbcAGR3G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Jan 2016 12:29:06 -0500
Date: Thu, 7 Jan 2016 11:28:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: designware: Simplify config accessors
Message-ID: <20160107172859.GA14105@localhost>
References: <20160106195339.24780.37612.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160106195339.24780.37612.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 06, 2016 at 01:54:59PM -0600, Bjorn Helgaas wrote:
> These make the code slightly smaller and easier to read but shouldn't make
> any functional difference.
> 
> ---
> 
> Bjorn Helgaas (2):
>       PCI: designware: Simplify control flow
>       PCI: designware: Make config accessor override checking symmetric

Applied with Pratyush's ack to pci/host-designware for v4.5.
