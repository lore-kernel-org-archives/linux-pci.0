Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42952 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423152AbcFMS4v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Jun 2016 14:56:51 -0400
Date: Mon, 13 Jun 2016 13:56:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v5] PCI: PTM preliminary implementation
Message-ID: <20160613185648.GA6901@localhost>
References: <1462956446-27361-1-git-send-email-jonathan.yong@intel.com>
 <1462956446-27361-2-git-send-email-jonathan.yong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462956446-27361-2-git-send-email-jonathan.yong@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 11, 2016 at 08:47:26AM +0000, Yong, Jonathan wrote:
> Simplified Precision Time Measurement driver, activates PTM feature
> if a PCIe PTM requester (as per PCI Express 3.1 Base Specification
> section 7.32)is found, but not before checking if the rest of the
> PCI hierarchy can support it.
> 
> The driver does not take part in facilitating PTM conversations,
> neither does it provide any useful services, it is only responsible
> for setting up the required configuration space bits.

I'm not convinced we should blindly enable PTM on every device that
supports it (especially endpoints), and I think the logic here is more
complicated than necessary.

I'm going to post a v6 as a draft.  My draft is probably not
complicated *enough*, but maybe we can figure out some point
in the middle.

I'm also a little confused about how Root Complex Integrated Endpoints
are supposed to use PTM, since they don't have an upstream bridge.
Maybe it has to do with an RCRB (Root Complex Register Block, spec
r3.1, sec 7.2.3)?  I don't think Linux really has any support for that
(yet).

Bjorn
