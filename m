Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40784 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932128AbcFVPm4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 Jun 2016 11:42:56 -0400
Message-ID: <1466610168.11733.7.camel@kernel.crashing.org>
Subject: Re: PCI resource allocation not using pref 64-bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Date: Thu, 23 Jun 2016 01:42:48 +1000
In-Reply-To: <1466579045.4089.22.camel@kernel.crashing.org>
References: <1466579045.4089.22.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-06-22 at 17:04 +1000, Benjamin Herrenschmidt wrote:

> Hi folks !
> 
> So on my POWER9 simulator, I noticed that the PCI code isn't assigning
> any BAR to my 64-bit prefetchable window.

Problem found ... for various reasons the "windows" registers of the
root complex are emulated in firmware and the emulation wasn't properly
masking (and OR'ing 1) in the prefetchable ones, thus Linux was ditching
them.

Sorry for the noise..

Cheers,
Ben.

