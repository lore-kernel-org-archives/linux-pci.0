Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48821 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932607AbbLHMRj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2015 07:17:39 -0500
Date: Tue, 8 Dec 2015 13:16:37 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Geliang Tang <geliangtang@163.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: simplify pci_bios_{read,write}
In-Reply-To: <0ed29e57b699af22a8759f1b1c0d59d79664dee5.1449495573.git.geliangtang@163.com>
Message-ID: <alpine.DEB.2.11.1512081316250.3595@nanos>
References: <0ed29e57b699af22a8759f1b1c0d59d79664dee5.1449495573.git.geliangtang@163.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 7 Dec 2015, Geliang Tang wrote:

> There are some repetitive code in the switch/case statement in
> pci_bios_read() and pci_bios_write(). I drop it to simplify the
> code.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
