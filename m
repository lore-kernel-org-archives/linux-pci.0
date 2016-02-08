Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:54823 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbcBHQqn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2016 11:46:43 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, CARLOS.PALMINHA@synopsys.com
Subject: Re: [PATCH] link up validation moved to pcie-designware
Date: Mon, 08 Feb 2016 17:46:36 +0100
Message-ID: <2817924.61jZWIvqjt@wuerfel>
In-Reply-To: <56B8C5B5.5050400@synopsys.com>
References: <b00bf38b4351831b97892b747d48c9206fbab9c7.1454935205.git.jpinto@synopsys.com> <20160208164104.GA17268@localhost> <56B8C5B5.5050400@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 08 February 2016 16:43:33 Joao Pinto wrote:
> Hi,
> Ok, so what should be the retries and waiting time in your opinion?
> The most typical is:
> 
> retries: 10
> delay: 100ms (usleep_range (90000, 100000))
> 
> These values should be ok?
> 
> I am already testing a full pcie-designware platform driver.
> 
> 
You are the one with the datasheet, not me. ;-)

	Arnd
