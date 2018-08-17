Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbeHQSsY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Aug 2018 14:48:24 -0400
Date: Fri, 17 Aug 2018 10:44:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, Hari Vyas <hari.vyas@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] Revert "PCI: Fix is_added/is_busmaster race
 condition"
Message-ID: <20180817154431.GC128050@bhelgaas-glaptop.roam.corp.google.com>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
 <20180817044902.31420-2-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180817044902.31420-2-benh@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2018 at 02:48:57PM +1000, Benjamin Herrenschmidt wrote:
> This reverts commit 44bda4b7d26e9fffed6d7152d98a2e9edaeb2a76.

Just to be clear, if I understand correctly, this is a pure revert of
44bda4b7d26e and as such it reintroduces the problem solved by that
commit.

If your solution turns out to be better, that's great, but it would be
nice to avoid the bisection hole of reintroducing the problem, then
fixing it again later.

> The new pci state mutex provides a simpler way of addressing
> this race and avoids the relative includes added to the powerpc
> code.
