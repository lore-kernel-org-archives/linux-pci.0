Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:64114 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbcBHQkk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2016 11:40:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, CARLOS.PALMINHA@synopsys.com
Subject: Re: [PATCH] link up validation moved to pcie-designware
Date: Mon, 08 Feb 2016 17:40:30 +0100
Message-ID: <13142496.gh5Gdib4M6@wuerfel>
In-Reply-To: <b00bf38b4351831b97892b747d48c9206fbab9c7.1454935205.git.jpinto@synopsys.com>
References: <b00bf38b4351831b97892b747d48c9206fbab9c7.1454935205.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 08 February 2016 12:43:58 Joao Pinto wrote:
> This patch goal is to centralize in pcie-designware the link up
> validation. A new function was added to pci-designware that is
> responsible for doing such a task. This was implemented in a form that
> permits flexibility for all SoCs.
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>

I believe the different timeouts in each driver are just coincidence
and partly based on who reviewed which driver.

I'm pretty sure it doesn't really matter at all, and we can just use
the same loop for every one.

I was also hoping that a little more than just the loop could be
unified between the various establish_link() functions. I have a
feeling that each one just implements a subset of what is actually
required, so they are buggy in different ways because nobody
has the datasheet.

	Arnd
