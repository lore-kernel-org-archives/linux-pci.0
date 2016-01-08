Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 8 Jan 2016 10:36:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bogicevic Sasa <brutallesale@gmail.com>
Cc: bhelgaas@google.com, Richard.Zhu@freescale.com,
	l.stach@pengutronix.de, rjw@rjwysocki.net, lenb@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] drivers:pci Fix all whitespace issues
Message-ID: <20160108163638.GB31005@localhost>
References: <1451251271-43502-1-git-send-email-brutallesale@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1451251271-43502-1-git-send-email-brutallesale@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 27, 2015 at 01:21:11PM -0800, Bogicevic Sasa wrote:
> This patch fixes all whitespace issues( missing or needed whitespace) in
> all files in drivers/pci folder. Code is compiled with allyesconfig
> before and after code changes and objects are recorded and checked with
> objdiff and they are not changed after this commit.
> 
> Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>

Applied to pci/trivial for v4.5, thanks!

Bjorn
