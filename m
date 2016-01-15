Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39743 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbcAOTpL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2016 14:45:11 -0500
Date: Fri, 15 Jan 2016 20:44:10 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Keith Busch <keith.busch@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv8 0/5] Driver for new "VMD" device
In-Reply-To: <20160115181938.GA5296@localhost>
Message-ID: <alpine.DEB.2.11.1601152042090.3575@nanos>
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com> <20160115181938.GA5296@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 15 Jan 2016, Bjorn Helgaas wrote:
> +    [bhelgaas: add VMD BAR #defines, factor out vmd_cfg_addr(), whitespace]
>      Signed-off-by: Keith Busch <keith.busch@intel.com>
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Just for the record. You forgot my Acked-bys
 
Other than that the changes look good!

Thanks,

	tglx
