Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Ley Foon Tan <lftan@altera.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 5/5] drivers/pci: make most of the PCI_DW drivers modular
Date: Mon, 08 Feb 2016 11:00:27 +0100
Message-ID: <2730150.DUniNa63fK@wuerfel>
In-Reply-To: <1454889644-27830-6-git-send-email-paul.gortmaker@windriver.com>
References: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com> <1454889644-27830-6-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday 07 February 2016 19:00:44 Paul Gortmaker wrote:
> We've exported the symbols that we know these specific drivers
> will need as tristate, so now we can make the conversion from
> bool to tristate w/o concern for build regressions.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Looks good, but I'm not sure what happens on unload. Did you check?
Until this is tested, maybe it's best to prevent module unloading?

	Arnd
