Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:53473 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755923AbcBIP2z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2016 10:28:55 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, CARLOS.PALMINHA@synopsys.com
Subject: Re: [PATCH] link up validation moved to pcie-designware
Date: Tue, 09 Feb 2016 16:28:38 +0100
Message-ID: <3127323.7iUuBrk8dh@wuerfel>
In-Reply-To: <56B8C6C7.9060105@synopsys.com>
References: <b00bf38b4351831b97892b747d48c9206fbab9c7.1454935205.git.jpinto@synopsys.com> <2817924.61jZWIvqjt@wuerfel> <56B8C6C7.9060105@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 08 February 2016 16:48:07 Joao Pinto wrote:
> On 2/8/2016 4:46 PM, Arnd Bergmann wrote:
> > On Monday 08 February 2016 16:43:33 Joao Pinto wrote:
> >> Hi,
> >> Ok, so what should be the retries and waiting time in your opinion?
> >> The most typical is:
> >>
> >> retries: 10
> >> delay: 100ms (usleep_range (90000, 100000))
> >>
> >> These values should be ok?
> >>
> >> I am already testing a full pcie-designware platform driver.
> >>
> >>
> > You are the one with the datasheet, not me. 
> 
> Our reference driver follows the 10x with 100ms delay between retries, so lets
> follow that value. Agree?
> 

I wouldn't trust the reference driver too much, better follow whatever
the hardware specifications says.

	Arnd
