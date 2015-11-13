Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33928 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbbKMV1x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Nov 2015 16:27:53 -0500
Date: Fri, 13 Nov 2015 16:27:07 -0500 (EST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Keith Busch <keith.busch@intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv5 5/6] x86/pci: Initial commit for new VMD device
 driver
In-Reply-To: <1447435057-5212-6-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.DEB.2.11.1511131624580.3987@nanos>
References: <1447435057-5212-1-git-send-email-keith.busch@intel.com> <1447435057-5212-6-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 13 Nov 2015, Keith Busch wrote:
> +/**
> + * struct vmd_irq_list - list of driver requested irq's mapping to a vmd vector
> + * &irq_list:	list of child irq's the VMD one demuxes to.

Is "&" a  new KernelDoc mechanism?

> +/*
> + * XXX: potential corruption if NMI occurs when irq handler is walking this
> + * list and irq deletion occurs concurrently.

I'm going to fix that before the driver hits the tree.

Thanks,

	tglx
