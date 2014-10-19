Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:60185 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbaJSJYx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 19 Oct 2014 05:24:53 -0400
Date: Sun, 19 Oct 2014 11:24:48 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Daniel J Blueman <daniel@numascale.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Steffen Persvold <sp@numascale.com>
Subject: Re: [PATCH v2 2/5] Numachip: APIC fixes
Message-ID: <20141019092448.GA29407@gmail.com>
References: <1413683152-31302-1-git-send-email-daniel@numascale.com>
 <1413683152-31302-2-git-send-email-daniel@numascale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413683152-31302-2-git-send-email-daniel@numascale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Daniel J Blueman <daniel@numascale.com> wrote:

> Fix 16-bit APIC ID truncation and redundant APIC ICR idle polling for IPI
> to self (AMD64 APICs are documented in the system developer manuals to
> queue APIC writes).

That is again two fixes - there should be one fix per patch, with 
a good description of what the effects of the bug were and what 
the advantages of the change are - for each change separately.

Thanks,

	Ingo
