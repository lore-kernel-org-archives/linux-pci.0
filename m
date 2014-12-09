Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:54336 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486AbaLIDSI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Dec 2014 22:18:08 -0500
MIME-Version: 1.0
In-Reply-To: <1415907457-3147-3-git-send-email-l.stach@pengutronix.de>
References: <1415907457-3147-1-git-send-email-l.stach@pengutronix.de> <1415907457-3147-3-git-send-email-l.stach@pengutronix.de>
From: Alexandre Courbot <gnurou@gmail.com>
Date: Tue, 9 Dec 2014 12:17:47 +0900
Message-ID: <CAAVeFuJ95scnwB9iW_A-uNqVghC4sKfvL2zj=pJJoSze6D4U9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: tegra: remove bogus bridge setup fixup
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 14, 2014 at 4:37 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> The bridge setup is already done by generic code
> while scanning the buses. Do not duplicate (or potentially
> alter) this setup as a fixup.

Jetson seems to be happy with this change.

Tested-by: Alexandre Courbot <acourbot@nvidia.com>
