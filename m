Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55166 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbaKCTpw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Nov 2014 14:45:52 -0500
Date: Mon, 3 Nov 2014 20:45:42 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Daniel J Blueman <daniel@numascale.com>
cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Steffen Persvold <sp@numascale.com>
Subject: Re: [PATCH v3 3/5] Numachip: Add safe is-present function
In-Reply-To: <1414915813-2462-3-git-send-email-daniel@numascale.com>
Message-ID: <alpine.DEB.2.11.1411032044590.5308@nanos>
References: <1414915813-2462-1-git-send-email-daniel@numascale.com> <1414915813-2462-3-git-send-email-daniel@numascale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2 Nov 2014, Daniel J Blueman wrote:

> Add safe function to check if Numachip is detected, to be used elsewhere.

I cannot find a use case for this. I guess this is a left over of the
earlier 2G change, right?
 
Thanks,

	tglx
