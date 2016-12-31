Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:58162 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754540AbcLaQBL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Dec 2016 11:01:11 -0500
Date: Sat, 31 Dec 2016 17:01:07 +0100
From: Martin Mares <mj@ucw.cz>
To: Harry Mallon <hjmallon@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: lspci memory behind bridge reporting
Message-ID: <mj+md-20161231.155855.4261.nikam@ucw.cz>
References: <CDB45911-510C-459D-BCDC-17955FCC400D@gmail.com>
 <20161221201635.GA31167@bhelgaas-glaptop.roam.corp.google.com>
 <F9DB0FE1-0518-4799-98A9-DA9053A86AEC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F9DB0FE1-0518-4799-98A9-DA9053A86AEC@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> I attach a patch with behaviour similar to what you describe. It is based on
> the current master branch of pciutils (hash
> 4a190235224ff6dfe44adbb07ac929afea612acd).

I like the idea, but not much the ifdeffery in your implementation.
I wrote something similar in a little bit more systematic way, please
see commit 41d883cb97f94e844e96b4631a99c3da557cf162.

> I have not altered anything in the tests folder yet as I am not sure about how to run them.

The tests are not automated yet. Just add a configuration space
dump together with the expected output.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Power corrupts; Powerpoint corrupts absolutely.  -- Vint Cerf
