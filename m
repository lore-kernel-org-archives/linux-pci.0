Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:48930 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab2JVPjw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Oct 2012 11:39:52 -0400
Date: Mon, 22 Oct 2012 16:44:44 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Jackson <ajax@redhat.com>
Cc: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
	dri-devel@lists.freedesktop.org,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linux-pci@vger.kernel.org,
	Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org,
	Brian King <brking@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: radeon: RFC speed cap detection on ppc64
Message-ID: <20121022164444.2b0775ce@pyramind.ukuu.org.uk>
In-Reply-To: <508565FA.4040908@redhat.com>
References: <50819140.8030806@linux.vnet.ibm.com>
	<508565FA.4040908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> That (walking all parent nodes) is probably the safest thing to do.  I'm 
> not sure whether it's optimal.  It would likely depend on whether you 
> can meaningfully have a bridge that's faster on the downstream side than 
> on the upstream.

This is architecture goo at heart - would this be better as a helper in
the PCI and arch PCI code ?

Alan
