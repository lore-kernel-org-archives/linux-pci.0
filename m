Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:32881 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932464Ab3HGPGg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2013 11:06:36 -0400
Date: Wed, 7 Aug 2013 17:06:29 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: [PATCHv5 08/11] ARM: pci: add ->add_bus() and ->remove_bus()
 hooks to hw_pci
Message-ID: <20130807170629.76ca63c1@skate>
In-Reply-To: <20130807133719.GA26302@manwe>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1373889167-27878-9-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130725165302.GA27802@dhcp-172-17-186-34.nvidia.com>
	<20130807111354.5e29a74c@skate>
	<20130807133719.GA26302@manwe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Thierry Reding,

On Wed, 7 Aug 2013 15:37:20 +0200, Thierry Reding wrote:

> > Hum, I must be missing something here. Looking at the patch you're
> > quoting, and my code, I see one tab before 'void' in both cases, and
> > spaces between 'void' and the (*function) in both cases.
> > 
> > Am I missing something here?
> 
> Perhaps I should've said "alignment" instead of "indentation" to make it
> more explicit. All other members use tabs to separate the data type and
> the field name, while the lines that you add use spaces.

Ah, right, I understand now. Unfortunately, I've already sent PATCHv7
with some other fixes. So either Jason Cooper can fix this when
applying, or I'll fix it if a PATCHv8 is needed for some other reason.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
