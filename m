Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:55542 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751519AbeF3WJ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Jun 2018 18:09:27 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 8D4F11C09A6
        for <linux-pci@vger.kernel.org>; Sat, 30 Jun 2018 23:59:42 +0200 (CEST)
Date: Sat, 30 Jun 2018 23:59:42 +0200
From: Martin Mares <mj@ucw.cz>
To: Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: Released pciutils-3.6.0
Message-ID: <mj+md-20180630.215836.98434.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello, world!\n

I just released version 3.6.0 of the pciutils with huge thanks to everybody
who contributed.

>From the changelog:

	* Released as 3.6.0.

	* BARs reported by the OS, but not set on the device itself are
	  reliably marked with "[virtual]".

	* Library: Introduced a generic mechanism of string properties. This
	  avoids lots of special cases and makes ABI compatibility easier.

	* On Linux systems with OpenFirmware, report corresponding device tree nodes
	  as device properties.

	* VPD decoder knows several non-standard extensions.

	* When PCIe link speed is less than the maximum supported by the
	  device, it is explicitly marked as "downgraded".

	* Several new capabilities are not decoded yet, but at least their
	  names are printed.

	* The Null capability is easily decoded.

	* Formatting of several capabilities was cleaned up.

	* The VGA16 bit in the bridge control register is now supported.

	* Added a port to SylixOS. Thanks to YuJian Gong for contribution.

	* Added a port to DOS/DJGPP. Thanks to Rudolf Marek for contribution.

	* The order in which back-ends are probed was decoupled from the
	  internal back-end IDs. This helps, because new back-ends must have
	  their ID allocated at the end to keep the ABI, but they might need
	  to be proved earlier.

	* The fbsd-device back-end should work again.

	* Fixed a couple of bugs. Most notably, DeviceName was not printed.

	* As usually, updated pci.ids to the current snapshot of the database.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A half-joke: What is the difference between a cat?
