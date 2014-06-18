Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:50367 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767AbaFRUvO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jun 2014 16:51:14 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <benh@au1.ibm.com>;
	Thu, 19 Jun 2014 06:51:12 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0F4AA357804F
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2014 06:51:10 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5IKSxjo48758794
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2014 06:28:59 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5IKp8au002227
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2014 06:51:09 +1000
Message-ID: <1403124662.7661.225.camel@pasglop>
Subject: Re: [RFC PATCH V3 14/17] ppc/pci: create/release dev-tree node for
 VFs
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	gwshan@linux.vnet.ibm.com, Mike Qiu <qiudayu@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, yan@linux.vnet.ibm.com,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 19 Jun 2014 06:51:02 +1000
In-Reply-To: <CACxGe6v6Rdd=GQ8qR5LQ64NThidn7kn3WkKFkOXOsNuWq75D-A@mail.gmail.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
	 <1402365399-5121-15-git-send-email-weiyang@linux.vnet.ibm.com>
	 <CACxGe6v6Rdd=GQ8qR5LQ64NThidn7kn3WkKFkOXOsNuWq75D-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-06-18 at 19:26 +0100, Grant Likely wrote:
> I don't think this is the right way to handle this. Unless it is a
> fixup to a buggy devicetree provided by firmware, I don't want to see
> any code modifying the devicetree to describe stuff that is able to be
> directly enumerated. Really the pci code should handle the lack of a
> device_node gracefully. If it cannot then it should be fixed.

Right, I've long said that we need to get rid of that "pci_dn" structure
we've been carrying around forever on ppc64.

Any auxiliary data structures we keep around associated with a PCI
device should be pointed to by the pci_dev itself, possibly using
firmware_data or similar.

Cheers,
Ben.

